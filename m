Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691B3C4332F
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 11:54:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC05B3CB1CE
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 13:54:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9B553C6E8B
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 13:53:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EF6306010F5
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 13:53:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ABFC01F8ED;
 Fri, 21 Oct 2022 11:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666353219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQGdygcN5Jfm3y6HWQukHk+fFBquPKZn6TIxfHhA3gM=;
 b=sCmxW+sVQW45dLHsqWTNc4btdO2fRNwA9He405zLoeX3naFDGf5Ze2e9DBSaYpKwaH1jQq
 V0b01bkHvwB+Ak8b+NdBqd45nrZCGd9t61hzeCTsx2iGsMAZImCSEdlOs43lInT2AYzRqH
 /tl4uxWm8V6WChrTw3b4ExNpszM+XAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666353219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQGdygcN5Jfm3y6HWQukHk+fFBquPKZn6TIxfHhA3gM=;
 b=Sdbo6TDYpV9vKbISPYUOcCYGTjh738KZiB0lxLs4Hr+ZcHyTXcmT3jNwBU6bCxBLRmSPMT
 tao4qlZ8G9wEuQBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DCA713A0E;
 Fri, 21 Oct 2022 11:53:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GGZkHUOIUmOdTAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Oct 2022 11:53:39 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 21 Oct 2022 13:53:33 +0200
Message-Id: <20221021115333.13725-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221021115333.13725-1-pvorel@suse.cz>
References: <20221021115333.13725-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] doc: Remove mini-howto-building-ltp-from-git.txt
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

Document is not linked into our wiki, there is "Quick guide to running
the tests" section in README.md visible from web and CI scripts in
ci/*.sh and build.sh, which describe what to install and how to build.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Do we want any of these move to "Quick guide to running the tests"
section in README.md?


 doc/mini-howto-building-ltp-from-git.txt | 62 ------------------------
 1 file changed, 62 deletions(-)
 delete mode 100644 doc/mini-howto-building-ltp-from-git.txt

diff --git a/doc/mini-howto-building-ltp-from-git.txt b/doc/mini-howto-building-ltp-from-git.txt
deleted file mode 100644
index 28825c20f..000000000
--- a/doc/mini-howto-building-ltp-from-git.txt
+++ /dev/null
@@ -1,62 +0,0 @@
-Mini-Howto: Building LTP from Git
-=================================
-
-******************************************************************************
-The following document briefly describes the single steps to build LTP from
-the Git repository located at GitHub.
-The instructions here were tested on a Ubuntu/precise Linux system (feel free
-to adapt to your distribution).
-
-Changelog:
- * Initial version: Sedat Dilek <sedat.dilek@gmail.com>
- * Embedded comments from Cyril Hrubis <chrubis@suse.cz>
-******************************************************************************
-
-# Export language settings
-
-export LANG=C
-export LC_ALL=C
-
-# Set some useful variables (adapt if you dislike)
-
-WORKING_DIR="$HOME/src/ltp"
-
-PREFIX="/opt/ltp"
-
-GIT_URL="https://github.com/linux-test-project/ltp.git"
-
-MAKE_JOBS=$(getconf _NPROCESSORS_ONLN)
-
-BUILD_LOG_FILE="build-log.txt"
-INSTALL_LOG_FILE="install-log.txt"
-
-# PREREQS on Ubuntu (package-list is incomplete and may vary for other distros)
-
-sudo apt-get install build-essential
-sudo apt-get install autoconf automake autotools-dev m4
-sudo apt-get install git
-sudo apt-get install linux-headers-$(uname -r)
-sudo apt-get install libaio-dev libattr1-dev libcap-dev
-
-# Working directory
-
-mkdir -p $WORKING_DIR
-cd $WORKING_DIR
-
-# Get the LTP source
-
-git clone $GIT_URL ltp-git
-
-# Configure LTP
-
-cd ltp-git/
-make autotools
-./configure --prefix=$PREFIX
-
-# Start building LTP
-
-make -j$MAKE_JOBS 2>&1 | tee ../$BUILD_LOG_FILE
-
-# Install LTP (requires superuser privileges)
-
-sudo make install 2>&1 | tee ../$INSTALL_LOG_FILE
-- 
2.38.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
