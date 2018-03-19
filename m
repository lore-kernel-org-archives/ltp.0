From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 19 Mar 2018 15:29:43 +0100
Subject: [LTP] [PATCH v2] runtest/fs: filter /dev/watchdog* for
	read_all_dev by default
In-Reply-To: <1521455915-3081-1-git-send-email-xuyang.jy@cn.fujitsu.com>
References: <87vadsv34j.fsf@rpws.prws.suse.cz>
 <1521455915-3081-1-git-send-email-xuyang.jy@cn.fujitsu.com>
Message-ID: <87tvtcuoiw.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hello,

yang xu writes:

> On some distros with Magic Close feature or built-in CONFIG_WATCHDOG_NOWA=
YOUT,
> just closing /dev/watchdog* enabled by open leads to system reboot as exp=
ected.
>
> If Magic Close feature is supported, just writing a specific magic charac=
ter 'V'
> into /dev/watchdog* before closing it can disable the watchdog.
>
> If CONFIG_WATCHDOG_NOWAYOUT is built-in, there is no way to disable the w=
atchdog.
>
> Magic Close feature is introduced by:
> commit 017cf080("watchDog Timer Driver Core - Add Magic Close feature")
>
> Please see the following url for detailed watchdog info:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/watchdog/watchdog-api.txt
>
> Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  runtest/fs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/runtest/fs b/runtest/fs
> index a595edb..42a9bfc 100644
> --- a/runtest/fs
> +++ b/runtest/fs
> @@ -69,7 +69,7 @@ fs_di fs_di -d $TMPDIR
>  # Was not sure why it should reside in runtest/crashme and won=C2=B4t ge=
t tested ever
>  proc01 proc01 -m 128
> =20
> -read_all_dev read_all -d /dev -q -r 10
> +read_all_dev read_all -d /dev -e '/dev/watchdog?(0)' -q -r 10
>  read_all_proc read_all -d /proc -q -r 10
>  read_all_sys read_all -d /sys -q -r 10

LGTM, thanks!

--=20
Thank you,
Richard.
