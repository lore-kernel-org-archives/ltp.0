Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NXEWk-00047w-So
	for ltp-list@lists.sourceforge.net; Tue, 19 Jan 2010 13:53:50 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NXEWj-0006mP-Tp
	for ltp-list@lists.sourceforge.net; Tue, 19 Jan 2010 13:53:50 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1260357670.6958.25.camel@subratamodak.linux.ibm.com>
References: <1259849059.5085.17.camel@subratamodak.linux.ibm.com>
	<1260357670.6958.25.camel@subratamodak.linux.ibm.com>
Date: Tue, 19 Jan 2010 19:13:31 +0530
Message-Id: <1263908612.5114.7.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] [ANNOUNCE] Intermediate release for JANUARY 2010
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
To: ltp-list <ltp-list@lists.sf.net>
Cc: Mike Frysinger <vapier@gentoo.org>

Hi,

The first release(ltp-intermediate-20100119.tgz) for 2010 is out. Please
start experimenting. We may still have issues building:

     1. controllers/cpusets
     2. syscalls/get_mempolicy
     3. syscalls/mbind

Please see: http://ltp.sourceforge.net/, for download details.

Regards--
Subrata



------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
