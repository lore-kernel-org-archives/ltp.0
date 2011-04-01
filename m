Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q5men-0003R5-03
	for ltp-list@lists.sourceforge.net; Fri, 01 Apr 2011 22:17:29 +0000
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q5mem-0004lk-5q
	for ltp-list@lists.sourceforge.net; Fri, 01 Apr 2011 22:17:28 +0000
From: Alex Elder <aelder@sgi.com>
Date: Fri,  1 Apr 2011 17:01:23 -0500
Message-Id: <26c7134d7a0855a4bd8a5f73e7dfc8088115f9d2.1301695094.git.aelder@sgi.com>
In-Reply-To: <1301695288-24912-1-git-send-email-aelder@sgi.com>
References: <1301695288-24912-1-git-send-email-aelder@sgi.com>
Subject: [LTP] [PATCH 1/6] ltp: fix databinchk() definition
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

Fix a bogus (misspelled) declaration for databinchk() in
"include/databin.h".

Then, change databinchk() so that its second argument is a signed
rather than an unsigned character pointer.  This is consistent with
the way it is used throughout the code.  Because of the way that
argument is used, it won't change the behavior of that function; its
value is immediately assigned to a local variable, which is still
unsigned.  Add a cast in that assignment to force the conversion.

Signed-off-by: Alex Elder <aelder@sgi.com>
---
 include/databin.h |    2 +-
 lib/databin.c     |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/databin.h b/include/databin.h
index c168799..93c3863 100644
--- a/include/databin.h
+++ b/include/databin.h
@@ -39,6 +39,6 @@
 
 void databingen( int mode, char *buffer, int bsize, int offset );
 
-void databinchedk( int mode, unsigned char *buffer, int bsize, int offset, char **errmsg);
+int databinchk( int mode, char *buffer, int bsize, int offset, char **errmsg);
 
 #endif
diff --git a/lib/databin.c b/lib/databin.c
index 6659ccf..c0f4307 100644
--- a/lib/databin.c
+++ b/lib/databin.c
@@ -91,7 +91,7 @@ int ind;
 int
 databinchk(mode, buffer, bsize, offset, errmsg)
 int mode;	/* either a, c, r, z, o, or C */
-unsigned char *buffer;	/* buffer pointer */
+char *buffer;	/* buffer pointer */
 int bsize;	/* size of buffer */
 int offset;	/* offset into the file where buffer starts */
 char **errmsg;
@@ -102,7 +102,7 @@ char **errmsg;
     long expbits;
     long actbits;
 
-	chr=buffer;
+	chr = (unsigned char *) buffer;
 	total=bsize;
 
 	if (errmsg != NULL) {
-- 
1.7.4


------------------------------------------------------------------------------
Create and publish websites with WebMatrix
Use the most popular FREE web apps or write code yourself; 
WebMatrix provides all the features you need to develop and 
publish your website. http://p.sf.net/sfu/ms-webmatrix-sf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
