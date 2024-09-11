Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A43EE57C2
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 16:36:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7EB63C1DAC
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 18:36:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F9E23C1D31
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 18:34:57 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 67662601FC1
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 18:34:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7EDDB21A7C
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726072495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h/tYbFjtWRzLTo07d/ZogzDzwi+INhMNeTVBw/FWJ8M=;
 b=jsqkQVB5dmSUrJ4/jj/2rtNdf2M6FBYg93vM9GqPe1hoifRR0AqbDhUCZbZhwEghC4tg+D
 41EeeS87PzjNEFrQx8X9m0iLKkT3UdQ2fPX9khTh3c2etpLgCx/J/N6gmJtkaAolE91boH
 CQGqAlXCoEadyw/XSo+hbDhqIgqqMJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726072495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h/tYbFjtWRzLTo07d/ZogzDzwi+INhMNeTVBw/FWJ8M=;
 b=PoZoD93ZIyeiFwQ02GVuImERKkN/oY0JDDXudNNiKABz3+xhH4bSpdwe9doNd1vZgLvBcH
 yD7bj4kAIG5pxSCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726072495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h/tYbFjtWRzLTo07d/ZogzDzwi+INhMNeTVBw/FWJ8M=;
 b=jsqkQVB5dmSUrJ4/jj/2rtNdf2M6FBYg93vM9GqPe1hoifRR0AqbDhUCZbZhwEghC4tg+D
 41EeeS87PzjNEFrQx8X9m0iLKkT3UdQ2fPX9khTh3c2etpLgCx/J/N6gmJtkaAolE91boH
 CQGqAlXCoEadyw/XSo+hbDhqIgqqMJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726072495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=h/tYbFjtWRzLTo07d/ZogzDzwi+INhMNeTVBw/FWJ8M=;
 b=PoZoD93ZIyeiFwQ02GVuImERKkN/oY0JDDXudNNiKABz3+xhH4bSpdwe9doNd1vZgLvBcH
 yD7bj4kAIG5pxSCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C08F13A7C
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u+UdGq/G4WZcBQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:34:55 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 11 Sep 2024 18:34:34 +0200
Message-ID: <20240911163443.95398-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] Enable .all_filesystems in readdir() and
 getdents() tests
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

The readdir() and getdents() syscalls are currently subtly broken
on bcachefs. However, this was missed until recently because
the respective syscall tests do not test multiple filesystems.
Enable .all_filesystems in readdir() and getdents() tests to increase
coverage.

Martin Doucha (5):
  readdir01: Enable .all_filesystems
  readdir21: Enable .all_filesystems
  getdents01: Enable .all_filesystems
  getdents02: Remove obsolete TCID
  getdents02: Enable .all_filesystems

 .../kernel/syscalls/getdents/getdents01.c     | 54 ++++++++++++-------
 .../kernel/syscalls/getdents/getdents02.c     | 15 +++---
 testcases/kernel/syscalls/readdir/readdir01.c | 11 ++--
 testcases/kernel/syscalls/readdir/readdir21.c | 12 +++--
 4 files changed, 61 insertions(+), 31 deletions(-)

-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
