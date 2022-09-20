Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8F5C54EE9
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 21:43:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F56D3CAD46
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 23:43:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B6D83CA9D2
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 23:43:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 117BC1A003C0
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 23:43:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F273521AC8;
 Tue, 20 Sep 2022 21:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663710185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6Ozc6HZoy45r5QSLMBA+BmM/Ae2X68BhLUogOIBfY3M=;
 b=W+RGk8/09OuGEnNbJtUObi8QQYh5OocSNGsjpan9ahrV+Niy0zQkbtgW7Z9CecDnX9tclD
 +uBiOMdbDUph/enrUY3fVio0T/yXYhoe2LJQNj+upya28mV8SnR1jcDd2UVESdLVP/Qok6
 1K3WH9b/1D7mYdQfI2tjWC7LN7USwXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663710185;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6Ozc6HZoy45r5QSLMBA+BmM/Ae2X68BhLUogOIBfY3M=;
 b=29WTA0yeB6nL/YpeolREOX/NV9ZT/bFJWowx4C9iptb7HN14sgp28CwTixCkOx5LPzMAzn
 6IeeVYH0ldrmwHBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0D2F13ABB;
 Tue, 20 Sep 2022 21:43:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vyNaKekzKmPdPwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Sep 2022 21:43:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 20 Sep 2022 23:43:01 +0200
Message-Id: <20220920214301.12828-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ima_setup.sh: Fix loop device workaround
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

Since 1f6bd6e66 ("tst_test.sh: Add $TST_ALL_FILESYSTEMS") ima_keys.sh
and other following tests fail on systems with tmpfs on $TMPDIR:

    ima_keys 1 TCONF: IMA policy does not specify '^measure.*func=KEY_CHECK'
    tst_device.c:255: TWARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for too long

    Usage:
    tst_device acquire [size [filename]]
    tst_device release /path/to/device
    tst_device clear /path/to/device

    ima_keys 1 TWARN: Failed to release device '/dev/loop0'
    rm: cannot remove '/tmp/LTP_ima_keys.YArl935DCg/mntpoint': Device or resource busy

unset TST_NEEDS_DEVICE should have been done before loading tst_test.sh,
as it's not a good idea to modify TST_* variables after loading tst_test.sh
(It worked before just by change).

Fixes: 04021637f ("tst_test.sh: Cleanup getopts usage")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index a626aae44..4b6690ce6 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -348,10 +348,9 @@ require_evmctl()
 	fi
 }
 
-. tst_test.sh
-
 # loop device is needed to use only for tmpfs
 TMPDIR="${TMPDIR:-/tmp}"
 if [ "$(df -T $TMPDIR | tail -1 | awk '{print $2}')" != "tmpfs" -a -n "$TST_NEEDS_DEVICE" ]; then
 	unset TST_NEEDS_DEVICE
 fi
+. tst_test.sh
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
