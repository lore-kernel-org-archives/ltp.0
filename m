Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0B5C433EF
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 10:49:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 655983C6BD8
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 11:49:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD0CA3C5A83
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:49:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2961E1000A43
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:49:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6169C21709
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 10:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638269356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ANEQleHS81hE+PVPgdl4NDFyuPPwQfNLjjRuETQZaNE=;
 b=H4RJLS6uCIEQJW//zHvMbId2DEL0J8WVwZEWuk3ggbAFGWpVuf1VuF+u05RANIWEljc4HQ
 9+9QgLlM+DtOGUHHTWOfTNgenNnRaFI43db6ma1Vo2KBuhZrKQw/lJ2sfkDGQofbvj05Hc
 0mimqUf9UitTK4BdXXZNWYBBRRB7fkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638269356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ANEQleHS81hE+PVPgdl4NDFyuPPwQfNLjjRuETQZaNE=;
 b=clm4ZfzwE5/r5Ry/bbRmztZ1YUFjxgmrm8ByuWbcoNIhR9DW9VdUhhUuNEoZDOGVKzMpmz
 WQmA3Z0r/pPbiSDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4960013C44
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 10:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8k9tEawBpmG2QAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 10:49:16 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Nov 2021 11:50:25 +0100
Message-Id: <20211130105027.1071-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Two small fixes for LTP-003
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

This fixes false possitives for tst_fuzzy_sync.h

Cyril Hrubis (2):
  include/tst_fuzzy_sync.h: Add inline to static fucntions
  sparse: Do not report static inline functions

 include/tst_fuzzy_sync.h  | 14 +++++++-------
 tools/sparse/sparse-ltp.c |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
