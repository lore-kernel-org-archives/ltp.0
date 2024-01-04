Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149BDC47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 20:47:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FC303CE740
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:47:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EB8E3CBDB0
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 21:46:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 06EEB601148
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 21:46:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF0611F82F;
 Thu,  4 Jan 2024 20:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704401181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wj2qBR7x8s1D5oV2faaSpYslhFKGwH2VVH/yTxHFoEg=;
 b=FC4ufamaQuWuG5mgT1Nbz+ocltmmHTmrmwDl22o/SWLdanC975+NcvYTcS/9WnDTCLcEU4
 9qPxpVMhA6TWkkSpAKtZKbYtlp2pXnfByiGUsCRf5J52y28BW0YT6Suw31gcSG2AVrcEwj
 SCutHNvfGlR68m0Q92DSb48a9bJ2nZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704401181;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wj2qBR7x8s1D5oV2faaSpYslhFKGwH2VVH/yTxHFoEg=;
 b=/pB/dUWcHimaB8u8Tlp73lkJ0jIn30TpuJVSLbvcKm1OWrdU79v+04IPqrHt+aafvnfvki
 8ORWkSecHVVNfZCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704401180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wj2qBR7x8s1D5oV2faaSpYslhFKGwH2VVH/yTxHFoEg=;
 b=XuiYB1/TVnljFVwECXX6DDMpo13zo126T8T3BmGJdCsr4JBehm3hYBq51WLUNKWgB9RXt5
 kNVWSniWVNFFPVyEKKHIf5VxusVMiSlDwF9VK6xQRIKmvZ0y1Hq/sYos2JWYW82ilHmygO
 HeV9zUjzyhwGLXmJSeZ3ehwqKg6N2a8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704401180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wj2qBR7x8s1D5oV2faaSpYslhFKGwH2VVH/yTxHFoEg=;
 b=6nnfjphJX6oDWsZmCPHYl2NlPEpYUZRg2Miq36YbT94xGxxs4/y0ABeDr651D7H06mD6Dz
 ncC2rTUYE2prnABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAA8D137E8;
 Thu,  4 Jan 2024 20:46:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YfLzLxwZl2WsIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 20:46:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 21:46:05 +0100
Message-ID: <20240104204614.1426027-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="XuiYB1/T";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6nnfjphJ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:dkim]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: EF0611F82F
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/9] metadata: improvements
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

Hi all,

there are 3 parts:

1) The main motivation is to avoid having to fix docs manually,
implemented in commit "metaparse: Add missing blank line on the list".

2) Add CI job for generating metadata, to catch the problem early
(we test metadata in docker/podman CI jobs, but error there is quite
hidden. Having special job (which is quick) will show the problem
immediately.

3) Minor verbose output improvements.

Kind regards,
Petr

Petr Vorel (9):
  metaparse: Print parsing file on verbose
  metadata: parse.sh: Allow to pass list of files
  metadata: parse.sh: Pass -v to metaparse on VERBOSE=1
  metadata: test.sh: Print more info on VERBOSE=1
  metaparse: Verbose output on V=1
  metaparse: Add missing blank line on the list
  metadata: Add test for missing blank line in list
  ci/debian: Allow to install packages only for docparse
  ci: Add job for building metadata

 .github/workflows/metadata.yml                | 58 +++++++++++++++++++
 ci/debian.sh                                  | 17 +++++-
 metadata/Makefile                             |  4 +-
 metadata/data_storage.h                       | 36 +++++++++++-
 metadata/metaparse.c                          |  3 +
 metadata/parse.sh                             | 13 ++++-
 metadata/tests/list_missing_blank_line.c      | 14 +++++
 metadata/tests/list_missing_blank_line.c.json | 18 ++++++
 metadata/tests/test.sh                        |  2 +
 9 files changed, 159 insertions(+), 6 deletions(-)
 create mode 100644 .github/workflows/metadata.yml
 create mode 100644 metadata/tests/list_missing_blank_line.c
 create mode 100644 metadata/tests/list_missing_blank_line.c.json

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
