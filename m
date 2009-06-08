Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MDd3N-0006B9-I9
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 11:30:13 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MDd3I-00028C-Ea
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 11:30:13 +0000
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 7B578FF0E95F
	for <ltp-list@lists.sourceforge.net>;
	Mon,  8 Jun 2009 13:30:06 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian.localnet)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277) id 1MDd3G-0003FU-00
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 13:30:06 +0200
From: Jiri Palecek <jpalecek@web.de>
Date: Mon, 8 Jun 2009 13:33:41 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200906081333.42673.jpalecek@web.de>
Subject: [LTP] [PATCH] Return immediately when the ZOO file couldn't be
	opened, prevent crash later
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

Hello,

there was a crash in pan when the zoofile couldn't be opened; this patch fixes it by disallowing the zoo_open function to continue.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>

---
 pan/zoolib.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/pan/zoolib.c b/pan/zoolib.c
index 3e31733..72ddfb0 100644
--- a/pan/zoolib.c
+++ b/pan/zoolib.c
@@ -104,6 +104,7 @@ zoo_open(char *zooname)
 		snprintf(zoo_error, ZELEN, 
 				"Could not open zoo as \"%s\", errno:%d %s", 
 				zooname, errno, strerror(errno));
+		return 0;
 	    }
 	    fclose(new_zoo);
 	    new_zoo = fopen(zooname, "r+");
-- 
1.6.2.4


------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
