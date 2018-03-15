From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 15 Mar 2018 13:25:50 +0100
Subject: [LTP] [PATCH] fs/read_all: Filter /dev/watchdog*
In-Reply-To: <1521025644-18312-1-git-send-email-xuyang.jy@cn.fujitsu.com>
References: <1521025644-18312-1-git-send-email-xuyang.jy@cn.fujitsu.com>
Message-ID: <87woydv835.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

yang xu writes:

> On some distros with Magic Close feature or built-in CONFIG_WATCHDOG_NOWAYOUT,
> just closing /dev/watchdog* enabled by open leads to system reboot as expected.
>
> If Magic Close feature is supported, just writing a specific magic character 'V'
> into /dev/watchdog* before closing it can disable the watchdog.
>
> If CONFIG_WATCHDOG_NOWAYOUT is built-in, there is no way to disable the watchdog.
>
> Magic Close feature is introduced by:
> commit 017cf080("watchDog Timer Driver Core - Add Magic Close feature")
>
> Please see the following url for detailed watchdog info:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/watchdog/watchdog-api.txt
>
> Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/fs/read_all/read_all.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
> index 81806e7..a841b88 100644
> --- a/testcases/kernel/fs/read_all/read_all.c
> +++ b/testcases/kernel/fs/read_all/read_all.c
> @@ -393,6 +393,9 @@ static void visit_dir(const char *path)
>  		snprintf(dent_path, MAX_PATH,
>  			 "%s/%s", path, dent->d_name);
>
> +		if (!strncmp(dent_path, "/dev/watchdog", 13))
> +			continue;
> +

I don't think this should be hardcoded because it is OK to read this
file on some systems. Unfortunately there does not seem to be a reliable
way to find out if it is OK (/sys/class/watchdog/watchdogn/nowayout is
not even present on my system)

However perhaps we could set the default for the exclude parameter (-e)
to /dev/watchdog? Then the user can easily override it, but we won't
reboot some people's systems by default. What do you think?

>  		if (act == DA_UNKNOWN) {
>  			if (lstat(dent_path, &dent_st))
>  				tst_res(TINFO | TERRNO, "lstat(%s)", path);
> --
> 1.8.3.1


--
Thank you,
Richard.
