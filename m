From: Shuang Qiu <shuang.qiu@oracle.com>
Date: Wed, 13 Jan 2016 13:14:12 +0800
Subject: [LTP] [PATCH] Skip test02 before kernel 2.6.38
In-Reply-To: <1452661129-3963-1-git-send-email-shuang.qiu@oracle.com>
References: <1452661129-3963-1-git-send-email-shuang.qiu@oracle.com>
Message-ID: <5695DD24.6000905@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sorry,forgot to indicate the testcase in subject,please ignore this one.
On 01/13/2016 12:58 PM, shuang.qiu@oracle.com wrote:
> From: Shuang Qiu <shuang.qiu@oracle.com>
>
> FALLOC_FL_PUNCH_HOLE flag for fallocate syscall is available since Linux 2.6.38.
>
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
> ---
>   testcases/kernel/syscalls/fallocate/fallocate04.c |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
> index 41453ac..f77e283 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate04.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
> @@ -142,6 +142,11 @@ static void test02(void)
>   	tst_resm(TINFO, "read allocated file size '%zu'", alloc_size0);
>   	tst_resm(TINFO, "make a hole with FALLOC_FL_PUNCH_HOLE");
>   
> +	if (tst_kvercmp(2, 6, 38) < 0) {
> +		tst_brkm(TCONF, cleanup,
> +			 "Test must be run with kernel 2.6.38 or newer");
> +	}
> +
>   	if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>   	    block_size, block_size) == -1) {
>   		if (errno == EOPNOTSUPP)

