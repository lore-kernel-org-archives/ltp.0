Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DC7C433EF
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 16:45:48 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118F361213
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 16:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 118F361213
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7E923C753F
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 17:45:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C9023C712A
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 17:45:35 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DB031600704
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 17:45:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 48D43218B5;
 Thu,  4 Nov 2021 16:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636044334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aqcJwjAbmH2jP2zQPTEEIcOjr3Ms1mplKsNvWeivrZ4=;
 b=STa/UKtWyvyndCYzch254ZVh8tDwDORB8+6dnC8he9O4/wfBT0rCiue5vxSqr+m9+sYW6Y
 2B1Lt2FM+wUPsLrdxTUjtjtClQEOIqx8hh/lrU0bAY0GcWU29UC1JfXhxRGZJ9Y0ECk/VG
 NBJum1+SyKPVoKmvgsaKQLT5GkbVWy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636044334;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aqcJwjAbmH2jP2zQPTEEIcOjr3Ms1mplKsNvWeivrZ4=;
 b=fL7N/Ai3d64fVwVctOqnqc7BQWwGQ9w2lzBt3/bnDb2UBXCSMGd4EDjTfiG/gccszuWJf1
 Kkq/h1dXRKvbRZCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2652B13E70;
 Thu,  4 Nov 2021 16:45:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rtLABy4OhGG1FwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 Nov 2021 16:45:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Nov 2021 17:45:28 +0100
Message-Id: <20211104164528.29936-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] test_zero_hugepage.sh: Detect errors write to
 /proc/sys/vm/nr_hugepages
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

Fix running make test-c as non-root.

Fixes: 057d6b046 ("lib/tst_hugepage: Fix .request_hugepages = 0 bug")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

maybe echo "128" would not have to be checked.

Kind regards,
Petr

 lib/newlib_tests/test_zero_hugepage.sh | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/lib/newlib_tests/test_zero_hugepage.sh b/lib/newlib_tests/test_zero_hugepage.sh
index d270e686c..663bd2316 100755
--- a/lib/newlib_tests/test_zero_hugepage.sh
+++ b/lib/newlib_tests/test_zero_hugepage.sh
@@ -3,16 +3,31 @@
 # Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
 # Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
 
+tconf()
+{
+	echo "TCONF: $1"
+	exit 32
+}
+
 echo "Testing .request_hugepages = TST_NO_HUGEPAGES"
 
 orig_value=`cat /proc/sys/vm/nr_hugepages`
 
 if grep -q -E '^proc /proc(/sys)? proc ro' /proc/mounts; then
-	echo "TCONF: /proc or /proc/sys mounted as read-only"
-	exit 32
+	tconf "/proc or /proc/sys mounted as read-only"
+fi
+
+if [ ! -f /proc/sys/vm/nr_hugepages ]; then
+	tconf "/proc/sys/vm/nr_hugepages does not exist"
+fi
+
+if [ ! -w /proc/sys/vm/nr_hugepages ]; then
+	tconf "no write permission to /proc/sys/vm/nr_hugepages (run as root)"
 fi
 
-echo "128" > /proc/sys/vm/nr_hugepages
+if ! echo "128" > /proc/sys/vm/nr_hugepages; then
+	tconf "Failed to write /proc/sys/vm/nr_hugepages"
+fi
 
 ./test_zero_hugepage
 
-- 
2.33.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
