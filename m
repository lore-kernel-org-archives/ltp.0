From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 14 Jun 2019 15:26:56 +0200
Subject: [LTP] increase quotactl01.c coverage
In-Reply-To: <5CDD3FB4.50502@cn.fujitsu.com>
References: <5CDD3FB4.50502@cn.fujitsu.com>
Message-ID: <20190614132655.GA10082@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  m4/ltp-quota.m4                               | 29 ++--------
>  .../kernel/syscalls/quotactl/quotactl01.c     | 54 ++++++++-----------
>  2 files changed, 27 insertions(+), 56 deletions(-)
> 
> diff --git a/m4/ltp-quota.m4 b/m4/ltp-quota.m4
> index a25e34a83..5618c769e 100644
> --- a/m4/ltp-quota.m4
> +++ b/m4/ltp-quota.m4
> @@ -20,9 +20,10 @@ dnl
>  dnl LTP_CHECK_SYSCALL_QUOTACTL
>  dnl ----------------------------
>  dnl
> -AC_DEFUN([LTP_CHECK_SYSCALL_QUOTACTL],[dnl
> +AC_DEFUN([LTP_CHECK_SYSCALL_QUOTACTL],[
> +AC_CHECK_HEADERS([sys/quota.h],[quota_header_prefix="sys"])
> +if test "x$quota_header_prefix" != x; then
>  	AC_LINK_IFELSE([AC_LANG_SOURCE([
> -#define _LINUX_QUOTA_VERSION 2
>  #include <sys/types.h>
>  #include <sys/quota.h>
>  #include <unistd.h>
> @@ -31,28 +32,8 @@ int main(void) {
>  	return quotactl(QCMD(Q_GETINFO, USRQUOTA), (const char *) "/dev/null",
>  			geteuid(), (caddr_t) &dq);
>  }])],[has_quotav2="yes"])
> -
> +fi
>  if test "x$has_quotav2" = xyes; then
> -	AC_DEFINE(HAVE_QUOTAV2,1,[Define to 1 if you have quota v2])
> -else
> -
> -	# got quota v1?
> -	AC_LINK_IFELSE([AC_LANG_SOURCE([
> -#define _LINUX_QUOTA_VERSION 1
> -#include <sys/types.h>
> -#include <sys/quota.h>
> -#include <unistd.h>
> -int main(void) {
> -	struct dqblk dq;
> -	return quotactl(QCMD(Q_GETQUOTA, USRQUOTA), (const char *) "/dev/null",
> -			geteuid(), (caddr_t) &dq);
> -}])],[has_quotav1="yes"])
> -
> -	if test "x$has_quotav1" = xyes; then
> -		AC_DEFINE(HAVE_QUOTAV1,1,[Define to 1 if you have quota v1])
> -	else
> -		AC_MSG_WARN(Couldn't determine quota version (please submit config.log and manpage to ltp@lists.linux.it))
> -	fi
> -
> +	AC_DEFINE(HAVE_QUOTA_Q_GETINFO,1,[Define to 1 if you have quota Q_GETINFO])
>  fi
>  ])
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
> index 92b654eba..7c5a1c401 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl01.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
> @@ -55,44 +55,29 @@
>  
>  #include "tst_test.h"
>  
> -#if defined(HAVE_QUOTAV2) || defined(HAVE_QUOTAV1)
> -# include <sys/quota.h>
> -
> -# if defined(HAVE_QUOTAV2)
> -#  define _LINUX_QUOTA_VERSION  2
> -#  ifndef QFMT_VFS_V0
> -#   define QFMT_VFS_V0     2
> -#  endif
> -#  define USRPATH MNTPOINT "/aquota.user"
> -#  define GRPPATH MNTPOINT "/aquota.group"
> -#  define FMTID	QFMT_VFS_V0
> -# else
> -#  define _LINUX_QUOTA_VERSION  1
> -#  ifndef QFMT_VFS_OLD
> -#   define QFMT_VFS_OLD    1
> -#  endif
> -#  define USRPATH MNTPOINT "/quota.user"
> -#  define GRPPATH MNTPOINT "/quota.group"
> -#  define FMTID	QFMT_VFS_OLD
> -# endif
> +#if HAVE_SYS_QUOTA_H
> +#include <sys/quota.h>
>  
> -# define MNTPOINT	"mntpoint"
> +#define MNTPOINT "mntpoint"
>  
> -static int32_t fmt_id = FMTID;
> +char USRPATH[32];
> +char GRPPATH[32];
> +static int32_t fmt_id;
>  static int test_id;
>  static struct dqblk set_dq = {
>  	.dqb_bsoftlimit = 100,
>  	.dqb_valid = QIF_BLIMITS
>  };
>  static struct dqblk res_dq;
> -# if defined(HAVE_QUOTAV2)
> +
> +# if HAVE_QUOTA_Q_GETINFO
>  static struct dqinfo set_qf = {
>  	.dqi_bgrace = 80,
>  	.dqi_valid = IIF_BGRACE
>  };
>  static struct dqinfo res_qf;
>  static int32_t fmt_buf;
> -# endif
> +#endif
>  
>  static struct tcase {
>  	int cmd;
> @@ -112,7 +97,7 @@ static struct tcase {
>  	{QCMD(Q_GETQUOTA, USRQUOTA), &test_id, &res_dq,
>  	&set_dq.dqb_bsoftlimit, &res_dq.dqb_bsoftlimit,
>  	sizeof(res_dq.dqb_bsoftlimit), "get disk quota limit for user"},
> -# if defined(HAVE_QUOTAV2)
> +# if HAVE_QUOTA_Q_GETINFO
>  	{QCMD(Q_SETINFO, USRQUOTA), &test_id, &set_qf,
>  	NULL, NULL, 0, "set information about quotafile for user"},
>  
> @@ -139,7 +124,7 @@ static struct tcase {
>  	{QCMD(Q_GETQUOTA, GRPQUOTA), &test_id, &res_dq, &set_dq.dqb_bsoftlimit,
>  	&res_dq.dqb_bsoftlimit, sizeof(res_dq.dqb_bsoftlimit),
>  	"set disk quota limit for group"},
> -# if defined(HAVE_QUOTAV2)
> +# if  HAVE_QUOTA_Q_GETINFO
>  	{QCMD(Q_SETINFO, GRPQUOTA), &test_id, &set_qf,
>  	NULL, NULL, 0, "set information about quotafile for group"},
>  
> @@ -159,18 +144,22 @@ static struct tcase {
>  
>  static void setup(void)
>  {
> -	const char *const cmd[] = {"quotacheck", "-ug", MNTPOINT, NULL};
> +	const char *const cmd[] = {"quotacheck", "-ug", "--format=vfsv0", MNTPOINT, NULL};
>  	int ret;
>  
> -
>  	ret = tst_run_cmd(cmd, NULL, NULL, 1);
>  	switch (ret) {
>  	case 255:
> -		tst_brk(TCONF, "quotacheck binary not installed");
> +		tst_brk(TBROK, "quotacheck binary not installed");

Why have you changed this to TBROK? This is not a fatal bug just missing
binary.

> +	case 0:
> +		sprintf(USRPATH, "%s/aquota.user", MNTPOINT);
> +		sprintf(GRPPATH, "%s/aquota.group", MNTPOINT);
> +		fmt_id = 2;
> +		tst_res(TINFO, "%s %s %d", USRPATH, GRPPATH, fmt_id);

Why do you sprintf() the path here? You does not seem to change it
anywhere else, so it's constant after all.

How is this exactly increasing the coverage?

> +		break;
>  	default:
>  		tst_brk(TBROK, "quotacheck exited with %i", ret);
> -	case 0:
> -	break;
> +		break;
>  	}
>  
>  	test_id = geteuid();
> @@ -187,9 +176,10 @@ static void verify_quota(unsigned int n)
>  	struct tcase *tc = &tcases[n];
>  
>  	res_dq.dqb_bsoftlimit = 0;
> +# if HAVE_QUOTA_Q_GETINFO
>  	res_qf.dqi_igrace = 0;
>  	fmt_buf = 0;
> -
> +#endif
>  	TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr));
>  	if (TST_RET == -1) {
>  		tst_res(TFAIL | TTERRNO, "quotactl failed to %s", tc->des);
> -- 
> 2.18.1
> 


-- 
Cyril Hrubis
chrubis@suse.cz
