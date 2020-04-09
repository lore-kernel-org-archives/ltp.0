From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Apr 2020 12:09:25 +0200
Subject: [LTP] [PATCH v1 01/10] lapi: Add a configure check and fallback
 for loop ioctl and flag
In-Reply-To: <6bb6bc11-c3c0-48e5-0a67-80b246dfbe4b@suse.cz>
References: <1585839990-19923-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1585839990-19923-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <6bb6bc11-c3c0-48e5-0a67-80b246dfbe4b@suse.cz>
Message-ID: <20200409100925.GC9792@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
> 
> Here's a little legal issue for LTP: "GPL" and "All rights reserved" are
> mutually exclusive. Those two lines are effectively saying that your
> code is both open-source and proprietary at the same time. Please pick
> one, or the other. It can't be both.

Actually the "All rights reserved" should not have any legal effects.
The Buenos Aires Convention required that text for estabilishing
copyright which you would have needed before you could license your work
under GPL. However it's long obsolete now and has no legal effect as far
as I can tell.

Btw "All rights reserved" is part of the BSD MIT license because of
these reasons.

-- 
Cyril Hrubis
chrubis@suse.cz
