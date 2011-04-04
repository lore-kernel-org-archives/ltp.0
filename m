Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q6ia9-0005Tg-5x
	for ltp-list@lists.sourceforge.net; Mon, 04 Apr 2011 12:08:33 +0000
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q6ia5-0001CZ-Fj
	for ltp-list@lists.sourceforge.net; Mon, 04 Apr 2011 12:08:33 +0000
Received: from cf--amer001e--3.americas.sgi.com
	(cf--amer001e--3.americas.sgi.com [137.38.100.5])
	by relay2.corp.sgi.com (Postfix) with ESMTP id 3305630406A
	for <ltp-list@lists.sourceforge.net>;
	Mon,  4 Apr 2011 05:08:24 -0700 (PDT)
From: Alex Elder <aelder@sgi.com>
Date: Mon, 04 Apr 2011 07:08:22 -0500
Message-ID: <1301918902.3282.24.camel@doink>
Mime-Version: 1.0
Subject: [LTP] [PATCH 1/6] ltp: fix databinchk() definition
Reply-To: aelder@sgi.com
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
