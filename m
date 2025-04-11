Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFEEC36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 11:44:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12CA33CAEB7
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 13:44:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2A633CA320
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 13:43:41 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0DFA9600BB9
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 13:43:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C91D1F74D;
 Fri, 11 Apr 2025 11:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744371819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rlsyjQVDk7Ffp0WML90hVZ586rHyXSJy986irJUxJYk=;
 b=hLSCimKAx+xv5wEjUU2PiCs1MgzRVKm0XoZYjjMsyHdDtI2TJG9iiA8Hntu7GH8mzNpEVU
 4r1JQLj93sHOccswG+GpRo9Mnlu3qy5z2vW8avqvOONUmIhuLlGnceOHvfdDKNm9KZWs4r
 m9BxCtdfl4TsFaGicKgCXRzEJywtoTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744371819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rlsyjQVDk7Ffp0WML90hVZ586rHyXSJy986irJUxJYk=;
 b=S7BDVuTjyo9Fv5YX8DgW/DTimRFwvRese8iyyofJdhnF5//gCzosehbkFo/8cvxQiDA06S
 5Sln8A4qN59/dSCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hLSCimKA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=S7BDVuTj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744371819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rlsyjQVDk7Ffp0WML90hVZ586rHyXSJy986irJUxJYk=;
 b=hLSCimKAx+xv5wEjUU2PiCs1MgzRVKm0XoZYjjMsyHdDtI2TJG9iiA8Hntu7GH8mzNpEVU
 4r1JQLj93sHOccswG+GpRo9Mnlu3qy5z2vW8avqvOONUmIhuLlGnceOHvfdDKNm9KZWs4r
 m9BxCtdfl4TsFaGicKgCXRzEJywtoTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744371819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rlsyjQVDk7Ffp0WML90hVZ586rHyXSJy986irJUxJYk=;
 b=S7BDVuTjyo9Fv5YX8DgW/DTimRFwvRese8iyyofJdhnF5//gCzosehbkFo/8cvxQiDA06S
 5Sln8A4qN59/dSCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B9FA13886;
 Fri, 11 Apr 2025 11:43:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2inFCGsA+WcmVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Apr 2025 11:43:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 11 Apr 2025 13:43:20 +0200
Message-ID: <20250411114326.526-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5C91D1F74D
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/4] Support for Patchwork CI
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

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
Changes in v4:
- patchwork script is now a tool that can be used independently to ci

Andrea Cervesato (4):
  ci: install dependences for patchwork-ci script
  ci: add patchwork communication script
  ci: add ci-patchwork-trigger workflow
  ci: apply patchwork series in ci-docker-build workflow

 .github/workflows/ci-docker-build.yml      |  39 +++-
 .github/workflows/ci-patchwork-trigger.yml |  63 +++++++
 ci/alpine-runtime.sh                       |   2 +
 ci/alpine.sh                               |   2 +
 ci/debian.i386.sh                          |   2 +
 ci/debian.sh                               |  28 +--
 ci/fedora.sh                               |   2 +
 ci/tools/patchwork.sh                      | 197 +++++++++++++++++++++
 ci/tumbleweed.sh                           |   2 +
 9 files changed, 323 insertions(+), 14 deletions(-)
 create mode 100644 .github/workflows/ci-patchwork-trigger.yml
 create mode 100755 ci/tools/patchwork.sh

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
