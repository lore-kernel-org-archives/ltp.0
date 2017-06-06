From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 6 Jun 2017 10:06:18 -0700
Subject: [LTP] [PATCH 2/2] syscalls/add_key03: add test for NULL payload
 with nonzero length
In-Reply-To: <20170606120656.GB5208@rei>
References: <20170605174811.95267-1-ebiggers3@gmail.com>
 <20170605174811.95267-3-ebiggers3@gmail.com>
 <20170606120656.GB5208@rei>
Message-ID: <20170606170618.GB88445@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 06, 2017 at 02:06:56PM +0200, Cyril Hrubis wrote:
> Hi!
> > diff --git a/testcases/kernel/syscalls/add_key/add_key03.c b/testcases/kernel/syscalls/add_key/add_key03.c
> > new file mode 100644
> > index 000000000..21812710f
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/add_key/add_key03.c
> > @@ -0,0 +1,104 @@
> > +/*
> > + * Copyright (c) 2017 Google, Inc.
> > + *
> > + * This program is free software: you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include "config.h"
> > +#ifdef HAVE_LINUX_KEYCTL_H
> > +# include <linux/keyctl.h>
> > +#endif
> > +#include "tst_test.h"
> > +#include "linux_syscall_numbers.h"
> > +
> > +/*
> > + * Test that the add_key() syscall correctly handles a NULL payload with nonzero
> > + * length.  Specifically, it should fail with EFAULT rather than oopsing the
> > + * kernel with a NULL pointer dereference or failing with EINVAL, as it did
> > + * before (depending on the key type).  This is a regression test for "KEYS: fix
> > + * dereferencing NULL payload with nonzero length".
> 
> Can you pretty please add the kernel commit hash here as well?
> 

It's not in mainline yet, but I'll resend once it is.

> > +		tst_res(TFAIL,
> > +			"add_key() with key type \"%s\" unexpectedly succeeded",
>                                                   ^
> 						  And we tend to use
> 						  single quotes that
> 						  does not have to be
> 						  escaped. But that is
> 						  very minor.

Will do in v2.

Thanks,

- Eric
