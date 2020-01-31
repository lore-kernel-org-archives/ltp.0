From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 31 Jan 2020 04:37:42 -0500 (EST)
Subject: [LTP] [PATCH] Taunt OOM killer in fork12 setup()
In-Reply-To: <CAEemH2f7s+q1upnaikCnQZSqxb-xgdN73aPxhKhLo2i5_M7FkA@mail.gmail.com>
References: <20200130161337.31614-1-mdoucha@suse.cz>
 <CAEemH2f7s+q1upnaikCnQZSqxb-xgdN73aPxhKhLo2i5_M7FkA@mail.gmail.com>
Message-ID: <1041474174.5093428.1580463462902.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 
> 
> On Fri, Jan 31, 2020 at 12:13 AM Martin Doucha < mdoucha@suse.cz > wrote:
> 
> 
> On a system with low memory, fork12 can trigger OOM killer before it hits
> any fork() limits. The OOM killer might accidentally kill e.g. the parent
> shell and external testing tools will assume the test failed.
> 
> Set high oom_score_adj on the fork12 process so that the OOM killer focuses
> on it and its children.
> 
> It sounds more like the OOM-Killer defect but not fork12.

Badness score is based on proportion of rss/swap. It doesn't seem like
defect to me, we just quickly spawn many small tasks.

> What we do for that
> is to protect the parent shell and its harness to avoid oom_kill_process()
> acting on them.
> 
> On the other side, if we do raise the oom score of fork12, that would not
> guarantee OOM-Killer do right evaluation but just makes fork12 easily to be
> killed in testing.

fork12 is not an OOM test, so I don't see problem with this. We only need OOM
to kill something we don't care about, in case it triggers.

I'd move oom_score_adj after fork, so only child processes are better target,
not the parent.

