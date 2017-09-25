From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 25 Sep 2017 18:47:36 +0800
Subject: [LTP] [PATCH] cve/cve-2016-10044.c: fix two errors
In-Reply-To: <87lgl7yov6.fsf@our.domain.is.not.set>
References: <1506072101-4550-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <87lgl7yov6.fsf@our.domain.is.not.set>
Message-ID: <59C8DEC8.7050908@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2017/09/22 19:06, Richard Palethorpe wrote:
> Hello,
>
> Xiao Yang writes:
>
>> 1) If the number of nr_events exceeds the limit of available events
>>    defined in /proc/sys/fs/aio-max-nr, it returns EAGAIN.  We should
>>    call io_destroy() to cleanup the AIO context after finishing test.
>>
>>    Steps to reproduce this error:
>>       #echo 4 > /proc/sys/fs/aio-max-nr
>>       # ./cve-2016-10044 -i 5
>>       tst_test.c:908: INFO: Timeout per run is 0h 05m 00s
>>       cve-2016-10044.c:62: FAIL: AIO mapping is executable: rwxs!
>>       cve-2016-10044.c:62: FAIL: AIO mapping is executable: rwxs!
>>       cve-2016-10044.c:62: FAIL: AIO mapping is executable: rwxs!
>>       cve-2016-10044.c:62: FAIL: AIO mapping is executable: rwxs!
>>       cve-2016-10044.c:49: BROK: Failed to create AIO context: EAGAIN/EWOULDBLOCK
>>
>> 2) The kernel created an AIO pseudo-fs and introduced cve-2016-10044
>>    by the following patch:
>>    '71ad7490c1f3("rework aio migrate pages to use aio fs")'
>>
>>    We should return TCONF rather than TBROK when an AIO pseudo-fs is
>>    not found in /proc/self/maps.
> Maybe instead of doing this we could increase the required kernel
> version to 3.12 which appears to be where the patch was introduced?
>
> Otherwise we may fail with TCONF because the format of the file has
> slightly changed and I am worried that nobody will notice. I don't think
> this will have been backported to earlier versions:
> http://lkml.iu.edu/hypermail/linux/kernel/1312.0/04590.html
Hi Richard,

On RHEL7, the above patch has been backported to v3.10.0, so increasing
the required
kernel version to 3.12 does not seem better.

The old format of file is set to 'anon_inode:[aio]' by the following patch set:
'55708698c5f1("fs/anon_inode: Introduce a new lib function anon_inode_getfile_private()")'
'36bc08cc0170("fs/aio: Add support to aio ring pages migration")'

The current format of file is set to '/[aio]' by the following patch:
'71ad7490c1f3("rework aio migrate pages to use aio fs")'

Could we change the keyword into '[aio]' to match as many formats as possible, and
return TCONF if the mapping file does not exist.

Thanks,
Xiao Yang.
> The rest LGTM. Thanks.
>
>> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> ---
>>  testcases/cve/cve-2016-10044.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/testcases/cve/cve-2016-10044.c b/testcases/cve/cve-2016-10044.c
>> index 7928d27..a84590a 100644
>> --- a/testcases/cve/cve-2016-10044.c
>> +++ b/testcases/cve/cve-2016-10044.c
>> @@ -53,7 +53,7 @@ static void run(void)
>>  		if (strstr(line, "/[aio]") != NULL)
>>  			goto found_mapping;
>>  	}
>> -	tst_brk(TBROK, "Could not find mapping in /proc/self/maps");
>> +	tst_brk(TCONF, "Could not find mapping in /proc/self/maps");
>>  
>>  found_mapping:
>>  	if (sscanf(line, "%*x-%*x %s7", perms) < 0)
>> @@ -63,6 +63,9 @@ found_mapping:
>>  	else
>>  		tst_res(TPASS, "AIO mapping is not executable: %s", perms);
>>  
>> +	if (tst_syscall(__NR_io_destroy, ctx))
>> +		tst_brk(TBROK | TERRNO, "Failed to destroy AIO context");
>> +
>>  	SAFE_FCLOSE(f);
>>  	f = NULL;
>>  }
>> -- 
>> 1.8.3.1
>



