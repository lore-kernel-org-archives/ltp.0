Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAECDC636CC
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 13:17:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C6853CC214
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 14:17:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 550C73C7835
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 14:17:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A58B460091A
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 14:17:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 82CE43F82A;
 Tue,  7 Feb 2023 13:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675775838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=b6LSDJj3ZQhsrDU2zwK0Abm7ANDGdie5NsAwzCrZOfs=;
 b=Mn9CjLbqSSyV/VXM7SVJHLmpJ4+y/k2naVnjsFkCCDbBPtQVUOEvjg3FbeXctyjrrs8B5H
 xR5tOOvBRc4YnHmjsE5XFf9RWjins7hjYBHuTAZuRH2bp86c2Re9vGaLXoNvODe+2zUIp0
 mM22P5pNMihVeCcasyp9KYC7b8Qla8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675775838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=b6LSDJj3ZQhsrDU2zwK0Abm7ANDGdie5NsAwzCrZOfs=;
 b=KW8PAqZ8/eooV6Ta9pTb4W3rz1TDygFPqgYdxEfmEit4vcflNhy/oGYG1uF+PLOV+wkCj6
 8Aw4IUJy5zuT6GCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38CA013467;
 Tue,  7 Feb 2023 13:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SYlTC15P4mOJbQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 07 Feb 2023 13:17:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  7 Feb 2023 14:17:11 +0100
Message-Id: <20230207131714.2500-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] ioctl01: device check, enable
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

NOTE: the same should be done for ioctl02, but it should be first
converted to the new API.

Kind regards,
Petr

Petr Vorel (3):
  ioctl01: Add default tty device
  ioctl01: Check tty device
  runtest/syscalls: Enable ioctl01

 runtest/syscalls                          |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl01.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
