Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1ZFgeA-0007pA-7W
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 10:44:10 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZFge9-0000bA-8Y
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 10:44:10 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6GAgFee027811
	for <ltp-list@lists.sourceforge.net>; Thu, 16 Jul 2015 18:42:15 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Thu, 16 Jul 2015 18:43:23 +0800
Message-ID: <1437043403-11184-2-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1437043403-11184-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1437043403-11184-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] pan/splitstr.c: free arg_string before return
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

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 pan/splitstr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pan/splitstr.c b/pan/splitstr.c
index 39b4698..608c682 100644
--- a/pan/splitstr.c
+++ b/pan/splitstr.c
@@ -136,6 +136,7 @@ const char **splitstr(const char *str, const char *separator, int *argcount)
 	if (argcount != NULL)
 		*argcount = num_toks;
 
+	free(arg_string);
 	/*
 	 * Return the argument array.
 	 */
-- 
1.9.3


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
