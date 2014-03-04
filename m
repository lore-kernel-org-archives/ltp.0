Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WKhVa-0004r1-RN
	for ltp-list@lists.sourceforge.net; Tue, 04 Mar 2014 05:03:14 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WKhVZ-0008VQ-B3
	for ltp-list@lists.sourceforge.net; Tue, 04 Mar 2014 05:03:14 +0000
Message-ID: <1393909375.2005.1.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 04 Mar 2014 13:02:55 +0800
In-Reply-To: <40197796.12723624.1393878529754.JavaMail.zimbra@redhat.com>
References: <1392372604.2085.10.camel@G08JYZSD130126>
	<1128042688.6449127.1392894329625.JavaMail.zimbra@redhat.com>
	<929738145.6498501.1392901385804.JavaMail.zimbra@redhat.com>
	<1393832848.1991.19.camel@G08JYZSD130126>
	<1393833079.1991.22.camel@G08JYZSD130126>
	<1720660524.12179720.1393837634610.JavaMail.zimbra@redhat.com>
	<1393845775.1984.10.camel@G08JYZSD130126>
	<1393845909.1984.13.camel@G08JYZSD130126>
	<40197796.12723624.1393878529754.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH v5 3/3] mlock/mlock02.c: add EPERM and ENOMEM
	errno tests
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Mon, 2014-03-03 at 15:28 -0500, Jan Stancek wrote:
> 
> ----- Original Message -----
> > From: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: "ltp-list" <ltp-list@lists.sourceforge.net>
> > Sent: Monday, 3 March, 2014 12:25:09 PM
> > Subject: [PATCH v5 3/3] mlock/mlock02.c: add EPERM and ENOMEM errno tests
> > 
> > Add EPERM and ENOMEM errno tests for mlock(2).
> > 
> > Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> 
> Looks good to me.
> 

Thanks for your review. :)
Best regards,
Zeng

> Reviewed-by: Jan Stancek <jstancek@redhat.com>
> 
> > ---



------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
