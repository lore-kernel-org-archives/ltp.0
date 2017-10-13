From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 13 Oct 2017 11:06:49 +0200
Subject: [LTP] [PATCH 2/2] POSIX: Allow pthread_cond_destroy to block
In-Reply-To: <20171012140111.GC21253@rei>
References: <20171009101824.17251-1-rpalethorpe@suse.com>
 <20171009101824.17251-3-rpalethorpe@suse.com> <20171012140111.GC21253@rei>
Message-ID: <87h8v376xi.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


hello,

Cyril Hrubis writes:

> Hi!
> Do I understand this correctly that this is a preemptive fix? Since this
> test seems to work fine for me, while the barrier one blocks.
>
> Can we have this kind of information included in the commit message as
> well?
>

It deadlocks on my system. The two functions share a lot of code in
glibc as well, so the same code is responsible for the blocking.

--
Thank you,
Richard.
