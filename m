From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 14 May 2018 09:28:29 +0200
Subject: [LTP] [PATCH] runtest/fs: Don't read files in /dev
	indiscriminately
In-Reply-To: <20180511173156.30197-1-punit.agrawal@arm.com>
References: <20180511173156.30197-1-punit.agrawal@arm.com>
Message-ID: <87lgcmy9uq.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hello,

Punit Agrawal writes:

> read_all_dev attempts to read 1024 bytes from all devices in /dev. As
> nodes in /dev represent devices, any access can have side-effects -
> sometimes fatally so, e.g., accessing /dev/port on Juno R2 and AMD
> Seattle lead to synchronous external abort or SError (system error)
> interrupt depending on the access pattern.
>
> There isn't much the kernel can do about the aborts other than panic
> the system.
>
> The side-effects problem is also highlighted by the recent exclusion
> added for watchdog devices. See commit 4a41aa6b48c134e ("runtest/fs:
> filter /dev/watchdog* for read_all_dev by default").
>
> It would be better to replace indiscriminate reading of /dev files
> with tests targeting specific files in /dev which have defined known
> behaviour, e.g., /dev/null, /dev/urandom, etc.
>
> In the meanwhile, drop the indiscriminate reading of files in /dev.

Another solution might be to add an option which drops privileges before
running the test on /dev. An unprivileged user should not have access to fi=
les
like /dev/port, but will for /dev/null and /dev/urandom.

>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: xuyang.jy@cn.fujitsu.com
> Cc: naresh.kamboju@linaro.org
> Cc: rpalethorpe@suse.com
> Cc: chrubis@suse.cz
> Cc: james.morse@arm.com
> ---
> Hi,
>
> The test leads to panic during nightly ltp runs on internal
> systems. Looking at the crash report from Naresh[0], it looks likely
> that he's facing the same problem.
>
> Please consider including in upcoming release.
>
> Thanks,
> Punit
>
> [0] http://lists.linux.it/pipermail/ltp/2018-May/007954.html
> ---
>  runtest/fs | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/runtest/fs b/runtest/fs
> index 42a9bfcbf..c7ed64fbf 100644
> --- a/runtest/fs
> +++ b/runtest/fs
> @@ -69,7 +69,6 @@ fs_di fs_di -d $TMPDIR
>  # Was not sure why it should reside in runtest/crashme and won=C2=B4t ge=
t tested ever
>  proc01 proc01 -m 128
>
> -read_all_dev read_all -d /dev -e '/dev/watchdog?(0)' -q -r 10
>  read_all_proc read_all -d /proc -q -r 10
>  read_all_sys read_all -d /sys -q -r 10


--
Thank you,
Richard.
