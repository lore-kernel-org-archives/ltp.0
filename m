Return-Path: <SRS0=2Bls=OD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CD9C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 12:40:50 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3650260F6C
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 12:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3650260F6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bell-sw.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 445D73C92A5
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 14:40:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53CCB3C86BB
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 14:40:38 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D3AA51A00FDF
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 14:40:37 +0200 (CEST)
Received: by mail-lj1-x22a.google.com with SMTP id r3so17059978ljc.4
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 05:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bell-sw-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ROqYq+MNuXYoF6btipNaurwRf9PPaunphTBJ0clPE9s=;
 b=bPycLtauTf5YUUu+L6/ld/NFkpGZbo2JXQM2Uv6kRMxoWRbOBmCy30OwCf7udeDw1h
 u4oH/7/N2G1MkH5jUetIAJhGM2ybAorAPaas0bn33Jbzv5BslkMXVqZ+SymzquayoYgE
 gaZdH0Jjv3canWjs5Jh2pJ2NYOQWhIrm/kDZChueeFsAAc4FUJnudVmZytLznF5xm9CE
 6SWNJxjvx6F/ZR2IYEyl0WZNM1ccqwFWJptPG1EVslKy/Ygg6ml5/ff94z2MjImWcyAN
 3TqPkfp6wnMw0riCg95Zx8EJgxLGp9GyKSnvWM4wUOq1tuv8YB4sF40p/wOHyy8vt3T7
 +RaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ROqYq+MNuXYoF6btipNaurwRf9PPaunphTBJ0clPE9s=;
 b=VJdrZJn75cBeVDmCMokYqu92qj+yoJgEjXBEgod1KB4uTMTU6290jf6Wi+Xqpbxucf
 ZyErQuHrTTftdQHkiDYSbVP/b8hnRKmPVD6QEi2h+Rtkk0s3OY4SVLNYQo5Ct4bZWbHr
 aMauBEy4CGrucKdXz/ns26RL38IaOQhYbH5CnzYmTxeQILEZ2K1TWQOv1BfYuiyOZMNt
 haVqJtpSjGb23jrxJjN+x039OYkV/IDUQwEWy70blBPyWhz5nR7RdFbQTuVCaHN+CrSf
 ZNwfEVaYjBYGwfzStt9xVgbLwiVBg3adMlxF26/LuboFOE3whK9UIwbUu8y5Pa3DniIw
 vD2g==
X-Gm-Message-State: AOAM531zzmsT5UjkBfnLoiuNaF3y502zdNxd0bIp8GfntaKeBZrvw+Ox
 9iGux8LUVV/ZIn0KibTmFAZaKAgAc2wD
X-Google-Smtp-Source: ABdhPJz7DuoasOw0qzD5NqxBWRMEbBirPSsjTY33t/+63TP6Z07ARxTBef8W/YerqkV1IcBmEXhwCw==
X-Received: by 2002:a2e:9e05:: with SMTP id e5mr10266011ljk.166.1631536836824; 
 Mon, 13 Sep 2021 05:40:36 -0700 (PDT)
Received: from localhost.localdomain ([95.161.221.177])
 by smtp.gmail.com with ESMTPSA id z4sm814560lfd.298.2021.09.13.05.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 05:40:36 -0700 (PDT)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: ltp@lists.linux.it
Date: Mon, 13 Sep 2021 15:39:34 +0300
Message-ID: <20210913123935.10761-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib/tst_net.sh: ignore errors on rhost with -i
 option in tst_net_run()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210913123934.iGnwhOKIl1PHTDTs5NP5CP8F3trs_y1XRg71s42_L68@z>

Unfortanetly busysbox/sysctl with -e option only suppresses the
warning about unknown keys and still returns exit code 1:
    sysctl -h
    ...
    -e don't warn about unknown keys

As a result busy_poll01 fails on this error:

    busy_poll01.sh
    busy_poll01 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
    ...
    busy_poll01 1 TINFO: set low latency busy poll to 50
    busy_poll01 1 TBROK: 'sysctl -q -w '-e' net.core.busy_read=50' failed on '': ''

So let's add a new option (-i) in tst_net_run() to ignore the
error when running the command on "rhost".

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 testcases/lib/tst_net.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 958d71e3d..7f2a1bab3 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -212,6 +212,7 @@ tst_rhost_run()
 # -l LPARAM: parameter passed to CMD in lhost
 # -r RPARAM: parameter passed to CMD in rhost
 # -q: quiet mode (suppress failure warnings)
+# -i: ignore errors on rhost
 # CMD: command to run (this must be binary, not shell builtin/function due
 # tst_rhost_run() limitation)
 # RETURN: 0 on success, 1 on missing CMD or exit code on lhost or rhost
@@ -227,12 +228,13 @@ tst_net_run()
 	local quiet
 
 	local OPTIND
-	while getopts l:qr:s opt; do
+	while getopts l:qr:si opt; do
 		case "$opt" in
 		l) lparams="$OPTARG" ;;
 		q) quiet=1 ;;
 		r) rparams="$OPTARG" ;;
 		s) lsafe="ROD"; rsafe="-s" ;;
+		i) rsafe="" ;;
 		*) tst_brk_ TBROK "tst_net_run: unknown option: $OPTARG" ;;
 		esac
 	done
@@ -916,9 +918,9 @@ tst_set_sysctl()
 	[ "$3" = "safe" ] && safe="-s"
 
 	local rparam=
-	[ "$TST_USE_NETNS" = "yes" ] && rparam="-r '-e'"
+	[ "$TST_USE_NETNS" = "yes" ] && rparam="-i -r '-e'"
 
-	tst_net_run $safe $rparam "sysctl" "-q -w $name=$value"
+	tst_net_run $safe -q $rparam "sysctl" "-q -w $name=$value"
 }
 
 tst_cleanup_rhost()
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
