From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 6 Dec 2019 14:58:05 +0100
Subject: [LTP] [PATCH v2] futex_cmp_requeue01: fix test expectations
In-Reply-To: <1013755663.15334773.1575587950733.JavaMail.zimbra@redhat.com>
References: <1059626680.11523678.1573489826970.JavaMail.zimbra@redhat.com>
 <ec1792be62432bb64e4d5c5085f6ebfa7e5d4b53.1573562645.git.jstancek@redhat.com>
 <20191120161634.GA31645@rei>
 <1318319247.13280749.1574323496266.JavaMail.zimbra@redhat.com>
 <20191121110236.GB14186@rei.lan>
 <1965156629.13355311.1574352460203.JavaMail.zimbra@redhat.com>
 <1013755663.15334773.1575587950733.JavaMail.zimbra@redhat.com>
Message-ID: <20191206135805.GA729@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Any thoughts about my last reply?

Sorry this fallen out of my radar since I've been off previous week.

> > > > > Unless spurious wakeup has happened between the requeue and wake
> > > > > operation which means that the num_requeues can be smaller because we
> > > > > will wake up less than requeued processes. So if we sampled spurious
> > > > > wakeups before the requeue operation and after the futex_wake() for
> > > > > requeued processes and call it delta_spurious we would get a range:
> > > > > 
> > > > > TST_RET - num_requeues >= set_wakes
> > > > 
> > > > This doesn't look correct if we consider spurious wakeups:
> > > > 
> > > > 5 processes, set_wakes = 5, set_requeue = 0, 1 spuriously wakes up,
> > > > remaining 4 are woken up by futex(), 0 are requeued:
> > > > 
> > > > 4 - 0 >= 5
> > > 
> > > Well I was betting on the fact that we wake up much less processes than
> > > we attempt to lock on the futex and that waking up processes takes
> > > precedence. I we can add delta_spurious to the right side that wouldn't
> > > change much and we end up being correct all the time, i.e.
> > > 
> > > TST_RET + delta_spurious - num_requeues >= set_wakes
> > 
> > I'd go with just spurious instead of delta_spurious. If there is spurious
> > wake up before requeue (and first sample), wouldn't that fail in same way
> > as example above?
> > 
> > TST_RET + delta_spurious - num_requeues >= set_wakes
> > 4 + 0 - 0 >= 5
> > 
> > Also delta_spurious looks racy, because it's based on counter
> > that is increased only after user-space gets chance to run. But process
> > may have been already removed from futex queue on kernel side.
> > So 'first sample before requeue' can see inaccurate state.
> > 
> > So I'd tweak your check to:
> >   set_wakes-spurious <= TST_RET-num_requeues <= set_wakes+spurious

Sounds reasonable to me.

-- 
Cyril Hrubis
chrubis@suse.cz
