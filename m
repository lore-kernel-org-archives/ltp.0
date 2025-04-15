Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D41DC369AB
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 16:40:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39C743CB91D
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 18:39:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97D703CA513
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 18:39:42 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 745281000367
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 18:39:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD6942119A;
 Tue, 15 Apr 2025 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744735180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5C6NEypkWAlgxELRihY8y1D7QdjarlW/QTO+AoogL64=;
 b=eWK//Z+RlQEh+23dNN5d6H09e9Y5KB/hXcdkyERKaU3nwkgK6XMz2qh/2rpWi8IThbMOhd
 ic4S0AsFlN4EVsD9hun8yIGu1asvG8GhbrE0OSYKeBfplh0zcOhvfZs3D/0Qem0iL86hMn
 d2vT18Y8pMy9t+Z1CaLHt9NZbIi6wog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744735180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5C6NEypkWAlgxELRihY8y1D7QdjarlW/QTO+AoogL64=;
 b=WHxr6fgcKF3mn3GxLr1eMPifltwZn+gXgNCxq7Y4IxKFOxPJ0sCEXo6bh0xk6ZRHUCYjxL
 sLFPHzc+ktMA8wBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="eWK//Z+R";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WHxr6fgc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744735180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5C6NEypkWAlgxELRihY8y1D7QdjarlW/QTO+AoogL64=;
 b=eWK//Z+RlQEh+23dNN5d6H09e9Y5KB/hXcdkyERKaU3nwkgK6XMz2qh/2rpWi8IThbMOhd
 ic4S0AsFlN4EVsD9hun8yIGu1asvG8GhbrE0OSYKeBfplh0zcOhvfZs3D/0Qem0iL86hMn
 d2vT18Y8pMy9t+Z1CaLHt9NZbIi6wog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744735180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5C6NEypkWAlgxELRihY8y1D7QdjarlW/QTO+AoogL64=;
 b=WHxr6fgcKF3mn3GxLr1eMPifltwZn+gXgNCxq7Y4IxKFOxPJ0sCEXo6bh0xk6ZRHUCYjxL
 sLFPHzc+ktMA8wBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 854FB137A5;
 Tue, 15 Apr 2025 16:39:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6TjfHsyL/meEZQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 15 Apr 2025 16:39:40 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 15 Apr 2025 18:39:36 +0200
Message-Id: <20250415-patchwork_ci-v7-0-bc0b9adca971@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMiL/mcC/33MwW4CIRSF4VcxrEsDzIVhXPkejTFwuTjE1DFgR
 xsz7150NSGpy3OS73+wQjlRYdvNg2WaU0nTuY7+Y8NwdOcj8RTqZkooLUAKfnFXHG9TPh0w8T4
 gOBIKQQRWySVTTPdX7mtf95jKdcq/r/osn+8/oVlywQNFq63SEYzblZ9Cnzh9s2dnVu+sqlZZG
 8GT7XSMje3WVja2qxYH7weBZjDSNxbeWai2jx1q79RgnWysWVvdWFOtlWQCSAsu6pVdluUPsa0
 QE5cBAAA=
X-Change-ID: 20250410-patchwork_ci-7dc4ae02c40d
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744735180; l=3846;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=dbpK0qH/y29G/H+roHCAvmGcvSp7XeF+FEbkuEhvekw=;
 b=iG7FPTHO1U+XrktUoKU/nct8JQVX6AjSRqM2/YAPJmVrCGKWfxJ0Zt5ONrJ6XAt8RV23069Js
 W7coDvbFzIgBxhkAws+p2HZzQhj7qPbUGsJlS5Sr7q+MTt7+RabgKMe
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: AD6942119A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/4] Support for Patchwork CI
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
Changes in v7:
- patchwork.sh: fix bashism ==
- patchwork.sh: fix return code check for curl
- patchwork.sh: remove IFS= from loops
- patchwork.sh: local cmd in command_exists
- fix message for trigger scripts commit
- Link to v6: https://lore.kernel.org/r/20250415-patchwork_ci-v6-0-81e6d4184af5@suse.com

Changes in v6:
- patchwork.sh: use more "[ $stuff ] || do_something" syntax
- patchwork.sh: remove set -ex
- patchwork.sh: variables default setup
- patchwork.sh: move file creation in tmp folder
- patchwork.sh: check multiple commands exist in once
- trigger workflow now triggers only on linux-test-project/ltp repo
- Link to v5: https://patchwork.ozlabs.org/project/ltp/list/?series=452320

Changes in v5:
- patchwork is now a utility that can be used separately
- Link to v4: https://lore.kernel.org/r/20250411-patchwork_ci-v4-0-7f3c5ba298a1@suse.com

Changes in v4:
- make use of secrets to apply patches in order to set state to
  needs-review-ack
- check for curl failures and eventually exit 1
- use a different format for stored file in 'patchwork-ci.sh verify'
  command
- define PATCHWORK_CI_FILE
- some symbols like . are not supported by patchwork checks, so slurmify
  the string before sending checks context
- Link to v3: https://lore.kernel.org/r/20250411-patchwork_ci-v3-0-c9bb90c6961b@suse.com

Changes in v3:
- secrets are not supported by if: statement, so we remove it
- Link to v2: https://lore.kernel.org/r/20250410-patchwork_ci-v2-0-288f4be835ff@suse.com

Changes in v2:
- check for secrets.PATCHWORK_TOKEN before sending tests results
- v2 to re-trigger lore after missing 3/4 patch
- Link to v1: https://lore.kernel.org/r/20250410-patchwork_ci-v1-0-def85825f46a@suse.com

---
Andrea Cervesato (4):
      ci: install dependences for patchwork-ci script
      ci: add patchwork communication script
      ci: add ci-patchwork-trigger workflow
      ci: apply patchwork series in ci-docker-build workflow

 .github/workflows/ci-docker-build.yml      |  39 ++++++-
 .github/workflows/ci-patchwork-trigger.yml |  65 +++++++++++
 ci/alpine-runtime.sh                       |   2 +
 ci/alpine.sh                               |   2 +
 ci/debian.i386.sh                          |   2 +
 ci/debian.sh                               |   2 +
 ci/fedora.sh                               |   2 +
 ci/tools/patchwork.sh                      | 173 +++++++++++++++++++++++++++++
 ci/tumbleweed.sh                           |   2 +
 9 files changed, 288 insertions(+), 1 deletion(-)
---
base-commit: 40c559787d15b2167ba657b3ba431e3299969d98
change-id: 20250410-patchwork_ci-7dc4ae02c40d

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
