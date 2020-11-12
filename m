From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Nov 2020 13:05:05 +0100
Subject: [LTP] [PATCH v2 2/2] syscalls/ptrace11: Add test for tracing
 init process
In-Reply-To: <20201112103217.GD11365@yuki.lan>
References: <20201111150926.GA21539@yuki.lan>
 <1605163724-20306-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1605163724-20306-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20201112103217.GD11365@yuki.lan>
Message-ID: <20201112120505.GA15765@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
> > + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com
> > + *
> > + * This case just check whether we can trace init(1) process and
> > + * doesn't trigger error.
> > + */
> 
> Why is init(1) special here? Is this a regression test?

Looking into the manual page this wasn't supported until 2.6.26. I guess
that we should mention that here in the test description.

-- 
Cyril Hrubis
chrubis@suse.cz
