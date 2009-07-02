Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MMMKK-00026T-R0
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 13:27:48 +0000
Received: from qw-out-1920.google.com ([74.125.92.149])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMMKE-00063h-QV
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 13:27:43 +0000
Received: by qw-out-1920.google.com with SMTP id 5so658074qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 06:27:41 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 2 Jul 2009 18:26:01 +0530
Message-ID: <f5a7b3810907020556y371595fenf19bdbf7b5ea1d3e@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: [LTP] rt_sigaction FAIL -> PASS
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

Hi,

I have noticed design issues in rt_sigaction test case.
After few changes test case reported as PASS.

Shall I change the design and generate new patches.

Best regards,
Naresh Kamboju

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
