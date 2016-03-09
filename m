From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Mar 2016 13:00:39 +0100
Subject: [LTP] [PATCH] syscalls/profil01: disable this test for uClibc
In-Reply-To: <3ABF60118B9B784CA5BF7C841D2F00ECFB6AED@DE02WEMBXB.internal.synopsys.com>
References: <1457109655-6170-1-git-send-email-yuriy.kolerov@synopsys.com>
 <20160307095424.GA3559@rei.suse.cz>
 <3ABF60118B9B784CA5BF7C841D2F00ECFB6ABC@DE02WEMBXB.internal.synopsys.com>
 <3ABF60118B9B784CA5BF7C841D2F00ECFB6AED@DE02WEMBXB.internal.synopsys.com>
Message-ID: <20160309120039.GC27617@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The problem is that an environment variable must be defined to exclude
> tests for uClibc in Makefiles. And tests must be built by this way (as
> it done in uClinux):
>
> make UCLIBC=1

Yes. It's the same for UCLINUX. You have to set UCLINUX=1 (which causes
env_post.mk to add -DUCLINUX and -D__UCLIBC__). But it's the UCLINUX
variable that is used in the Makefiles.

> Exclusion may be implemented in "testcases/kernel/syscalls/Makefile" like this:
> 
> ifeq ($(__UCLIBC__),1)
> FILTER_OUT_DIRS	+= profil
> endif

Why the double underscores here? I would rather go for simple $(UCLIBC)
hre.

> So UCLIBC variable must be set explicitly. Is it a right way?

Yes.

-- 
Cyril Hrubis
chrubis@suse.cz
