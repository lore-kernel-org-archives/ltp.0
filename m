From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 16 Jan 2017 10:13:33 +0800
Subject: [LTP] [PATCH] quotactl01: replace int comparison with memcmp
In-Reply-To: <74ba2553e066b29871bd1e16f00755eb57747fc8.1484307598.git.jstancek@redhat.com>
References: <74ba2553e066b29871bd1e16f00755eb57747fc8.1484307598.git.jstancek@redhat.com>
Message-ID: <587C2C4D.20600@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2017/01/13 19:43, Jan Stancek wrote:
> Testcase currently uses unsigned long for all returned
> and expected values. This doesn't work for some cases,
> for example Q_GETFMT returns 32bit number. So if we pass
> in unsigned long (8 bytes) on big endian, the comparison
> breaks:
>
> quotactl01.c:198: FAIL: quotactl got unexpected info 8589934592, expected 2
> 2 << 32 == 8589934592
>
> This patch converts parameters to void* and adds size value. After
> syscall it passes all to memcmp.
>
> Patch also removes dummy "data" variable and replaces it with
> NULL and 0 size parameters.
Hi Jan

It looks fine to me, thanks for your patch.

Best Regards,
Xiao Yang
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/quotactl/quotactl01.c | 99 +++++++++++++++----------
>  1 file changed, 58 insertions(+), 41 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
> index 586272af1d0c..fb74a8a6404f 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl01.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
> @@ -79,9 +79,8 @@
>  # define MNTPOINT	"mntpoint"
>  
>  static int mount_flag;
> -static unsigned long fmt_id = FMTID;
> -static unsigned long test_id;
> -static unsigned long data;
> +static int32_t fmt_id = FMTID;
> +static int test_id;
>  static struct dqblk set_dq = {
>  	.dqb_bsoftlimit = 100,
>  	.dqb_valid = QIF_BLIMITS
> @@ -93,53 +92,70 @@ static struct dqinfo set_qf = {
>  	.dqi_valid = IIF_BGRACE
>  };
>  static struct dqinfo res_qf;
> -static unsigned long fmt_buf[32];
> +static int32_t fmt_buf;
>  # endif
>  
>  static struct tcase {
>  	int cmd;
> -	unsigned long *id;
> +	int *id;
>  	void *addr;
> -	unsigned long *set_data;
> -	unsigned long *res_data;
> +	void *set_data;
> +	void *res_data;
> +	int sz;
>  	char *des;
>  } tcases[] = {
> -	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, USRPATH, &data, &data,
> -	"turn on quota for user"},
> -	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dq, &data, &data,
> -	"set disk quota limit for user"},
> -	{QCMD(Q_GETQUOTA, USRQUOTA), &test_id, &res_dq, &set_dq.dqb_bsoftlimit,
> -	&res_dq.dqb_bsoftlimit, "get disk quota limit for user"},
> +	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, USRPATH,
> +	NULL, NULL, 0, "turn on quota for user"},
> +
> +	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dq,
> +	NULL, NULL, 0, "set disk quota limit for user"},
> +
> +	{QCMD(Q_GETQUOTA, USRQUOTA), &test_id, &res_dq,
> +	&set_dq.dqb_bsoftlimit, &res_dq.dqb_bsoftlimit,
> +	sizeof(res_dq.dqb_bsoftlimit), "get disk quota limit for user"},
>  # if defined(HAVE_QUOTAV2)
> -	{QCMD(Q_SETINFO, USRQUOTA), &test_id, &set_qf, &data, &data,
> -	"set information about quotafile for user"},
> -	{QCMD(Q_GETINFO, USRQUOTA), &test_id, &res_qf, &set_qf.dqi_bgrace,
> -	&res_qf.dqi_bgrace, "get information about quotafile for user"},
> -	{QCMD(Q_GETFMT, USRQUOTA), &test_id, fmt_buf, &fmt_id, fmt_buf,
> +	{QCMD(Q_SETINFO, USRQUOTA), &test_id, &set_qf,
> +	NULL, NULL, 0, "set information about quotafile for user"},
> +
> +	{QCMD(Q_GETINFO, USRQUOTA), &test_id, &res_qf,
> +	&set_qf.dqi_bgrace, &res_qf.dqi_bgrace, sizeof(res_qf.dqi_bgrace),
> +	"get information about quotafile for user"},
> +
> +	{QCMD(Q_GETFMT, USRQUOTA), &test_id, &fmt_buf,
> +	&fmt_id, &fmt_buf, sizeof(fmt_buf),
>  	"get quota format for user"},
>  # endif
> -	{QCMD(Q_SYNC, USRQUOTA), &test_id, &res_dq, &data, &data,
> -	"update quota usages for user"},
> -	{QCMD(Q_QUOTAOFF, USRQUOTA), &test_id, USRPATH, &data, &data,
> -	"turn off quota for user"},
> -	{QCMD(Q_QUOTAON, GRPQUOTA), &fmt_id, GRPPATH, &data, &data,
> -	"turn on quota for group"},
> -	{QCMD(Q_SETQUOTA, GRPQUOTA), &test_id, &set_dq, &data, &data,
> -	"set disk quota limit for group"},
> +	{QCMD(Q_SYNC, USRQUOTA), &test_id, &res_dq,
> +	NULL, NULL, 0, "update quota usages for user"},
> +
> +	{QCMD(Q_QUOTAOFF, USRQUOTA), &test_id, USRPATH,
> +	NULL, NULL, 0, "turn off quota for user"},
> +
> +	{QCMD(Q_QUOTAON, GRPQUOTA), &fmt_id, GRPPATH,
> +	NULL, NULL, 0, "turn on quota for group"},
> +
> +	{QCMD(Q_SETQUOTA, GRPQUOTA), &test_id, &set_dq,
> +	NULL, NULL, 0, "set disk quota limit for group"},
> +
>  	{QCMD(Q_GETQUOTA, GRPQUOTA), &test_id, &res_dq, &set_dq.dqb_bsoftlimit,
> -	&res_dq.dqb_bsoftlimit, "set disk quota limit for group"},
> +	&res_dq.dqb_bsoftlimit, sizeof(res_dq.dqb_bsoftlimit),
> +	"set disk quota limit for group"},
>  # if defined(HAVE_QUOTAV2)
> -	{QCMD(Q_SETINFO, GRPQUOTA), &test_id, &set_qf, &data, &data,
> -	"set information about quotafile for group"},
> +	{QCMD(Q_SETINFO, GRPQUOTA), &test_id, &set_qf,
> +	NULL, NULL, 0, "set information about quotafile for group"},
> +
>  	{QCMD(Q_GETINFO, GRPQUOTA), &test_id, &res_qf, &set_qf.dqi_bgrace,
> -	&res_qf.dqi_bgrace, "get information about quotafile for group"},
> -	{QCMD(Q_GETFMT, GRPQUOTA), &test_id, fmt_buf, &fmt_id, fmt_buf,
> -	"get quota format for group"},
> +	&res_qf.dqi_bgrace, sizeof(res_qf.dqi_bgrace),
> +	"get information about quotafile for group"},
> +
> +	{QCMD(Q_GETFMT, GRPQUOTA), &test_id, &fmt_buf,
> +	&fmt_id, &fmt_buf, sizeof(fmt_buf), "get quota format for group"},
>  # endif
> -	{QCMD(Q_SYNC, GRPQUOTA), &test_id, &res_dq, &data, &data,
> -	"update quota usages for group"},
> -	{QCMD(Q_QUOTAOFF, GRPQUOTA), &test_id, GRPPATH, &data, &data,
> -	"turn off quota for group"}
> +	{QCMD(Q_SYNC, GRPQUOTA), &test_id, &res_dq,
> +	NULL, NULL, 0, "update quota usages for group"},
> +
> +	{QCMD(Q_QUOTAOFF, GRPQUOTA), &test_id, GRPPATH,
> +	NULL, NULL, 0, "turn off quota for group"}
>  };
>  
>  static void setup(void)
> @@ -185,7 +201,7 @@ static void verify_quota(unsigned int n)
>  
>  	res_dq.dqb_bsoftlimit = 0;
>  	res_qf.dqi_igrace = 0;
> -	memset(fmt_buf, 0, sizeof(fmt_buf));
> +	memset(&fmt_buf, 0, sizeof(fmt_buf));
>  
>  	TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr));
>  	if (TEST_RETURN == -1) {
> @@ -193,13 +209,14 @@ static void verify_quota(unsigned int n)
>  		return;
>  	}
>  
> -	if (*tc->set_data != *tc->res_data) {
> -		tst_res(TFAIL, "quotactl got unexpected info %lu, "
> -			"expected %lu", *tc->res_data, *tc->set_data);
> +	if (memcmp(tc->res_data, tc->set_data, tc->sz)) {
> +		tst_res(TFAIL, "quotactl failed to %s", tc->des);
> +		tst_res_hexd(TINFO, tc->res_data, tc->sz, "retval:   ");
> +		tst_res_hexd(TINFO, tc->set_data, tc->sz, "expected: ");
>  		return;
>  	}
>  
> -	tst_res(TPASS, "quotactl secceeded to %s", tc->des);
> +	tst_res(TPASS, "quotactl succeeded to %s", tc->des);
>  }
>  
>  static struct tst_test test = {



