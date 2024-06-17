Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD12C2BA15
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 16:23:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A2353D0D36
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 18:23:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D63F3CB74E
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 18:23:06 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=jack@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C9A6A1A01551
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 18:23:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 47ED338428;
 Mon, 17 Jun 2024 16:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718641384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oggDJYBSo2qeDPzt/0sibyAU5pgNAJGwFip45qgq4Ss=;
 b=R5FNxQgvSpYUeYM1xh9xHapg1hXiKpgdwDXOcsvyzB17S8NEcN5dXyPuNDmpkY6lupHMCV
 hCxlRMNovSgUZ9hb8/vfD4uWvyGPVT93jV7z2q2IePd7a18MYF+Z946eVeLR/jU1SW+xl4
 4EMLJxOVomcd2OGDZ3W29vturBqn1RI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718641384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oggDJYBSo2qeDPzt/0sibyAU5pgNAJGwFip45qgq4Ss=;
 b=lLFwNumav4uAJ5oD0zdIkoAUkAWzcYn6Y0ATEWX1vHI24NeJ28rAyhlRdirraCDDjN6wkm
 GuMZGA4I1ZItaYBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R5FNxQgv;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lLFwNuma
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718641384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oggDJYBSo2qeDPzt/0sibyAU5pgNAJGwFip45qgq4Ss=;
 b=R5FNxQgvSpYUeYM1xh9xHapg1hXiKpgdwDXOcsvyzB17S8NEcN5dXyPuNDmpkY6lupHMCV
 hCxlRMNovSgUZ9hb8/vfD4uWvyGPVT93jV7z2q2IePd7a18MYF+Z946eVeLR/jU1SW+xl4
 4EMLJxOVomcd2OGDZ3W29vturBqn1RI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718641384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oggDJYBSo2qeDPzt/0sibyAU5pgNAJGwFip45qgq4Ss=;
 b=lLFwNumav4uAJ5oD0zdIkoAUkAWzcYn6Y0ATEWX1vHI24NeJ28rAyhlRdirraCDDjN6wkm
 GuMZGA4I1ZItaYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C1B5139AB;
 Mon, 17 Jun 2024 16:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ELWnDuhicGalfAAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 17 Jun 2024 16:23:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id D4F42A0887; Mon, 17 Jun 2024 18:23:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Jun 2024 18:22:59 +0200
Message-Id: <20240617161828.6718-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=452; i=jack@suse.cz;
 h=from:subject:message-id; bh=mSsUwxmMLIw4cKaX/vpMSetNvrXIrvi3e5WnPs3vOHs=;
 b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmcGLTdpi8wel9sY4POxemAyYRLC5CkxeKmVQ43lIY
 qA6cM7GJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnBi0wAKCRCcnaoHP2RA2clHCA
 CHstESl7piamDe/izrMM9WFiyBNrm+zd9InTZBdHlCxPPk7gq/0NoGoqwG9jFlkIVto4i276lCt+SI
 s1KMnhxQAIdTzlVuMu2ZnruJ7UdBM1eXIyGHkVrAEaSOPkzmm6gwqtPhL1lIWzJFNhve/AvIFJwggA
 kRuThpfUxu17rLwxiRUmtZQqovNq3lUnKdGPuEjyKtSniDFS+N7HAxlpieGQ5LwNbu8j1/rtQRatpi
 CRCNFAi/RGt35X+FkiwqayiasIek+LeQUnHoitctI5G8ob+3KcIw/fQo/oIn1QCGH8iBNJeYfG+1mb
 g8U+cDZnzIiffHw0SpwhPLu4i8CVsS
X-Developer-Key: i=jack@suse.cz; a=openpgp;
 fpr=93C6099A142276A28BBE35D815BC833443038D8C
X-Rspamd-Queue-Id: 47ED338428
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,arm.com,suse.de,ZenIV.linux.org.uk,lists.linux.it,suse.cz];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_LAST(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2 v3] fsnotify: Generate FS_CREATE event before
 FS_OPEN
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
Cc: linux-nfs@vger.kernel.org, Jan Kara <jack@suse.cz>,
 NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org, ltp@lists.linux.it,
 Al Viro <viro@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

this is a third revision of the series Neil started making sure FS_CREATE event
is generated before FS_OPEN event even for filesystems using atomic_open.

Changes since v2:
* Don't generate FS_OPEN events for O_PATH fd opens
* Move generation of FS_OPEN event for atomic_open() into a more logical place

Previous version:
v2: https://lore.kernel.org/all/171817619547.14261.975798725161704336@noble.neil.brown.name/

								Honza

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
