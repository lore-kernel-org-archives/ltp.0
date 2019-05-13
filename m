From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 May 2019 11:40:08 +0200
Subject: [LTP] [PATCH v2 2/2] syscalls/getcpu:Add libc sched_getcpu()
 detection &&fix compiler errors
In-Reply-To: <20190513085520.GA12685@rei.lan>
References: <20190412114632.GD28648@haruka.lan>
 <1555481102-4158-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1555481102-4158-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190513082708.GA9928@dell5510> <20190513085520.GA12685@rei.lan>
Message-ID: <20190513094008.GA19326@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > @Metan: I'd be for pushing this before new release.

> Acked, please go ahead.
Merged.

...
> > BTW: when rewriting into new C API (whenever it happens) it'd be nice to test
> > both syscall and libc sched_getcpu() (if available) via recently added test_variants [1].
> > [1] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2229-testing-similar-syscalls-in-one-test

> Sure, but let's aim for that after the release has been finished.
Sure, nothing should block release :).


Kind regards,
Petr
