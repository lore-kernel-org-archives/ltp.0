Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E8BC3601E
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 18:21:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B22423CB53E
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 20:21:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6C5A3CAD86
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 20:21:16 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AB237100044B
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 20:21:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B29261F38C;
 Thu, 10 Apr 2025 18:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744309273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L/RxDdNsKGg2q0GReLv3vo0SA1S+K6BKri58KzH4w4s=;
 b=uHP07tZech4jFBQGmFI8/eJ9wf+2ZrOtH4OsQd2dJ7VFzDDsN01YvvhKVyRE6KwLwaKAkK
 F4i6Gz7NArVhkg7gflxo/j/z6tM9T9H2kJ98uJk0Qyza+vZ1Lbu83TP9O5rajVaSBXxTfp
 9M49AT02TGPmJOvzcKRSeFIFAi+7Nak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744309273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L/RxDdNsKGg2q0GReLv3vo0SA1S+K6BKri58KzH4w4s=;
 b=3YrCJZ5gjTm0rBtFysBNmOENxOWYQJc88ql0uA6p3yemCzjsEQ7LC0C0MI1zznAn3ZHBfd
 FZ/2N1vTLU8K56Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744309273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L/RxDdNsKGg2q0GReLv3vo0SA1S+K6BKri58KzH4w4s=;
 b=uHP07tZech4jFBQGmFI8/eJ9wf+2ZrOtH4OsQd2dJ7VFzDDsN01YvvhKVyRE6KwLwaKAkK
 F4i6Gz7NArVhkg7gflxo/j/z6tM9T9H2kJ98uJk0Qyza+vZ1Lbu83TP9O5rajVaSBXxTfp
 9M49AT02TGPmJOvzcKRSeFIFAi+7Nak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744309273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L/RxDdNsKGg2q0GReLv3vo0SA1S+K6BKri58KzH4w4s=;
 b=3YrCJZ5gjTm0rBtFysBNmOENxOWYQJc88ql0uA6p3yemCzjsEQ7LC0C0MI1zznAn3ZHBfd
 FZ/2N1vTLU8K56Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92B4B132D8;
 Thu, 10 Apr 2025 18:21:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qPJeHRkM+GfPQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Apr 2025 18:21:13 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 10 Apr 2025 20:21:09 +0200
Message-Id: <20250410-patchwork_ci-v2-0-288f4be835ff@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABUM+GcC/3XMQQ7CIBCF4as0sxZDCWjjynuYxhAYZGIsDVNR0
 3B3sXuX/0vetwJjJmQ4dStkLMSUphZq14GLdrqhIN8alFRG6l6K2S4uvlK+Xx2Jo3faolROSw/
 tMmcM9N64y9g6Ei8pfza99L/1D1R6IYXHMJhBmaAP9sxPxr1LDxhrrV9bPXcGpwAAAA==
X-Change-ID: 20250410-patchwork_ci-7dc4ae02c40d
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744309273; l=2314;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=88EfSIwoNByr175X+6uXqDwHQVzopQPGpG7lOMwAwLs=;
 b=1dtxAoY9B7upM9/xvcnUlaBG7BC9dle93FFxDp6uRHI6W3hjq9GTkNIwAOL4XWpN80NvVuq6D
 v7OkE7EzlzMCFLBsjxTtenG0gPe7dUCa/xNsmSffvSTCYt2AQco8P0A
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/4] Support for Patchwork CI
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

Add support for patch-series validation in the patchwork ML.
We use Github to schedule a trigger every 30 minutes, checking for new
patche-series in parchwork which has not been tested yet.

The way we decide if a patch-series has been tested in patchwork, is
by looking at its status (in particular, if it's "Needs Review / ACK"),
as well as checking if test report has been uploaded to any of the
series patches.

All communication to Patchwrok is done via REST API, using curl and js
tools.

First, we create a script called patchwork-ci.sh that provides all the
commands to read new untested patch-series, set their status and testing
report. Then, we create a scheduled workflow in Gitlab, checking every
30 minutes if there are new untested patch-series. At the end, we
trigger the main build workflow, used to validate LTP commits in our
Github mainline. All the times we trigger the build workflow, we also
provide the patch-series ID, that will be fetched and applied on the
current branch before running the tests.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- check for secrets.PATCHWORK_TOKEN before sending tests results
- v2 to re-trigger lore after missing 3/4 patch
- Link to v1: https://lore.kernel.org/r/20250410-patchwork_ci-v1-0-def85825f46a@suse.com

---
Andrea Cervesato (4):
      ci: install dependences for patchwork-ci script
      ci: add patchwork-ci script
      ci: add ci-patchwork-trigger workflow
      ci: apply patchwork series in ci-docker-build workflow

 .github/workflows/ci-docker-build.yml      |  29 ++++-
 .github/workflows/ci-patchwork-trigger.yml |  53 ++++++++++
 ci/alpine-runtime.sh                       |   2 +
 ci/alpine.sh                               |   2 +
 ci/debian.i386.sh                          |   2 +
 ci/debian.sh                               |  28 ++---
 ci/fedora.sh                               |   2 +
 ci/patchwork-ci.sh                         | 164 +++++++++++++++++++++++++++++
 ci/tumbleweed.sh                           |   2 +
 9 files changed, 270 insertions(+), 14 deletions(-)
---
base-commit: 8000c950d6ba61a541a9278cdda6d68141c2fc0d
change-id: 20250410-patchwork_ci-7dc4ae02c40d

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
