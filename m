Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B067CDB482
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 18:45:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 327FA3CFD3A
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 20:45:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DAE93C894B
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 20:44:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 138EC60086B
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 20:44:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9068A21C63;
 Mon, 16 Oct 2023 18:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697481869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ANv4OeERr0K7SXsLoUdafx8yzZWUtPvqaWBPbZmBeJg=;
 b=ZMJCMPRXLx/iimrZ9zVmJAX3Z+WiuudQiEmBlAf55amC2E29EEqNAumxs5N0GkcPZv2XPl
 dq8muU0hvkZAxVHImA5eDqSrmnLHctHni2Ua0VI5IvdeTtGYVxgdcff3gyQz44RgQOLsID
 IeFeq3CLV14TSYtfPmUb1h1v/q9JW/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697481869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ANv4OeERr0K7SXsLoUdafx8yzZWUtPvqaWBPbZmBeJg=;
 b=96qkFObbALZPrzLAaOx14NZZ6c+cVOp8bFQjeHTQLR1OS7ahWWoauI/SmvYXXMKKjJiNHp
 QWUlclNb+vNnVPCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4785F138EF;
 Mon, 16 Oct 2023 18:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Sp4dD42ELWXAZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 16 Oct 2023 18:44:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 16 Oct 2023 20:44:01 +0200
Message-ID: <20231016184408.879977-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.15 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-2.91)[-0.970];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-1.14)[88.64%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 0/7] Remove scsi testsuite + various testscripts
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

cleanup of 2 old scsi testsuites and some of legacy testscripts.
IMHO the testsuites are not worth of fixing.

Kind regards,
Petr

Petr Vorel (7):
  doc: Remove ltp-run-files.txt
  fs: Remove scsi/ltpfs testsuite
  fs: Remove scsi/ltpscsi testsuite
  testscripts: Remove ltpdmmapper.sh
  testscripts: Remove ltp-scsi_debug.sh
  testscripts: Remove sysfs.sh
  testcases: Remove autofs{1,4}.sh scripts

 doc/Test-Writing-Guidelines.asciidoc          |   12 +
 doc/ltp-run-files.txt                         |   96 -
 testcases/kernel/fs/scsi/ltpfs/Ltpfs.h        |   71 -
 testcases/kernel/fs/scsi/ltpfs/LtpfsCmds.c    |  315 -
 testcases/kernel/fs/scsi/ltpfs/Makefile       |   30 -
 testcases/kernel/fs/scsi/ltpfs/ltpfs.part1    |    4 -
 testcases/kernel/fs/scsi/ltpfs/ltpfs.part2    |    3 -
 testcases/kernel/fs/scsi/ltpfs/ltpfs.part3    |    3 -
 testcases/kernel/fs/scsi/ltpfs/ltpfs.part4    |    3 -
 testcases/kernel/fs/scsi/ltpfs/ltpfs.part5    |    3 -
 testcases/kernel/fs/scsi/ltpfs/ltpfs.part6    |    3 -
 testcases/kernel/fs/scsi/ltpfs/ltpfs.part7    |    3 -
 testcases/kernel/fs/scsi/ltpfs/ltpfsio.sh     |  154 -
 testcases/kernel/fs/scsi/ltpfs/main.c         |  647 --
 testcases/kernel/fs/scsi/ltpscsi/Makefile     |   47 -
 testcases/kernel/fs/scsi/ltpscsi/llseek.c     |  123 -
 testcases/kernel/fs/scsi/ltpscsi/llseek.h     |   10 -
 testcases/kernel/fs/scsi/ltpscsi/ltpfsscsi.sh |  111 -
 testcases/kernel/fs/scsi/ltpscsi/scsimain.c   | 7651 -----------------
 testcases/kernel/fs/scsi/ltpscsi/sg_err.c     | 1379 ---
 testcases/kernel/fs/scsi/ltpscsi/sg_err.h     |  162 -
 testcases/kernel/fs/scsi/ltpscsi/sg_include.h |   42 -
 testscripts/autofs1.sh                        |  273 -
 testscripts/autofs4.sh                        |  259 -
 testscripts/ltp-scsi_debug.sh                 |  218 -
 testscripts/ltpdmmapper.sh                    |  204 -
 testscripts/sysfs.sh                          |  121 -
 27 files changed, 12 insertions(+), 11935 deletions(-)
 delete mode 100644 doc/ltp-run-files.txt
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/Ltpfs.h
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/LtpfsCmds.c
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/Makefile
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part1
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part2
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part3
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part4
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part5
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part6
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part7
 delete mode 100755 testcases/kernel/fs/scsi/ltpfs/ltpfsio.sh
 delete mode 100644 testcases/kernel/fs/scsi/ltpfs/main.c
 delete mode 100644 testcases/kernel/fs/scsi/ltpscsi/Makefile
 delete mode 100644 testcases/kernel/fs/scsi/ltpscsi/llseek.c
 delete mode 100644 testcases/kernel/fs/scsi/ltpscsi/llseek.h
 delete mode 100755 testcases/kernel/fs/scsi/ltpscsi/ltpfsscsi.sh
 delete mode 100644 testcases/kernel/fs/scsi/ltpscsi/scsimain.c
 delete mode 100644 testcases/kernel/fs/scsi/ltpscsi/sg_err.c
 delete mode 100644 testcases/kernel/fs/scsi/ltpscsi/sg_err.h
 delete mode 100644 testcases/kernel/fs/scsi/ltpscsi/sg_include.h
 delete mode 100755 testscripts/autofs1.sh
 delete mode 100755 testscripts/autofs4.sh
 delete mode 100755 testscripts/ltp-scsi_debug.sh
 delete mode 100755 testscripts/ltpdmmapper.sh
 delete mode 100755 testscripts/sysfs.sh

-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
