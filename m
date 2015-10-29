From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 29 Oct 2015 13:45:01 +0100
Subject: [LTP] [PATCH 9/11] ipc/semctl: Testcases failed when no root
 user run it
In-Reply-To: <1446001907-43525-9-git-send-email-cuibixuan@huawei.com>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
 <1446001907-43525-9-git-send-email-cuibixuan@huawei.com>
Message-ID: <20151029124501.GB23990@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl07.c b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
> index 3cc1eff..2eb9b5e 100644
> --- a/testcases/kernel/syscalls/ipc/semctl/semctl07.c
> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
> @@ -155,6 +155,8 @@ void setup(void)
>  {
>  	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>  
> +	tst_require_root();
> +
>  	TEST_PAUSE;
>  
>  	tst_tmpdir();

This test runs fine without root for me.

-- 
Cyril Hrubis
chrubis@suse.cz
