From: Mimi Zohar <zohar@linux.ibm.com>
Date: Sun, 20 Jan 2019 13:38:54 -0500
Subject: [LTP] [PATCH v3 6/6] ima/ima_violations: Temporarily remove the
 printk rate limit
In-Reply-To: <1547607461-11233-7-git-send-email-zhang.jia@linux.alibaba.com>
References: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547607461-11233-7-git-send-email-zhang.jia@linux.alibaba.com>
Message-ID: <1548009534.3982.216.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Wed, 2019-01-16 at 10:57 +0800, Jia Zhang wrote:
> The output frequency of audit log is limited by printk_ratelimit()
> in kernel if auditd not used. Thus, the test cases heavily depending
> on searching certain keywords in log file may fail if the matching
> patterns are exactly suppressed by printk_ratelimit().
>=20
> In order to fix such a sort of failure, just temporarily remove the
> printk rate limit, and restore its original setting when doing
> cleanup.
>=20
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>

Thanks, I wasn't aware of the sysctl. =C2=A0If the message isn't in
/var/log/messages or /var/log/audit/audit.log, do we now need to also
check journalctl?

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  .../kernel/security/integrity/ima/tests/ima_setup.sh      |  2 +-
>  .../kernel/security/integrity/ima/tests/ima_violations.sh | 15 +++++++++=
++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b=
/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 6dfb4d2..fe60981 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -20,7 +20,7 @@
>  TST_TESTFUNC=3D"test"
>  TST_SETUP_CALLER=3D"$TST_SETUP"
>  TST_SETUP=3D"ima_setup"
> -TST_CLEANUP=3D"ima_cleanup"
> +TST_CLEANUP=3D"${TST_CLEANUP:-ima_cleanup}"
>  TST_NEEDS_TMPDIR=3D1
>  TST_NEEDS_ROOT=3D1
> =20
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations=
.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index f3f40d4..74223c2 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -20,6 +20,7 @@
>  # Test whether ToMToU and open_writer violations invalidatethe PCR and a=
re logged.
> =20
>  TST_SETUP=3D"setup"
> +TST_CLEANUP=3D"cleanup"
>  TST_CNT=3D3
>  TST_NEEDS_DEVICE=3D1
> =20
> @@ -31,15 +32,29 @@ setup()
>  	FILE=3D"test.txt"
>  	IMA_VIOLATIONS=3D"$SECURITYFS/ima/violations"
>  	LOG=3D"/var/log/messages"
> +	PRINTK_RATE_LIMIT=3D"0"
> =20
>  	if status_daemon auditd; then
>  		LOG=3D"/var/log/audit/audit.log"
> +	else
> +		tst_check_cmds sysctl
> +
> +		PRINTK_RATE_LIMIT=3D`sysctl -n kernel.printk_ratelimit`
> +		sysctl -wq kernel.printk_ratelimit=3D0
>  	fi
>  	[ -f "$LOG" ] || \
>  		tst_brk TBROK "log $LOG does not exist (bug in detection?)"
>  	tst_res TINFO "using log $LOG"
>  }
> =20
> +cleanup()
> +{
> +	[ "$PRINTK_RATE_LIMIT" !=3D "0" ] && \
> +		sysctl -wq kernel.printk_ratelimit=3D$PRINTK_RATE_LIMIT
> +
> +	ima_cleanup
> +}
> +
>  open_file_read()
>  {
>  	exec 3< $FILE || exit 1

