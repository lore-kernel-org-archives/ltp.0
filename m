From: Li Wang <liwang@redhat.com>
Date: Wed, 20 Mar 2019 14:11:13 +0800
Subject: [LTP] [PATCH RFC 1/3] min_free_kbytes: Fix child exit status
	check conditions
In-Reply-To: <1947630455.10371822.1553013024245.JavaMail.zimbra@redhat.com>
References: <20190319093858.584-1-liwang@redhat.com>
 <1947630455.10371822.1553013024245.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2eiWMPL3WsH4fanrbY0mx6n=Apurbp2sNPVfi+UMTw68Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

@Vipin, is there any possible you can have a look Jan's question?

On Wed, Mar 20, 2019 at 12:30 AM Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
> >
> > Fixes: #349
> >
> > min_free_kbytes test has badly formed if conditions in mem_tune()
> > for child exit status check.
>
> Can you please elaborate what's wrong about it?
>

I=E2=80=98m not sure if Vipin could help to explain this. I just nocited th=
at this
pull request was pending there more than half year, so I re-send this patch
to ML for more discussion.
https://github.com/linux-test-project/ltp/pull/350


> > This is causing test to declare as FAILED
> > despite that not being the case.
>
> Why? Shouldn't mmap succeed with overcommit =3D=3D 1?
>

I was unable to reproduce this. But AFAIK, 'overcommit =3D=3D 1' cann't
guarantee the MAP_FAILED(with ENOMEM) before oom. So I roughly made change
in the original patch to catch up both oom and map_failed scenario for any
'overcommit'.

Beside that, as I was pointed out in patch 3/3, this test has an obviously
defect in design, I'm also not sure if MemFree + (1/10 *min_free_kbytes) is
safty enough, but that's only what I can do for the case remedy.


> > Fix child exit status check conditions.
> >
> > ---ERROR LOG---
> > <..snip..>
> > mem.c:839: INFO: set overcommit_memory to 1
> > mem.c:839: INFO: set min_free_kbytes to 11580
> > memfree is 6974720 kB before eatup mem
> > memfree is 15488 kB after eatup mem
> > min_free_kbytes.c:135: FAIL: child unexpectedly failed: 0
> > mem.c:839: INFO: set min_free_kbytes to 23160
> > memfree is 7104128 kB before eatup mem
> > memfree is 26560 kB after eatup mem
> > min_free_kbytes.c:135: FAIL: child unexpectedly failed: 0
> > mem.c:839: INFO: set min_free_kbytes to 145812
> > memfree is 7101504 kB before eatup mem
> > memfree is 215872 kB after eatup mem
> > min_free_kbytes.c:135: FAIL: child unexpectedly failed: 0
> > min_free_kbytes.c:81: PASS: min_free_kbytes test pass
> > mem.c:839: INFO: set min_free_kbytes to 11580
> > ---------------
> >
> > Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > Cc: Jan Stancek <jstancek@redhat.com>
> > ---
> >  .../kernel/mem/tunable/min_free_kbytes.c      | 40 +++++--------------
> >  1 file changed, 11 insertions(+), 29 deletions(-)
> >
> > diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c
> > b/testcases/kernel/mem/tunable/min_free_kbytes.c
> > index f114dc493..d2378a700 100644
> > --- a/testcases/kernel/mem/tunable/min_free_kbytes.c
> > +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
> > @@ -119,39 +119,21 @@ static void test_tune(unsigned long
> overcommit_policy)
> >
> >               SAFE_WAITPID(pid[i], &status, WUNTRACED | WCONTINUED);
> >
> > -             if (overcommit_policy =3D=3D 2) {
> > -                     if (!WIFEXITED(status) || WEXITSTATUS(status) !=
=3D 0)
> > -                             tst_res(TFAIL,
> > -                                      "child unexpectedly failed: %d",
> > -                                      status);
> > -             } else if (overcommit_policy =3D=3D 1) {
> > -                     if (!WIFSIGNALED(status) || WTERMSIG(status) !=3D
> SIGKILL)
> > +             if (WIFEXITED(status) && WEXITSTATUS(status) !=3D 0) {
> > +                     tst_res(TFAIL,
> > +                             "child unexpectedly failed: %d", status);
> > +             } else if (WIFSIGNALED(status) && WTERMSIG(status) !=3D
> SIGKILL) {
> >  #if __WORDSIZE =3D=3D 32
> > -                     {
> > -                             if (total_mem < 3145728UL)
> > +                     if (total_mem < 3145728UL)
> >  #endif
> > -                                     tst_res(TFAIL,
> > -                                              "child unexpectedly
> failed: %d",
> > -                                              status);
> > +                             tst_res(TFAIL,
> > +                                     "child unexpectedly failed: %d",
> status);
> >  #if __WORDSIZE =3D=3D 32
> > -                             /* in 32-bit system, a process allocate
> about 3Gb memory at most */
> > -                             else
> > -                                     tst_res(TINFO, "Child can't
> allocate "
> > -                                              ">3Gb memory in 32bit
> system");
> > -                     }
> > +                     /* in 32-bit system, a process allocate about 3Gb
> memory at most */
> > +                     else
> > +                             tst_res(TINFO, "Child can't allocate "
> > +                                     ">3Gb memory in 32bit system");
> >  #endif
> > -             } else {
> > -                     if (WIFEXITED(status)) {
> > -                             if (WEXITSTATUS(status) !=3D 0) {
> > -                                     tst_res(TFAIL, "child unexpectedly
> "
> > -                                              "failed: %d", status);
> > -                             }
> > -                     } else if (!WIFSIGNALED(status) ||
> > -                                WTERMSIG(status) !=3D SIGKILL) {
> > -                             tst_res(TFAIL,
> > -                                      "child unexpectedly failed: %d",
> > -                                      status);
> > -                     }
> >               }
> >       }
> >  }
> > --
> > 2.20.1
> >
> >
>


--=20
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190320/7ddf0f55/att=
achment-0001.html>
