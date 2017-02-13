From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 13 Feb 2017 13:43:07 +0100
Subject: [LTP] madvise07.c:72: FAIL: Did not receive SIGBUS
In-Reply-To: <20170213090837.GA16973@rei.lan>
References: <CAEemH2ddpwBet_2crzv+sOJ9P84fscFH1re4SCo1dD_PKGgsgA@mail.gmail.com>
 <20170213090837.GA16973@rei.lan>
Message-ID: <20170213134307.0bb5fab0@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Li & Metan,

On Mon, 13 Feb 2017 10:08:37 +0100
"Cyril Hrubis" <chrubis@suse.cz> wrote:

> Hi!
> > I'm trying to run ltp on upstream kernel-4.10.0-rc7, and found that
> > madvise07 always failing with no SIGBUS received when mmap the PRIVATE
> > memory. I hope to know if there're some relevant stuff about this
> > issue.
> > Any discussion or document for that?  
> 
> Looks like a plain old kernel bug to me.

Sorry, I have to admit that I knew this fails, but did not follow it up before
submitting the patch! don't know whether it is a bug, or if MADV_HWPOISON is
not intended to work with private memory. I would assume that it is a bug
judging by the man pages.

> 
> > # uname -r
> > 4.10.0-rc7
> > 
> > # ./madvise07
> > tst_test.c:794: INFO: Timeout per run is 0h 05m 00s
> > madvise07.c:57: INFO: madvise(0x7f25bdd7e000, 4096, MADV_HWPOISON)
> > madvise07.c:72: FAIL: Did not receive SIGBUS after accessing
> > MAP_PRIVATE memory marked with MADV_HWPOISON  
> 
> If you reach this TFAIL the child wasn't killed with a signal after it
> accessed memory marked with MADV_HWPOISON.
> 
> What hardware is this?
> 
> > madvise07.c:57: INFO: madvise(0x7f25bdd7e000, 4096, MADV_HWPOISON)
> > madvise07.c:90: PASS: madvise(..., MADV_HWPOISON) on MAP_SHARED memory  
> 

I know that it fails on x86_64 and ppc64le.

Thank you,
Richard.
