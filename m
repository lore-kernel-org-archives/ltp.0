From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Aug 2018 16:26:32 +0200
Subject: [LTP] [PATCH] Move getcwd05 to realpath01 and fix for old distro
In-Reply-To: <20180813134152.GA7239@dell5510>
References: <20180801134717.29909-1-mmoese@suse.de>
 <20180813134152.GA7239@dell5510>
Message-ID: <20180813142631.GA4374@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >  rename testcases/kernel/syscalls/{getcwd/getcwd05.c => realpath/realpath01.c} (72%)
> I wonder whether file should be named realpath_buffer_underflow.c to be more
> descriptive.

We usually keep just the names short and simple, so I would keep it as
it is.

> > diff --git a/testcases/kernel/syscalls/realpath/Makefile b/testcases/kernel/syscalls/realpath/Makefile
> > new file mode 100644
> > index 000000000..bd617d806
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/realpath/Makefile
> > @@ -0,0 +1,23 @@
> > +#
> > +#  Copyright (c) International Business Machines  Corp., 2001
> Copy paste error. + I'd prefer to use 'SPDX-License-Identifier: GPL-2.0-or-later' as it's shorter.

Just fix this before you push the patch.

> > +#
> > +#  This program is free software;  you can redistribute it and/or modify
> > +#  it under the terms of the GNU General Public License as published by
> > +#  the Free Software Foundation; either version 2 of the License, or
> > +#  (at your option) any later version.
> > +#
> > +#  This program is distributed in the hope that it will be useful,
> > +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> > +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> > +#  the GNU General Public License for more details.
> > +#
> > +#  You should have received a copy of the GNU General Public License
> > +#  along with this program;  if not, write to the Free Software
> > +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

-- 
Cyril Hrubis
chrubis@suse.cz
