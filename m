Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penght@cn.fujitsu.com>) id 1PdgIe-00042n-7l
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 09:50:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PdgIc-0007i1-Ks
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 09:50:28 +0000
Message-ID: <4D3017F9.7060307@cn.fujitsu.com>
Date: Fri, 14 Jan 2011 17:31:37 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] Fix a building error.
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
To: yanegomi@gmail.com
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 pan/scan.l |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/pan/scan.l b/pan/scan.l
index 9696531..cc47bdf 100644
--- a/pan/scan.l
+++ b/pan/scan.l
@@ -91,6 +91,7 @@ static int check_mode(int, int, ...);
 %option noinput
 %option nolex-compat
 %option nounput
+%option yylineno
 
 UI      [0-9]+
 A       [a-zA-Z]+
-- 
1.7.0.4

-- 
Best Regards,
Peng Haitao


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
