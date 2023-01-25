Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB8BC54E94
	for <ltp@archiver.kernel.org>; Wed, 25 Jan 2023 22:27:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB5373CD3BA
	for <ltp@archiver.kernel.org>; Wed, 25 Jan 2023 23:27:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD67D3CC753
 for <ltp@lists.linux.it>; Wed, 25 Jan 2023 23:27:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C5EF4600A65
 for <ltp@lists.linux.it>; Wed, 25 Jan 2023 23:27:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3202C1F895;
 Wed, 25 Jan 2023 22:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674685627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1v01XNLGUBhQHY1MmKahuWPWpfYAIIeaO21pbFXf9RA=;
 b=QspCMyQigmih5KXS2NwNAsgdVbv2BDHr6SEs+ob/6ClF8e4grsXw3kGBx7wWqvE4HbRiMU
 0aocejT4TWPkqLrusAxX5/RhS58XHVkDtwNy6YhneNSrAZ//VxkZplAkFxECW/9NibkJ/b
 89dkEF/BawXxf59BLAKcoAcFN0+1XnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674685627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1v01XNLGUBhQHY1MmKahuWPWpfYAIIeaO21pbFXf9RA=;
 b=pc+4t45jtEd738YqQCZn/42D9oEFtU109eVHuQizF4ghhTDhV8PkVO68e2BvI5TDky4M0V
 0OgqG92GRO+lQDCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDCED1339E;
 Wed, 25 Jan 2023 22:27:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RBavM7qs0WPoNgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Jan 2023 22:27:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 25 Jan 2023 23:27:01 +0100
Message-Id: <20230125222703.19943-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] hugemmap15 pre-release testing
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

Hi all,

it'd be good to merge tomorrow, to have it in upcoming release.

Kind regards,
Petr

Petr Vorel (2):
  hugemmap15: Compile with -O
  hugemmap15.c: Use TST_TEST_TCONF() for unsupported archs

 testcases/kernel/mem/hugetlb/hugemmap/Makefile     |  2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
