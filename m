From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Apr 2016 17:45:06 +0800
Subject: [LTP] [PATCH V2 3/3] mm/oom: enable ksm before OOM-KSM testing
In-Reply-To: <20160331135204.GD21298@rei.lan>
References: <1458707157-31233-1-git-send-email-liwang@redhat.com>
 <1458707157-31233-2-git-send-email-liwang@redhat.com>
 <1458707157-31233-3-git-send-email-liwang@redhat.com>
 <20160331135204.GD21298@rei.lan>
Message-ID: <CAEemH2fPcP6cZ7jXj-fyfC0Ld848SpycoPoR+81Tzy065pSMFg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Mar 31, 2016 at 9:52 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> >  void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
> >  {
> > +     int ksm_run_orig;
> > +
> >       set_global_mempolicy(mempolicy);
> >
> >       tst_resm(TINFO, "start normal OOM testing.");
> > @@ -224,7 +226,10 @@ void testoom(int mempolicy, int lite, int retcode,
> int allow_sigkill)
> >                        "skip OOM test for KSM pags");
> >       } else {
> >               tst_resm(TINFO, "start OOM testing for KSM pages.");
> > +             SAFE_FILE_SCANF(cleanup, PATH_KSM "run", "%d",
> &ksm_run_orig);
> > +             SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
> >               oom(KSM, lite, retcode, allow_sigkill);
> > +             SAFE_FILE_PRINTF(cleanup,PATH_KSM "run", "%d",
> ksm_run_orig);
>                                          ^
>                                          missing space
>
> Technically the oom() can actually exit the test execution (calls
> tst_brkm()) so it would be a bit better if the value was restored in the
> test cleanup. But I guess that it's unlikely to happen and we can
> proceed with this patch.
>

hmm, right. To be honest, before I go this way, I took a consideration that
if we can enable the ksm in oom*.c codes, but looks like mm library(mem.c)
achieves so many functions for the oom test, and it will mix with other oom
special test if do like that.

Anyway, with the patch applied, oom + ksm PASS on kernel-4.4 currently.
------------------------------
oom01       0  TINFO  :  start OOM testing for KSM pages.
oom01       0  TINFO  :  expected victim is 1044.
oom01       0  TINFO  :  thread (7f6b8e4df700), allocating 3221225472 bytes.
oom01       0  TINFO  :  thread (7f6b8dcde700), allocating 3221225472 bytes.
oom01       0  TINFO  :  thread (7f6b8bcda700), allocating 3221225472 bytes.
oom01       0  TINFO  :  thread (7f6b8c4db700), allocating 3221225472 bytes.
oom01       0  TINFO  :  thread (7f6b8b4d9700), allocating 3221225472 bytes.
oom01       0  TINFO  :  thread (7f6b8ccdc700), allocating 3221225472 bytes.
oom01       0  TINFO  :  thread (7f6b8d4dd700), allocating 3221225472 bytes.
oom01       0  TINFO  :  thread (7f6b8e4df700), allocating 3221225472 bytes.
oom01       0  TINFO  :  thread (7f6b8bcda700), allocating 3221225472 bytes.
oom01       0  TINFO  :  thread (7f6b8c4db700), allocating 3221225472 bytes.
oom01       0  TINFO  :  thread (7f6b8dcde700), allocating 3221225472 bytes.
oom01       0  TINFO  :  thread (7f6b8ccdc700), allocating 3221225472 bytes.
oom01       0  TINFO  :  thread (7f6b8b4d9700), allocating 3221225472 bytes.
oom01       0  TINFO  :  thread (7f6b8d4dd700), allocating 3221225472 bytes.
oom01       5  TPASS  :  victim signalled: (9) SIGKILL
oom01       0  TINFO  :  set overcommit_memory to 0



-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160401/4989a97f/attachment-0001.html>
