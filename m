From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 10 Apr 2019 20:59:34 -0400
Subject: [LTP] [PATCH v2 1/3] ima: Call test's cleanup inside
 ima_setup.sh cleanup
In-Reply-To: <20190405165225.27216-2-pvorel@suse.cz>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190405165225.27216-2-pvorel@suse.cz>
Message-ID: <1554944374.25614.25.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Fri, 2019-04-05 at 18:52 +0200, Petr Vorel wrote:
> to work the same way as setup
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/security/integrity/ima/tests/ima_setup.sh  | 6 +++++-
>  .../kernel/security/integrity/ima/tests/ima_violations.sh   | 2 --
>  2 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b=
/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 52551190a..cbded42c2 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -20,7 +20,8 @@
>  TST_TESTFUNC=3D"test"
>  TST_SETUP_CALLER=3D"$TST_SETUP"
>  TST_SETUP=3D"ima_setup"
> -TST_CLEANUP=3D"${TST_CLEANUP:-ima_cleanup}"
> +TST_CLEANUP_CALLER=3D"$TST_CLEANUP"
> +TST_CLEANUP=3D"ima_cleanup"

It seems to be working, but defining TST_SETUP and TST_CLEANUP after
defining the respective _CALLER looks strange. =C2=A0The _CALLER's string
must be empty.

>  TST_NEEDS_TMPDIR=3D1
>  TST_NEEDS_ROOT=3D1
>=20
> @@ -95,6 +96,9 @@ ima_setup()
>  ima_cleanup()
>  {
>  	local dir
> +
> +	[ -n "$TST_CLEANUP_CALLER" ] && $TST_CLEANUP_CALLER
> +

Is something else setting TST_CLEANUP_CALLER?

>  	for dir in $UMOUNT; do
>  		umount $dir
>  	done
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations=
.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index 74223c221..a44bd1230 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -51,8 +51,6 @@ cleanup()
>  {
>  	[ "$PRINTK_RATE_LIMIT" !=3D "0" ] && \
>  		sysctl -wq kernel.printk_ratelimit=3D$PRINTK_RATE_LIMIT
> -
> -	ima_cleanup
>  }
>=20
>  open_file_read()

