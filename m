From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 8 Jun 2016 10:31:43 -0400 (EDT)
Subject: [LTP] [PATCH v2] lib/tst_test.c: Run test in child process
In-Reply-To: <20160608140635.GC27367@rei.lan>
References: <20160607115806.GA1740@rei.lan>
 <969277405.4512739.1465373864678.JavaMail.zimbra@redhat.com>
 <20160608123056.GA26573@rei.lan>
 <1836941003.4597191.1465390741285.JavaMail.zimbra@redhat.com>
 <20160608131515.GA27367@rei.lan>
 <1570517895.4619774.1465392983796.JavaMail.zimbra@redhat.com>
 <20160608135528.GB27367@rei.lan> <20160608140635.GC27367@rei.lan>
Message-ID: <796099325.4641600.1465396303623.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, 8 June, 2016 4:06:35 PM
> Subject: Re: [LTP] [PATCH v2] lib/tst_test.c: Run test in child process
> 
> Hi!
> And I guess that the best solution is to pass the exit value to
> do_exit(), that way we have only one function that calls the exit() in
> the code called by the test library process.

I was thinking the same as your patch below, but plus these changes:
- remove call to do_cleanup in tst_run_tcases
- add call to cleanup_ipc in do_cleanup
- remove call to cleanup_ipc in do_exit
- add call to do_cleanup in do_exit

> 
> What about:
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index f7485bd..6e6d417 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -64,7 +64,7 @@ char *const tst_ipc_envp[] = {ipc_path, NULL};
>  
>  static char shm_path[1024];
>  
> -static void do_exit(void) __attribute__ ((noreturn));
> +static void do_exit(int ret) __attribute__ ((noreturn));
>  
>  static void setup_ipc(void)
>  {
> @@ -237,7 +237,7 @@ void tst_vbrk_(const char *file, const int lineno, int
> ttype,
>  		do_test_cleanup();
>  
>  	if (getpid() == lib_pid)
> -		do_exit();
> +		do_exit(TTYPE_RESULT(ttype));
>  
>  	exit(TTYPE_RESULT(ttype));
>  }
> @@ -443,10 +443,8 @@ static void parse_opts(int argc, char *argv[])
>  }
>  
>  
> -static void do_exit(void)
> +static void do_exit(int ret)
>  {
> -	int ret = 0;
> -
>  	printf("\nSummary:\n");
>  	printf("passed   %d\n", results->passed);
>  	printf("failed   %d\n", results->failed);
> @@ -719,7 +717,7 @@ void tst_run_tcases(int argc, char *argv[], struct
> tst_test *self)
>  	do_cleanup();
>  
>  	if (WIFEXITED(status) && WEXITSTATUS(status))
> -		exit(WEXITSTATUS(status));
> +		do_exit(WEXITSTATUS(status));
>  
>  	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
>  		tst_res(TINFO, "If you are running on slow machine, "
> @@ -730,5 +728,5 @@ void tst_run_tcases(int argc, char *argv[], struct
> tst_test *self)
>  	if (WIFSIGNALED(status))
>  		tst_brk(TBROK, "Test killed by %s!", tst_strsig(WTERMSIG(status)));
>  
> -	do_exit();
> +	do_exit(0);
>  }
> 
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
