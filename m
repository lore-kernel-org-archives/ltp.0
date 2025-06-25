Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A618C7EE30
	for <ltp@archiver.kernel.org>; Wed, 25 Jun 2025 09:08:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D54E83CCB2F
	for <ltp@archiver.kernel.org>; Wed, 25 Jun 2025 11:08:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6C043CCB10
 for <ltp@lists.linux.it>; Wed, 25 Jun 2025 11:08:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DB5D060090C
 for <ltp@lists.linux.it>; Wed, 25 Jun 2025 11:08:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 31C631F441
 for <ltp@lists.linux.it>; Wed, 25 Jun 2025 09:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750842479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WY5+vxEpAFRkpM3pumaNB2zWwRLTc8tJOiN6TqSRixY=;
 b=x4iedyyf22Vy/l0iQqWd7rTmZDaPItsm0qV13vkmZjvDHyaO3ciPKL1Xjgy26vKFYWNu2Q
 GwTSlthavjIwsNqv4OK7f18NfsAkbbs9KWe3BIvGgChshQ1GqmEj6qaqbcoEeVpIRBj8tQ
 16aEwyzHCRpxxpaLpV4lXMWpyoybxWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750842479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WY5+vxEpAFRkpM3pumaNB2zWwRLTc8tJOiN6TqSRixY=;
 b=CBogHKZE0Rf+3L5i6npw6ae7CAto4UKyKVwBjgDK4/7SafKB7+CGiH3uaerrClpwk0LU9+
 Fjwkm1MFwAcmggDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ga6hkawf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EKhkdToT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750842478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WY5+vxEpAFRkpM3pumaNB2zWwRLTc8tJOiN6TqSRixY=;
 b=Ga6hkawfSU1eVWunRzhuLxlO7DYabbMFaoH6IGIzz0TVlqYte3shIimHD/2Dx6BLOUORtL
 m7hkIUwBLB9uHgh4Mfv4HUDinUtwA+See4dW8yuARnb3zF65X4xij5Qe1Z9ANquihi0ekY
 9/Tyq2isbcHFJI2auF7BEnMlskNX0Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750842478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WY5+vxEpAFRkpM3pumaNB2zWwRLTc8tJOiN6TqSRixY=;
 b=EKhkdToT9qu31e5J1r8WUldJ3lpRIT+CLWqbT9Oh6Wb6b22ILdtHchCaRc34cg1l+P/avv
 uKVN2i73r5/RZhAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23DD013485
 for <ltp@lists.linux.it>; Wed, 25 Jun 2025 09:07:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HII8Bm68W2huLAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 25 Jun 2025 09:07:58 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 25 Jun 2025 11:08:33 +0200
Message-ID: <20250625090833.2960-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 31C631F441
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:mid, suse.cz:dkim, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITED] [PATCH] doc: Fix link in testers_guide.rst
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
 doc/users/testers_guide.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/users/testers_guide.rst b/doc/users/testers_guide.rst
index 82ce907a2..9c1ddb988 100644
--- a/doc/users/testers_guide.rst
+++ b/doc/users/testers_guide.rst
@@ -89,7 +89,7 @@ a few interesting ones and run them for some time in order to get an idea of
 their usefulness. If you are feeling adventurous you may try to measure and
 compare actual test coverage with one of the tools such as `gcov
 <https://www.kernel.org/doc/html/latest/dev-tools/gcov.html>`_ and `lcov
-<https://github.com/linux-test-project/lcov>`. If you do so do not fall into a
+<https://github.com/linux-test-project/lcov>`_. If you do so do not fall into a
 trap of attempting to have 100% line coverage. Having 100% of lines executed
 during the test does not mean that your test coverage is 100%.  Good tests
 validate much more than just how much code from the tested binary was executed.
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
