From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 3 Sep 2018 10:14:12 +0800
Subject: [LTP] [PATCH v4 2/2] lib/tst_test.c: Add .needs_devfs flag
In-Reply-To: <20180831123102.GC30263@rei.lan>
References: <20180830144943.GA20702@rei.lan>
 <1535774861-27429-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180831123102.GC30263@rei.lan>
Message-ID: <5B8C98F4.1060304@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/08/31 20:31, Cyril Hrubis wrote:
> Hi!
>> +static void prepare_and_mount_dev_fs(const char *mntpoint)
>> +{
>> +	const char *flags[] = {"nodev", NULL};
>> +	int mounted_nodev;
>> +
>> +	mounted_nodev = tst_path_has_mnt_flags(NULL, NULL, flags);
>> +	if (mounted_nodev) {
>> +		tst_res(TINFO, "tmpdir isn't suitable for creating devices, "
>> +			"so mount tmpfs without nodev on %s", mntpoint);
>> +		SAFE_MOUNT(NULL, mntpoint, "tmpfs", 0, NULL);
>> +		mntpoint_mounted = 1;
>> +	}
>> +}
> That is even better than my version, nice :-).
>
> There is a last nit to solve, the problem is that
> tst_path_has_mnt_flags() is defined in old/test.h, we have to move the
> definition to a separate header file (in a separate patch) so that it
> could be included in test.h, tst_path_has_mnt_flags.c, and tst_test.c.
Hi Cyril,

This is a patch set, and i have factored out tst_path_has_mnt_flags() by 
the first patch:
http://lists.linux.it/pipermail/ltp/2018-August/009013.html

Thanks,
Xiao Yang
> I can do that or you can sent v5, your choice.
>



