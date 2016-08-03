From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 3 Aug 2016 11:33:35 -0400 (EDT)
Subject: [LTP] [PATCH] tst_test: Allow to set timeout from test setup()
In-Reply-To: <20160803150655.GB25589@rei>
References: <20160803135355.GA30335@rei.lan>
 <1896180212.843449.1470235129619.JavaMail.zimbra@redhat.com>
 <20160803150655.GB25589@rei>
Message-ID: <1951597278.861795.1470238415053.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, 3 August, 2016 5:06:55 PM
> Subject: Re: [PATCH] tst_test: Allow to set timeout from test setup()
> 
> Hi!
> >  void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
> > @@ -706,16 +715,9 @@ void tst_run_tcases(int argc, char *argv[], struct
> > tst_test *self)
> >  
> >         do_setup(argc, argv);
> >  
> > -       if (tst_test->timeout)
> > -               tst_set_timeout(tst_test->timeout);
> > -       else
> > -               tst_set_timeout(300);
> > -
> >         SAFE_SIGNAL(SIGALRM, alarm_handler);
> >         SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
> >  
> > -       alarm(results->timeout);
> > -
> 
> After this change the tst_test->setup() runs without a timeout, doesn't it?
> 
> I think that it will be safer to have it run with either with a default
> timeout or with a test->timeout. And that is the whole point of setting
> the timeout twice in case that we call tst_set_timeout() in the test
> setup().

Good point, so setting timeout twice seems unavoidable.
But I'm still thinking about actions needed to set timeout
that are now not part of tst_set_timeout(). Would it make sense
to bring those in?


diff --git a/lib/tst_test.c b/lib/tst_test.c
index 72d46969a51d..9eb1393415fa 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -636,8 +636,6 @@ static void testrun(void)

        do_test_setup();

-       kill(getppid(), SIGUSR1);
-
        if (duration > 0)
                stop_time = get_time_ms() + (unsigned long long)(duration * 1000);

@@ -694,6 +692,11 @@ void tst_set_timeout(unsigned int timeout)
        tst_res(TINFO, "Timeout per run is %uh %02um %02us",
                results->timeout/3600, (results->timeout%3600)/60,
                results->timeout % 60);
+
+       if (getpid() == lib_pid)
+               alarm(results->timeout);
+       else
+               kill(getppid(), SIGUSR1);
 }

 void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
@@ -706,16 +709,14 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)

        do_setup(argc, argv);

+       SAFE_SIGNAL(SIGALRM, alarm_handler);
+       SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
+
        if (tst_test->timeout)
                tst_set_timeout(tst_test->timeout);
        else
                tst_set_timeout(300);

-       SAFE_SIGNAL(SIGALRM, alarm_handler);
-       SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
-
-       alarm(results->timeout);
-
        test_pid = fork();
        if (test_pid < 0)
                tst_brk(TBROK | TERRNO, "fork()");
