Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715F8C433EF
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 12:36:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 118003C9ABD
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 13:36:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 799D83C9A59
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 13:35:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A75891A00668
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 13:35:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D2D301F446;
 Thu,  3 Feb 2022 12:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643891724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E220/OCwECjgekxckzHEX7e5xLyc034WvDRepvRtaMU=;
 b=KYmTsmmQrsCiTepONgV/bb1RApcxiw9zl9Yp7TdbRwx7KY6XovHemXPoC5ekAOqZEvunkH
 BAEAKrMv36hnKDtyYV6fk3zRz0HQ2s9R9OgOdz1e8VnsYP/t60wXmTjgKCD3CS47XpvpHd
 lDmweSfrjWNarx5j/YBnN11FTqtrECw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643891724;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E220/OCwECjgekxckzHEX7e5xLyc034WvDRepvRtaMU=;
 b=j4NF7sfAQEvX13V0jphKeM+6DW+LqEWbfIBqr0nWiter/t/mz9tbk+/ANk1M4qHeFxi70l
 0iwP1S38Ogd1btCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB59E1348D;
 Thu,  3 Feb 2022 12:35:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mdKkJwzM+2GkGwAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 03 Feb 2022 12:35:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu,  3 Feb 2022 13:35:17 +0100
Message-Id: <20220203123522.28604-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/5] Rewrite mountns testing suite
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

mountns testing suite has been rewritten using new LTP API and libclone
has been removed from dependences.

Andrea Cervesato (5):
  Rewrite mountns01 test using new LTP API
  Rewrite mountns02 test using new LTP API
  Rewrite mountns03 test using new LTP API
  Rewrite mountns04 test using new LTP API
  Remove obsolete mountns_helper.h

 testcases/kernel/containers/mountns/Makefile  |  21 +--
 testcases/kernel/containers/mountns/common.h  |  53 ++++++
 .../kernel/containers/mountns/mountns01.c     | 148 ++++++++--------
 .../kernel/containers/mountns/mountns02.c     | 145 +++++++---------
 .../kernel/containers/mountns/mountns03.c     | 161 ++++++++----------
 .../kernel/containers/mountns/mountns04.c     |  98 +++++------
 .../containers/mountns/mountns_helper.h       |  61 -------
 7 files changed, 308 insertions(+), 379 deletions(-)
 create mode 100644 testcases/kernel/containers/mountns/common.h
 delete mode 100644 testcases/kernel/containers/mountns/mountns_helper.h

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
