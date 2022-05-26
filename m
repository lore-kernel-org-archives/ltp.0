Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01BBC433EF
	for <ltp@archiver.kernel.org>; Thu, 26 May 2022 09:46:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 618DB3C0F72
	for <ltp@archiver.kernel.org>; Thu, 26 May 2022 11:46:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F6BF3C0215
 for <ltp@lists.linux.it>; Thu, 26 May 2022 11:46:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A99C36009FD
 for <ltp@lists.linux.it>; Thu, 26 May 2022 11:46:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D0E06219B0
 for <ltp@lists.linux.it>; Thu, 26 May 2022 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653558404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nJf0oNRZxXMMtpxWAC0qNMSQGoAwVLlg50C6bJNr7NY=;
 b=K8BJF3rD0aktmj5E20ARd/YSlY2XVM3kFk1stVuzMyEbvcYe5rPwlHq53vcPTrwWb0/aKv
 Q9CWmndbY7OMaiP+wKuBHJp1JWo4lvy6efFfM5+OVuG3ThEEwlGELLZfJw7JVNbn1mmqI5
 Yv5IoRzI6QU/D+R7NOgwqe2kVAS7WIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653558404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nJf0oNRZxXMMtpxWAC0qNMSQGoAwVLlg50C6bJNr7NY=;
 b=8ADCa2oPug+OvDWsXpD67bT3I65LacyHDk19QS2xVm6Dx8EvBHHuMwiD0L4p6Brp17xPc9
 qyl4jqx5b8MMiKDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B752D1351F
 for <ltp@lists.linux.it>; Thu, 26 May 2022 09:46:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Zz+CK4RMj2IsHAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 26 May 2022 09:46:44 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 26 May 2022 11:48:52 +0200
Message-Id: <20220526094852.8084-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ci/wiki-mirror: Track KVM API too
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .github/workflows/wiki-mirror.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/wiki-mirror.yml b/.github/workflows/wiki-mirror.yml
index 36c7d8311..d2e434152 100644
--- a/.github/workflows/wiki-mirror.yml
+++ b/.github/workflows/wiki-mirror.yml
@@ -45,6 +45,7 @@ jobs:
           cp -v $dir/supported-kernel-libc-versions.txt Supported-kernel,-libc,-toolchain-versions.asciidoc
           cp -v $dir/test-writing-guidelines.txt Test-Writing-Guidelines.asciidoc
           cp -v $dir/user-guide.txt User-Guidelines.asciidoc
+          cp -v $dir/kvm-test-api.txt KVM-Test-API.asciidoc
 
           git add .
           # only commit if there are changes
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
