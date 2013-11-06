Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VeAPe-0000FA-HI
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 21:13:18 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VeAPc-0000rj-Ep
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 21:13:18 +0000
Date: Wed, 6 Nov 2013 16:13:06 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1198475184.23113242.1383772386323.JavaMail.root@redhat.com>
In-Reply-To: <527A9B57.1000908@gmx.de>
References: <527A9B57.1000908@gmx.de>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] sendfile08 - initialize buf structure
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





----- Original Message -----
> From: "Helge Deller" <deller@gmx.de>
> To: ltp-list@lists.sourceforge.net
> Sent: Wednesday, 6 November, 2013 8:41:11 PM
> Subject: [LTP] [PATCH] sendfile08 - initialize buf structure
> 
> The sendfile08 testcase uses the sendfile() syscall
> to write the strings "hello" and "world" to a file descriptor
> and then reads them back in through another file descriptor.
> 
> The length of the strings written are determined by strlen(),
> so that in total 10 bytes are written.
> 
> When reading the strings back in, again 10 bytes are read, but
> the problem is, that those are read back into a *local* string
> buffer array (buf[]) which hasn't been initialized.
> 
> Afterwards,
>   strcmp(buf, "helloworld")
> is called to compare input and output.
> This strcmp() is wrong, because basically "helloworld\0"
> (with the trailing string zero terminator) is compared to
> "helloworld" (likely without a trailing zero in the buf[] array).
> 
> So, if buf[] hasn't been initialized, it's not guaranteed
> that the 10th byte in buf[10] equals to '\0'.
> 
> This problem was found on hppa64-linux-gnu architecture, most
> likely, because it's a stack-grows-up architecture.
> 
> Fix this buglet, by zero-initializing the buf[] array.
> Alternatively, strncmp() could be used instead of memcmp().
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Hi,

I pushed the strncmp() version.

Thanks,
Jan

> 
> ------------------------------------------------------------------------------
> November Webinars for C, C++, Fortran Developers
> Accelerate application performance with scalable programming models. Explore
> techniques for threading, error checking, porting, and tuning. Get the most
> from the latest Intel processors and coprocessors. See abstracts and register
> http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

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
