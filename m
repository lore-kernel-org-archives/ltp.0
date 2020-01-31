From: Li Wang <liwang@redhat.com>
Date: Fri, 31 Jan 2020 17:47:03 +0800
Subject: [LTP] [PATCH] Taunt OOM killer in fork12 setup()
In-Reply-To: <1041474174.5093428.1580463462902.JavaMail.zimbra@redhat.com>
References: <20200130161337.31614-1-mdoucha@suse.cz>
 <CAEemH2f7s+q1upnaikCnQZSqxb-xgdN73aPxhKhLo2i5_M7FkA@mail.gmail.com>
 <1041474174.5093428.1580463462902.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2ftRvWTbx5DpuoaYiP_iZmb0O2NQwFi2bya2_VweB7=-A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jan 31, 2020 at 5:37 PM Jan Stancek <jstancek@redhat.com> wrote:

>
> ----- Original Message -----
> >
> >
> > On Fri, Jan 31, 2020 at 12:13 AM Martin Doucha < mdoucha@suse.cz >
> wrote:
> >
> >
> > On a system with low memory, fork12 can trigger OOM killer before it hits
> > any fork() limits. The OOM killer might accidentally kill e.g. the parent
> > shell and external testing tools will assume the test failed.
> >
> > Set high oom_score_adj on the fork12 process so that the OOM killer
> focuses
> > on it and its children.
> >
> > It sounds more like the OOM-Killer defect but not fork12.
>
> Badness score is based on proportion of rss/swap. It doesn't seem like
> defect to me, we just quickly spawn many small tasks.
>

Ok, but killing the parent shell is not what we wanted anyway. Though oom
killer does the right evaluation and gives a high score to the whole test
framework, that will break ltp reporting.


>
> > What we do for that
> > is to protect the parent shell and its harness to avoid
> oom_kill_process()
> > acting on them.
> >
> > On the other side, if we do raise the oom score of fork12, that would not
> > guarantee OOM-Killer do right evaluation but just makes fork12 easily to
> be
> > killed in testing.
>
> fork12 is not an OOM test, so I don't see problem with this. We only need
> OOM
> to kill something we don't care about, in case it triggers.
>
> I'd move oom_score_adj after fork, so only child processes are better
> target,
> not the parent.
>

Exactly, I agree with this. At least only target for the child process.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200131/37f336a1/attachment.htm>
