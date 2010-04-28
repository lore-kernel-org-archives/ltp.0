Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O7GGl-0008C5-Nv
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 23:02:15 +0000
Received: from mail-gw0-f47.google.com ([74.125.83.47])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O7GGk-0006AA-Q6
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 23:02:15 +0000
Received: by gwj15 with SMTP id 15so365730gwj.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 28 Apr 2010 16:02:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100428224750.GA25829@us.ibm.com>
References: <20100428224750.GA25829@us.ibm.com>
Date: Wed, 28 Apr 2010 16:02:09 -0700
Message-ID: <x2w364299f41004281602h7256b1b8t9a9554cddee90e5d@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH ltp] make filecaps tests succeed
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Wed, Apr 28, 2010 at 3:47 PM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Most of these are belated cleanup after the move to using /opt/ltp.
> Also undoing an ill-advised replacement of return with tst_exit. =A0All
> filecaps tests now succeed on fedora 10.
>
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> ---
> =A0testcases/kernel/security/filecaps/filecapstest.sh | =A0 =A09 ++++++---
> =A0testcases/kernel/security/filecaps/print_caps.c =A0 =A0| =A0 =A03 ++-
> =A0.../kernel/security/filecaps/verify_caps_exec.c =A0 =A0| =A0 19 ++++++=
++++++++-----
> =A03 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/testcases/kernel/security/filecaps/filecapstest.sh b/testcas=
es/kernel/security/filecaps/filecapstest.sh
> index 43582dc..6864de4 100755
> --- a/testcases/kernel/security/filecaps/filecapstest.sh
> +++ b/testcases/kernel/security/filecaps/filecapstest.sh
> @@ -22,8 +22,11 @@
> =A0echo "Running in:"
> =A0#rm -f print_caps
> =A0#cp $LTPROOT/testcases/bin/print_caps .
> -mkfifo caps_fifo
> -chmod 777 caps_fifo
> +#FIFOFILE=3D"$LTPROOT/testcases/bin/caps_fifo"
> +FIFOFILE=3D"/tmp/caps_fifo"

Why not

TMP=3D${TMP:=3D/tmp}
$TMP/caps_fifo

etc? FWIW if you're in $TMP already, a lot of these changes aren't
required, correct?

> +rm -f $FIFOFILE
> +mkfifo $FIFOFILE
> +chmod 777 $FIFOFILE
> =A0exit_code=3D0
> =A0echo "cap_sys_admin tests"
> =A0verify_caps_exec 0
> @@ -46,5 +49,5 @@ if [ $tmp -ne 0 ]; then
> =A0 =A0 =A0 =A0exit_code=3D$tmp
> =A0fi
>
> -unlink caps_fifo
> +unlink $FIFOFILE
> =A0exit $exit_code
> diff --git a/testcases/kernel/security/filecaps/print_caps.c b/testcases/=
kernel/security/filecaps/print_caps.c
> index f0e9bce..b887738 100644
> --- a/testcases/kernel/security/filecaps/print_caps.c
> +++ b/testcases/kernel/security/filecaps/print_caps.c
> @@ -36,7 +36,7 @@
> =A0#include <sys/capability.h>
> =A0#endif
>
> -#define FIFOFILE "caps_fifo"
> +#define FIFOFILE "/tmp/caps_fifo"
>
> =A0int main(int argc, char *argv[])
> =A0{
> @@ -68,4 +68,5 @@ int main(int argc, char *argv[])
> =A0#else
> =A0 =A0 =A0 =A0return 0;
> =A0#endif
> + =A0 =A0 =A0 return 0;

What's the value returned for #if ..? If it's `return 0', then why not
just remove the other two references in the preprocessor blocks?

> =A0}
> diff --git a/testcases/kernel/security/filecaps/verify_caps_exec.c b/test=
cases/kernel/security/filecaps/verify_caps_exec.c
> index 5250007..7360d4a 100644
> --- a/testcases/kernel/security/filecaps/verify_caps_exec.c
> +++ b/testcases/kernel/security/filecaps/verify_caps_exec.c
> @@ -43,7 +43,7 @@
> =A0#include <sys/prctl.h>
> =A0#include <test.h>
>
> -#define TSTPATH "./print_caps"
> +#define TSTPATH "print_caps"

Ok.

> =A0char *TCID =3D "filecaps";
> =A0int TST_TOTAL=3D1;
>
> @@ -70,7 +70,7 @@ void print_my_caps()
> =A0 =A0 =A0 =A0cap_free(txt);
> =A0}
>
> -int drop_root(int keep_perms)
> +void drop_root(int keep_perms)
> =A0{
> =A0 =A0 =A0 =A0int ret;
>
> @@ -84,10 +84,19 @@ int drop_root(int keep_perms)
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (keep_perms) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cap_t cap =3D cap_from_text("=3Deip");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cap_set_proc(cap);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cap) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TBROK, "cap_from_t=
ext failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D cap_set_proc(cap);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 perror(cap_set_proc);

Why??? This could potentially fubar errno too...

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TBROK | TERRNO, "c=
ap_set_proc failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();

tst_brkm(TBROK | TERRNO, tst_exit, "cap_set..."); is better

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cap_free(cap);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 tst_exit();
> =A0}
>
> =A0int perms_test(void)
> @@ -114,7 +123,7 @@ int perms_test(void)
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -#define FIFOFILE "caps_fifo"
> +#define FIFOFILE "/tmp/caps_fifo"
> =A0void create_fifo(void)
> =A0{
> =A0 =A0 =A0 =A0int ret;
> --
> 1.6.0.6

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
