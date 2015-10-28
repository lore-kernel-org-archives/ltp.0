From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 28 Oct 2015 15:12:25 +0800
Subject: [LTP] [PATCH 10/11] ipc/shmctl: Testcase failed when no root
 user run it
In-Reply-To: <1446001907-43525-10-git-send-email-cuibixuan@huawei.com>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
 <1446001907-43525-10-git-send-email-cuibixuan@huawei.com>
Message-ID: <1446016345.17485.3.camel@G08FNSTD140232>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Wed, 2015-10-28 at 03:11 +0000, Cui Bixuan wrote:
> Add tst_require_root() to testcase for shmctl().
> 
> Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
> ---
>  testcases/kernel/syscalls/ipc/shmctl/shmctl01.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
> index ac66ceb..5aa039f 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
> @@ -470,6 +470,8 @@ void setup(void)
>  {
>  	tst_sig(FORK, sighandler, cleanup);
>  
> +	Add tst_require_root();
> +

tst_requite_root();

Thanks,
Zeng

>  	TEST_PAUSE;
>  
>  	tst_tmpdir();
> -- 
> 1.6.0.2
> 
> 


