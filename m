From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 6 Oct 2016 05:56:34 -0400 (EDT)
Subject: [LTP] [PATCH] [RFC] readahead02: Fix on Btrfs
In-Reply-To: <20161006093226.GB9427@rei>
References: <20161006081752.GA9210@rei>
 <966408417.764925.1475744970952.JavaMail.zimbra@redhat.com>
 <20161006093226.GB9427@rei>
Message-ID: <414326668.771913.1475747794724.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 6 October, 2016 11:32:26 AM
> Subject: Re: [PATCH] [RFC] readahead02: Fix on Btrfs
> 
> Hi!
> > > Also this is getting absurdly compliated, maybe we should rethink the
> > > test assertions so that we don't have to rely on reading the
> > > read_ahead_kb file, perhaps we can just try to guess the maximal size by
> > > calling the readahead in a loop with increasing size until it fails
> > > instead.
> > 
> > Syscall itself won't fail, it will silently make shorter read.
> 
> Ah, it would have been much easier if we got EINVAL instead...

Or if readahead returned number of bytes read instead of 0.

> 
> > If this patch goes through, then reading read_ahead_kb becomes
> > useless:
> >   https://lkml.org/lkml/2016/7/25/308
> > 
> > Perhaps, we should stop focusing on max size. We could change it to start
> > with size of entire file, and for subsequent calls update file offset as
> > max(MIN_SANE_READAHEAD, cache_increase_since_last_call), where
> > MIN_SANE_READAHEAD
> > would be some small arbitrary number. So there would be a guarantee
> > it can eventually finish and any smaller readahead than that number would
> > be considered a failure.
> 
> Sounds reasonable. Will you prepare a patch or should i work on it?

I want to finish writev patches first (very visible 4.8 syscall failure,
if I don't count scenario in this thread). If you need this ASAP then
go ahead, otherwise I can pick it up later.

Regards,
Jan
