From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Jun 2016 15:15:15 +0200
Subject: [LTP] [PATCH v2] lib/tst_test.c: Run test in child process
In-Reply-To: <1836941003.4597191.1465390741285.JavaMail.zimbra@redhat.com>
References: <20160607115806.GA1740@rei.lan>
 <969277405.4512739.1465373864678.JavaMail.zimbra@redhat.com>
 <20160608123056.GA26573@rei.lan>
 <1836941003.4597191.1465390741285.JavaMail.zimbra@redhat.com>
Message-ID: <20160608131515.GA27367@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The cleanup_ipc() is intended to be executed just before the main pid
> > exits since it unlinks the shm file.
> 
> So, if we fail a SAFE macro somewhere in lib/tst_test.c,
> I don't see we ever call cleanup_ipc().
> 
> tst_run_tcases
>  SAFE_WAITPID(test_pid, &status, 0);
>   tst_brkm
>    tst_brkm_
>     tst_brk_
>      tst_vbrk_
>       exit
> 
> > If child TBROKs it's catched in the
> > check_child_status() in the parent, tst_brk() is called which will call
> > the cleanup_ipc().
> 
> Not anymore. After this patch the only place that now calls
> cleanup_ipc() is do_exit().

Ah, right, that is since what was previously main_pid has been split
into the library process and main test process.

Indeed the cleanup_ipc() should be called from the library in the
tst_vbrk_().

> What I'm thinking is something like this on top of your patch:
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index eef54e49bafb..1a0a9494af26 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -40,7 +40,7 @@ struct tst_test *tst_test;
>  static char tmpdir_created;
>  static int iterations = 1;
>  static float duration = -1;
> -static pid_t main_pid;
> +static pid_t main_pid, lib_pid;
>  
>  struct results {
>         int passed;
> @@ -234,6 +234,9 @@ void tst_vbrk_(const char *file, const int lineno, int ttype,
>         if (getpid() == main_pid)
>                 do_test_cleanup();
>  
> +       if (getpid() == lib_pid)
> +               do_exit();
> +
>         exit(TTYPE_RESULT(ttype));
>  }
>  
> @@ -673,6 +676,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>         int status;
>         char *mul;
>  
> +       lib_pid = getpid();
>         tst_test = self;
>         TCID = tst_test->tid;

Looks good to me, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
