From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Nov 2016 08:09:54 +0100
Subject: [LTP] [PATCH 1/2] lib: move create_sig_proc() into newlib
In-Reply-To: <20161121145701.GF25334@rei.lan>
References: <20161116161833.16910-1-pvorel@suse.cz>
 <20161121145701.GF25334@rei.lan>
Message-ID: <20161122070953.za3jy6ww75dq2lj6@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

thanks for a review!

> Hi!
> > diff --git a/include/tst_sig_proc.h b/include/tst_sig_proc.h
> > new file mode 100644
> > index 0000000..bc918eb
> > --- /dev/null
> > +++ b/include/tst_sig_proc.h
> > @@ -0,0 +1,23 @@
> > +/*
> > + * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
>                       ^
> 		      This should be you, or Linux Test Project, as it
> 		      is in several other files
I'll chose LTP as it's not a code I wrote.

<snip>
> > diff --git a/lib/tst_sig_proc.c b/lib/tst_sig_proc.c
> > new file mode 100644
> > index 0000000..a5f6c54
> > --- /dev/null
> > +++ b/lib/tst_sig_proc.c
<snip>
> > +#define TST_NO_DEFAULT_MAIN
> > +#include "tst_test.h"

> Shouldn't be including tst_safe_macros.h here enough?
Well, create_sig_proc() uses SAFE_FORK macro (defined in tst_test.h), which uses (via
safe_fork() function) tst_test structure (also defined in tst_test.h). That's probably the
reason, why SAFE_FORK isn't in tst_safe_macros.h among with other SAFE_* macros.
So I'd keep it as it is.

> > +pid_t create_sig_proc(int sig, int count, unsigned int usec)
> > +{
> > +	pid_t pid, cpid;
> > +
> > +	pid = getpid();
> > +	cpid = SAFE_FORK();
> > +
> > +	if (cpid == 0) {
> > +		while (count-- > 0) {
> > +			usleep(usec);
> > +			if (kill(pid, sig) == -1)
> > +				break;
> > +		}
> > +		exit(0);
> > +	}
> > +
> > +	return cpid;
> > +}


Kind regards,
Petr
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161122/dbb81ef3/attachment.sig>
