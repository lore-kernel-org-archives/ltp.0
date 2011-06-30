Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanpai.chen@gmail.com>) id 1QcAdE-0002x6-Pp
	for ltp-list@lists.sourceforge.net; Thu, 30 Jun 2011 06:21:44 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QcAdE-0004v3-6U
	for ltp-list@lists.sourceforge.net; Thu, 30 Jun 2011 06:21:44 +0000
Received: by gyd12 with SMTP id 12so1019180gyd.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jun 2011 23:21:38 -0700 (PDT)
From: Andrew Chen <yanpai.chen@gmail.com>
Date: Thu, 30 Jun 2011 14:19:45 +0800
Message-Id: <1309414787-2022-5-git-send-email-yanpai.chen@gmail.com>
In-Reply-To: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
References: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
Subject: [LTP] [PATCH 5/7] runltp: precise pattern matching for skipped
	testcases
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
Cc: ypchen@faraday-tech.com

From: Andrew Chen <ypchen@faraday-tech.com>


Signed-off-by: Andrew Chen <ypchen@faraday-tech.com>
---
 ltp-full-20101031/runltp |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ltp-full-20101031/runltp b/ltp-full-20101031/runltp
index b385984..c8f558d 100755
--- a/ltp-full-20101031/runltp
+++ b/ltp-full-20101031/runltp
@@ -681,7 +681,7 @@ main()
     if [ -n "$SKIPFILE" ]
     then
         for file in $( cat $SKIPFILE ); do
-            sed -i "/$file/d" ${TMP}/alltests
+            sed -i "/^$file[ \t]/d" ${TMP}/alltests
         done
     fi
     
-- 
1.6.5


------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
