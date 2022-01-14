Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F823C433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 20:53:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3F3F3C9543
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 21:53:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A21223C928A
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 21:53:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B223D601410
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 21:53:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C1EC91F381;
 Fri, 14 Jan 2022 20:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642193594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=A59O6eCFN8btiMpGAz3UnU8AuKYrBheDpAPS4fvigD4=;
 b=p91ESh1lgbUj5zqfW+ov3eNshADsDONSUOoAbTelj4J6+flSNFK8HTnTYFGVkjL9A5DK1G
 /K9dDcll5jC73BeqPxbpXG7wdIzIW0Xg8iKeduTd4G2bk88cvGpJImnGiQtyzJoldt8oC1
 q429drlNXgSOK24lolltQTIxbT7MN18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642193594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=A59O6eCFN8btiMpGAz3UnU8AuKYrBheDpAPS4fvigD4=;
 b=bAHEITlLDNj7GBNEz0x+iIuV5FlDDny9ftKda5CGQyF1r4CVHg9BC4RTZ2oIz6hbf1GFYI
 snuVJ79yMShTA7CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FBCD13BB4;
 Fri, 14 Jan 2022 20:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KX4ZHbri4WHtWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jan 2022 20:53:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 14 Jan 2022 21:53:06 +0100
Message-Id: <20220114205309.14409-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] known-fail test tag
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

changes v2->v3:
* new commit: testinfo.pl: Support tag values on more lines
* use URL

Petr Vorel (3):
  lib: Add known-fail test tag
  testinfo.pl: Support tag values on more lines
  ustat0{1,2}: Mark failure on Btrfs with known-fail tag

 doc/c-test-api.txt                        |  1 +
 docparse/testinfo.pl                      | 17 ++++++++++++++++-
 lib/tst_test.c                            |  8 ++++++--
 testcases/kernel/syscalls/ustat/ustat01.c |  6 ++++++
 testcases/kernel/syscalls/ustat/ustat02.c |  6 ++++++
 5 files changed, 35 insertions(+), 3 deletions(-)

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
