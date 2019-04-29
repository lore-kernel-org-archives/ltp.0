From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 29 Apr 2019 13:59:52 +0200
Subject: [LTP] LTP Release
In-Reply-To: <CAEemH2ezD-diAYeG0=pbgUgdMtSFxs+dWYo4CnDNdHQT=SOEaQ@mail.gmail.com>
References: <20190418111812.GB3073@rei.lan> <20190426131258.GA18760@rei>
 <CAEemH2ezD-diAYeG0=pbgUgdMtSFxs+dWYo4CnDNdHQT=SOEaQ@mail.gmail.com>
Message-ID: <20190429115952.GA6265@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > So as usually please go ahead and point out anything that should go in
> > > before the release.
> >
> > Only Peter replied so far, so I suppose that we are ready to freeze git
> > starting next week and start the pre-release testing.
> >
> > Or is there anything that has to be considered to be included before we
> > do that?
> >
> 
> Here is a simple fix for hugepage test broken with memory shortage.
> Consider merging?
> http://lists.linux.it/pipermail/ltp/2019-April/011714.html

The basic idea looks OK however:

* the function name (reset_hugepages) is a bit confusing
  what about "cap_hugepages" or "limit_hugepages"

* The MemFree: may be close to zero on long running system because of
  cached files, AFAIK MemAvailable: would be a better choice, see:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=34e431b0ae398fc54ea69ff85ec700722c9da773

  Unfortunately that one is available since 3.14 kernel, if we wanted to
  run on older kenrnels I would propose to fall back to dropping caches
  and using MemFree: on kernel that does not have MemAvailable: in
  meminfo.

-- 
Cyril Hrubis
chrubis@suse.cz
