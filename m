Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5933F8D762
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 18:35:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 364A33E74F9
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 20:35:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F3573E71DB
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 20:35:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 87FE514001FD
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 20:35:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A759A6A801;
 Thu, 16 Apr 2026 18:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776364509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5ADEvUD6bEIaWuBliHWGJCjgpAWPWS9aEj80YXcFFZ4=;
 b=IXLv1B1khK12FuuGY48TY/j8NBRmMYHM5P61w8ST9gzjL8RarpnC6ee1DBG7+YYCyQNeW2
 /23GOnTmXWLt56GXWPxn6Q3UtmhsNnhc15+0dP/JY7a+7CmcfuS+pAcCXzcknWfuEIznVY
 6U40CiIFmco91Qov23gGGA31yO9JfLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776364509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5ADEvUD6bEIaWuBliHWGJCjgpAWPWS9aEj80YXcFFZ4=;
 b=anKRBBojN4lFVUH6FKnJTYOxgTXBbB6N+yfzo2nd+Wk2xVRRMSr19ap0d0s6pRtBigi2V9
 AWTeKT6nxHWyFcBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776364509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5ADEvUD6bEIaWuBliHWGJCjgpAWPWS9aEj80YXcFFZ4=;
 b=IXLv1B1khK12FuuGY48TY/j8NBRmMYHM5P61w8ST9gzjL8RarpnC6ee1DBG7+YYCyQNeW2
 /23GOnTmXWLt56GXWPxn6Q3UtmhsNnhc15+0dP/JY7a+7CmcfuS+pAcCXzcknWfuEIznVY
 6U40CiIFmco91Qov23gGGA31yO9JfLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776364509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5ADEvUD6bEIaWuBliHWGJCjgpAWPWS9aEj80YXcFFZ4=;
 b=anKRBBojN4lFVUH6FKnJTYOxgTXBbB6N+yfzo2nd+Wk2xVRRMSr19ap0d0s6pRtBigi2V9
 AWTeKT6nxHWyFcBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31C54593A3;
 Thu, 16 Apr 2026 18:35:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yqwaCt0r4WmABgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Apr 2026 18:35:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 16 Apr 2026 20:35:00 +0200
Message-ID: <20260416183500.316638-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,suse.com,gmail.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ci: doc: Remove Ubuntu bionic
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

Ubuntu 18.04 LTS bionic EOL 3 years ago (2023-04). Repositories were
publicly available until now, remove it to fix CI.

Exact error is missing Packages file

W: Failed to fetch http://archive.ubuntu.com/ubuntu/dists/bionic-backports/InRelease  Connection failed [IP: 91.189.91.82 80]
E: Failed to fetch http://archive.ubuntu.com/ubuntu/dists/bionic/universe/binary-amd64/Packages  Connection timed out [IP: 91.189.92.23 80]

which causes gcc not being installed.

Although repository has Packages.gz and Packages.xz (therefore it
should somehow work or it might be GitHub Actions issue) we don't need
to keep bionic (we have older distro openSUSE Leap 42), which we still
use for testing SLE1-SP2 build).

Reported-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

I'd like to merge tomorrow.
@Li just FYI that CI is being handled.

Kind regards,
Petr

 .github/workflows/ci-docker-build.yml | 4 ----
 doc/users/supported_systems.rst       | 6 ------
 2 files changed, 10 deletions(-)

diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
index 16d99f097a..0c0635febd 100644
--- a/.github/workflows/ci-docker-build.yml
+++ b/.github/workflows/ci-docker-build.yml
@@ -110,10 +110,6 @@ jobs:
               CC: gcc
               TREE: out
 
-          - container: "ubuntu:bionic"
-            env:
-              CC: gcc
-
     container:
       image: ${{ matrix.container }}
       env: ${{ matrix.env }}
diff --git a/doc/users/supported_systems.rst b/doc/users/supported_systems.rst
index dabb5883ad..b241d05739 100644
--- a/doc/users/supported_systems.rst
+++ b/doc/users/supported_systems.rst
@@ -34,12 +34,6 @@ Oldest build tested distributions
       - 4.8.5
       - \-
 
-    * - Ubuntu 18.04 LTS bionic
-      - 4.15
-      - 2.27
-      - 7.3.0
-      - \-
-
     * - Debian 11 (bullseye)
       - 5.10
       - 2.31
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
