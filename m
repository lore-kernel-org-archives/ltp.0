From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Dec 2020 13:47:27 +0100
Subject: [LTP] [PATCH] realtime/m4: Re-add define for robust mutexattr
 APIs
In-Reply-To: <8dc13989-88bf-1727-1dbd-83a2163ffb03@jv-coder.de>
References: <20201119095227.921830-1-lkml@jv-coder.de>
 <20201119113816.GH2785@yuki.lan>
 <8dc13989-88bf-1727-1dbd-83a2163ffb03@jv-coder.de>
Message-ID: <20201203124727.GC5809@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The code switched to the POSIX variants later on so I wonder if we even
> > need this configure check or if we can remove the ifdefs from the
> > testcases completely.
> either that or this patch. At least at the moment these tests are 
> completely broken.
> I am not sure how long pthread_mutexattr_*roboust* api is part of posix 
> and if ltp is supposed to be supported on platforms, that may not 
> implement it.

As for LTP the only part that is supposed to be used on anything else
than Linux is the open posix testsuite. The rest, including the relatime
tests, is strictly Linux only.

Looking at the glibc the pthread_mutexattr_*robust* calls were
implemented in 2010 which is 10 years from now, which means that it's
old enough to just remove the checks.

Will you send a patch or should I do so?

-- 
Cyril Hrubis
chrubis@suse.cz
