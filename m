Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED97C44501
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 10:54:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2D1E3E1CE1
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 12:54:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D83423E1CE1
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 12:53:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 46A811A001BE
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 12:53:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4156B78901;
 Thu, 16 Jul 2026 10:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784199237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7S7uisGHX7b7tdfrFqoZgSASnTMuS8G7kfMNJNTnuqc=;
 b=IqtqVZIMp6ncpPhf7Ofs/m8tekZaZAOlbwDqv939ZxMXOqkGhLW2IO2C8Vf6BmC1UmAHU6
 oWGrf3qaAQI2aNw5rhOCe/0VBUVOtTTnMHW1Lvc42ixe9Gzi/K6iIHr9/SDrk9ufsSH7dq
 I/G5/QAf9v9aw3dCGXkkeA+unzWIS5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784199237;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7S7uisGHX7b7tdfrFqoZgSASnTMuS8G7kfMNJNTnuqc=;
 b=bsxua0yTQXgJuLvw9bsONAxk2WBVFa7K3syRXBLfeIUHyjq3EZpNzqX88qpZQ/SFomEp+m
 rPcquP201ABzfdDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784199237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7S7uisGHX7b7tdfrFqoZgSASnTMuS8G7kfMNJNTnuqc=;
 b=IqtqVZIMp6ncpPhf7Ofs/m8tekZaZAOlbwDqv939ZxMXOqkGhLW2IO2C8Vf6BmC1UmAHU6
 oWGrf3qaAQI2aNw5rhOCe/0VBUVOtTTnMHW1Lvc42ixe9Gzi/K6iIHr9/SDrk9ufsSH7dq
 I/G5/QAf9v9aw3dCGXkkeA+unzWIS5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784199237;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7S7uisGHX7b7tdfrFqoZgSASnTMuS8G7kfMNJNTnuqc=;
 b=bsxua0yTQXgJuLvw9bsONAxk2WBVFa7K3syRXBLfeIUHyjq3EZpNzqX88qpZQ/SFomEp+m
 rPcquP201ABzfdDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D65DE779AD;
 Thu, 16 Jul 2026 10:53:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4fiHMUO4WGoxawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jul 2026 10:53:55 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 16 Jul 2026 12:53:44 +0200
Message-ID: <20260716105344.263649-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,suse.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 TAGGED_RCPT(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] submodules: Move from git:// to https://
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

git:// protocol is insecure and unreliable. LTP package build times to
times fails:

    $ git clone git://git.kernel.org/pub/scm/devel/sparse/sparse.git
    fatal: unable to connect to git.kernel.org:

Use https:// for all submodules (change for sparse and mce-test).

Reported-by: Petr Cervinka <pcervinka@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .gitmodules | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitmodules b/.gitmodules
index a1ac4b1b87..3f36667a3a 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -1,9 +1,9 @@
 [submodule "testcases/kernel/mce-test"]
 	path = testcases/kernel/mce-test
-	url = git://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/mce-test.git
+	url = https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/mce-test.git
 [submodule "tools/sparse/sparse-src"]
 	path = tools/sparse/sparse-src
-	url = git://git.kernel.org/pub/scm/devel/sparse/sparse.git
+	url = https://git.kernel.org/pub/scm/devel/sparse/sparse.git
 [submodule "tools/ltx/ltx-src"]
 	path = tools/ltx/ltx-src
 	url = https://github.com/linux-test-project/ltx.git
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
