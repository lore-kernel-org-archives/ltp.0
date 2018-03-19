From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 19 Mar 2018 10:14:20 +0100
Subject: [LTP] [PATCH] fs/read_all: Filter /dev/watchdog*
In-Reply-To: <5AAB53BA.6000207@cn.fujitsu.com>
References: <1521025644-18312-1-git-send-email-xuyang.jy@cn.fujitsu.com>
 <87woydv835.fsf@rpws.prws.suse.cz> <5AAB53BA.6000207@cn.fujitsu.com>
Message-ID: <87vadsv34j.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hello,

xuyang.jy writes:

> 2018/3/15 20:25, Richard Palethorpe write:
>> Hello,
>>
>> yang xu writes:
>>
>>> On some distros with Magic Close feature or built-in CONFIG_WATCHDOG_NO=
WAYOUT,
>>> just closing /dev/watchdog* enabled by open leads to system reboot as e=
xpected.
>>>
>>> If Magic Close feature is supported, just writing a specific magic char=
acter 'V'
>>> into /dev/watchdog* before closing it can disable the watchdog.
>>>
>>> If CONFIG_WATCHDOG_NOWAYOUT is built-in, there is no way to disable the=
 watchdog.
>>>
>>> Magic Close feature is introduced by:
>>> commit 017cf080("watchDog Timer Driver Core - Add Magic Close feature")
>>>
>>> Please see the following url for detailed watchdog info:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/watchdog/watchdog-api.txt
>>>
>>> Signed-off-by: yang xu<xuyang.jy@cn.fujitsu.com>
>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>> ---
>>>   testcases/kernel/fs/read_all/read_all.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel=
/fs/read_all/read_all.c
>>> index 81806e7..a841b88 100644
>>> --- a/testcases/kernel/fs/read_all/read_all.c
>>> +++ b/testcases/kernel/fs/read_all/read_all.c
>>> @@ -393,6 +393,9 @@ static void visit_dir(const char *path)
>>>   		snprintf(dent_path, MAX_PATH,
>>>   			 "%s/%s", path, dent->d_name);
>>>
>>> +		if (!strncmp(dent_path, "/dev/watchdog", 13))
>>> +			continue;
>>> +
>> I don't think this should be hardcoded because it is OK to read this
>> file on some systems. Unfortunately there does not seem to be a reliable
>> way to find out if it is OK (/sys/class/watchdog/watchdogn/nowayout is
>> not even present on my system)
>>
>> However perhaps we could set the default for the exclude parameter (-e)
>> to /dev/watchdog? Then the user can easily override it, but we won't
>> reboot some people's systems by default. What do you think?
>
> Hi Richard
> Agreed. We can run read_all with the -e option to exclude the /dev/watchd=
og*,
> as bleow:
>
> diff --git a/runtest/fs b/runtest/fs
> index a595edb..42a9bfc 100644
> --- a/runtest/fs
> +++ b/runtest/fs
> @@ -69,7 +69,7 @@ fs_di fs_di -d $TMPDIR
> # Was not sure why it should reside in runtest/crashme and won=C2=B4t get=
 tested
> ever
> proc01 proc01 -m 128
>
> -read_all_dev read_all -d /dev -q -r 10
> +read_all_dev read_all -d /dev -e '/dev/watchdog?(0)' -q -r 10
> read_all_proc read_all -d /proc -q -r 10
> read_all_sys read_all -d /sys -q -r 10
>
> How about this modification?

I think that is OK, but Cyril would prefer to make it the default value
of the exclude variable so that it does not cause a restart when the
user runs read_all manually.

I think I still prefer putting it in the runtest file because the exception
is only relevant to /dev and I don't want to have exceptions hardcoded.

>
> Best Regards,
> Yang Xu
>
>>>   		if (act =3D=3D DA_UNKNOWN) {
>>>   			if (lstat(dent_path,&dent_st))
>>>   				tst_res(TINFO | TERRNO, "lstat(%s)", path);
>>> --
>>> 1.8.3.1
>>
>> --
>> Thank you,
>> Richard.
>>
>>
>> .
>>


--=20
Thank you,
Richard.
