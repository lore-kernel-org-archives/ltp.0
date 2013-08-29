Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anders.roxell@linaro.org>) id 1VF2ho-0005Vf-CO
	for ltp-list@lists.sourceforge.net; Thu, 29 Aug 2013 13:56:12 +0000
Received: from mail-lb0-f172.google.com ([209.85.217.172])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VF2hn-0002Xl-Ht
	for ltp-list@lists.sourceforge.net; Thu, 29 Aug 2013 13:56:12 +0000
Received: by mail-lb0-f172.google.com with SMTP id x18so730782lbi.17
	for <ltp-list@lists.sourceforge.net>;
	Thu, 29 Aug 2013 06:56:04 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 29 Aug 2013 15:55:48 +0200
Message-Id: <1377784548-1036-3-git-send-email-anders.roxell@linaro.org>
In-Reply-To: <1377784548-1036-1-git-send-email-anders.roxell@linaro.org>
References: <1377784548-1036-1-git-send-email-anders.roxell@linaro.org>
Subject: [LTP] [PATCH 2/2] runltp: rework echo -n to printf POSIX-compliant
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

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 runltp | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/runltp b/runltp
index a419bf8..eb8e0c0 100755
--- a/runltp
+++ b/runltp
@@ -537,18 +537,13 @@ main()
         {
             [ -z "$RHOST" ] && \
             {
-                echo \
-                "INFO: Enter RHOST = 'name of the remote host machine'"
-                echo -n "-> "
+                printf "INFO: Enter RHOST = 'name of the remote host machine'\n-> "
                 read RHOST
             }
 
             [ -z "$PASSWD" ] && \
             {
-                echo " "
-                echo \
-                "INFO: Enter PASSWD = 'root passwd of the remote host machine'"
-                echo -n "-> "
+                printf "\nINFO: Enter PASSWD = 'root passwd of the remote host machine'\n-> "
                 read PASSWD
             }
             export RHOST=$RHOST
@@ -733,15 +728,15 @@ main()
     #$PAN_COMMAND #Duplicated code here, because otherwise if we fail, only "PAN_COMMAND" gets output
 
     ## Display the Output/Log/Failed/HTML file names here
-    echo -e "LOG File: \c"
+    printf "LOG File: "
     echo $LOGFILE | cut -b4-
 
     if [ "$OUTPUTFILE" ]; then
-       echo -e "OUTPUT File: \c"
+       printf "OUTPUT File: "
        echo $OUTPUTFILE | cut -b4-
     fi
 
-    echo -e "FAILED COMMAND File: \c"
+    printf "FAILED COMMAND File: "
     echo $FAILCMDFILE | cut -b4-
 
     if [ "$HTMLFILE" ]; then
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
