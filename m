Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A0CEE3F2F
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 14:42:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B6F63CE68F
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 16:42:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEE303CB0E3
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 16:41:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EECFC200B6D
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 16:41:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 776862183B;
 Fri, 15 Sep 2023 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694788917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=f+kGqKE49QL86ugUly7KdOsF35/rgDw5F57ECakh8kk=;
 b=i1nnCIyLvbovBCFbuHtRtT4jRJm8kGQqPulQzgsFkba8Z2ZPa69paSHtYOIcpdg9Gm+aal
 K/KP1PPtIed1E4wEgnDYBJLEKjIjxH95xA01tfVifhr1LxRB626xPXPvIDyOlICUjjS2CP
 h/9OKDiBVCEVWQVNETV4YogL42kGbyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694788917;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=f+kGqKE49QL86ugUly7KdOsF35/rgDw5F57ECakh8kk=;
 b=1szYgqqbbzc8j5Ae71sZJtHdkkXFDVnguyfSbolyQ8/rVNIuahczbJzKmpSgDE7g2sgvkC
 SpGY07YR7Qsu7nDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DB0213251;
 Fri, 15 Sep 2023 14:41:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kfJjETVtBGUTBgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 15 Sep 2023 14:41:57 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 15 Sep 2023 16:41:54 +0200
Message-Id: <20230915144156.22380-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Add kirk & ltx tools
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Replaced runltp-ng with kirk and added ltx tool for parallel execution.

Andrea Cervesato (2):
  Replace runltp-ng with kirk framework
  Add Linux Test eXecutor inside tools

 .gitmodules          |  9 ++++++---
 tools/kirk           |  1 +
 tools/ltx/.gitignore |  1 +
 tools/ltx/Makefile   | 26 ++++++++++++++++++++++++++
 tools/ltx/ltx-src    |  1 +
 tools/runltp-ng      |  1 -
 6 files changed, 35 insertions(+), 4 deletions(-)
 create mode 160000 tools/kirk
 create mode 100644 tools/ltx/.gitignore
 create mode 100644 tools/ltx/Makefile
 create mode 160000 tools/ltx/ltx-src
 delete mode 160000 tools/runltp-ng

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
