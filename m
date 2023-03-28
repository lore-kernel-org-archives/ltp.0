Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE44EC76196
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 11:14:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 366813CCB40
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 13:14:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 834553CA2FA
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 13:13:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F04FD6006C9
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 13:13:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A71DD1FD6A;
 Tue, 28 Mar 2023 11:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680002035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhZbExtLBlJkoX4jEMLGL2tncDHNSvhQ1MklcMHERRQ=;
 b=F7fuFXUn7R4u2IcnekOME/p9NDcxfsKjpDg3VbKzeV2ELRbFSIG3FrVkKpKiCuqIZ8KOvz
 pN/UreaJjrc+UGcIcJGH+arbcPNmqRtvIom0PMCrZ7e5jBAhshW4LavMh4G2Xb1Cg76ArU
 L0bkZpU7BcKm1CRF/gxLu1xjA91Gh7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680002035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhZbExtLBlJkoX4jEMLGL2tncDHNSvhQ1MklcMHERRQ=;
 b=KX6Uf6ROHGUib4kcEA9C0/tn7ORJODNlRuEKnsPuSFPT7HcoBVvR28hehKId2lHTBCDFq7
 T231w72/AIEjL1Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21CC31390B;
 Tue, 28 Mar 2023 11:13:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id INFYBvPLImR9CAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 28 Mar 2023 11:13:55 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 Mar 2023 13:13:37 +0200
Message-Id: <20230328111338.766712-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230328111338.766712-1-pvorel@suse.cz>
References: <20230328111338.766712-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/2] doc: Rename files to names from ltp.wiki.git
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Xiao Yang <yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Keeping the original extension from LTP wiki git brings:
* add syntax highlight for editors
* no need to add new file (only new extension)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .github/workflows/wiki-mirror.yml                | 16 +++-------------
 ...{build-system-guide.txt => Build-System.rest} |  0
 doc/{c-test-api.txt => C-Test-API.asciidoc}      |  0
 ...-simple.txt => C-Test-Case-Tutorial.asciidoc} |  0
 ...ork-c-api.txt => C-Test-Network-API.asciidoc} |  0
 doc/{kvm-test-api.txt => KVM-Test-API.asciidoc}  |  0
 ... LTP-Library-API-Writing-Guidelines.asciidoc} |  0
 ...> Maintainer-Patch-Review-Checklist.asciidoc} |  0
 ...hell-test-api.txt => Shell-Test-API.asciidoc} |  0
 ...ed-kernel,-libc,-toolchain-versions.asciidoc} |  0
 ...ines.txt => Test-Writing-Guidelines.asciidoc} |  0
 doc/{user-guide.txt => User-Guidelines.asciidoc} |  0
 12 files changed, 3 insertions(+), 13 deletions(-)
 rename doc/{build-system-guide.txt => Build-System.rest} (100%)
 rename doc/{c-test-api.txt => C-Test-API.asciidoc} (100%)
 rename doc/{c-test-tutorial-simple.txt => C-Test-Case-Tutorial.asciidoc} (100%)
 rename doc/{network-c-api.txt => C-Test-Network-API.asciidoc} (100%)
 rename doc/{kvm-test-api.txt => KVM-Test-API.asciidoc} (100%)
 rename doc/{library-api-writing-guidelines.txt => LTP-Library-API-Writing-Guidelines.asciidoc} (100%)
 rename doc/{maintainer-patch-review-checklist.txt => Maintainer-Patch-Review-Checklist.asciidoc} (100%)
 rename doc/{shell-test-api.txt => Shell-Test-API.asciidoc} (100%)
 rename doc/{supported-kernel-libc-versions.txt => Supported-kernel,-libc,-toolchain-versions.asciidoc} (100%)
 rename doc/{test-writing-guidelines.txt => Test-Writing-Guidelines.asciidoc} (100%)
 rename doc/{user-guide.txt => User-Guidelines.asciidoc} (100%)

diff --git a/.github/workflows/wiki-mirror.yml b/.github/workflows/wiki-mirror.yml
index 883892bf5..2ac0caf74 100644
--- a/.github/workflows/wiki-mirror.yml
+++ b/.github/workflows/wiki-mirror.yml
@@ -38,20 +38,10 @@ jobs:
           commit=$(git log --pretty=format:"%h (\"%s\")" -1 .)
 
           cd $GITHUB_WORKSPACE/ltp.wiki
-
-          # Don't forget to update this list, keep it sorted
-          cp -v $dir/c-test-api.txt C-Test-API.asciidoc
-          cp -v $dir/c-test-tutorial-simple.txt C-Test-Case-Tutorial.asciidoc
-          cp -v $dir/library-api-writing-guidelines.txt LTP-Library-API-Writing-Guidelines.asciidoc
-          cp -v $dir/maintainer-patch-review-checklist.txt Maintainer-Patch-Review-Checklist.asciidoc
-          cp -v $dir/network-c-api.txt C-Test-Network-API.asciidoc
-          cp -v $dir/shell-test-api.txt Shell-Test-API.asciidoc
-          cp -v $dir/supported-kernel-libc-versions.txt Supported-kernel,-libc,-toolchain-versions.asciidoc
-          cp -v $dir/test-writing-guidelines.txt Test-Writing-Guidelines.asciidoc
-          cp -v $dir/user-guide.txt User-Guidelines.asciidoc
-          cp -v $dir/kvm-test-api.txt KVM-Test-API.asciidoc
-
+          # don't forget to add new extensions
+          cp -v $dir/*.asciidoc $dir/*.rest .
           git add .
+
           # only commit if there are changes
           git diff-index --quiet HEAD -- || git commit -m "Update to $commit" .
           git push
diff --git a/doc/build-system-guide.txt b/doc/Build-System.rest
similarity index 100%
rename from doc/build-system-guide.txt
rename to doc/Build-System.rest
diff --git a/doc/c-test-api.txt b/doc/C-Test-API.asciidoc
similarity index 100%
rename from doc/c-test-api.txt
rename to doc/C-Test-API.asciidoc
diff --git a/doc/c-test-tutorial-simple.txt b/doc/C-Test-Case-Tutorial.asciidoc
similarity index 100%
rename from doc/c-test-tutorial-simple.txt
rename to doc/C-Test-Case-Tutorial.asciidoc
diff --git a/doc/network-c-api.txt b/doc/C-Test-Network-API.asciidoc
similarity index 100%
rename from doc/network-c-api.txt
rename to doc/C-Test-Network-API.asciidoc
diff --git a/doc/kvm-test-api.txt b/doc/KVM-Test-API.asciidoc
similarity index 100%
rename from doc/kvm-test-api.txt
rename to doc/KVM-Test-API.asciidoc
diff --git a/doc/library-api-writing-guidelines.txt b/doc/LTP-Library-API-Writing-Guidelines.asciidoc
similarity index 100%
rename from doc/library-api-writing-guidelines.txt
rename to doc/LTP-Library-API-Writing-Guidelines.asciidoc
diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/Maintainer-Patch-Review-Checklist.asciidoc
similarity index 100%
rename from doc/maintainer-patch-review-checklist.txt
rename to doc/Maintainer-Patch-Review-Checklist.asciidoc
diff --git a/doc/shell-test-api.txt b/doc/Shell-Test-API.asciidoc
similarity index 100%
rename from doc/shell-test-api.txt
rename to doc/Shell-Test-API.asciidoc
diff --git a/doc/supported-kernel-libc-versions.txt b/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc
similarity index 100%
rename from doc/supported-kernel-libc-versions.txt
rename to doc/Supported-kernel,-libc,-toolchain-versions.asciidoc
diff --git a/doc/test-writing-guidelines.txt b/doc/Test-Writing-Guidelines.asciidoc
similarity index 100%
rename from doc/test-writing-guidelines.txt
rename to doc/Test-Writing-Guidelines.asciidoc
diff --git a/doc/user-guide.txt b/doc/User-Guidelines.asciidoc
similarity index 100%
rename from doc/user-guide.txt
rename to doc/User-Guidelines.asciidoc
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
