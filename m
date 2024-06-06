Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A405CC27C54
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 17:24:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D7983D0A90
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 19:24:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4E543CBAFA
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 19:24:07 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DEECB1432361
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 19:24:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AF6A01FB47;
 Thu,  6 Jun 2024 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717694645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UpMiqJO8iPKd4Y+P9wQDGjKCAhuhSHnCOn6VBNN+2TI=;
 b=d1FdtFnXAfvWs2XzkAcBGRmEIXRS26+IwAAXqf5nocDRkLDslbIkAnfsbbF0ai66FuQfh9
 6j5e8a3IAvpmJPLYEfFmQjC7NEwY3A9njwxW7bvFnN+9KoBtLvn1rqepD2z7t2wNqkU6vp
 Z+Zyo1mAG52y+VOBuszenfNnwgeZ6EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717694645;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UpMiqJO8iPKd4Y+P9wQDGjKCAhuhSHnCOn6VBNN+2TI=;
 b=0hRJCTSj3QSQ0Jh2yCZiB3o7QrBpHJvQ9UKlNkJ9Ym1gki5LCuhRwiqKfZoEx8eG6wc0Gs
 3RFD3Pr5t7Ln3RDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717694645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UpMiqJO8iPKd4Y+P9wQDGjKCAhuhSHnCOn6VBNN+2TI=;
 b=d1FdtFnXAfvWs2XzkAcBGRmEIXRS26+IwAAXqf5nocDRkLDslbIkAnfsbbF0ai66FuQfh9
 6j5e8a3IAvpmJPLYEfFmQjC7NEwY3A9njwxW7bvFnN+9KoBtLvn1rqepD2z7t2wNqkU6vp
 Z+Zyo1mAG52y+VOBuszenfNnwgeZ6EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717694645;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UpMiqJO8iPKd4Y+P9wQDGjKCAhuhSHnCOn6VBNN+2TI=;
 b=0hRJCTSj3QSQ0Jh2yCZiB3o7QrBpHJvQ9UKlNkJ9Ym1gki5LCuhRwiqKfZoEx8eG6wc0Gs
 3RFD3Pr5t7Ln3RDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 993DF13A79;
 Thu,  6 Jun 2024 17:24:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RFQVJLXwYWaNFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 06 Jun 2024 17:24:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 06 Jun 2024 19:23:37 +0200
Message-Id: <20240606-unlink09-v3-0-37cc612ce0fd@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJnwYWYC/22MwQ6CMBAFf4Xs2Zp2ASmc/A/jgbZbadRiWmk0h
 H+3cOLgcV7ezAyRgqMIXTFDoOSiG32G8lCAHnp/I+ZMZkCOFT/xik3+4fydt8zoSnK0skHbQr6
 /Aln32VKXa+bBxfcYvls5iXX9E0mCCWaskVSS0ArVOU6Rjnp8wtpIuPfqnYeMM2V7rpTRsqnLn
 bcsyw+de15d1wAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=zgj4QGXKKX+M12Mx8pea0x8C9/JfAWCbO18+VY7uTbg=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmYfCcGKTrbYgiJQ4ZaM80z+EqscRT+BTC/abOo
 rYRjzoZYpWJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZmHwnAAKCRDLzBqyILPm
 RgC/DACnQOu0UOwji1WHmmQLlT00oV79KqovNHOTMv0hT0CcSZgVmZhdzOk9lIJVQsVA11XTLAb
 DEN1cSa0DbwKsXQPp0S6WAnaDxHJOWUBIlOJrh0xscdRiTyhlwjLesnjXG+MyZ+vEItyUyhrOFa
 U8OUB19bn16a8wm9HHfT9fDW5xBqrQMH9gZGO6j6UEIchuvvWr2lECevS0gGTupbUivmhA9JhL4
 2xzhTlzY0jA7rKJ2accULbl6q4u+HO35ShWGrfMfsu0DtB+FAiLuu2abb5KD9W6eETy/rbIi+9W
 E33Cmq6TPSoqXg+OjVvWmK6o1HJtjgXKcHRjNAFSmMaUbboeH1rpmOZIVRza7uNq/4T2J8JSCKo
 Bp+mSzXKREJGF+W10i83b53rkQPJgC9dlX94Rw412Y+vQfDKvMRA72mj3kFavuGM3a2OHl3bZ0r
 G9rbbOgcZ7ISDVvqR3uo3p12Y1qevpkKJdArsCY+ScrnzJU5kcUHYNQygbfg/VgPCZiCA=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Fix unlink09 test
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

This will fix the 2cf78f47a6 and resolve issues on filesystems
which are not supporting inode attributes. Split unlink09 read-only
check and move it into unlink10.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- added .mount_device = 1
- added .skip_filesystems (vfat and ntfs)
- skip test execution when the tmpfs is used on kernel<6.0
- Link to v2: https://lore.kernel.org/r/20240605-unlink09-v2-0-bfa0bbdc8753@suse.com

Changes in v2:
- moved read-only FS check out of unlink09 and created unlink10
- check when FS doesn't support inode attributes and print a TBROK
- simplified inode attributes setup by adding a common function
- added .all_filesystems support
- Link to v1: https://lore.kernel.org/r/20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com

---
Andrea Cervesato (2):
      Fix unlink09 test
      Add unlink10 test

 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/unlink/.gitignore |   1 +
 testcases/kernel/syscalls/unlink/unlink09.c | 106 ++++++++++++++++------------
 testcases/kernel/syscalls/unlink/unlink10.c |  33 +++++++++
 4 files changed, 97 insertions(+), 44 deletions(-)
---
base-commit: 66517b89141fc455ed807f3b95e5260dcf9fb90f
change-id: 20240604-unlink09-dc4802f872f9

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
