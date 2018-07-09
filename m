From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 9 Jul 2018 14:09:00 +0300
Subject: [LTP] [PATCH] device-drivers/acpi: skip the test if ACPI is
 disabled
In-Reply-To: <e6a9a252-19b4-dfd9-8cda-63386de66928@oracle.com>
References: <1529316599-8124-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <e6a9a252-19b4-dfd9-8cda-63386de66928@oracle.com>
Message-ID: <e517a04c-a5af-289f-fa72-0ac23b85c3e1@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Committed.

On 06/29/2018 01:00 PM, Stanislav Kholmanskikh wrote:
> Hi!
> 
> This is a shy ping.
> 
> On 06/18/2018 01:09 PM, Stanislav Kholmanskikh wrote:
>> Calling functions such as acpi_get_devices() on a system with ACPI
>> disabled (for example, a virtual machine) leads to a kernel panic.
>>
>> Earlier there was a related discussion on linux-acpi:
>>
>> https://www.spinics.net/lists/linux-acpi/msg79419.html
>>
>> and they came to the conclusion that the caller of the API should
>> check if ACPI is enabled, i.e. the test needs an update.
>>
>> Suggested-by: Rob Gardner <rob.gardner@oracle.com>
>> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
>> ---
>>  testcases/kernel/device-drivers/acpi/ltp_acpi.c    |    7 +++++++
>>  .../kernel/device-drivers/acpi/ltp_acpi_cmds.c     |   15 +++++++++++++++
>>  2 files changed, 22 insertions(+), 0 deletions(-)
>>
>> diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi.c b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
>> index d20d38f..f2dc6a4 100644
>> --- a/testcases/kernel/device-drivers/acpi/ltp_acpi.c
>> +++ b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
>> @@ -34,6 +34,7 @@ static const char dev_result[]	= "/sys/devices/" ACPI_TEST_NAME "/result";
>>  static const char dev_path[]	= "/sys/devices/" ACPI_TEST_NAME "/path";
>>  static const char dev_str[]	= "/sys/devices/" ACPI_TEST_NAME "/str";
>>  static const char dev_tcase[]	= "/sys/devices/" ACPI_TEST_NAME "/tcase";
>> +static const char dev_acpi_disabled[] = "/sys/devices/" ACPI_TEST_NAME "/acpi_disabled";
>>  static const char module_name[]	= "ltp_acpi_cmds.ko";
>>  static int module_loaded;
>>  
>> @@ -141,6 +142,8 @@ static void test_run(void)
>>  
>>  int main(int argc, char *argv[])
>>  {
>> +	int acpi_disabled;
>> +
>>  	tst_parse_opts(argc, argv, NULL, NULL);
>>  
>>  	tst_require_root();
>> @@ -155,6 +158,10 @@ int main(int argc, char *argv[])
>>  	tst_module_load(NULL, module_name, NULL);
>>  	module_loaded = 1;
>>  
>> +	SAFE_FILE_SCANF(cleanup, dev_acpi_disabled, "%d", &acpi_disabled);
>> +	if (acpi_disabled)
>> +		tst_brkm(TCONF, cleanup, "ACPI is disabled on the system");
>> +
>>  	test_run();
>>  
>>  	cleanup();
>> diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c b/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
>> index 419eb6a..6e8f051 100644
>> --- a/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
>> +++ b/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
>> @@ -537,6 +537,13 @@ static ssize_t sys_path(struct device *dev,
>>  }
>>  static DEVICE_ATTR(path, S_IRUSR, sys_path, NULL);
>>  
>> +static ssize_t sys_acpi_disabled(struct device *dev,
>> +				    struct device_attribute *attr, char *buf)
>> +{
>> +	return scnprintf(buf, PAGE_SIZE, "%d", acpi_disabled);
>> +}
>> +static DEVICE_ATTR(acpi_disabled, S_IRUSR, sys_acpi_disabled, NULL);
>> +
>>  static ssize_t sys_tcase(struct device *dev,
>>  	struct device_attribute *attr,  const char *buf, size_t count)
>>  {
>> @@ -616,8 +623,16 @@ int init_module(void)
>>  		goto err4;
>>  	}
>>  
>> +	err = device_create_file(&tdev, &dev_attr_acpi_disabled);
>> +	if (err) {
>> +		prk_err("Can't create sysfs file 'acpi_disabled'");
>> +		goto err5;
>> +	}
>> +
>>  	return 0;
>>  
>> +err5:
>> +	device_remove_file(&tdev, &dev_attr_path);
>>  err4:
>>  	device_remove_file(&tdev, &dev_attr_tcase);
>>  err3:
>>
> 
