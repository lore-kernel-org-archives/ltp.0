Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DA9C43334
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 08:02:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 913DC3C9539
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 10:02:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 102983C1C1B
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:02:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2ACBD1400547
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:02:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 68C7321C09;
 Thu, 23 Jun 2022 08:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655971339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ph+84WTtjLeAQuvtABbqk0y0eZlDYk3BQKLJhb8vzxw=;
 b=dt83GheOtK5GaE8NG3byJqUIzFYneXX3M9vOPagHFgKvgC2MwQzeMIFK43qRCf5knmEliG
 aPIv0YyZyAPNN3sw80om8ZBTGz2BcJKYKH0e8a5C9bu4roiKglFACvU+0rRRQc2d8LVE9S
 l8vPAObaimDjf0XrllZbRouL983hvZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655971339;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ph+84WTtjLeAQuvtABbqk0y0eZlDYk3BQKLJhb8vzxw=;
 b=cakxfa1/dR+AhmVRwR8DUzlCP9EaWf3hRxJ9Y9podBjM4YP+49uIZro9e9hl7Zx/msInrm
 VIW1N6mZVpoH0XAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09671133A6;
 Thu, 23 Jun 2022 08:02:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6AkwMwoetGJadgAAMHmgww
 (envelope-from <akumar@suse.de>); Thu, 23 Jun 2022 08:02:18 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 23 Jun 2022 13:32:09 +0530
Message-Id: <20220623080215.24186-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/6] Convert utime tests to new LTP API
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
Thank you for the feedback on v1 patches, I have made the requested
changes.

Thanks,
Avinesh

Avinesh Kumar (6):
  Rewrite utime01.c using new LTP API
  Rewrite utime02.c using new LTP API
  utime03.c: Remove unnecessary header includes
  Rewrite utime04.c using new LTP API
  Rewrite utime05.c using new LTP API
  Rewrite utime06.c using new LTP API

 testcases/kernel/syscalls/utime/utime01.c | 263 +++++---------------
 testcases/kernel/syscalls/utime/utime02.c | 283 ++++++----------------
 testcases/kernel/syscalls/utime/utime03.c |   2 -
 testcases/kernel/syscalls/utime/utime04.c | 203 +++-------------
 testcases/kernel/syscalls/utime/utime05.c | 213 +++-------------
 testcases/kernel/syscalls/utime/utime06.c | 188 ++++----------
 6 files changed, 243 insertions(+), 909 deletions(-)

-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
