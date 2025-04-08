Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85769C36010
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 11:45:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07D1F3CB389
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 13:45:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 360EB3CB381
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 13:44:37 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4A713100045A
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 13:44:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8EFA821166;
 Tue,  8 Apr 2025 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744112674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a6fIMxJRVHh7LHm8/B91MdPb/x73Q8lOHLyA+VUo5pw=;
 b=Q9hcKiZtim+7Cy/KtIPYVJ+M3L09OHVdYTEGi/2K0UnRb2tIyXhqTPA7BsaMzmSVVdk2kJ
 p6Hqu7lnzyMssJ7F8eKL+O5Vg5N/fg12ZUnJZd2WY9ttQn5cdDJHMpCNDopTyp423/o16X
 +vrbEVEMq2OycTa590tmdND/Inph6FU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744112674;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a6fIMxJRVHh7LHm8/B91MdPb/x73Q8lOHLyA+VUo5pw=;
 b=3VgfmoqPi3IUw+Vp4EiYdBianLTyU6T4Wjbt0GgPnmKMb9EdwSyt9lvxckxJjp72/SYPVJ
 K2i5gLHxeT5HIBDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744112674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a6fIMxJRVHh7LHm8/B91MdPb/x73Q8lOHLyA+VUo5pw=;
 b=Q9hcKiZtim+7Cy/KtIPYVJ+M3L09OHVdYTEGi/2K0UnRb2tIyXhqTPA7BsaMzmSVVdk2kJ
 p6Hqu7lnzyMssJ7F8eKL+O5Vg5N/fg12ZUnJZd2WY9ttQn5cdDJHMpCNDopTyp423/o16X
 +vrbEVEMq2OycTa590tmdND/Inph6FU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744112674;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=a6fIMxJRVHh7LHm8/B91MdPb/x73Q8lOHLyA+VUo5pw=;
 b=3VgfmoqPi3IUw+Vp4EiYdBianLTyU6T4Wjbt0GgPnmKMb9EdwSyt9lvxckxJjp72/SYPVJ
 K2i5gLHxeT5HIBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54E3513A1E;
 Tue,  8 Apr 2025 11:44:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rN+bEiIM9WdkEAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 08 Apr 2025 11:44:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  8 Apr 2025 13:44:31 +0200
Message-ID: <20250408114432.220841-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] sphinx: Update to 7.2.6, python 3.12, ubuntu-24.04
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
Cc: =?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Update sphinx to 7.2.6, python 3.12. This requires to update
.readthedocs.yml to use ubuntu-24.04 [1], because keep in sync sphinx in
readthedocs with with the one for local development and github CI.
Raising python makes sense, as development is usually done on newer
distros, we were still using old python 3.6.

This fixes the problem on local development trying to run older sphinx
5.3 on python 3.13 requires to use imghdr, which was removed from
standard library (alternatively we'd need to install it from pip via
adding standard-imghdr into requirements.txt).

[1] https://about.readthedocs.com/blog/2024/06/ubuntu-24-04/

Fixes: b900b790e9 ("doc: Add sphinx to requirements.txt")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

first, I'm sorry for a regression. I tested all the previous versions
carefully even locally, but in the end the final variant I obviously
omit to test.

Tested:
https://app.readthedocs.org/projects/linux-test-project/builds/27784588/

Alternatively, we could keep old distros and just add standard-imghdr
(without version) to doc/requirements.txt. But sooner or later we will
need to upgrade thus I'm sending this version.

Kind regards,
Petr

 .readthedocs.yml     | 4 ++--
 doc/requirements.txt | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.readthedocs.yml b/.readthedocs.yml
index 5434ef49d6..51825da77f 100644
--- a/.readthedocs.yml
+++ b/.readthedocs.yml
@@ -1,9 +1,9 @@
 version: 2
 
 build:
-  os: "ubuntu-22.04"
+  os: "ubuntu-24.04"
   tools:
-    python: "3.6"
+    python: "3.12"
   apt_packages:
     - autoconf
     - enchant-2
diff --git a/doc/requirements.txt b/doc/requirements.txt
index 6302ecd9f2..1b9a984547 100644
--- a/doc/requirements.txt
+++ b/doc/requirements.txt
@@ -1,6 +1,6 @@
 # Use the same sphinx as on readthedocs.org. When updated, make sure
 # sphinx-rtd-theme is compatible with sphinx.
-sphinx==5.3.0
+sphinx==7.2.6
 sphinx-rtd-theme==2.0.0
 
 linuxdoc==20231020
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
