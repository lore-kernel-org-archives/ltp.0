Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WjrWr-0002Aj-Lh
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 14:48:33 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WjrWp-0001cr-Tz
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 14:48:33 +0000
From: Mats Liljegren <mats.liljegren@enea.com>
Date: Mon, 12 May 2014 16:48:10 +0200
Message-ID: <1399906092-28901-1-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 0/2] safe_stdio: Added SAFE_POPEN() + new error
	message format
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

These patches are in preparation of v3 of partrt_nohz_full patch.

Mats Liljegren (2):
  SAFE_POPEN: Added function to safe_stdio.h
  safe_stdio: Error messages in new format

 include/safe_stdio.h |    5 +++++
 lib/safe_stdio.c     |   32 +++++++++++++++++++++++++++++---
 2 files changed, 34 insertions(+), 3 deletions(-)

-- 
1.7.10.4


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
