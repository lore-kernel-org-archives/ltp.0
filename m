From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 1 Aug 2016 18:17:28 +0200
Subject: [LTP] [PATCH] syscalls/mprotect04: Use
 __builtin___clear_cache() to sync caches
In-Reply-To: <CAFEAcA9fPp-Hemq5E6q7udfh-5jDHdiTstfNr6M7wn8JGfzbeA@mail.gmail.com>
References: <1469550665-12918-1-git-send-email-peter.maydell@linaro.org>
 <20160801113157.GD6899@rei.lan>
 <CAFEAcA9fPp-Hemq5E6q7udfh-5jDHdiTstfNr6M7wn8JGfzbeA@mail.gmail.com>
Message-ID: <20160801161727.GA13333@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I considered that, but I felt it was not worth having
> an architecture-specific ifdef in the code purely to support
> running this test case with compilers that are a decade
> old (and will only be getting rarer in the future) on one
> specific architecture...

Well I would be slightly inclined not to introduce false regressions
with newer LTP versions. But given that this affects only really old
compilers we may as well get with your version.

-- 
Cyril Hrubis
chrubis@suse.cz
