Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lethal@linux-sh.org>) id 1MR13e-000079-Ar
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 09:45:50 +0000
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]
	helo=master.linux-sh.org)
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MR13a-0003vh-Sp
	for ltp-list@lists.sourceforge.net; Wed, 15 Jul 2009 09:45:50 +0000
Date: Wed, 15 Jul 2009 18:21:13 +0900
From: Paul Mundt <lethal@linux-sh.org>
Message-ID: <20090715092113.GA1863@linux-sh.org>
References: <4A5C8068.6020203@monstr.eu> <200907141843.05629.arnd@arndb.de>
	<4A5CB8B4.7050108@monstr.eu> <200907141913.21240.arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200907141913.21240.arnd@arndb.de>
Subject: Re: [LTP] access_ok macor
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: LTP <ltp-list@lists.sourceforge.net>, monstr@monstr.eu, Linux Kernel list <linux-kernel@vger.kernel.org>

On Tue, Jul 14, 2009 at 07:13:20PM +0200, Arnd Bergmann wrote:
> On Tuesday 14 July 2009, Michal Simek wrote:
> > when the code tried to read/write from unaligned address (and in cpu
> > is turn on unaligned exception) then is caused unaligned exception
> > and asm code assemble/return value which is on that unaligned
> > address. (Assemble it that read/write every byte separately). That
> > will be harder to prevent all this cases because unaligned exception
> > is in generic code.  What do you mean add __range_ok? Range checking
> > is ok. The problem is when in case get_user kernel try to load
> > unaligned addr - unaligned exception is perform and try to load that
> > value separately.  If that page is not there, page fault handler is
> > called and not find it, it is performed search from exception table
> > and that address is not there of course - because address in pc is
> > generic unaligned code. I think that handling this needs more code.
> > Maybe if the address with from unaligned exception handler (there are
> > some address which can caused it) and find out which aligned address
> > is there and find out proper fixup for it.  I think that this could
> > work.
> > 
> > What do you think?
> 
> I think the key point is that the kernel should never try an unaligned
> access. Other architectures already rely on this, so you can too.

No, other architectures used to rely on this, until it was no longer
possible to do so. See for example, nfs. Unaligned accesses by the kernel
must be handled by the architecture, unaligned accesses by userspace can
be optionally fixed up.

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
