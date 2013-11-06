Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ve2IG-0005mW-6f
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 12:33:08 +0000
Date: Wed, 6 Nov 2013 13:32:46 +0100
From: chrubis@suse.cz
Message-ID: <20131106123245.GA28897@rei>
References: <52780C00.6010706@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52780C00.6010706@gmx.de>
Subject: Re: [LTP] [PATCH] fcntl16.c patch
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Helge Deller <deller@gmx.de>
Cc: ltp-list@lists.sourceforge.net

Hi!
> The fcntl16 testcase is being compiled twice, once normal, and the other
> time with the _FILE_OFFSET_BITS=64 define set.
> 
> When compiled with 64bit file functions (as fcntl16_64) all 
> file functions will automatically use their 64bit variants, e.g.
> "struct flock64" instead of "struct flock".
> 
> So, when in the code e.g.
> 	fcntl(fd, F_SETLK, thislock)
> is called, this will automatically be translated into
> 	fcntl64(fd, F_SETLK64, thislock)
> and "thislock" needs to be of type "struct flock64".
> 
> So, we need to make sure that thislock is of the correct type,
> with the start and len fields being of type "off_t" which then
> will be translated into "loff_t" during compilation when 
> _FILE_OFFSET_BITS=64 is set.
> 
> This fixes the fcntl16_64 testcase on hppa64-linux-gnu with
> 32bit userspace running on 64bit kernel.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

What about using struct flock as defined in bits/fcntl.h instead?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
