From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 14 Sep 2017 10:08:20 -0400 (EDT)
Subject: [LTP] [PATCH 2/2] [RFC] syscalls/mmap12: Do not fail on
 non-present	pages
In-Reply-To: <20170914114452.GB3467@rei>
References: <20170817143310.11634-1-chrubis@suse.cz>
 <20170817143310.11634-2-chrubis@suse.cz>
 <1932775025.3810596.1503050454745.JavaMail.zimbra@redhat.com>
 <20170818135035.GD18499@dhcp22.suse.cz> <20170914114452.GB3467@rei>
Message-ID: <1279322628.15785758.1505398100444.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > @Michal: Can you think of alternative way to differentiate between:
> > > "MAP_POPULATE did its best" vs. "MAP_POPULATE is broken"?
> > 
> > What about reading /proc/self/smaps for the range and check for RSS
> > field? Seeing 0 could be reported as an unexpected _warning_ but I am
> > not really sure there is any correctness test we could do here. Maybe
> > just compare that MAP_POPULATE will give you the same content as the
> > manual fault in.
> 
> Jan will you try to implement something along these lines or should we
> merge the original patch before the release and look into this later in
> a case we decide to?

Hi,

Let's go with original for now.

I think RSS != 0 is likely to work, but if we can't guarantee that,
I'd prefer simpler test over sporadic/rare false positives.

Regards,
Jan
