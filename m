Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Z2ZvS-00044t-S8
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 06:55:50 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z2ZvR-0005NH-Uj
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 06:55:50 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5A6sBTu004886
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Jun 2015 14:54:11 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 10 Jun 2015 14:55:00 +0800
Message-ID: <1433919301-24797-3-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1433919301-24797-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1433919301-24797-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/4] pan/symbol.c: fix memory leak for failure case
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
 pan/symbol.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/pan/symbol.c b/pan/symbol.c
index d7b90af..ca9964a 100644
--- a/pan/symbol.c
+++ b/pan/symbol.c
@@ -112,6 +112,7 @@ static struct sym *mknode(struct sym *next, char *key, void *data)
 
 	if (n->key == NULL) {
 		sym_error = "sym node strdup(key) failed!";
+		free(n);
 		return (NULL);
 	}
 	return (n);
@@ -204,8 +205,10 @@ int sym_put(SYM sym, char *key, void *data, int flags)
 	nkey = strdup(key);
 	keys = splitstr(key, ",", NULL);
 
-	if (keys == NULL)
+	if (keys == NULL) {
+		free(nkey);
 		return (EINVAL);
+	}
 
 	for (kk = (char **)keys, csym = sym;
 	     *kk != NULL && (nsym = find_key1(csym->sym, *kk)) != NULL;
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
