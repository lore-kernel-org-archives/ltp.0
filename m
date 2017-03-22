From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Mar 2017 16:51:13 +0100
Subject: [LTP] Running LTP results in read-only filesystem
In-Reply-To: <1490197770.19074.24.camel@caviumnetworks.com>
References: <1488912047.22552.6.camel@caviumnetworks.com>
 <20170308111930.GA28037@rei.lan>
 <1488998475.22552.12.camel@caviumnetworks.com>
 <20170322154013.GB4960@rei.lan>
 <1490197770.19074.24.camel@caviumnetworks.com>
Message-ID: <20170322155112.GC4960@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I may have been too fast to blame LTP for my system crashes. ??I had
> another crash when not running LTP and where the filesystem became
> read-only and now I think the machine has a hardware issue. ??LTP may
> have caused the problem to appear more frequently by stressing the
> system but I don't think the underlying bug of the filesystem becoming
> read-only was due to LTP.

That tends to happen a lot. Even compiling LTP is a stress test that
found bug in VFS :-).

-- 
Cyril Hrubis
chrubis@suse.cz
