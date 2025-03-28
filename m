Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2158C28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 11:43:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE7713CA3BF
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 12:43:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0E3F3CA273
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 12:43:20 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D657710001B6
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 12:43:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD1E32118E;
 Fri, 28 Mar 2025 11:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743162199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ewLSL/l52bF8eu3nCrXFru7bjBnoiIIsKKB5Pzlg4pw=;
 b=nRSViTrTRL4rt5xDVaIzRsIikXu3tO0CptWQhnYvP5yAsA5nxSUXjSLr7Euark0UjiMNFO
 9Cwx+zb4ZxEEZqcjl5EMqPIhi4ipNYTNqVqnd/y05dLImmeZNIUAr9BMGUA9eH7yxGYRAp
 /w0xyQ1Qq59DZvLhseNSYfYINgyZ0Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743162199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ewLSL/l52bF8eu3nCrXFru7bjBnoiIIsKKB5Pzlg4pw=;
 b=TUioEw5By00dI+p4HrFooZ/G0WWZVtmaXrL2/S+ibxV+BsMt+6+vjaB5P8YymktOBD/ozW
 nnVdM7s7rXzAF1Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mJLCeZMv;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SHNU5EOV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743162198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ewLSL/l52bF8eu3nCrXFru7bjBnoiIIsKKB5Pzlg4pw=;
 b=mJLCeZMvW+/g8Qn5jEXNS+NLvzcX68MYfGAAYF3z2PAeCWMVgfu5hlUlZaM+TZRqAo14ab
 IhZkLOwQ3E9gYU0h6cAPhxUs10nBukl2UphjtoNpFTxhCSpZB1+xKMZmJRCV68CjyPWRUc
 6yhWVO0nqQ8Qtrk/cyPyrCOoNDS7idk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743162198;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ewLSL/l52bF8eu3nCrXFru7bjBnoiIIsKKB5Pzlg4pw=;
 b=SHNU5EOVnwZ24vTC+G5w0bvrNMBMCHjcJY7mGSv/RBZhU37PCbQOcaLBUDEiWA8IExHlPc
 R6AxbpHT3fxGxCAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B274113A5B;
 Fri, 28 Mar 2025 11:43:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id V0Q/KlaL5mdqQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Mar 2025 11:43:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Mar 2025 12:43:09 +0100
Message-ID: <20250328114311.187541-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: DD1E32118E
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 0/2] Add safe_get_nodemap()
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

not a huge improvement, but because all tst_get_nodemap() are in the
setup (and only ksm06.c allows input parameter) we could have struct
tst_test member which would call safe_get_nodemap().

e.g.:

.nodemap = (const struct tst_path_val) {
		.type = TST_NUMA_MEM
		.required = 2,
},

safe_get_nodemap(tst_test->nodemap->type,
	tst_test->nodemap->required * getpagesize() / 1024);

This would not work for non - page sized nodes, e.g.:
nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * PAGES_ALLOCATED * page_size / 1024);

=> extra member would need to be added:

.nodemap = (const struct tst_path_val) {
		.type = TST_NUMA_MEM
		.required = 2,
		.size = PAGES_ALLOCATED, // default == 1
},

would call:

safe_get_nodemap(tst_test->nodemap->type,
	tst_test->nodemap->required * tst_test->nodemap->size * getpagesize() / 1024,
	tst_test->nodemap->required);

Petr Vorel (2):
  libs: Add safe_get_nodemap()
  Use safe_get_nodemap()

 include/tst_numa.h                            | 41 ++++++++++++++++++-
 libs/numa/tst_numa.c                          | 14 +++++++
 testcases/kernel/mem/ksm/ksm06.c              |  4 +-
 .../syscalls/get_mempolicy/get_mempolicy01.c  |  4 +-
 .../syscalls/get_mempolicy/get_mempolicy02.c  |  4 +-
 testcases/kernel/syscalls/mbind/mbind02.c     |  4 +-
 testcases/kernel/syscalls/mbind/mbind03.c     |  4 +-
 testcases/kernel/syscalls/mbind/mbind04.c     |  4 +-
 .../syscalls/set_mempolicy/set_mempolicy01.c  |  4 +-
 .../syscalls/set_mempolicy/set_mempolicy02.c  |  4 +-
 .../syscalls/set_mempolicy/set_mempolicy03.c  |  4 +-
 .../syscalls/set_mempolicy/set_mempolicy04.c  |  4 +-
 12 files changed, 63 insertions(+), 32 deletions(-)

-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
