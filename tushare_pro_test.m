%---------------------------------------
% Tushare Matlab Interface Samples
% Author(s) - Lianrui Fu (fulrbuaa#163{dot}com)
% Affiliation - National Laboratory of Pattern Recognition, Institute of Automation, Chinese Academy of Sciences
% Update Date - 2018-10-31
%---------------------------------------
% pro_api接口说明 见 help pro_api
% BAR接口说明 见 help pro_bar
% 输出数据为matalb table数据类型，和pandas的DataFrame非常接近，调用失败时返回[]
% 调用失败时会有显示相应原因，常见原因：(1)token无效，(2)网络不正常，(3)Matlab版本过低，需2016b及以上
% Tushare Matlab 接口调用示例：

% token 赋值，请替换为您的token
token = 'fa381e2536d016fd126110367ac47cf9da5fa515****************';
api = pro_api(token);

% 1 tushare pro_api接口示例
% results = api.query(api_name, param_name1, param_1, param_name2, param_2, ...);

% (1)获取stock_basic数据
df_basic = api.query('stock_basic');
disp(df_basic(1:10,:));

% (2)获取daily数据
% 参数如下：
% ts_code:证券代码，支持股票,ETF/LOF,期货/期权,港股,数字货币,如'000001.SZ','000905.SH'
% start_date:开始日期  YYYYMMDD, 如'20181001'
% end_date:结束日期 YYYYMMDD,''表示当前日期
df_daily = api.query('daily', 'ts_code', '000001.SZ', 'start_date', '19990101', 'end_date', '');
disp(df_daily(1:10,:));

% 2 获取BAR数据，详细说明：help pro_api
% 相比daily，pro_bar可以进行复权处理，还可以提供N日平均值
dd1 = pro_bar('000001.SZ', api, '19990101', '20181031');
dd2 = pro_bar('000001.SZ', api, '19990101', '');
dd_ma1 = pro_bar('000001.SZ', api, '19990101', '', 'D', 'E', '', 'qfq', 5);
dd_ma3 = pro_bar('000001.SZ', api, '19990101', '', 'D', 'E', '', 'qfq', [5, 10, 20]);
dd_index = pro_bar('000905.SH', api, '19990101', '', 'D', 'I');
disp(dd_ma3(1:10,:));




