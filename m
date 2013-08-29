Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anders.roxell@linaro.org>) id 1VF2hh-0002t5-Lo
	for ltp-list@lists.sourceforge.net; Thu, 29 Aug 2013 13:56:05 +0000
Received: from mail-la0-f45.google.com ([209.85.215.45])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VF2hg-0002qj-OW
	for ltp-list@lists.sourceforge.net; Thu, 29 Aug 2013 13:56:05 +0000
Received: by mail-la0-f45.google.com with SMTP id eh20so385091lab.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 29 Aug 2013 06:55:57 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 29 Aug 2013 15:55:46 +0200
Message-Id: <1377784548-1036-1-git-send-email-anders.roxell@linaro.org>
Subject: [LTP] [PATCHv2 0/2] Rework to printf and added required import
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: patches@linaro.org

Hi,

Rewoked to printf and added required import

/Anders

Anders Roxell (2):
  realtime parser: remove unused and depricated imports
  runltp: rework echo -n to printf POSIX-compliant

 runltp                               | 15 +++++----------
 testcases/realtime/scripts/parser.py |  2 +-
 2 files changed, 6 insertions(+), 11 deletions(-)

-- 
1.8.1.2


------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
