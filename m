Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBF1C44501
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 05:56:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20F903E26DD
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 07:56:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B46583E26BB
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 07:56:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 82056600A31
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 07:56:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B6275765FC;
 Fri, 10 Jul 2026 05:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783662959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8kisd/8wmUBj9ePZXPBJ/QX6LCSvTXthZ6uF4pJNOcc=;
 b=EHge57LEpAdQXVQAWvdaS1U4CLRkWiHW6aAg9NyiHEbo6jufe33KZTyt7M/f2v0soXR5Lc
 FFwA4wI/nJeJfUG+VDq8cXmPUKnWDPbhfldnK6xHdLBiG3ob9yaZprbn9ImUjdoje0ByXK
 6k3xFTTo6jmiKYRngq0JY0C//mS0Gvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783662959;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8kisd/8wmUBj9ePZXPBJ/QX6LCSvTXthZ6uF4pJNOcc=;
 b=PoGOEEKuctI6JmL2bZ4inth/Y2Oc7WuJQ1gveR+TwhJ5kLuDAJKyb9CYLjPptxuGAG3yaZ
 H5hUMIQr71Cs7sDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EHge57LE;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PoGOEEKu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783662959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8kisd/8wmUBj9ePZXPBJ/QX6LCSvTXthZ6uF4pJNOcc=;
 b=EHge57LEpAdQXVQAWvdaS1U4CLRkWiHW6aAg9NyiHEbo6jufe33KZTyt7M/f2v0soXR5Lc
 FFwA4wI/nJeJfUG+VDq8cXmPUKnWDPbhfldnK6xHdLBiG3ob9yaZprbn9ImUjdoje0ByXK
 6k3xFTTo6jmiKYRngq0JY0C//mS0Gvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783662959;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8kisd/8wmUBj9ePZXPBJ/QX6LCSvTXthZ6uF4pJNOcc=;
 b=PoGOEEKuctI6JmL2bZ4inth/Y2Oc7WuJQ1gveR+TwhJ5kLuDAJKyb9CYLjPptxuGAG3yaZ
 H5hUMIQr71Cs7sDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CA8D779BD;
 Fri, 10 Jul 2026 05:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A+r7JG+JUGp7TwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jul 2026 05:55:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Jul 2026 07:55:48 +0200
Message-ID: <20260710055556.1109220-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B6275765FC
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/7] CI: Run metadata tests
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

Changes v1->v2:
* Fix out of tree build
* Try to detect out-of-tree build without specifying variable
* Makefile: Skip test-metadata on cross compile (new commit)
* Add missing diffutils for openSUSE
* Add missing licenses, copyright (new commit)

Tested:
https://github.com/pevik/ltp/actions/runs/29044863389

Petr Vorel (8):
  Makefile: Skip test-metadata on cross compile
  metadata: test.sh: Print the test name and result
  metadata: Fix dependency for tests
  metadata: test.sh: Add support for building out-of-tree
  metadata: Add missing licenses, copyright
  build.sh: Add support for test-metadata
  ci/tumbleweed: Install diffutils
  ci: Test metadata in docker build testing

 .github/workflows/ci-docker-build.yml |  5 +++++
 Makefile                              |  5 ++++-
 build.sh                              |  5 +++--
 ci/tumbleweed.sh                      |  3 ++-
 metadata/Makefile                     |  4 ++--
 metadata/tests/Makefile               |  3 +++
 metadata/tests/test.sh                | 19 ++++++++++++++++---
 7 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
