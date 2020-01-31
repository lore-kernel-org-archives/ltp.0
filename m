From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 31 Jan 2020 13:40:29 +0100
Subject: [LTP] [PATCH] Taunt OOM killer in fork12 setup()
In-Reply-To: <1041474174.5093428.1580463462902.JavaMail.zimbra@redhat.com>
References: <20200130161337.31614-1-mdoucha@suse.cz>
 <CAEemH2f7s+q1upnaikCnQZSqxb-xgdN73aPxhKhLo2i5_M7FkA@mail.gmail.com>
 <1041474174.5093428.1580463462902.JavaMail.zimbra@redhat.com>
Message-ID: <26784292-af8d-7a5e-981c-43d4da2dfcdc@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 1/31/20 10:37 AM, Jan Stancek wrote:
> ----- Original Message ----
>> It sounds more like the OOM-Killer defect but not fork12.
> 
> Badness score is based on proportion of rss/swap. It doesn't seem
> like defect to me, we just quickly spawn many small tasks.

Yes, OOM killer is working as intended here. fork12 is basically a fork
bomb test so it spawns thousands of processes with almost no allocated
memory. Since kernel 2.6.36, OOM killer uses only two criteria to decide
which process to kill:
- how much memory/swap it has allocated
- whether the process is privileged

Since fork12 children have low memory footprint, most system processes
look like better targets for OOM killer right now. But we're not testing
userspace resilience against fork bomb here. We're trying to crash the
kernel itself.

>> What we do for that is to protect the parent shell and its harness
>> to avoid oom_kill_process() acting on them.
>> 
>> On the other side, if we do raise the oom score of fork12, that
>> would not guarantee OOM-Killer do right evaluation but just makes
>> fork12 easily to be killed in testing.
> 
> fork12 is not an OOM test, so I don't see problem with this. We only
> need OOM to kill something we don't care about, in case it triggers.
> 
> I'd move oom_score_adj after fork, so only child processes are better
> target, not the parent.

oom_score_adj is inherited by child processes and OOM killer tries to
kill first-level children if it can. So setting oom_score_adj on the
main fork12 process will work exactly the way we want - OOM killer will
kill one of the child processes, fork12 will notice on line 80 and exit
gracefully.

There could be problems only on kernels older than 2.6.36 where the
number of forked children was included in OOM score calculation and the
main worker process might get targeted directly (not sure if the
kill-children-first approach was used back then).

Either way, trying to protect the parent shell is a bad idea. We'd have
to set negative oom_score_adj on it and if fork12 crashes before it can
reset it back to zero, all further test processes would inherit the OOM
protection.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
