From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 16 May 2018 17:39:01 +0800
Subject: [LTP] [PATCH] read_all: Drop privileges
In-Reply-To: <87bmdhyyrf.fsf@rpws.prws.suse.cz>
References: <20180515095118.26282-1-rpalethorpe@suse.com>
 <20180515103042.GB7220@rei> <87bmdhyyrf.fsf@rpws.prws.suse.cz>
Message-ID: <5AFBFC35.3060400@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

If the permission of /dev/watchdog was 0600(default permission on RHEL7), we could not read /dev/watchdog
as nobody user and returned EACCES as expected.

If the permission of /dev/watchdog was 0660(default permission on RHEL6), Reading /dev/watchdog as nobody
user failed, but still led to system reboot.

I think reading /dev/watchdog as nobody user should get EACCES even if the permission is 0660, but i am not
sure whether this is a watchdog bug in kernel or not.

Thanks,
Xiao Yang

On 2018/05/15 18:55, Richard Palethorpe wrote:
> Hello,
>
> Cyril Hrubis writes:
>
>> Hi!
>>> +static void maybe_drop_privs(void)
>>> +{
>>> +	struct passwd *nobody;
>>> +
>>> +	if (!drop_privs)
>>> +		return;
>>> +
>>> +	nobody = SAFE_GETPWNAM("nobody");
>>> +
>>> +	TEST(setgid(nobody->pw_gid));
>>> +	if (TEST_RETURN<  0&&  TEST_ERRNO != EPERM)
>>> +		tst_res(TBROK | TTERRNO, "Failed to use nobody gid");
>>                  ^
>> 		Shouldn't this be tst_brk()?
>>
>>> +	TEST(setuid(nobody->pw_uid));
>>> +	if (TEST_RETURN<  0&&  TEST_ERRNO != EPERM)
>>> +		tst_res(TBROK | TTERRNO, "Failed to use nobody uid");
>>                  ^
>> 		And here as well?
>>
>> Otherwise it looks fine.
> Well spotted, yes it should.
>



