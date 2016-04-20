From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 20 Apr 2016 13:55:38 +0300
Subject: [LTP] [PATCH] syscall/fcntl33.c: fix test on FUSE fs
In-Reply-To: <20160419180151.GE21282@rei.lan>
References: <1461086247-23235-1-git-send-email-alexey.kodanev@oracle.com>
 <20160419180151.GE21282@rei.lan>
Message-ID: <5717602A.1020400@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 19.04.2016 21:01, Cyril Hrubis wrote:
>   
>   static void do_test(int i)
>   {
> -	pid_t cpid;
> +	fd = SAFE_OPEN(cleanup, "file", O_RDONLY);
> +
> +	pid_t cpid = tst_fork();
>   
> -	cpid = tst_fork();
>   	if (cpid < 0)
>   		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
>   
> -	if (cpid == 0)
> +	if (cpid == 0) {
> +		SAFE_CLOSE(NULL, fd);
>   		do_child(i);
> -
> -	fd = SAFE_OPEN(cleanup, "file", O_RDONLY);
> +	}
> Looks good.
>
> Another possible solution would be to use checkpoints and wait in the
> child before we call tst_process_state_wait() and wake it up from parent
> just before we call the fcntl(). But that would be more complicated than
> this.

Yes, it would be a more portable alternative instead of waiting for a 
sleep state in a child.

Applied the original patch which has a simpler fix.

Thanks,
Alexey


