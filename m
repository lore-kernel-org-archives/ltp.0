Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E90AC6FD18
	for <ltp@archiver.kernel.org>; Sat, 22 Apr 2023 13:54:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D766F3CBE8F
	for <ltp@archiver.kernel.org>; Sat, 22 Apr 2023 15:54:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFBB33CBDC7
 for <ltp@lists.linux.it>; Sat, 22 Apr 2023 15:53:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 622151400215
 for <ltp@lists.linux.it>; Sat, 22 Apr 2023 15:53:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB2951F38D;
 Sat, 22 Apr 2023 13:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1682171632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=okquNfPZmtCWyxmrQCoppfkP8eqSz2rAER8eX8IW0XE=;
 b=bNIc3Gq2tivCx9mQRwYrfQOfdsc6nqt6CwUW2nEHI3nryb+nIfKh96bQFcKHO/nMPbuD5q
 0/0/p/R4y5uwLAI7XMkLhpxNDbFnVThfSc93bp4ehkR3r6wgVkGCbK0caP224zatt1/y0l
 JmAEJH1kMIkAPWg0iE/E/1ChRE1Mt8s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D90C13591;
 Sat, 22 Apr 2023 13:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KWofM+/mQ2TOLAAAMHmgww
 (envelope-from <wegao@suse.com>); Sat, 22 Apr 2023 13:53:51 +0000
To: ltp@lists.linux.it
Date: Sat, 22 Apr 2023 09:53:35 -0400
Message-Id: <20230422135337.12087-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230421012642.16625-1-wegao@suse.com>
References: <20230421012642.16625-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 0/2] kill01: New case cgroup kill
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  kill01: New case cgroup kill
  tst_cgroup.c: Add a cgroup pseudo controller

 lib/tst_cgroup.c                              |  48 ++++--
 runtest/controllers                           |   1 +
 .../kernel/controllers/cgroup/.gitignore      |   1 +
 .../kernel/controllers/cgroup/cgroup_core03.c | 144 ++++++++++++++++++
 4 files changed, 179 insertions(+), 15 deletions(-)
 create mode 100644 testcases/kernel/controllers/cgroup/cgroup_core03.c


base-commit: b67facdd9c3f0ef471d74dd59ac276139e63f4c4
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
