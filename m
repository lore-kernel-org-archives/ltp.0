From: Zorro Lang <zlang@redhat.com>
Date: Fri, 29 Nov 2019 19:20:54 +0800
Subject: [LTP] [PATCH] syscalls/newmount: new test case for new mount API
In-Reply-To: <fa006742-d29d-4d19-c628-30b0454c8f72@cn.fujitsu.com>
References: <20191128173532.6468-1-zlang@redhat.com>
 <9c487d75-0de0-af8f-a439-d3ce9d965808@cn.fujitsu.com>
 <fa006742-d29d-4d19-c628-30b0454c8f72@cn.fujitsu.com>
Message-ID: <20191129112053.GF4601@dhcp-12-102.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Nov 29, 2019 at 01:29:35PM +0800, Yang Xu wrote:
> 
> 
> on 2019/11/29 11:39, Yang Xu wrote:
> > --- /dev/null
> > +++ b/include/lapi/newmount.h
> > @@ -0,0 +1,106 @@
> > +/*
> > + * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it would be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write the Free Software Foundation,
> > + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > + */
> > +
> > +#ifndef __NEWMOUNT_H__
> > +#define __NEWMOUNT_H__
> > +
> > +#include <stdint.h>
> > +#include <unistd.h>
> > +#include "lapi/syscalls.h"
> > +
> > +#if !defined(HAVE_FSOPEN)
> When we run make autotools and ./configure, this macro is in
> "include/config.h". You should include this header file like other lapi
> files.

Oh, thanks, I refered to the include/lapi/stat.h file, it doesn't include
config.h, I don't know if it's needed.

Thanks,
Zorro

> > +static inline int fsopen(const char *fs_name, unsigned int flags)
> > +{
> 
> 

