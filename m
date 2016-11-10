From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Nov 2016 16:12:49 +0100
Subject: [LTP] du01 with btrfs on systems with > 4k page size
In-Reply-To: <582486AA.6070701@oracle.com>
References: <582340D2.6070502@oracle.com> <20161109161822.GA9168@rei.lan>
 <582486AA.6070701@oracle.com>
Message-ID: <20161110151248.GA13022@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Since the grep ignores the 6 at the start of the pattern and succeeds.
> > It's strange that logs I have in SUSE bugzilla says that it was 4k in
> > size, but that may have been true for some other kernel, since the
> > pagesize is configurable in kernel .config.
> > 
> > So I guess that we should fix the pattern to match anyhing that could be
> > pagesize. For PPC64 that should be one of 4K/16K/64K/256K, it's 8K for
> > sparc apparently so I guess that we should go for 2^n between 4 and
> > 256.
> 
> Maybe determine the default page size at runtime (getconf PAGESIZE) and
> check if testsymlink is either 0 or the page size?

Sounds good.

-- 
Cyril Hrubis
chrubis@suse.cz
