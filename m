Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28454C433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 19:45:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3368B3C9538
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 20:45:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF94A3C8E6D
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 20:44:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2267C600F84
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 20:44:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 80E791F386;
 Fri, 14 Jan 2022 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642189488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNUIE4yql6TSFYKQkbReUcJuMnzn2mUa46548xzdGW8=;
 b=UNFXdw7A2vTbexcBjGBH+c/M/R7HHEVUyCXWMvNdVbxjDXWYG0zKvOxxpud8byEeAnOJkT
 dKwQN/PscpSPxto6L6OaUNuZhoBn87J2Zk5CfQtZhskxMX3q9Jnh46+5OHLpbD8EtFj3XP
 8j0ADPoTFK9/b6CPfqoJaC0LVHG4gxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642189488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNUIE4yql6TSFYKQkbReUcJuMnzn2mUa46548xzdGW8=;
 b=SiKQoemLVjOK0yPp7zuXC+egKWVHk3eGnTSRZcFD/zi7dnqmQX5Dl47cVT30K+5Hch7Zd7
 PMuYlABWgQgS8oAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B17A1345F;
 Fri, 14 Jan 2022 19:44:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2H5nFLDS4WFBQQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jan 2022 19:44:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 14 Jan 2022 20:44:44 +0100
Message-Id: <20220114194444.16949-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220114194444.16949-1-pvorel@suse.cz>
References: <20220114194444.16949-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] doc/user-guide: Remove "2. Colorized output"
 section
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

There are move important topics in the variables,
but only colors have it's own section.

Although it might be easier to find particular functionality though
these sections, let's keep just single table.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/user-guide.txt | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/doc/user-guide.txt b/doc/user-guide.txt
index 5f5a86c9d0..9eff725585 100644
--- a/doc/user-guide.txt
+++ b/doc/user-guide.txt
@@ -14,8 +14,9 @@ For running LTP network tests see `testcases/network/README.md`.
 | 'LTPROOT'             | Prefix for installed LTP.  **Should be always set**
                           as some tests need it for path to test data files
                           ('LTP_DATAROOT'). LTP is by default installed into '/opt/ltp'.
-| 'LTP_COLORIZE_OUTPUT' | Force colorized output behaviour. 'y' or '1': always colorize
-                          'n' or '0': never colorize.
+| 'LTP_COLORIZE_OUTPUT' | By default LTP colorizes it's output unless using
+                          pipe or redirect to file.  Force colorized output behaviour:
+                          'y' or '1': always colorize, 'n' or '0': never colorize.
 | 'LTP_DEV'             | Path to the block device to be used
                           (C: '.needs_device = 1', shell: 'TST_NEEDS_DEVICE=1').
 | 'LTP_SINGLE_FS_TYPE'  | Testing only - specifies filesystem instead all
@@ -35,9 +36,3 @@ For running LTP network tests see `testcases/network/README.md`.
                           and others, which imply it, shell: 'TST_NEEDS_TMPDIR=1').
 | 'TST_NO_CLEANUP'      | Disable running test cleanup (defined in 'TST_CLEANUP').
 |==============================================================================
-
-2. Colorized output
--------------------
-
-By default LTP colorizes it's output unless using pipe or redirect to file.
-It's possible to force behaviour with 'LTP_COLORIZE_OUTPUT' environment variable.
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
