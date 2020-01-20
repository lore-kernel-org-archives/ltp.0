From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 20 Jan 2020 05:56:59 -0500 (EST)
Subject: [LTP] [PATCH 2/3] tst_device.h: Use lapi/syscalls.h instead of
 <sys/syscall.h>
In-Reply-To: <20200120103108.GA15405@dell5510>
References: <20200117113715.22786-1-pvorel@suse.cz>
 <20200117113715.22786-3-pvorel@suse.cz> <20200120103108.GA15405@dell5510>
Message-ID: <558281761.2778139.1579517819187.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> >  #include <unistd.h>
> > -#include <sys/syscall.h>
> > +#include "lapi/syscalls.h"
> Hm, maybe this fix wasn't a good idea.
> It effectively uses lapi/syscalls.h everywhere instead of <sys/syscall.h>.
> Not sure if this is what we want.

We already include lapi/syscalls.h at several places, so I wouldn't expect
this to be as bad.

> 
> Example of the error is #634 [1], which is caused by __NR_socketcall being -1
> instead of not defined (socketcall is not defined on some archs, e.g. x86-64
> and ARM).
> We can fix the condition

Tests using tst_syscall or ltp_syscall should be fine, since those check
for ENOSYS.

>, but it will lead to numerous not obvious errors, so
> I
> suggest to revert this (and thus get LTP broken on very old distros).
> 

Cyril, any thoughts?

