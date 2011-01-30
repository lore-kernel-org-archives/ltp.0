Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Pjcwr-0008VA-UG
	for ltp-list@lists.sourceforge.net; Sun, 30 Jan 2011 19:28:33 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1Pjcwq-0006ga-MN
	for ltp-list@lists.sourceforge.net; Sun, 30 Jan 2011 19:28:33 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 31 Jan 2011 00:58:28 +0530
Message-Id: <1296415709.29830.8.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] Finding True Application Code Coverage in case of
	heteregenous	Executable Environment
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
To: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>, ltp-coverage <ltp-coverage@lists.sourceforge.net>

Peter,

Is there a way to find true application code coverage for a
heterogeneous Executable Environment, where the application can consist
of:
     1. C Programs(only for which .gcno and .gcda files can be
        generated)
     2. Shell Scripts,
     3. Perl Scripts,
     4. Python Scripts,
     5. etc ?

Is there any by which i can also count the no. of lines/ branches/
Functions executed by the Scripts ??

Another question. when i tried to execute the following, it took into
consideration only the .gcda of the C executables invoked by the
program:
     1. lcov --directory /root/LTP-GIT/ltp/ --zerocounters
     2. (cd /opt/ltp/; ./runltp -f math)
     3. lcov --directory /root/LTP-GIT/ltp/ --capture --output-file
        app.info
     4. genhtml app.info

Instead i wanted it consider all C files for which .gcno are present
and .gcda are not present(as i did not execute the corresponding
binaries), so to truly find the exact % of C files covered and % left
out from the whole trickled down /root/LTP-GIT/ltp/ directory.

Regards--
Subrata



------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
