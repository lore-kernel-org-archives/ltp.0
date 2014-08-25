Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <naresh.kamboju@linaro.org>) id 1XLzXG-0003QV-Ci
	for ltp-list@lists.sourceforge.net; Mon, 25 Aug 2014 19:02:34 +0000
Received: from mail-yk0-f177.google.com ([209.85.160.177])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XLzXF-00081F-9t
	for ltp-list@lists.sourceforge.net; Mon, 25 Aug 2014 19:02:34 +0000
Received: by mail-yk0-f177.google.com with SMTP id 79so10560382ykr.8
	for <ltp-list@lists.sourceforge.net>;
	Mon, 25 Aug 2014 12:02:22 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 26 Aug 2014 00:08:00 +0530
Message-ID: <CA+G9fYvRGMkgNAkVCsnTNhTfQCW_CTAtH3LDV=tELpG0wjfxCQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [LTP] LTP: overcommit_memory -R 0 failed due to overcommit_ratio =
	0 ?
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
To: ltp-list <ltp-list@lists.sourceforge.net>
Cc: Mark Brown <mark.brown@linaro.org>, Steve Capper <steve.capper@linaro.org>

Hi All,

Test case : overcommit_memory -R 0
Test faild.
Because overcommit_ratio = 0 ???
Is this a test case bug or any thing missing in kernel ?

Without Swap :
--------------------
CommitLimit = SwapTotal + MemTotal * overcommit_ratio
CommitLimit = ( 0 + 8232052 * 0 )
CommitLimit = 0
Committed_AS is the amount of memory that system has used.
Committed_AS = 727208
if (CommitLimit < Committed_AS) TEST BROKEN ;
if ( 65532 < 727080 )  TEST BROKEN ;
##################################################################
tag=overcommit_memory02 stime=1410838101
cmdline="overcommit_memory -R 0"
contacts=""
analysis=exit
<<<test_output>>>
overcommit_memory    0  TINFO  :  set overcommit_ratio to 0
overcommit_memory    0  TINFO  :  MemTotal is 8232052 kB
overcommit_memory    0  TINFO  :  SwapTotal is 0 kB
overcommit_memory    0  TINFO  :  CommitLimit is 0 kB
overcommit_memory    0  TINFO  :  set overcommit_memory to 2
overcommit_memory    0  TINFO  :  CommmitLimit is 0, Committed_AS is 727208
overcommit_memory    1  TBROK  :  Unexpected error: CommitLimit < Committed_AS
overcommit_memory    2  TBROK  :  Remaining cases broken
overcommit_memory    0  TINFO  :  set overcommit_memory to 0
overcommit_memory    0  TINFO  :  set overcommit_ratio to 50
##################################################################

With Swap enabled manually.
---------------------------------------
overcommit_memory02 overcommit_memory -R 0
Test faild.
Because overcommit_ratio = 0.
CommitLimit = SwapTotal + MemTotal * overcommit_ratio
CommitLimit = ( 65532  + 8232052 * 0 )
CommitLimit = 65532
Committed_AS is the amount of memory that system has used.
Committed_AS = 727080
if (CommitLimit < Committed_AS) TEST BROKEN ;
if ( 65532 < 727080 )  TEST BROKEN ;
##################################################################
cmdline="overcommit_memory -R 0"
contacts=""
analysis=exit
<<<test_output>>>
overcommit_memory    0  TINFO  :  set overcommit_ratio to 0
overcommit_memory    0  TINFO  :  MemTotal is 8232052 kB
overcommit_memory    0  TINFO  :  SwapTotal is 65532 kB
overcommit_memory    0  TINFO  :  CommitLimit is 65532 kB
overcommit_memory    0  TINFO  :  set overcommit_memory to 2
overcommit_memory    0  TINFO  :  CommmitLimit is 65532, Committed_AS is 727080
overcommit_memory    1  TBROK  :  Unexpected error: CommitLimit < Committed_AS
overcommit_memory    2  TBROK  :  Remaining cases broken
overcommit_memory    0  TINFO  :  set overcommit_memory to 0
overcommit_memory    0  TINFO  :  set overcommit_ratio to 50
##################################################################

Kernel Version: 3.10.52-linaro-vexpress64
Machine Architecture: aarch64

Full test log can be found at: http://pastebin.com/e5j5xzZu

Best regards
Naresh Kamboju

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
