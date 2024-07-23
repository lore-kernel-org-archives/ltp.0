Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6A8C3DA49
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 07:15:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C1133D1C08
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 09:15:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF18F3CC2E7
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 09:15:33 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 45DF21001572
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 09:15:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C3CCA21AEE;
 Tue, 23 Jul 2024 07:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721718931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eM6ERzCQ8P2M+f1wToYVVTQVxk36vfOXIq64dO6PTAk=;
 b=CbTT7kvZ+Jy81V0abxFyCkXKpAXbApqLvpSZojU20mlGpCDSZDcGGa+b9eP0KWUut8Zgd8
 KB1cwcY2xypyDtjcVrhXpkknvtIIveXDVQLucnCrzEKrWFww9EksHQqAJSc0wVHM3KanyZ
 GBAHZ6Bvt1/nc04qtK1tEbmUZ+8YWzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721718931;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eM6ERzCQ8P2M+f1wToYVVTQVxk36vfOXIq64dO6PTAk=;
 b=eGBnV4w1eYnp9943omkP1hD8wTvOZeqqtxHIoTtpFkVJ+iknSvwrrYPRtbwEajcJ0UDMJz
 axhgPz7SGbgJsqBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721718931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eM6ERzCQ8P2M+f1wToYVVTQVxk36vfOXIq64dO6PTAk=;
 b=CbTT7kvZ+Jy81V0abxFyCkXKpAXbApqLvpSZojU20mlGpCDSZDcGGa+b9eP0KWUut8Zgd8
 KB1cwcY2xypyDtjcVrhXpkknvtIIveXDVQLucnCrzEKrWFww9EksHQqAJSc0wVHM3KanyZ
 GBAHZ6Bvt1/nc04qtK1tEbmUZ+8YWzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721718931;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eM6ERzCQ8P2M+f1wToYVVTQVxk36vfOXIq64dO6PTAk=;
 b=eGBnV4w1eYnp9943omkP1hD8wTvOZeqqtxHIoTtpFkVJ+iknSvwrrYPRtbwEajcJ0UDMJz
 axhgPz7SGbgJsqBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 970C913874;
 Tue, 23 Jul 2024 07:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lXBHIpNYn2bKUQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 07:15:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 09:15:00 +0200
Message-Id: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHRYn2YC/13MQQrCMBCF4auUWRuZpLYlrryHFCnpxA7UpCQ1K
 CV3NxZXLv8H79sgUmCKcK42CJQ4sncl1KECMw3uToLH0qBQnbBRWrA363yzbGbvSOjGtFjbTo5
 NDeWzBLL82r1rX3riuPrw3vkkv+tPqvFPSlKgsINuLXYjWjNc4jPS0fgH9DnnD8wsCZypAAAA
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=20r4Bu1oDvHdB2xngNOrTqyOnaiQrAvInS0fXzEWpbo=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn1h6hv6qDTuJ/xTwlJy8HT1YtAgBuCvOX3qhs
 8j6pZPlGkCJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp9YegAKCRDLzBqyILPm
 Rgb6C/9PG2kuJqBZ2bLJFUAft7cgDZzAA8MNZPUa7jwmTtNC1nEwLlkKNV966jWzZlTrxlRN3jb
 /9dgw03DdQ3IJOe/r3lhOdtC7LQm26RuyjdATgi+G2QVaDdywdMIBW659W7PU99HNwhiznmyD+X
 oh9oyTPGCG6b1g9h4V6ZyfevmaNOWQ5i7bKvhcwI5RSrPW+dXSiSFNBM1/+at3cXuLlNsY0l7tn
 5yRSlVI8fAB6VaZQ97Ui7qv/NeEr9fv0fmx1dkfCowWvf7n5GBrMFo0y4R2E/sGWlxByNPgOnbr
 GPDu1Njkgdz8W+pZM01Sok1jmSNaEvE3RZTPZSwqgCtkfddJxSytfkJ1z9aCGyJ9BH8xe805UsJ
 UK1lTSlHGyEgy7H3Ht69LVNUlMD32dH7DDgGGShJ7TwPv2HJFdeIxPpgVxtri3ln7Mn1Zb1WH8t
 gzvSTj3jfqfH1emeBXNXnFO/jk91k8nJc4TZ7ALKxoI7p/ahlmCTijrBS14J1dzExjo/M=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/7] Add ioctl_ficlone testing suite
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

This testing suite is testing ioctl() FICLONE and FICLONERANGE
functionalities. In particular, file clone and error codes.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- add fallback definitions
- algorithm steps using '-'
- avoid assigning -1 to file descriptors after close()
- use SAFE_UNLINK() instead of remove()
- enable both xfs and btrs for all tests
- Link to v1: https://lore.kernel.org/r/20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com

---
Andrea Cervesato (7):
      Add fallback definitions for lapi/fs.h
      Add ioctl_ficlone01 test
      Add ioctl_ficlone02 test
      Add ioctl_ficlone03 test
      Add ioctl_ficlonerange01 test
      Add ioctl_ficlonerange02 test
      Add ioctl_ficlone04 test

 configure.ac                                       |   1 +
 include/lapi/fs.h                                  |  17 +++
 runtest/syscalls                                   |   6 +
 testcases/kernel/syscalls/ioctl/.gitignore         |   6 +
 testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c  | 122 ++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c  |  70 +++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c  | 124 ++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_ficlone04.c  | 108 ++++++++++++++
 .../kernel/syscalls/ioctl/ioctl_ficlonerange01.c   | 162 +++++++++++++++++++++
 .../kernel/syscalls/ioctl/ioctl_ficlonerange02.c   |  97 ++++++++++++
 10 files changed, 713 insertions(+)
---
base-commit: c5d95b6d34e2356bd19e6b646da06f1bce66a024
change-id: 20240529-ioctl_ficlone-95c603f71d53

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
