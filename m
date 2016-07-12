From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Jul 2016 15:38:24 +0200
Subject: [LTP] [PATCH] syscalls/mmap16: close open files in cleanup path
In-Reply-To: <1497887326.3689343.1468245872467.JavaMail.zimbra@redhat.com>
References: <1467384925-24792-1-git-send-email-peter.maydell@linaro.org>
 <1194994844.3639216.1468239570693.JavaMail.zimbra@redhat.com>
 <CAFEAcA_5+0TQMr4iQSD2ogCRXyB9Jii6x-5xO8-j1M7zRStWFQ@mail.gmail.com>
 <1497887326.3689343.1468245872467.JavaMail.zimbra@redhat.com>
Message-ID: <20160712133824.GB2651@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > after the SAFE_CLOSE() line? doc/test-writing-guidelines.txt
> > says "The SAFE_CLOSE() function also sets the passed file
> > descriptor to -1 after it's successfully closed.", so if
> > that's not correct we should fix the docs.
> 
> It's true for newlib, but not for oldlib. I think we should
> rather fix oldlib SAFE_CLOSE to match the docs, so I dropped
> the line:
> 
> include/old/safe_macros.h:
> #define SAFE_CLOSE(cleanup_fn, fildes)  \
>         safe_close(__FILE__, __LINE__, (cleanup_fn), (fildes))
> 
> I'll send a patch for oldlib SAFE_CLOSE.

I avoided changing the oldlib in order not to introduce any regressions.
There may be code that depends on the fd > 0 even after the close, it's
unlikely but possible.

I'm OK with changing it, I just avoided to do so in the patch that added
the new library API.

> > That doc also gives an example (in section 2.2.1) that
> > says "Since global variables are initialized to zero we can
> > just check that fd > 0 before we attempt to close it.",
> > which is why I used 0 rather than -1. If current preferred
> > test style has changed it would be nice to update the
> > example code.
> 
> Hmm. Cyril, can we guarantee that testcase won't open fd 0?
> Would that apply for both newlib and oldlib?

Well the fd 0 always points to STDIN, so unless the test actively closes
it this will work. There may be testcases that does that, and would
require special treatement, but I'm pretty sure that these are in single
numbers.

-- 
Cyril Hrubis
chrubis@suse.cz
