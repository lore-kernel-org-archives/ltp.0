Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kraxel@redhat.com>) id 1MF0P2-0005BT-Lh
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 06:38:16 +0000
Received: from mx2.redhat.com ([66.187.237.31])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MF0OP-0002pn-3c
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 06:38:16 +0000
Message-ID: <4A31F790.7020607@redhat.com>
Date: Fri, 12 Jun 2009 08:37:04 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
MIME-Version: 1.0
References: <1244775216.4982.2.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1244775216.4982.2.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [002][RFC] [TESTING linux-2.6.30] preadv/pwritev syscalls
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>, Ralf Baechle <ralf@linux-mips.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>

On 06/12/09 04:53, Subrata Modak wrote:
> Hi Gerd,
>
> Thanks for writing preadv/pwritev syscalls for linux-2.6.30. We would
> like to include your test code (hosted at:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=dac1213842f5caf081804a11d87d2a39a21d6f55) to be included in our Linux Test Project (http://ltp.sf.net) under GPLv2.

Fine with me.

Note that there was an ABI change 
(http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=601cc11d054ae4b5e9b5babec3d8e4667a2cb9b5), 
so the test program needs adaptions to the final ABI present in 2.6.30.

cheers,
   Gerd


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
