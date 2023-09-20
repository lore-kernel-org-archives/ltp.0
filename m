Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298EDCE79AD
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 09:53:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F9173CE3DC
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 11:53:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9AF23CDEB9
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 11:53:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6005721E106
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 11:53:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 73E1B220E7;
 Wed, 20 Sep 2023 09:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695203602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WhlGV6TuuVQcMt1cXzh7Ia303BmPPLqBp6/YFtrjTrY=;
 b=C0aCi0OGl7VmmMwhRwNhqgZigqzSoRNKyUTAIo6zRIeJ0p/uG5IIM+QGnvYBNVbVdyi/j/
 5khAVQZi2MibyEZlFMLdGEQT5nK60flvxP4F3eim+o9Bhj2tLRtr6GHfUtkgJQbaKjo3OD
 ynaSgQE+qsUw0Y3Zz4MApgvxTYMM9SU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695203602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WhlGV6TuuVQcMt1cXzh7Ia303BmPPLqBp6/YFtrjTrY=;
 b=PL5JYNoZ9dlvmTlOxOolT/g5QBqdl8Wfj58vMyueiiGQ7JjmX7+cZunoKCx2TlfzhI7GGj
 LbiG7XcaPLGP+MAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34E991333E;
 Wed, 20 Sep 2023 09:53:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eJOxCxLBCmVpBQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 20 Sep 2023 09:53:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 20 Sep 2023 11:53:15 +0200
Message-Id: <20230920095318.340582-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230920095318.340582-1-pvorel@suse.cz>
References: <20230920095318.340582-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] tools: Add script for creating tarballs and
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Xiao Yang <yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

A helper for new releases.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tools/create-tarballs-metadata.sh | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 tools/create-tarballs-metadata.sh

diff --git a/tools/create-tarballs-metadata.sh b/tools/create-tarballs-metadata.sh
new file mode 100755
index 000000000..4736c9d36
--- /dev/null
+++ b/tools/create-tarballs-metadata.sh
@@ -0,0 +1,52 @@
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
+rod git submodule update --init
+rod make autotools
+
+# tarballs, checksums
+title "Creating tarballs"
+cd ..
+rod tar --exclude .git -cjf $tarball_dir.tar.bz2 $tarball_dir
+rod tar --exclude .git -cJf $tarball_dir.tar.xz $tarball_dir
+
+title "Creating checksums"
+for alg in $checksums; do
+	for ext in $extensions; do
+		file="$tarball_dir.tar.$ext"
+		${alg}sum $file > "$file.$alg"
+	done
+done
+
+# metadata documentation
+title "Creating metadata documentation"
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
