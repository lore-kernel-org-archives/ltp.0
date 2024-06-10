Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F48C27C5E
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 09:45:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC2033D0B47
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 11:45:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0E5C3D0729
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 11:44:40 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 638E81A02384
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 11:44:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8469D1F7BE;
 Mon, 10 Jun 2024 09:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718012678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I35ZF6yzNSemYvudZ4XSLvMOJXJpSrnuWEh65DwmNUo=;
 b=NDlKi6zVKrdjYh3K6a4rna7bGRm3hOSFvCIJDBGoFUShhgooLBnFjG1hJCw1Z2FoZmXr0Y
 HReMLSCzHVcOEHW+n1+LyEq7l2GyclPjDpV946L1oeg5fvPo6qVx0E2VWdBOVtctGfLPP5
 YBzbxuQgnX86PLFmrHS4Z1cUX8eDxvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718012678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I35ZF6yzNSemYvudZ4XSLvMOJXJpSrnuWEh65DwmNUo=;
 b=BdLtJy6Vl7QZV7aZi7EJuTnzH07TiUHoDM4AJwUnNK6o1zGtPqSnMpkfr/w0+1wvht8Rx+
 Yd1/yULZG6hrtAAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NDlKi6zV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BdLtJy6V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718012678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I35ZF6yzNSemYvudZ4XSLvMOJXJpSrnuWEh65DwmNUo=;
 b=NDlKi6zVKrdjYh3K6a4rna7bGRm3hOSFvCIJDBGoFUShhgooLBnFjG1hJCw1Z2FoZmXr0Y
 HReMLSCzHVcOEHW+n1+LyEq7l2GyclPjDpV946L1oeg5fvPo6qVx0E2VWdBOVtctGfLPP5
 YBzbxuQgnX86PLFmrHS4Z1cUX8eDxvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718012678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I35ZF6yzNSemYvudZ4XSLvMOJXJpSrnuWEh65DwmNUo=;
 b=BdLtJy6Vl7QZV7aZi7EJuTnzH07TiUHoDM4AJwUnNK6o1zGtPqSnMpkfr/w0+1wvht8Rx+
 Yd1/yULZG6hrtAAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E1EA13A7F;
 Mon, 10 Jun 2024 09:44:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id c5l/GQbLZmbpbgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 10 Jun 2024 09:44:38 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Jun 2024 11:43:59 +0200
Message-Id: <20240610-mseal-v1-0-f659b9e97efa@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAODKZmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwNz3dzi1MQc3ZS0xGRDIzNzUwNLMyWg2oKi1LTMCrA50bG1tQCustp
 eVwAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=w1R24hSjHPIhhf+ruI/+tzYTMv0xztMagmJGAz6fKFE=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmZsriph8DY1yMcuZFjyXnRVEID+0dS/bV7vWlO
 bBsOQOocLOJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZmbK4gAKCRDLzBqyILPm
 Rg1aC/48uIE/x7NNbMzxDc7M3pC6XkKTW6gkHnOgx9P/jAJCH2PAEiYmhdBJd1evhLSllzPOr5r
 g+/RAfwX4UakxMsmOI/f6exxwVnaDZrcBBy2ZZ/UNYvBRf+V3hn15SH4QKdBcrEYID8bnC/aSzQ
 eOujEAvXjEznSkXBvlcM2uzdStlNFvoXhM0QdPvjZkV3D3xjCPk+ZVjfIyJYAKaVLgK8LOkk1Bg
 vRmKTtcvozwegEXD6XSjqNgl4mu7cwa0yhNFsXYeaMeMumEkVM2c9xZr2bjuqR4JWhpxPbfUSP0
 f1ruVL2/8iU+js039PyvvatNj95ws/5DNzDKCWIkqCEkh6eNpYmtzy4tElUuu41aIPoiBEF0B+h
 U1UDkNkB2asrVxfmknzxb75BsfIKeBcmF8jPmnTGq+jwOMWoKFoH1d99q/waE38sc4ZFBrpMJ5u
 ahAwv2VLTFvQ4v3TCwoY9VEHiHZE0sZUBFahddVPM70ecoAg/meShRk3MejLk6XUQSQXs=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8469D1F7BE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Add mseal() testing suite
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

Smoke test for mseal() syscall added in the kernel 6.10. All information
can be found at the following link:

https://docs.kernel.org/userspace-api/mseal.html

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (2):
      Add mseal() syscall declaration
      Add mseal01 test

 include/lapi/syscalls/aarch64.in           |   1 +
 include/lapi/syscalls/arc.in               |   1 +
 include/lapi/syscalls/arm.in               |   1 +
 include/lapi/syscalls/hppa.in              |   1 +
 include/lapi/syscalls/i386.in              |   1 +
 include/lapi/syscalls/ia64.in              |   1 +
 include/lapi/syscalls/loongarch.in         |   1 +
 include/lapi/syscalls/mips_n32.in          |   1 +
 include/lapi/syscalls/mips_n64.in          |   1 +
 include/lapi/syscalls/mips_o32.in          |   1 +
 include/lapi/syscalls/powerpc.in           |   1 +
 include/lapi/syscalls/powerpc64.in         |   1 +
 include/lapi/syscalls/s390.in              |   1 +
 include/lapi/syscalls/s390x.in             |   1 +
 include/lapi/syscalls/sh.in                |   1 +
 include/lapi/syscalls/sparc.in             |   1 +
 include/lapi/syscalls/sparc64.in           |   1 +
 include/lapi/syscalls/x86_64.in            |   1 +
 testcases/kernel/syscalls/mseal/.gitignore |   1 +
 testcases/kernel/syscalls/mseal/Makefile   |   7 ++
 testcases/kernel/syscalls/mseal/mseal01.c  | 177 +++++++++++++++++++++++++++++
 21 files changed, 203 insertions(+)
---
base-commit: 66517b89141fc455ed807f3b95e5260dcf9fb90f
change-id: 20240607-mseal-dfac12675096

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
