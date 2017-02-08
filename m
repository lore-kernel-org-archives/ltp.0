From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Feb 2017 15:11:17 +0100
Subject: [LTP] [PATCH] getrandom02: relax check for returned data
In-Reply-To: <20170208140855.GC16139@rei.lan>
References: <e8ddadfad4495f90db68d5b714a570daa93b8a82.1486382998.git.jstancek@redhat.com>
 <20170207153352.GB3595@rei.suse.cz>
 <1487036067.1086032.1486484128036.JavaMail.zimbra@redhat.com>
 <20170207173028.GC3595@rei.suse.cz>
 <9fd2359c-ab9e-8f3d-3022-30ad6a430380@redhat.com>
 <20170208140855.GC16139@rei.lan>
Message-ID: <20170208141051.GD16139@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Based on that (see attached python snippet) I'm getting that:
> > "x*0.1" is quite bad, specially for N=19
> > "6+x*0.2" is a lot better, with chance ~10^-16
> 
> I'm getting the same with the fixed formula in gnuplot:
> 
> plot [10:60] 256 * comb(x, int(6 + x * 0.2) + 1) / (256 ** (int(6 + x * 0.2) + 1))
> 
> This shows a peak for 15 which is about ~10^-16.
                         ^
			should have been 14 of course

I was typing faster than thinking again...

-- 
Cyril Hrubis
chrubis@suse.cz
