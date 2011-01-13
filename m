Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PdQrn-0001EV-HW
	for ltp-list@lists.sourceforge.net; Thu, 13 Jan 2011 17:21:43 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 0BB0494393
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Jan 2011 18:21:36 +0100 (CET)
Date: Thu, 13 Jan 2011 18:38:20 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110113173820.GA5486@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] last two git build failures
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
To: ltp-list@lists.sourceforge.net

Hi!
The build failure that still breaks the build of the ltp git repository
is related to check_keepcaps.c from kernel/security/securebits/. The
problem is that header file sys/securebits.h is not included in system
headers packages or in some cases its there but empty :(. This results
in symbol SECBIT_KEEP_CAPS missing.

Apart from that realtime tests still fails with implicit declaration of
tst_exit.

The rest of the tree seems to build at least on one machine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
