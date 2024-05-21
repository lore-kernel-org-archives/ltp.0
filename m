Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D639C25B75
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 07:50:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C28B3CFF77
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 09:50:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DCAA3C02C0
 for <ltp@lists.linux.it>; Tue, 21 May 2024 09:50:03 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7F24C1A00990
 for <ltp@lists.linux.it>; Tue, 21 May 2024 09:50:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4FFDD345B4;
 Tue, 21 May 2024 07:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716277800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WdVABYmQE/KINUzzaWEyH92v7Gj9Lrj6wisRGqacmF4=;
 b=D8xjADsxRQg6a6MLJqjeNctvGwiU1BatIJsJ+5DjfEhKjg94jumPYRATtn1W5aQdrtLxTe
 kFE+3jxeO0NEftiawP7cjzuITzdmvpWxjUmN2sABYmHJUtwtTgNy+dp+xuidZmJccIXebi
 zU5FcKRh06OIz8h6qWrtMjtwBVesBLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716277800;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WdVABYmQE/KINUzzaWEyH92v7Gj9Lrj6wisRGqacmF4=;
 b=op0vG79OG5atD/ZiCi+2fktkSSa5n0DN8Z1NoL/UjoycPis/OeJHE1vU9LVWQ0ncuowTi1
 3WHL3XnScjsyPJAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716277800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WdVABYmQE/KINUzzaWEyH92v7Gj9Lrj6wisRGqacmF4=;
 b=D8xjADsxRQg6a6MLJqjeNctvGwiU1BatIJsJ+5DjfEhKjg94jumPYRATtn1W5aQdrtLxTe
 kFE+3jxeO0NEftiawP7cjzuITzdmvpWxjUmN2sABYmHJUtwtTgNy+dp+xuidZmJccIXebi
 zU5FcKRh06OIz8h6qWrtMjtwBVesBLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716277800;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WdVABYmQE/KINUzzaWEyH92v7Gj9Lrj6wisRGqacmF4=;
 b=op0vG79OG5atD/ZiCi+2fktkSSa5n0DN8Z1NoL/UjoycPis/OeJHE1vU9LVWQ0ncuowTi1
 3WHL3XnScjsyPJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C51413A21;
 Tue, 21 May 2024 07:50:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9SLeBShSTGYMFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 May 2024 07:50:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 May 2024 09:49:52 +0200
Message-ID: <20240521074955.78675-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.57 / 50.00]; BAYES_HAM(-2.77)[99.01%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] libswap: Fix SLE12-SP5 + cleanup
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

Hi,

Changes v1->v2:
* Don't swap 5.19 and 6.2 conditions (Cyril)
* Separate whitelist changes to "libswap: Split long lines
  (readability)"
* Add new commit "libswap: Remove function description"

@Cyril any change I could rebase and merge this patch (Li acked)

* libs: Remove 'libltp' prefix from libs source directories
https://patchwork.ozlabs.org/project/ltp/patch/20240419110230.191809-1-pvorel@suse.cz/

Petr Vorel (3):
  libswap: Split long lines (readability)
  libswap: Fix tst_max_swapfiles() for SLE12-SP5
  libswap: Remove function description

 libs/libltpswap/libswap.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
