From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Jan 2021 16:06:02 +0100
Subject: [LTP] [PATCH v2 4/6] can_recv_own_msgs: Convert to new library
In-Reply-To: <322f1056-0a73-65e6-531a-3275029df256@pengutronix.de>
References: <20210119093143.17222-1-rpalethorpe@suse.com>
 <20210119093143.17222-5-rpalethorpe@suse.com>
 <322f1056-0a73-65e6-531a-3275029df256@pengutronix.de>
Message-ID: <YAb1Wncn2/x6LBYj@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >  /*
> > - * tst-rcv-own-msgs.c
> > - *
> > - * Copyright (c) 2010 Volkswagen Group Electronic Research
> > - * All rights reserved.
> > - *
> > - * Redistribution and use in source and binary forms, with or without
> > - * modification, are permitted provided that the following conditions
> > - * are met:
> > - * 1. Redistributions of source code must retain the above copyright
> > - *    notice, this list of conditions and the following disclaimer.
> > - * 2. Redistributions in binary form must reproduce the above copyright
> > - *    notice, this list of conditions and the following disclaimer in the
> > - *    documentation and/or other materials provided with the distribution.
> > - * 3. Neither the name of Volkswagen nor the names of its contributors
> > - *    may be used to endorse or promote products derived from this software
> > - *    without specific prior written permission.
> 
> IANAL, I think you're missing this license. Is looks like some sort of BSD to me.
> 
> > - *
> > - * Alternatively, provided that this notice is retained in full, this
> > - * software may be distributed under the terms of the GNU General
> > - * Public License ("GPL") version 2, in which case the provisions of the
> > - * GPL apply INSTEAD OF those given above.
> 
> It doesn't say "or later".

Looks like we cannot just remove this license. So what about moving this
text into a separate COPYING file and changing the SPDX to GPL-v2.0?

-- 
Cyril Hrubis
chrubis@suse.cz
