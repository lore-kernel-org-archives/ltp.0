Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF341E82CD2
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 20:21:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E67203CE18C
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 22:21:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAE943CBA91
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 22:21:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 29E471A00E7F
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 22:21:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7C1DF1F38C;
 Wed, 27 Sep 2023 20:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695846085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5PTLAn4fW7dngDLi8DEO9UtdtLyLSLECyt9HmuNdFI=;
 b=vP7TLqm8S1fXllUA07nHb9wnQ+Z9GZ2SjSr8OvKEtmq59zC8+3HSQY0QeJuN7xW/KVKdeD
 T16u7lOFa+JrtCUSNSQL1PPUvjUN+S2Ons/GaR7xuYAcebHVqDcQPHgFv6kAxw9GCxEasQ
 vxAbbVcovG00HwLU5j8BIrveEPlOkaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695846085;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5PTLAn4fW7dngDLi8DEO9UtdtLyLSLECyt9HmuNdFI=;
 b=ujdutGQnNSgbQ1abYsYwgwraEfuvIcAHjmDRl2lT6lmw7W12nDhwslyTwwSWlPH2CVxQAu
 zPVogK9hfA5mWbCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2287513479;
 Wed, 27 Sep 2023 20:21:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eJH5BsWOFGWGewAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Sep 2023 20:21:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 27 Sep 2023 22:21:17 +0200
Message-Id: <20230927202121.300325-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927202121.300325-1-pvorel@suse.cz>
References: <20230927202121.300325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/6] tools: Add script for creating tarballs and
 metadata
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

A helper for new releases.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tools/create-tarballs-metadata.sh | 56 +++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100755 tools/create-tarballs-metadata.sh

diff --git a/tools/create-tarballs-metadata.sh b/tools/create-tarballs-metadata.sh
new file mode 100755
index 000000000..e7f93d5c0
--- /dev/null
+++ b/tools/create-tarballs-metadata.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+# Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
+# Create tarballs and metadata for uploading after tagging release.
+# https://github.com/linux-test-project/ltp/wiki/LTP-Release-Procedure
+set -e
+
+tag="$(date +%Y%m%d)"
+tarball_dir="ltp-full-$tag"
+extensions="bz2 xz"
+checksums="md5 sha1 sha256"
+git_dir=$(cd $(dirname "$0")/..; pwd)
+dir="$(cd $git_dir/../; pwd)/ltp-release-$tag"
+
+. $(dirname "$0")/lib.sh
+
+if [ -d $dir ]; then
+	ask "Directory '$dir' exists, will be deleted"
+	rm -rf $dir
+fi
+rod mkdir $dir
+cd $dir
+dir=$PWD
+
+# git clone (local)
+title "git clone"
+rod git clone $git_dir $tarball_dir
+rod cd $tarball_dir
+
+title "Update submodules"
+rod git submodule update --init
+
+title "Generate configure script"
+rod make autotools
+
+# tarballs, checksums
+title "Generate tarballs"
+cd ..
+rod tar --exclude .git -cjf $tarball_dir.tar.bz2 $tarball_dir
+rod tar --exclude .git -cJf $tarball_dir.tar.xz $tarball_dir
+
+title "Generate checksums"
+for alg in $checksums; do
+	for ext in $extensions; do
+		file="$tarball_dir.tar.$ext"
+		${alg}sum $file > "$file.$alg"
+	done
+done
+
+# metadata documentation
+title "Generate metadata documentation"
+cd $tarball_dir
+rod ./configure --with-metadata-generator=asciidoctor
+rod make -C metadata
+cp -v docparse/metadata.html $dir/metadata.$tag.html
+
+echo "Generated files are in '$dir', upload them to github"
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
