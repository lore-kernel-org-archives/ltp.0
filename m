From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 24 Nov 2020 10:33:53 +0530
Subject: [LTP] [PATCH V2 1/2] syscalls: Add tests for name_to_handle_at()
In-Reply-To: <20201123140630.GA17077@yuki.lan>
References: <b758999c1bd02a52a68cbb6449bb3d82dd2a4e69.1606120441.git.viresh.kumar@linaro.org>
 <20201123140630.GA17077@yuki.lan>
Message-ID: <20201124050353.xyvyjar5vcfwmwhk@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 23-11-20, 15:06, Cyril Hrubis wrote:
> Hi!
> > diff --git a/include/lapi/name_to_handle_at.h b/include/lapi/name_to_handle_at.h
> > new file mode 100644
> > index 000000000000..19c08545802a
> > --- /dev/null
> > +++ b/include/lapi/name_to_handle_at.h
> > @@ -0,0 +1,54 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2020 Linaro Limited. All rights reserved.
> > + * Author: Viresh Kumar <viresh.kumar@linaro.org>
> > + */
> > +
> > +#ifndef NAME_TO_HANDLE_AT_H__
> > +#define NAME_TO_HANDLE_AT_H__
> > +
> > +#include <sys/syscall.h>
> > +#include "config.h"
> > +#include "tst_buffers.h"
> > +#include "tst_test.h"
> > +
> > +#ifndef HAVE_NAME_TO_HANDLE_AT
> > +struct file_handle {
> > +	unsigned int handle_bytes;
> > +	int handle_type;
> > +	/* File identifier.  */
> > +	unsigned char f_handle[0];
> > +};
> > +
> > +int name_to_handle_at(int dfd, const char *pathname, struct file_handle *handle,
> > +		      int *mount_id, int flags);
> > +int open_by_handle_at(int mount_fd, struct file_handle *handle, int flags);
> 
> This still is not complete solution. As far as I can tell this will fail
> to link on machine where libc does not implement these, so we have to
> make them static inline functions that actually call the tst_syscall().

This is embarrassing. Not that I was doing this for the first time, I
just completely forgot to update this path, damn. Sorry about that.

-- 
viresh
