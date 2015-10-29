From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 29 Oct 2015 13:46:04 +0100
Subject: [LTP] [PATCH 10/11] ipc/shmctl: Testcase failed when no root
 user run it
In-Reply-To: <1446001907-43525-10-git-send-email-cuibixuan@huawei.com>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
 <1446001907-43525-10-git-send-email-cuibixuan@huawei.com>
Message-ID: <20151029124603.GC23990@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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
>  	TEST_PAUSE;
>  
>  	tst_tmpdir();

This one runs fine as well.

-- 
Cyril Hrubis
chrubis@suse.cz
