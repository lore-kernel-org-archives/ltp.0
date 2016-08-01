From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Aug 2016 13:23:43 +0100
Subject: [LTP] [PATCH] syscalls/mprotect04: Use
 __builtin___clear_cache() to sync caches
In-Reply-To: <20160801113157.GD6899@rei.lan>
References: <1469550665-12918-1-git-send-email-peter.maydell@linaro.org>
 <20160801113157.GD6899@rei.lan>
Message-ID: <CAFEAcA9fPp-Hemq5E6q7udfh-5jDHdiTstfNr6M7wn8JGfzbeA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 1 August 2016 at 12:31, Cyril Hrubis <chrubis@suse.cz> wrote:
> As far as I can tell this is not needed on x86 machines so maybe we
> should do something as:
>
> ...
>
> #else
> # if !defined(__x86_64__) && !defined(__i386__)
>         tst_brkm(TCONF, cleanup,
>                 "compiler doesn't have __builtin___clear_cache()");
> # endif
> #endif
>
>
> So that the test is not disabled on older x86 machines.

I considered that, but I felt it was not worth having
an architecture-specific ifdef in the code purely to support
running this test case with compilers that are a decade
old (and will only be getting rarer in the future) on one
specific architecture...

thanks
-- PMM
