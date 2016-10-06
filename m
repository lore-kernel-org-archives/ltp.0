From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 Oct 2016 11:32:26 +0200
Subject: [LTP] [PATCH] [RFC] readahead02: Fix on Btrfs
In-Reply-To: <966408417.764925.1475744970952.JavaMail.zimbra@redhat.com>
References: <20161006081752.GA9210@rei>
 <966408417.764925.1475744970952.JavaMail.zimbra@redhat.com>
Message-ID: <20161006093226.GB9427@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Also this is getting absurdly compliated, maybe we should rethink the
> > test assertions so that we don't have to rely on reading the
> > read_ahead_kb file, perhaps we can just try to guess the maximal size by
> > calling the readahead in a loop with increasing size until it fails
> > instead.
> 
> Syscall itself won't fail, it will silently make shorter read.

Ah, it would have been much easier if we got EINVAL instead...

> If this patch goes through, then reading read_ahead_kb becomes
> useless:
>   https://lkml.org/lkml/2016/7/25/308
> 
> Perhaps, we should stop focusing on max size. We could change it to start
> with size of entire file, and for subsequent calls update file offset as
> max(MIN_SANE_READAHEAD, cache_increase_since_last_call), where MIN_SANE_READAHEAD
> would be some small arbitrary number. So there would be a guarantee
> it can eventually finish and any smaller readahead than that number would
> be considered a failure.

Sounds reasonable. Will you prepare a patch or should i work on it?

> > --- a/testcases/kernel/syscalls/readahead/readahead02.c
> > +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> > @@ -42,6 +42,7 @@
> >  #include <stdint.h>
> >  #include <unistd.h>
> >  #include <fcntl.h>
> > +#include <linux/btrfs.h>
> 
> This will be an issue on old distros/kernels.

Sure, this should be wrapped in ifdefs, but I hope that we figure out
something simpler instead.

-- 
Cyril Hrubis
chrubis@suse.cz
