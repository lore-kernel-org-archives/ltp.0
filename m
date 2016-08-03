From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Aug 2016 17:06:55 +0200
Subject: [LTP] [PATCH] tst_test: Allow to set timeout from test setup()
In-Reply-To: <1896180212.843449.1470235129619.JavaMail.zimbra@redhat.com>
References: <20160803135355.GA30335@rei.lan>
 <1896180212.843449.1470235129619.JavaMail.zimbra@redhat.com>
Message-ID: <20160803150655.GB25589@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
> @@ -706,16 +715,9 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>  
>         do_setup(argc, argv);
>  
> -       if (tst_test->timeout)
> -               tst_set_timeout(tst_test->timeout);
> -       else
> -               tst_set_timeout(300);
> -
>         SAFE_SIGNAL(SIGALRM, alarm_handler);
>         SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
>  
> -       alarm(results->timeout);
> -

After this change the tst_test->setup() runs without a timeout, doesn't it?

I think that it will be safer to have it run with either with a default
timeout or with a test->timeout. And that is the whole point of setting
the timeout twice in case that we call tst_set_timeout() in the test
setup().

-- 
Cyril Hrubis
chrubis@suse.cz
