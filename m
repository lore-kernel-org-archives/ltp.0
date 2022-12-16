Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5347FC4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 15:01:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83E573CBC72
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 16:01:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 319EF3CBC18
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 16:01:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6DB34600917
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 16:01:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CAD1C34341;
 Fri, 16 Dec 2022 15:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1671202901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Ds+7DD0eYwp3SBU/hu/elr8FYOyOg6pkVcwD75K/apM=;
 b=GVXrvME1fCo8NXZv7uCnz1oKeHCQ5FVrAvbnf2f5XlyrnMKWCd9/gWNUeBndheBHdYh5/d
 aR5SBlZyafSrubprI5hw44gY1vO6htYNc6e4IrYjj13EfUcRZDiK5EH8GTX1j9cFcJLYlE
 taU57dybsigXvnZ1hgEpC2zAz0uExkg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95237138FD;
 Fri, 16 Dec 2022 15:01:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XSNLIVWInGOKegAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Fri, 16 Dec 2022 15:01:41 +0000
To: ltp@lists.linux.it
Date: Fri, 16 Dec 2022 16:00:01 +0100
Message-Id: <20221216150001.3425-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Use filesize notation for aio-stress options
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The record size defined by -r option is not using filesize notation
inside ltp-aio-stress runtest file.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/ltp-aio-stress | 108 ++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/runtest/ltp-aio-stress b/runtest/ltp-aio-stress
index 4b0b81ce2..1de49b406 100644
--- a/runtest/ltp-aio-stress
+++ b/runtest/ltp-aio-stress
@@ -1,55 +1,55 @@
 # ltp A-sync IO Stress IO tests
-ADS1000 aio-stress -o2 -r4 -f1
-ADS1001 aio-stress -o2 -r8 -f1
-ADS1002 aio-stress -o2 -r16 -f1
-ADS1003 aio-stress -o2 -r32 -t2 -f2
-ADS1004 aio-stress -o2 -r64 -f2
-ADS1005 aio-stress -o3 -r4 -f2
-ADS1006 aio-stress -o3 -r8 -f2
-ADS1007 aio-stress -o3 -r16 -f2
-ADS1008 aio-stress -o3 -r32 -f4
-ADS1009 aio-stress -o3 -r64 -t4 -f4
-ADS1010 aio-stress -o3 -r128 -t4 -f4
-ADS1011 aio-stress -o3 -r256 -t8 -f8
-ADS1012 aio-stress -o3 -r512 -t8 -f8
-ADS1013 aio-stress -o2 -O -r4 -t8 -f8
-ADS1014 aio-stress -o2 -O -r8 -f2
-ADS1015 aio-stress -o2 -O -r16 -f2
-ADS1016 aio-stress -o2 -O -r32 -t2 -f2
-ADS1017 aio-stress -o2 -O -r64 -t2 -f2
-ADS1018 aio-stress -o3 -O -r4 -t2 -f2
-ADS1019 aio-stress -o3 -O -r8 -t2 -f2
-ADS1020 aio-stress -o3 -O -r16 -t2 -f2
-ADS1021 aio-stress -o3 -O -r32 -t4 -f4
-ADS1022 aio-stress -o3 -O -r64 -t4 -f4
-ADS1023 aio-stress -o3 -O -r128 -t4 -f4
-ADS1024 aio-stress -o3 -O -r256 -t8 -f8
-ADS1025 aio-stress -o3 -O -r512 -t8 -f8
-ADS1026 aio-stress -o0 -r4 -t8 -f8
-ADS1027 aio-stress -o0 -r8 -f1
-ADS1028 aio-stress -o0 -r16 -f1
-ADS1029 aio-stress -o0 -r32 -t2 -f2
-ADS1030 aio-stress -o0 -r64 -t2 -f2
-ADS1031 aio-stress -o1 -r4 -t2 -f1
-ADS1032 aio-stress -o1 -r8 -t2 -f1
-ADS1033 aio-stress -o1 -r16 -t2 -f2
-ADS1034 aio-stress -o1 -r32 -t4 -f4
-ADS1035 aio-stress -o1 -r64 -t4 -f4
-ADS1036 aio-stress -o1 -r128 -t4 -f4
-ADS1037 aio-stress -o1 -r256 -t8 -f8
-ADS1038 aio-stress -o1 -r512 -t8 -f8
-ADS1039 aio-stress -o1 -O -r4 -t8 -f8
-ADS1040 aio-stress -o1 -O -r8 -t2 -f2
-ADS1041 aio-stress -o1 -O -r16 -t2 -f2
-ADS1042 aio-stress -o1 -O -r32 -t2 -f2
-ADS1043 aio-stress -o1 -O -r64 -t2 -f2
-ADS1044 aio-stress -o1 -O -r4 -t4 -f4
-ADS1045 aio-stress -o1 -O -r8 -t4 -f4
-ADS1046 aio-stress -o1 -O -r16 -t4 -f4
-ADS1047 aio-stress -o1 -O -r32 -t8 -f8
-ADS1048 aio-stress -o1 -O -r64 -t8 -f8
-ADS1049 aio-stress -o1 -O -r128 -t8 -f8
-ADS1050 aio-stress -o1 -O -r256 -t2 -f2
-ADS1051 aio-stress -o3 -r8 -t2 -f2
-ADS1052 aio-stress -o3 -r16 -t2 -f2
-ADS1053 aio-stress -o3 -r32 -t4 -f4
+ADS1000 aio-stress -o2 -r4k -f1
+ADS1001 aio-stress -o2 -r8k -f1
+ADS1002 aio-stress -o2 -r16k -f1
+ADS1003 aio-stress -o2 -r32k -t2 -f2
+ADS1004 aio-stress -o2 -r64k -f2
+ADS1005 aio-stress -o3 -r4k -f2
+ADS1006 aio-stress -o3 -r8k -f2
+ADS1007 aio-stress -o3 -r16k -f2
+ADS1008 aio-stress -o3 -r32k -f4
+ADS1009 aio-stress -o3 -r64k -t4 -f4
+ADS1010 aio-stress -o3 -r128k -t4 -f4
+ADS1011 aio-stress -o3 -r256k -t8 -f8
+ADS1012 aio-stress -o3 -r512k -t8 -f8
+ADS1013 aio-stress -o2 -O -r4k -t8 -f8
+ADS1014 aio-stress -o2 -O -r8k -f2
+ADS1015 aio-stress -o2 -O -r16k -f2
+ADS1016 aio-stress -o2 -O -r32k -t2 -f2
+ADS1017 aio-stress -o2 -O -r64k -t2 -f2
+ADS1018 aio-stress -o3 -O -r4k -t2 -f2
+ADS1019 aio-stress -o3 -O -r8k -t2 -f2
+ADS1020 aio-stress -o3 -O -r16k -t2 -f2
+ADS1021 aio-stress -o3 -O -r32k -t4 -f4
+ADS1022 aio-stress -o3 -O -r64k -t4 -f4
+ADS1023 aio-stress -o3 -O -r128k -t4 -f4
+ADS1024 aio-stress -o3 -O -r256k -t8 -f8
+ADS1025 aio-stress -o3 -O -r512k -t8 -f8
+ADS1026 aio-stress -o0 -r4k -t8 -f8
+ADS1027 aio-stress -o0 -r8k -f1
+ADS1028 aio-stress -o0 -r16k -f1
+ADS1029 aio-stress -o0 -r32k -t2 -f2
+ADS1030 aio-stress -o0 -r64k -t2 -f2
+ADS1031 aio-stress -o1 -r4k -t2 -f1
+ADS1032 aio-stress -o1 -r8k -t2 -f1
+ADS1033 aio-stress -o1 -r16k -t2 -f2
+ADS1034 aio-stress -o1 -r32k -t4 -f4
+ADS1035 aio-stress -o1 -r64k -t4 -f4
+ADS1036 aio-stress -o1 -r128k -t4 -f4
+ADS1037 aio-stress -o1 -r256k -t8 -f8
+ADS1038 aio-stress -o1 -r512k -t8 -f8
+ADS1039 aio-stress -o1 -O -r4k -t8 -f8
+ADS1040 aio-stress -o1 -O -r8k -t2 -f2
+ADS1041 aio-stress -o1 -O -r16k -t2 -f2
+ADS1042 aio-stress -o1 -O -r32k -t2 -f2
+ADS1043 aio-stress -o1 -O -r64k -t2 -f2
+ADS1044 aio-stress -o1 -O -r4k -t4 -f4
+ADS1045 aio-stress -o1 -O -r8k -t4 -f4
+ADS1046 aio-stress -o1 -O -r16k -t4 -f4
+ADS1047 aio-stress -o1 -O -r32k -t8 -f8
+ADS1048 aio-stress -o1 -O -r64k -t8 -f8
+ADS1049 aio-stress -o1 -O -r128k -t8 -f8
+ADS1050 aio-stress -o1 -O -r256k -t2 -f2
+ADS1051 aio-stress -o3 -r8k -t2 -f2
+ADS1052 aio-stress -o3 -r16k -t2 -f2
+ADS1053 aio-stress -o3 -r32k -t4 -f4
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
