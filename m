Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7975BC02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 12:48:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D236F3C93A4
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 13:48:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2454E3C1BCB
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 13:48:41 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0EE6A1410AE4
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 13:48:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3D7342116A;
 Fri,  7 Feb 2025 12:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738932519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2QUMe05k/B8EM/sb92FF2WWTywBBSzLpxO0URbRU+KQ=;
 b=FvtoL9Nrn7mtCT2EC6hE5d4J9svr/y21byNdo6a6mvv0dkWzSmQoZdlX1u9Af0WiGNhmls
 df/j2BZ8+0L3S4pWdCi7NzZkD8jqKsQuiJa6SHXRZjtMinYz5NL/mCL1idOxvH9DeC2Z1X
 Ekf7DNyTNu0Ou4BboKTq6URn4ssWAPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738932519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2QUMe05k/B8EM/sb92FF2WWTywBBSzLpxO0URbRU+KQ=;
 b=c3qKLAf3dg+IghhKE4Kg3C2iuAvPV9277au1jn6DvlJkdm98z1NkPugwKwqsGfsiDgW3yF
 f/Wh9dkKOJ3y5/Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738932518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2QUMe05k/B8EM/sb92FF2WWTywBBSzLpxO0URbRU+KQ=;
 b=JKcOAeeyBiFIkLjFyG64JWoiyWz/vjdOl8+TwnDJy5il6u+3iV400aZj9PdHiWFbs6WvbY
 46PX8cM6tSFyncZfZhF98AekKJS+g0L3MyOnWWXn6fE/5acZLE1IJccOqDttO3A578jLWo
 ei1Fns7XQ5vP7rrdzMwmeeMwZvwl2Sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738932518;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2QUMe05k/B8EM/sb92FF2WWTywBBSzLpxO0URbRU+KQ=;
 b=hPBwp8D4OVajV9+ywLuODn/6CfKThxqOFrHWrLhE1n07+1cfpV0uVS+Ns6bGeA+aWEFJMl
 RA3tGtQ8rfKdgfAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B27F1139CB;
 Fri,  7 Feb 2025 12:48:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pZNEKiUBpmfkHAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Feb 2025 12:48:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Feb 2025 13:48:30 +0100
Message-ID: <20250207124830.1765318-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc/documentation: Add tip for debugging
 .readthedocs.yml
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/developers/documentation.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/doc/developers/documentation.rst b/doc/developers/documentation.rst
index 27c847e125..2308010006 100644
--- a/doc/developers/documentation.rst
+++ b/doc/developers/documentation.rst
@@ -18,9 +18,9 @@ Before building, make sure you have python3 ``virtualenv`` module installed.
     # run configure to be able to compile doc dependencies in metadata/
     make autotools
     ./configure
-    cd doc
 
     # prepare virtual environment
+    cd doc
     python3 -m virtualenv .venv
     . .venv/bin/activate
 
@@ -39,6 +39,14 @@ Once the procedure has been completed, documentation will be visible at
     older Python versions were causing issues. No other version has been tested,
     but it should work anyway.
 
+.. tip::
+
+    For debugging :master:`.readthedocs.yml` (can't be debugged locally) it's
+    the least intrusive to set in `ReadTheDoc settings
+    <https://app.readthedocs.org/dashboard/linux-test-project/edit/>`_
+    different *default branch*. This allows to use ``git push -f`` without
+    polluting master branch.
+
 Validating spelling
 ~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
