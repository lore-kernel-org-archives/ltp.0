Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MGHh3-0001kP-Ka
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:18:09 +0000
Received: from [32.97.110.151] (helo=e33.co.us.ibm.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGHh2-0001fh-TZ
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:18:09 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A325BCC.2020701@redhat.com>
References: <20090612132112.32049.92495.sendpatchset@subratamodak.linux.ibm.com>
	<4A325BCC.2020701@redhat.com>
Date: Tue, 16 Jun 2009 00:45:33 +0530
Message-Id: <1245093333.4871.36.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Add preadv01 test for preadv() and pwritev()
	syscall
Reply-To: subrata@linux.vnet.ibm.com
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: ltp-list <ltp-list@lists.sf.net>, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, Al Viro <viro@zeniv.linux.org.uk>

On Fri, 2009-06-12 at 15:44 +0200, Gerd Hoffmann wrote: 
> Hi,
> 
> > + * Reference: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=601cc11d054ae4b5e9b5babec3d8e4667a2cb9b5
> 
> Look at the commit message again ...

Oops. I will fix that soon and resend.

Regards--
Subrata

> 
> > +static ssize_t preadv(int fd, const struct iovec *iov, int iovcnt, off_t offset)
> > +{
> > +    uint32_t pos_high = (offset>>  32)&  0xffffffff;
> > +    uint32_t pos_low  =  offset&  0xffffffff;
> > +
> > +    return syscall(__NR_preadv, fd, iov, iovcnt, pos_high, pos_low);
> > +}
> 
> No.
> 
> #define HALF_BITS (sizeof(unsigned long)*4)
> return syscall(__NR_preadv, fd, iov, iovcnt, offset,
>                 (offset >> HALF_BITS) >> HALF_BITS);
> 
> Likewise for pwritev.
> 
> Also note that latest glibc has preadv/pwritev support, so you could use 
> that instead.
> 
> cheers,
>    Gerd
> 


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
