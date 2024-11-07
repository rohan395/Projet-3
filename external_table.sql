IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'root_12test224_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [root_12test224_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://root@12test224.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.my_external_data (
	[id] nvarchar(4000),
	[first_name] nvarchar(4000),
	[last_name] nvarchar(4000),
	[address] nvarchar(4000),
	[city] nvarchar(4000),
	[province] nvarchar(4000),
	[pin] nvarchar(4000)
	)
	WITH (
	LOCATION = 'customers/customers_2024-11-07.csv',
	DATA_SOURCE = [root_12test224_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.my_external_data
GO