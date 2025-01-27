Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2109C02188
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 14:11:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6750C3C2C45
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 15:11:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E59893C2C9C
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 15:08:36 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5FB481021197
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 15:08:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E21C210F7
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737986908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YZ8tVuBWvZFGeZC38xcrOeLgioUtCIoEFgRE6quBpkc=;
 b=PxiuhYEWOcuR1+ric/eE/84+pKPydl9qQsoICbiNOSuITUGVTD0aq1Ytv735q5yA33beAB
 dW//TPa9KdMfDLvk9mttcMaYbzKmK1XOtMdw2Md8gMFmw3V/YrQBMh4EMw1t2wZIte2DPA
 J3E/zD0PWjTIWzDXhTLkhEryxSVcstM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737986908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YZ8tVuBWvZFGeZC38xcrOeLgioUtCIoEFgRE6quBpkc=;
 b=/AZcLtZW7xY+/sGb3djhLK1d33KnFsll4mOuEGWIhKEFhZDpEpoaFc07kVdYGFbgqIQUz4
 hCt39WXbgCtBOXCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737986907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YZ8tVuBWvZFGeZC38xcrOeLgioUtCIoEFgRE6quBpkc=;
 b=A14kdR1uDXujZP5nBK/2ynY6GeU7OdiuAwwXLXhMGLPTtNs7U3EBPY48tutKBeRRXet0mM
 fk2Ut4OcSqBXnnzVJfUiSrDHBMlGb3pqNeuZyc6kaWjV771BgD5iqE7meGjTVKLmJOpJJO
 ebIqiUmmeqd7obzA2bo+/au8r+CBTbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737986907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YZ8tVuBWvZFGeZC38xcrOeLgioUtCIoEFgRE6quBpkc=;
 b=8EXHdF8iuOfqzhTJhuNLi6KjZtsn4qCN4BSf/bN3LGKznmJnFOMT8rLu6qF0EMXdKL073j
 /zCsLm1ZLU97pmBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4ADD7137C0
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SZ1WEFqTl2dfZQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 27 Jan 2025 15:08:18 +0100
Message-Id: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFKTl2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyND3YrEkpKixBJdwyRDM1Pj5OTURGNDJaDqgqLUtMwKsEnRsbW1AP1
 bCf9ZAAAA
X-Change-ID: 20250121-xattrat-1b1653ccea31
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737986906; l=2591;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=xQ5y8FObU0JKM0OeYHU6apMt87WDa/zckybejMFFhws=;
 b=Vy7/Kt2bptpNfEW90KjiKvopBFm502czWkOoaVKAmkQrCKV7ViUzhQ/BUiM1rMg5WmkS4vp0e
 9kaTiTgYh2gCm7j7Sjwc143ThpkXjZ/Rnqok1BdxV43xLqEt+BGfYgR
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, configure.ac:url,
 suse.com:mid, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/8] setxattrat coverage
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

This is a patch-set meant to cover setxattrat() syscalls scenarios.
There are two parts:

- cover errors and features which are already tested for setxattr()
  by adding a new setxattrat() test variant to setxattr() testing
  suite

- cover errors which are strictly related to the setxattrat() syscall

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (8):
      syscalls: add *xattrat syscalls
      lapi: add struct xattr_args fallback
      setxattr01: add setxattrat variant
      setxattr02: add setxattrat variant
      setxattr03: add setxattrat variant
      lapi: add safe *xattrat macros
      Add setxattrat01 test
      Add setxattrat02 test

 configure.ac                                       |   1 +
 include/lapi/syscalls/arc.in                       |   4 +
 include/lapi/syscalls/arm.in                       |   4 +
 include/lapi/syscalls/arm64.in                     |   4 +
 include/lapi/syscalls/i386.in                      |   4 +
 include/lapi/syscalls/loongarch64.in               |   4 +
 include/lapi/syscalls/mips64.in                    |   4 +
 include/lapi/syscalls/mips64n32.in                 |   4 +
 include/lapi/syscalls/mipso32.in                   |   4 +
 include/lapi/syscalls/parisc.in                    |   4 +
 include/lapi/syscalls/powerpc.in                   |   4 +
 include/lapi/syscalls/powerpc64.in                 |   4 +
 include/lapi/syscalls/s390.in                      |   4 +
 include/lapi/syscalls/s390x.in                     |   4 +
 include/lapi/syscalls/sh.in                        |   4 +
 include/lapi/syscalls/sparc.in                     |   4 +
 include/lapi/syscalls/sparc64.in                   |   4 +
 include/lapi/syscalls/x86_64.in                    |   4 +
 include/lapi/xattr.h                               | 117 ++++++++++++++++
 testcases/kernel/syscalls/setxattr/setxattr01.c    |  53 ++++++--
 testcases/kernel/syscalls/setxattr/setxattr02.c    |  71 ++++++++--
 testcases/kernel/syscalls/setxattr/setxattr03.c    |  25 +++-
 testcases/kernel/syscalls/setxattrat/.gitignore    |   2 +
 testcases/kernel/syscalls/setxattrat/Makefile      |   8 ++
 .../kernel/syscalls/setxattrat/setxattrat01.c      | 151 +++++++++++++++++++++
 .../kernel/syscalls/setxattrat/setxattrat02.c      | 126 +++++++++++++++++
 26 files changed, 597 insertions(+), 25 deletions(-)
---
base-commit: de17245aa04e4cdfacc9f84893ba78a1f029cc2a
change-id: 20250121-xattrat-1b1653ccea31

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
