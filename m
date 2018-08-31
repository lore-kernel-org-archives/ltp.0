From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 31 Aug 2018 10:58:55 +0800
Subject: [LTP] [PATCH v3 2/2] lib/tst_test.c: Add .needs_devfs flag
In-Reply-To: <20180830144943.GA20702@rei.lan>
References: <20180816132815.GB30369@rei>
 <1534480415-18932-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180830144943.GA20702@rei.lan>
Message-ID: <5B88AEEF.6020708@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/08/30 22:49, Cyril Hrubis wrote:
> Hi!
>> +static void prepare_and_mount_dev_fs(const char *mntpoint)
>> +{
>> +	const char *flags[] = {"nodev", NULL};
>> +	char abs_path[PATH_MAX];
>> +
>> +	sprintf(abs_path, "%s/%s", tst_get_tmpdir(), mntpoint);
> The tst_get_tmpdir() allocates memory and also we are sure that mntpoint
> is on the same filesystem as the path returned by tst_get_tmpdir().
>
> So I would suggest something like this:
>
> 	char *tmpdir;
> 	int mounted_nodev;
>
> 	tmpdir = tst_get_tmpdir();
> 	mounted_nodev = tst_path_has_mnt_flags(NULL, tmpdir, flags);
> 	free(tmpdir);
>
> 	if (mounted_nodev) {
> 		...
> 	}
>
Hi Cyril,

Thanks for your review.

By default, the path returned by tst_get_tmpdir() will be used in 
tst_path_has_mnt_flags() if we
pass NULL as a path parameter, so i will use 
tst_path_has_mnt_flags(NULL, NULL, flags) directly.
>> +	if (tst_path_has_mnt_flags(NULL, abs_path, flags)) {
>> +		tst_res(TINFO, "%s isn't suitable for creating devices, "
>> +			"so mount tmpfs without nodev over it", abs_path);
>> +		SAFE_MOUNT(NULL, mntpoint, "tmpfs", 0, NULL);
>> +		mntpoint_mounted = 1;
>> +	}
>> +}
>> +
>>   static void prepare_device(void)
>>   {
>>   	if (tst_test->format_device) {
>> @@ -786,11 +801,15 @@ static void do_setup(int argc, char *argv[])
>>   	if (tst_test->mntpoint)
>>   		SAFE_MKDIR(tst_test->mntpoint, 0777);
>>
>> -	if ((tst_test->needs_rofs || tst_test->mount_device ||
>> -	     tst_test->all_filesystems)&&  !tst_test->mntpoint) {
>> +	if ((tst_test->needs_devfs || tst_test->needs_rofs ||
>> +	     tst_test->mount_device || tst_test->all_filesystems)&&
>> +	     !tst_test->mntpoint) {
>>   		tst_brk(TBROK, "tst_test->mntpoint must be set!");
>>   	}
> I guess that we should also make sure only one of needs_rofs,
> needs_devfs or needs_device is set, because otherwise we would attempt
> to mount multiple filesystems over the mntpoint.
>
> something as:
>
> 	if (!!tst_test->needs_rofs +
> 	    !!tst_test->needs_devfs +
> 	    !!tst_test->needs_device>  1) {
> 		tst_brk(TBROK, "Two or more of needs_{rofs, devfs, device} are set");
> 	}
OK, i will add it as you said.

Thanks,
Xiao Yang
>> +	if (tst_test->needs_devfs)
>> +		prepare_and_mount_dev_fs(tst_test->mntpoint);
>> +
>>   	if (tst_test->needs_rofs) {
>>   		/* If we failed to mount read-only tmpfs. Fallback to
>>   		 * using a device with read-only filesystem.
> Other than the minor nits this version looks fine.
>



