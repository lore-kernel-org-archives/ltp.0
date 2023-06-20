Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6BCEB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 12:02:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3DA73CE112
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 14:02:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54CDC3CB041
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 14:02:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AEC1A60064D
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 14:02:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F3A6D1F37E;
 Tue, 20 Jun 2023 12:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687262523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=D3E2KRe0L2LRcH4u5mGONwLmRr0V+FQm5RbAKj4EtiY=;
 b=enJ06JR4UxAUA+jYNCK+/LY2BN/XpDuVV2ljwEalqVGmCK7Fv257sSRTa0JXPz5/7XmAxk
 FBVYgK7JGRZmcsxjqbFsbMZd5gzyIAhhA6+0mzUTawWBZndzS/sSiYnUevdx0aoOksLAGp
 KVfotHI2tQGZOl3yxQdHA01n44KC9IA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687262523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=D3E2KRe0L2LRcH4u5mGONwLmRr0V+FQm5RbAKj4EtiY=;
 b=bcjBfENaITQnJvDn0w6Yk6veEoS2yU/WkFZ64lXdf6eYACN5HX21GHb+gc6nbDxrW+C6ED
 POtGn4jpxZN3DNCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1712133A9;
 Tue, 20 Jun 2023 12:02:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vVrKLTqVkWSQDAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Jun 2023 12:02:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 20 Jun 2023 14:01:56 +0200
Message-Id: <20230620120159.320052-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] ioprio minor cleanup
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Further minor ioprio cleanup. NOTE, docparse markers /*\ [Description]
in the second commit allow test to be included in our automatically
generated documentation [1].

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/releases/download/20230516/metadata.20230516.html

Petr Vorel (3):
  ioprio: Move fallback constants and structs to LAPI header
  ioprio: Add docparse markers
  utils: Remove unused ioprio.h

 include/lapi/ioprio.h                         | 47 +++++++++++++++++++
 testcases/kernel/syscalls/ioprio/ioprio.h     | 42 ++---------------
 .../kernel/syscalls/ioprio/ioprio_get01.c     |  9 ++--
 .../kernel/syscalls/ioprio/ioprio_set01.c     |  9 ++--
 .../kernel/syscalls/ioprio/ioprio_set02.c     |  9 ++--
 .../kernel/syscalls/ioprio/ioprio_set03.c     |  9 ++--
 testcases/kernel/syscalls/utils/ioprio.h      | 46 ------------------
 7 files changed, 71 insertions(+), 100 deletions(-)
 create mode 100644 include/lapi/ioprio.h
 delete mode 100644 testcases/kernel/syscalls/utils/ioprio.h

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
