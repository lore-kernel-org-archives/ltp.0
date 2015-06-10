Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Z2ZvU-0004fQ-76
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 06:55:52 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z2ZvS-0003X9-8X
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 06:55:52 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5A6sCSr004892
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Jun 2015 14:54:13 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 10 Jun 2015 14:55:01 +0800
Message-ID: <1433919301-24797-4-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1433919301-24797-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1433919301-24797-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 4/4] pan/splitstr.c: free memory allocated by strdup()
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
index fbcd697..decfbf5 100644
--- a/pan/splitstr.c
+++ b/pan/splitstr.c
@@ -122,6 +122,7 @@ const char **splitstr(const char *str, const char *separator, int *argcount)
 		}
 	}
 	arg_array[num_toks] = NULL;
+	free(arg_string);
 
 	/*
 	 * If there are any spaces left in our array, make them NULL
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
