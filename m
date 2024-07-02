Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86229C3064D
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 14:13:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F21E63D3EC2
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 16:13:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54B923D0F6E
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 16:13:16 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5DFEB1000A56
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 16:13:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6130D1FBAA;
 Tue,  2 Jul 2024 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719929594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eC/V9UVB2WYtKfU1KgXZKjDtOASyyFIDVTwK7ASjnPI=;
 b=AyANOFMC/DMtBvbnsMfFG1SSFtfRHI4ClwA+H4C+OTr2YKgoAs3bXttSPB6QkO8Um5+Vcr
 HI2I4NcVTTOO5zaCJ3J5Nwvv9cyh1lxeihOeupPCVQd19rJ7/9ofGUdlgIUZOLnL0AUyBQ
 qGname59mUcm29Gpz3Vb/9aVYX6zOjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719929594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eC/V9UVB2WYtKfU1KgXZKjDtOASyyFIDVTwK7ASjnPI=;
 b=Fms6h70tL9xJtY8jR4tnOMr3FifeOCMlRh9zjYIoEKGcXb2sYJMKpEQyzCaZffYCtBiFZa
 6m7SWnkPj1K4+vAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719929594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eC/V9UVB2WYtKfU1KgXZKjDtOASyyFIDVTwK7ASjnPI=;
 b=AyANOFMC/DMtBvbnsMfFG1SSFtfRHI4ClwA+H4C+OTr2YKgoAs3bXttSPB6QkO8Um5+Vcr
 HI2I4NcVTTOO5zaCJ3J5Nwvv9cyh1lxeihOeupPCVQd19rJ7/9ofGUdlgIUZOLnL0AUyBQ
 qGname59mUcm29Gpz3Vb/9aVYX6zOjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719929594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eC/V9UVB2WYtKfU1KgXZKjDtOASyyFIDVTwK7ASjnPI=;
 b=Fms6h70tL9xJtY8jR4tnOMr3FifeOCMlRh9zjYIoEKGcXb2sYJMKpEQyzCaZffYCtBiFZa
 6m7SWnkPj1K4+vAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 111F313A9A;
 Tue,  2 Jul 2024 14:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q7G1OfkKhGbpDgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 02 Jul 2024 14:13:13 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 02 Jul 2024 16:12:46 +0200
Message-Id: <20240702-stat04-v1-0-e27d9953210d@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN4KhGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwMj3eKSxBIDE93k1NQkU4skCwNLQwMloOKCotS0zAqwQdGxtbUAYhn
 dAFgAAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=IWXQdwaP7V0qMDQpG/mEw4/YVr721tRezRfLgjXEOKM=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmhArmyv0Fuumkn2rdqHf/a6ou9auNm+YaI0e9T
 B+yrvlsKJaJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZoQK5gAKCRDLzBqyILPm
 Rt/8C/oCHbqjVuaijQrYr/Og3RfJwmYhzVjFlDIwCr6Du7GYCAwDXgngy+2/x+O8O8C062Z1T0D
 IiGxzrCbm3Cg7SuR4VmJFriZ79PeaAHAnyI0fNt5XDfKpy7dCKoC9fgDeMLnG5oXfWChif3Yvxv
 9UueRrJqqqxCLhgjqqiZePTIluNsY6n0PjK8tWtrrYojWLiR5MRZbzjBD7n8ltMB+2enTTzvb4Q
 w4QAsBqjAJrFxsoeluFcaLn0v0Hb0GX3u+ru+Ld3feGcejoOevuBA7gzpzJgPgVQXRHF1HbQDTS
 1fAlKdz0DdetJgBTBcdL7+XmWhRFgvVIM4/IJLk3mCcBxKhpj5YXPczkDzpLEcHmaSxcQ7UXdyz
 zbEOIKDY/b4HbPG/26+gIuA9hZXP/8UatjPIAHcxJRzE9iOE47t6yBLXwhC39T0brxF9rUJoArI
 o9E+S27xZvF400inTCq10cS97kn/Txu3Mzw2nb38M/pRjlxK4Anog1y23g9kGgZBrxNIk=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] symlink01 split
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

This is a developement series (requested by Petr Vorel) that handle
symlink01 split, which has been already merged in the master branch.

In this series we face the next part of symlink01 split that
includes stat04, lstat03, open15 and chmod08.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (5):
      Add stat04 test
      Fix TST_EXP_EXTR() stringification
      Add lstat03 test
      Add chmod08 test
      Add open15 test

 include/tst_test_macros.h                  |   5 +-
 runtest/smoketest                          |   4 +-
 runtest/syscalls                           |  11 +--
 testcases/kernel/syscalls/chmod/.gitignore |   1 +
 testcases/kernel/syscalls/chmod/chmod08.c  |  45 +++++++++++
 testcases/kernel/syscalls/fork/fork04.c    |   6 +-
 testcases/kernel/syscalls/lstat/.gitignore |   2 +
 testcases/kernel/syscalls/lstat/lstat03.c  | 102 ++++++++++++++++++++++++
 testcases/kernel/syscalls/open/.gitignore  |   1 +
 testcases/kernel/syscalls/open/open15.c    |  86 ++++++++++++++++++++
 testcases/kernel/syscalls/stat/.gitignore  |   2 +
 testcases/kernel/syscalls/stat/stat04.c    | 121 +++++++++++++++++++++++++++++
 12 files changed, 374 insertions(+), 12 deletions(-)
---
base-commit: 072f359ac54395af1d5ade4ca8cc347c5afe6310
change-id: 20240702-stat04-ceeb58b80910

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
