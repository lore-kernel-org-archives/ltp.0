From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 Oct 2016 13:16:38 +0200
Subject: [LTP] [PATCH] [RFC] readahead02: Fix on Btrfs
In-Reply-To: <414326668.771913.1475747794724.JavaMail.zimbra@redhat.com>
References: <20161006081752.GA9210@rei>
 <966408417.764925.1475744970952.JavaMail.zimbra@redhat.com>
 <20161006093226.GB9427@rei>
 <414326668.771913.1475747794724.JavaMail.zimbra@redhat.com>
Message-ID: <20161006111638.GB9711@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > If this patch goes through, then reading read_ahead_kb becomes
> > > useless:
> > >   https://lkml.org/lkml/2016/7/25/308
> > > 
> > > Perhaps, we should stop focusing on max size. We could change it to start
> > > with size of entire file, and for subsequent calls update file offset as
> > > max(MIN_SANE_READAHEAD, cache_increase_since_last_call), where
> > > MIN_SANE_READAHEAD
> > > would be some small arbitrary number. So there would be a guarantee
> > > it can eventually finish and any smaller readahead than that number would
> > > be considered a failure.
> > 
> > Sounds reasonable. Will you prepare a patch or should i work on it?
> 
> I want to finish writev patches first (very visible 4.8 syscall failure,
> if I don't count scenario in this thread). If you need this ASAP then
> go ahead, otherwise I can pick it up later.

No rush, this test wasn't working on Btrfs for quite some time.

-- 
Cyril Hrubis
chrubis@suse.cz
