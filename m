Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16237C4332F
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 05:59:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E71963CAEEC
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 07:59:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4C863CA9BC
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 07:59:22 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4479E600C89
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 07:59:22 +0200 (CEST)
Received: by mail-pf1-x42a.google.com with SMTP id i3so1018541pfc.11
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 22:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gB+bVtYxl0CBlvyZfCqACE4TGiPCHgFExGajBo6ftdU=;
 b=Aashi9rWZ2GVet7qR6hVjG8GWVxpzLr9kkmi1K+9iB0hepWNSwzcCnk+lWaDXqSN3H
 ZM2CkRlo78Y7Fw/X+GAmRT9oDEu0K5CDhG5OhobUF9YDqyIsvDFzGdyRyK6of1y0O+pX
 kmq8rLgu3iFrwQrvK/3OXNqX6Hl9UOH2jCIoHDIpIBh44BDJgWpdCwv/3/CNE7RNZP29
 CFLG8EqE21NTA3EgI4TP38JEwiTgnhyi/UenmjN5N+ndVb39UJ+5l7VfwTYC6toaEqhi
 KmJKRrnjePuucJ2VLjiF+sL6IHcI3Iu3pqoWWWMIIYiGIWn2JNZwUg/eeiaqH/ab+2vy
 FPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gB+bVtYxl0CBlvyZfCqACE4TGiPCHgFExGajBo6ftdU=;
 b=eLXttmXQeOWwRc4buHY4CSgx1HFAiFwd1FKwCpnarwJH9f7bo+kW8jHLaJb+xhaZel
 RXfIzlWE47+FJC+6j48RUsTg1Xq08PzLc2S82UUeGAx+73pV1SOQA2UkNNfWjV8u212V
 Ay4bOKLsfGiw3SbJ5EEqvl0FpiSVGUmP/G+OgfByJRbouDHdqd+2NrlfTE0Gck6gVQuA
 tEfmYAurw/AazdJqcXCSKZOp3P8aAy+lIF45fbzyx9U32qCNGvLxzOw9E5zz05zNvfxZ
 vCQvTAY+3QC2C/2vQRZf8GgrijtOvn1E1jNfwAFcMYoLkXQwvHkgrAa2mzJ3CZrGLWBU
 4DKw==
X-Gm-Message-State: ACrzQf2lXERhYwUgf99jeSYzw+Dv/qV7hT4EuF38gQeBUchUscItVkUN
 PLf3u2ekMVby9enGhlzzes3DQpqZMAhXJA==
X-Google-Smtp-Source: AMsMyM6i0JSapCBa2iOhEdIpHru8z02KpviUXtgCITyRZ7dm4jbkupG17mLnNXPK2FEeaeB7IpKxCA==
X-Received: by 2002:a65:4508:0:b0:43c:e3c6:d1c2 with SMTP id
 n8-20020a654508000000b0043ce3c6d1c2mr28376063pgq.582.1665640749476; 
 Wed, 12 Oct 2022 22:59:09 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 r1-20020aa79881000000b00553d5920a29sm931133pfl.101.2022.10.12.22.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Oct 2022 22:59:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: ltp@lists.linux.it
Date: Thu, 13 Oct 2022 14:59:04 +0900
Message-Id: <20221013055904.28978-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ftp/ftp01: Use tst_net.sh
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
 Yuri Benditovich <yuri.benditovich@daynix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This allows to use SSH rather than RSH.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 testcases/network/tcp_cmds/ftp/ftp01.sh | 61 ++++++++-----------------
 1 file changed, 20 insertions(+), 41 deletions(-)

diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
index 8d23abc62..9900ad491 100755
--- a/testcases/network/tcp_cmds/ftp/ftp01.sh
+++ b/testcases/network/tcp_cmds/ftp/ftp01.sh
@@ -40,6 +40,10 @@
 #
 #----------------------------------------------------------------------
 
+TST_TESTFUNC=do_test
+TST_SETUP=do_setup
+TST_NEEDS_TMPDIR=1
+
 #-----------------------------------------------------------------------
 #
 # FUNCTION:  do_setup
@@ -50,25 +54,15 @@ do_setup()
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
 
-    cd "$TCtmp"
+    tst_require_cmds awk ftp
 
-    rsh -n -l root $RHOST mkdir -p "$TCtmp"
-    rsh -n -l root $RHOST chown -R ${RUSER} "$TCtmp"
-    [ $? = 0 ] || end_testcase "Check .rhosts file on remote machine."
+    [ $? = 0 ] || tst_brk TBROK "Check .rhosts file on remote machine."
 
 }
 
@@ -95,51 +89,39 @@ do_test()
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
 
                 if [ $SUM1 = $SUM2 ]; then
-                    tst_resm TINFO "Test Successful doing ftp $a $j $i"
+                    tst_res TINFO "Test Successful doing ftp $a $j $i"
                 else
-                    end_testcase "Test Fail: Wrong sum while performing ftp $a $j $i"
+                    tst_brk TFAIL "Test Fail: Wrong sum while performing ftp $a $j $i"
                 fi
                 sleep $SLEEPTIME
             done
         done
     done
-}
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
+    tst_res TPASS "Test Successful"
 }
 
 #----------------------------------------------------------------------
@@ -150,9 +132,6 @@ do_cleanup()
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
