Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1MO7iK-000560-1F
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 10:15:52 +0000
Received: from e28smtp03.in.ibm.com ([59.145.155.3])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MO7iB-0007HJ-Kh
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 10:15:51 +0000
Message-ID: <4A53190C.2070809@linux.vnet.ibm.com>
Date: Tue, 07 Jul 2009 15:14:44 +0530
From: gowrishankar <gomuthuk@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] request to enable realtime tests in default run list
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
Cc: ltp-list@lists.sf.net

Hi Subrata,

We are looking for your concerns as well as from community on enabling realtime
tests by default. By the way we can broad our realtime tests as well as scan
the existing tests functionality with the help of community.

One bottleneck we had in past is that it fails to compile on platforms that
does not support few arch-specific tests (like TSC related tests) and also
I am not too sure about remaining platforms than System X and P.

We can think of either dropping platform specific tests so that RT tests depend
only on distros (for glibc ??) or conditionally enable them by looking for
platform ids.

Also, we can think of enabling/disabling whole RT tests in default LTP build
for the same reason I said at the top.

Your thoughts are very welcome.

Thanks for paying attention,
Gowri

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
