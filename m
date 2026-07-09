Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9160BC43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 13:02:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 207E13E5C64
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 15:02:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 630C13E5C62
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:01:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A8E136009FD
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:01:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF2FA761EF;
 Thu,  9 Jul 2026 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783602107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v2TaFvI49LZgAVVaTz28r8i0u5k5Hw/QXZKd2MAS0eM=;
 b=0PKBwB++X7j8XQPa1TmrQOQOCLaSTlAi6VEJ7ykaQp7BALvTtnWZfBcIJ6Uozj85wFxt9K
 RV160YHjAsVOWVhpnDGR0ZG8ycraXX+UFTLNZNbl9IS4920iYX3ROOj3nhO2axN3hukgxL
 OK76Vio3DCTTN+ShRaLjfPYZSaaH4wE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783602107;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v2TaFvI49LZgAVVaTz28r8i0u5k5Hw/QXZKd2MAS0eM=;
 b=Bkr0t4DPdSI1oiOGmXtVroAdCTTPXnza/UpKtcIzD5PNG/ycorRkJj534VUYJkpTP6GcUR
 F/0dgSFwkRQMrDDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="mzsFB/gH";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HUIN3wx7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783602105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v2TaFvI49LZgAVVaTz28r8i0u5k5Hw/QXZKd2MAS0eM=;
 b=mzsFB/gHFlYyksl8Hd06PWbKALxPnKyhSBkq+q+vUGjnQtCIWb9FG95rlrswXpx1Kapgsy
 xtgzl8fYyue6hemR4XaANNEmSNAHxBjcEQt8RQ7pS8u6GKV3seNNsMmf9j1Vr715OCa++p
 kwHxl1yxUGK78eFp9GWGLRQ0j2Ppz1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783602105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v2TaFvI49LZgAVVaTz28r8i0u5k5Hw/QXZKd2MAS0eM=;
 b=HUIN3wx7xyczPn6zoQdwfpXoFM5kVbLzyrGG41/O21th7C8GKLA6birXukQo9abZRuG3GH
 RRLBPTgLxWal8FAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FC70779AA;
 Thu,  9 Jul 2026 13:01:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6GcrELmbT2rtFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jul 2026 13:01:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Jul 2026 15:01:32 +0200
Message-ID: <20260709130135.927868-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DF2FA761EF
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] CI: Run metadata tests
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

trivial patchset to run metadata tests in the CI.

Petr Vorel (3):
  build.sh: Add support for test-metadata
  ci: Test metadata in docker build testing
  metadata: test.sh: Print the test name and result

 .github/workflows/ci-docker-build.yml | 5 +++++
 build.sh                              | 5 +++--
 metadata/tests/test.sh                | 6 ++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
