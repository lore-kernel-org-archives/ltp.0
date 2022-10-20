Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9920BC433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 12:08:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F00E3CB0D1
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 14:08:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B53163CB0D1
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 14:07:57 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E36A71400FBB
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 14:07:56 +0200 (CEST)
Received: by mail-pg1-x535.google.com with SMTP id h185so19012150pgc.10
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 05:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lE5cHRRij5qxE83ATDj5jCOlx2lVUKTya2gIeJlzuTI=;
 b=IPnElsyC7cGU4DUaLGUhNIrJu/GIi2HMOZ0HKkEGeqd0Vkqa3fnv3E0vt5txKbLhtA
 SPFOzuY4X48BYvtAp5YyJt3pEvQcSQ6p4Xs5NnVWt6ZJs+mIU1noMuHrZEF2SZlVMzA1
 PcRtvBFB0RK23PpsX8DB4VOZRDDkmMfk0vBnLquJmMOuxaha2iSVKGoWu/bfWd9WKbd5
 A6xUvKrMdgOs7Z+yjaOQ/f9mCyYYQVLQhBhBjTwm6Qgal3grB/9t5F65WlMdHmfNFkBx
 VgCTSXjaU/A5k6n/+wR7w1s8mTaWmhCAiTUBevjmv5k050Z2Wj5sd/ZxDc7NryzKccEe
 wYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lE5cHRRij5qxE83ATDj5jCOlx2lVUKTya2gIeJlzuTI=;
 b=ISNGmBRjyYRWkKddkbXwghFmX6g4bB+A/iecsnkf8ESIleRniA19cE5IJoBf8J5vHo
 oXoQEJrQrjoolfV+kn03lBimM4XwMgI7BRlLPMLvxAWSuyzeFSghXN70F8KlH4mBV6wl
 xsoG8WcvpO42VR1PtCVvV6R+OXylvoG5pzu4KCyQsP4XlLmQgJyyZ9s2nltdkr3CCV11
 l2eRKgTS7vR83xE8i1p6qUmspiXeosrN3NiH1kq0adjFuRpV+RgZi9Cd3buKrLbLmDle
 mvahG10s5OZ0qPuIV2j0qaVNBYyQukroyUKcbxkxZFtMMcPr8iiojsmItNDIRM9CcJ2H
 ZNrw==
X-Gm-Message-State: ACrzQf2UMxgDPmoLJxKTjKNcPrw1+7HN5OiTocmDh9r0tFMZwCQ/3twm
 VQ4tzsqit9AdWmLJXjsJ23KEv/ue1Bt/EQju
X-Google-Smtp-Source: AMsMyM7hlAsxZYgvamGQF3PDGt03jnA3FjghLiJ37aCqsmEcK1SKgBqkqeQ5S8RmYFg2rJCT/+FbMQ==
X-Received: by 2002:aa7:88c4:0:b0:563:9fe9:5da9 with SMTP id
 k4-20020aa788c4000000b005639fe95da9mr13645633pff.41.1666267675281; 
 Thu, 20 Oct 2022 05:07:55 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 r27-20020aa79edb000000b005403b8f4bacsm13078947pfq.137.2022.10.20.05.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Oct 2022 05:07:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Oct 2022 21:07:36 +0900
Message-Id: <20221020120741.212671-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/6] ftp/ftp01: Use tst_net.sh
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This allows to use SSH rather than RSH.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 testcases/network/tcp_cmds/ftp/ftp01.sh | 64 +++++++------------------
 1 file changed, 17 insertions(+), 47 deletions(-)

diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
index 8d23abc62..a78d8adc0 100755
--- a/testcases/network/tcp_cmds/ftp/ftp01.sh
+++ b/testcases/network/tcp_cmds/ftp/ftp01.sh
@@ -40,6 +40,11 @@
 #
 #----------------------------------------------------------------------
 
+TST_TESTFUNC=do_test
+TST_SETUP=do_setup
+TST_NEEDS_CMDS='awk ftp'
+TST_NEEDS_TMPDIR=1
+
 #-----------------------------------------------------------------------
 #
 # FUNCTION:  do_setup
@@ -50,25 +55,11 @@ do_setup()
 {
 
     TC=ftp
-    TCtmp=${TCtmp:-$LTPROOT/$TC${EXEC_SUFFIX}$$}
-    TCdat=${TCdat:-$LTPROOT/datafiles}
     SLEEPTIME=${SLEEPTIME:-0}
     ASCII_FILES=${ASCII_FILES:-"ascii.sm ascii.med ascii.lg ascii.jmb"}
     BIN_FILES=${BIN_FILES:-"bin.sm bin.med bin.lg bin.jmb"}
 
-    RHOST=${RHOST:-`hostname`}
     RUSER=${RUSER:-root}
-    PASSWD=${PASSWD:-.pasroot}
-
-    tst_setup
-
-    exists awk ftp rsh
-
-    cd "$TCtmp"
-
-    rsh -n -l root $RHOST mkdir -p "$TCtmp"
-    rsh -n -l root $RHOST chown -R ${RUSER} "$TCtmp"
-    [ $? = 0 ] || end_testcase "Check .rhosts file on remote machine."
 
 }
 
@@ -95,53 +86,35 @@ do_test()
                 if [ $a = "get" ]; then
                     {
                         echo user $RUSER $PASSWD
-                        echo lcd $TCtmp
                         echo $i
-                        echo cd $TCdat
+                        echo cd $TST_NET_DATAROOT
                         echo $a $j
                         echo quit
                     } | ftp -nv $RHOST
-                    SUM1=`ls -l $TCtmp/$j  | awk '{print $5}'`
-                    SUM2=`ls -l $TCdat/$j | awk '{print $5}'`
-                    rm -f $TCtmp/$j
+                    SUM1=`ls -l $j  | awk '{print $5}'`
+                    SUM2=`ls -l $TST_NET_DATAROOT/$j | awk '{print $5}'`
+                    rm -f $j
                 else
                     {
                         echo user $RUSER $PASSWD
-                        echo lcd $TCdat
+                        echo lcd $TST_NET_DATAROOT
                         echo $i
-                        echo cd $TCtmp
+                        echo cd $TST_TMPDIR
                         echo $a $j
                         echo quit
                     } | ftp -nv $RHOST
-                    SUM1=`rsh -n -l root $RHOST sum $TCtmp/$j | awk '{print $1}'`
-                    SUM2=`sum $TCdat/$j | awk '{print $1}'`
-                    rsh -n -l root $RHOST rm -f $TCtmp/$j
+                    SUM1=`tst_rhost_run -c "sum $TST_TMPDIR/$j" -s | awk '{print $1}'`
+                    SUM2=`sum $TST_NET_DATAROOT/$j | awk '{print $1}'`
+                    tst_rhost_run -c "rm -f $TST_TMPDIR/$j"
                 fi
 
-                if [ $SUM1 = $SUM2 ]; then
-                    tst_resm TINFO "Test Successful doing ftp $a $j $i"
-                else
-                    end_testcase "Test Fail: Wrong sum while performing ftp $a $j $i"
-                fi
+                EXPECT_PASS "[ '$SUM1' = '$SUM2' ]"
                 sleep $SLEEPTIME
             done
         done
     done
 }
 
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  do_cleanup
-#
-#-----------------------------------------------------------------------
-
-do_cleanup()
-{
-    rsh -n -l root $RHOST rmdir "$TCtmp"
-    tst_cleanup
-}
-
 #----------------------------------------------------------------------
 # FUNCTION: MAIN
 # PURPOSE:  To invoke the functions to perform the tasks described in
@@ -150,9 +123,6 @@ do_cleanup()
 # OUTPUT:   A testcase run log with the results of the execution of this
 #           test.
 #----------------------------------------------------------------------
-. net_cmdlib.sh
+. tst_net.sh
 
-read_opts $*
-do_setup
-do_test
-end_testcase
+tst_run
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
