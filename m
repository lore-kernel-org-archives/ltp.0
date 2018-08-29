From: Li Wang <liwan@redhat.com>
Date: Wed, 29 Aug 2018 12:52:11 +0800
Subject: [LTP] [PATCH v2 1/2] lib: add tst_get_timeout()
In-Reply-To: <1445215680.43198555.1535467127164.JavaMail.zimbra@redhat.com>
References: <6680bda80c85d424a5219d9f55dc9c5355dc0da1.1535454204.git.jstancek@redhat.com>
 <20180828125808.GB24095@rei> <87wosashbp.fsf@rpws.prws.suse.cz>
 <1445215680.43198555.1535467127164.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2cd9_j+g0suRSEXw2UyM+XrPnWUv5UaLCybk8WeikxyFA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 28, 2018 at 10:38 PM, Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > Hello,
> >
> > Cyril Hrubis <chrubis@suse.cz> writes:
> >
> > > Hi!
> > > It's just an idea, but we can make this even more elegant API.
> > >
> > > We measure the time in the test library anyway, so what about we added
> > > something as tst_timeout_reached() that would return number of seconds
> > > remaining to 80% of the real timeout or 0 if in a case that the timeout
> > > was reached. Then we can use this as a soft-timeout in all the
> testcases
> > > without any additional steps.
> > >
> > > --
> > > Cyril Hrubis
> > > chrubis@suse.cz
> >
> > 80% is probably way more than many of the CVE test cases need unless the
> > overall timeout is reduced from 5 minutes. Probably 20% would be
> > OK. Assuming this is the kind of usage scenario you had in mind.
>
> I'd leave it to user. Give him data how much time is left,
> and let him decide what is sensible limit for soft-timeout.
>
> Hmm, I'm not sure if I have any misunderstood on Cyril's words. But from
what I think, maybe we also could give more flexible to customize the
soft-timeout as tst_timeout_reached(0.8) to return true when testcase
reached 80% of the real timeout. This makes thing more easier and can
satisfy some kind of demanded.

Here I draw the main idea base on Jan's V3 patch:


diff --git a/include/tst_test.h b/include/tst_test.h
index 98dacf3..7318c3e 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -218,6 +218,7 @@ const char *tst_strsig(int sig);
 const char *tst_strstatus(int status);

 void tst_set_timeout(int timeout);
+unsigned int tst_timeout_reached(float ratio);

 #ifndef TST_NO_DEFAULT_MAIN

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2f3d357..7864aa5 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -47,6 +47,8 @@ static int iterations = 1;
 static float duration = -1;
 static pid_t main_pid, lib_pid;
 static int mntpoint_mounted;
+static clockid_t tst_clock;
+static struct timespec tst_start_time;

 struct results {
  int passed;
@@ -758,6 +760,7 @@ static void do_setup(int argc, char *argv[])

  if (tst_test->sample)
  tst_test = tst_timer_test_setup(tst_test);
+ tst_clock = tst_timer_find_clock();

  parse_opts(argc, argv);

@@ -1012,6 +1015,8 @@ void tst_set_timeout(int timeout)
  results->timeout = results->timeout * m + 0.5;
  }

+ if (tst_clock_gettime(tst_clock, &tst_start_time))
+ tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
  tst_res(TINFO, "Timeout per run is %uh %02um %02us",
  results->timeout/3600, (results->timeout%3600)/60,
  results->timeout % 60);
@@ -1022,6 +1027,24 @@ void tst_set_timeout(int timeout)
  heartbeat();
 }

+unsigned int tst_timeout_reached(float ratio)
+{
+       static struct timespec now;
+       unsigned int elapsed;
+
+       if (ratio >= 1 || ratio <= 0)
+               tst_brk(TBROK, "ratio should be: 0 < ratio < 1");
+
+       if (tst_clock_gettime(tst_clock, &now))
+               tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
+
+       elapsed = tst_timespec_diff_ms(now, tst_start_time) / 1000;
+       if (elapsed >= (results->timeout * ratio))
+               return 1;
+
+       return 0;
+}
+
 static int fork_testrun(void)
 {
  int status;
diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c
b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 43acb42..0dc94ee 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -123,14 +123,15 @@ static void do_test(void)
  memset(addr, 0, TEST_PAGES * hpsz);

  SAFE_MUNMAP(addr, TEST_PAGES * hpsz);
- }

- if (i == LOOPS) {
- SAFE_KILL(cpid, SIGKILL);
- SAFE_WAITPID(cpid, &status, 0);
- if (!WIFEXITED(status))
- tst_res(TPASS, "Bug not reproduced");
+ if(tst_timeout_reached(0.8))
+ break;
  }
+
+ SAFE_KILL(cpid, SIGKILL);
+ SAFE_WAITPID(cpid, &status, 0);
+ if (!WIFEXITED(status))
+ tst_res(TPASS, "Bug not reproduced");
 }

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180829/abed3a77/attachment-0001.html>
