classdef pro_api
%---------------------------------------
% Tushare pro_api Matlab Interface
% Author(s) - Lianrui Fu (fulrbuaa#163{dot}com)
% Affiliation - National Laboratory of Pattern Recognition, Institute of Automation, Chinese Academy of Sciences
% Update Date - 2018-10-31
%---------------------------------------
% pro_api调用说明：
% 调用方式：
% results = api.query(api_name, param_name1, param_1, param_name2, param_2, ...);
% 具体参数与python接口参数一致
% 调用示例：
% token = 'c7b68d2a726dc747e6d6c4484a42b9275b7d8389a****************';
% api = pro_api(token);
% % stock_basic
% df_basic = api.query('stock_basic');
% disp(df_basic(1:10,:));
% % daily
% df_daily = api.query('daily', 'ts_code', '000001.SZ', 'start_date', '19990101', 'end_date', '');
% disp(df_daily(1:10,:));
% >>
%       ts_code       symbol      name     area    industry    market    list_date 
%     ___________    ________    ______    ____    ________    ______    __________
% 
%     '000001.SZ'    '000001'    '平安银行'    '深圳'    '银行'        '主板'      '19910403'
%     '000002.SZ'    '000002'    '万科A'     '深圳'    '全国地产'      '主板'      '19910129'
%     '000004.SZ'    '000004'    '国农科技'    '深圳'    '生物制药'      '主板'      '19910114'
%     '000005.SZ'    '000005'    '世纪星源'    '深圳'    '房产服务'      '主板'      '19901210'
%     '000006.SZ'    '000006'    '深振业A'    '深圳'    '区域地产'      '主板'      '19920427'
%     '000007.SZ'    '000007'    '全新好'     '深圳'    '酒店餐饮'      '主板'      '19920413'
%     '000008.SZ'    '000008'    '神州高铁'    '北京'    '运输设备'      '主板'      '19920507'
%     '000009.SZ'    '000009'    '中国宝安'    '深圳'    '综合类'       '主板'      '19910625'
%     '000010.SZ'    '000010'    '美丽生态'    '深圳'    '建筑施工'      '主板'      '19951027'
%     '000011.SZ'    '000011'    '深物业A'    '深圳'    '区域地产'      '主板'      '19920330'
%   
%       ts_code      trade_date    open     high      low     close    pre_close    change    pct_change       vol          amount  
%     ___________    __________    _____    _____    _____    _____    _________    ______    __________    __________    __________
% 
%     '000001.SZ'    '20181030'    10.78    11.08    10.73     10.9    10.75         0.15      1.3953       1.5018e+06    1.6414e+06
%     '000001.SZ'    '20181029'     11.2    11.24    10.62    10.75    11.18        -0.43     -3.8462       1.5916e+06    1.7259e+06
%     '000001.SZ'    '20181026'    11.29    11.31    10.96    11.18    11.29        -0.11     -0.9743          1.3e+06    1.4488e+06
%     '000001.SZ'    '20181025'     10.8    11.29    10.71    11.29    11.04         0.25      2.2645        1.685e+06    1.8558e+06
%     '000001.SZ'    '20181024'     10.9    11.33     10.8    11.04    10.84          0.2       1.845       1.8294e+06    2.0262e+06
%     '000001.SZ'    '20181023'     11.2    11.22    10.73    10.84    11.15        -0.31     -2.7803       1.6025e+06    1.7593e+06
%     '000001.SZ'    '20181022'    10.81    11.46    10.78    11.15    10.76         0.39      3.6245       2.6455e+06    2.9327e+06
%     '000001.SZ'    '20181019'     9.95    10.78     9.92    10.76    10.09         0.67      6.6402       2.0837e+06    2.1736e+06
%     '000001.SZ'    '20181018'    10.29    10.29    10.06    10.09    10.33        -0.24     -2.3233       1.0012e+06    1.0157e+06
%     '000001.SZ'    '20181017'     10.5    10.55    10.14    10.33    10.37        -0.04     -0.3857       1.3509e+06    1.4003e+06


    properties
        token = '';
        http_url = 'http://api.tushare.pro';
        tcp_url = 'tcp://tushare.pro';
    end

    methods
        function api = pro_api(token)
            api.token = token;
        end
 
         function data = query(api, varargin)
            data = [];
            results.data = [];
            results.msg = '';
            try                
                num = length(varargin);
                if num<1
                    results.msg = '第一个参数需要指定接口名称.';
                elseif 0~=rem(num-1, 2) || num<1
                    results.msg = '输入参数有缺失.';
                else
                    params = cell2struct(varargin(3:2:end), varargin(2:2:end), 2);
                end
                struct_params.api_name = varargin{1};
                struct_params.token = api.token;
                struct_params.params = params;
%             struct_params.params.ts_code = ts_code;
%             struct_params.params.start_date = start_date;
%             struct_params.params.end_date = end_date;            

                results.msg = '抱歉：需要matlab 2016b及以上版本.';
                req_text = jsonencode(struct_params);
                results.msg = '抱歉：请检查网络设置.';
                res = urlread2(api.http_url, 'Post', req_text);
                results = jsondecode(res);
            catch
                %----
            end
            if ~isempty(results.msg)
                disp(results.msg);
            end
            if ~isempty(results.data)               
                index = results.data.fields;
                data = cat(2, results.data.items{:})';
                data = cell2table(data, 'VariableNames', index);
            end
        end  % query     
      

    end % end of methods
end

