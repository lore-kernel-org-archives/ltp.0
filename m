Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5336C433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:12:07 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D568E61027
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D568E61027
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D769D3C089D
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:12:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D7A93C03B1
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:11:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B82CE2000F0
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:11:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DAFA91FDB7;
 Tue,  9 Nov 2021 10:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636452712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9w4AMYyckxWKsJN2G+AG1jqjtGgClaXqfqWAAAmd8FY=;
 b=hED/3BFWin3+d1byQgESVB2hbPhP4UbjKyt1iXEdERP1Lb8KdWrjglw6RMA+ujiFcpJEQy
 3MfPSGOb8ONp/2a/yfNlt2TLBnK5GWunYO7084CHowvl4OFgkj/sFYtd22NVci2bwYKpQp
 2fCsXqpMc26OjtFMpcMx2ROMq6TBKD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636452712;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9w4AMYyckxWKsJN2G+AG1jqjtGgClaXqfqWAAAmd8FY=;
 b=2L0xuRTiePuTG88NoqnBCetlnIwxV85h2C+q8XLRLxN5YvFyTDGljGcpUo5ERS/D1HPBun
 H0vARHuLdjwru+BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A86B813481;
 Tue,  9 Nov 2021 10:11:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Gu8MJ2hJimHWagAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 09 Nov 2021 10:11:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  9 Nov 2021 11:11:45 +0100
Message-Id: <20211109101145.20092-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] test_zero_hugepage.sh: Lower hpages to 4
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

which is enough

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Yang Xu <xuyang2018.jy@fujitsu.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Tested on various distros, working.

Kind regards,
Petr

 lib/newlib_tests/test_zero_hugepage.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/newlib_tests/test_zero_hugepage.sh b/lib/newlib_tests/test_zero_hugepage.sh
index eed0a96f9..92bd7e331 100755
--- a/lib/newlib_tests/test_zero_hugepage.sh
+++ b/lib/newlib_tests/test_zero_hugepage.sh
@@ -25,7 +25,7 @@ if [ ! -w /proc/sys/vm/nr_hugepages ]; then
 	tconf "no write permission to /proc/sys/vm/nr_hugepages (run as root)"
 fi
 
-echo "128" > /proc/sys/vm/nr_hugepages
+echo 4 > /proc/sys/vm/nr_hugepages
 
 ./test_zero_hugepage
 
-- 
2.33.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
