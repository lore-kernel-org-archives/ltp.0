Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE441E82CD1
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 20:22:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 722103CDD57
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 22:22:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 713C43CDC79
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 22:21:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7862460047F
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 22:21:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 04A8F1F894;
 Wed, 27 Sep 2023 20:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695846087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZt4hdxWenoDJH4FOkFxxjePEO37crMvA9BuW7JMwCs=;
 b=04K+1jHrGvNQzrP+QunlTvHuSzrm14XR9nX1lCHWzJlasKL8vzXFdP4P49O0he4UK/5mED
 9Oj7PnW6HfkEGeJTK2QKDOfx8AU5B+P1u81TYxxMsrsaAKt7anpF+NBIYzbdcxcBw24v+0
 gggiOI1ofXnN8SMTnYEmSXV/XwL0bgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695846087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZt4hdxWenoDJH4FOkFxxjePEO37crMvA9BuW7JMwCs=;
 b=SiA8P+KVu4HHJXmSFT9oFRXFA9vWde0bHMoEicstyvSnhmTdJZn+cpwjWS+/U4fYrpn3SW
 LV8qziCWJ5wMKxBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D68A13479;
 Wed, 27 Sep 2023 20:21:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gE/hHMaOFGWGewAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Sep 2023 20:21:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 27 Sep 2023 22:21:20 +0200
Message-Id: <20230927202121.300325-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927202121.300325-1-pvorel@suse.cz>
References: <20230927202121.300325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/6] doc: Update release procedure
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

* Completely rewrite Release preparation (Cyril).
* Update command examples.
* Document helper scripts.
* Update link to the release announcement.

Co-developed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
"LTP Release Procedure" wiki page is (temporarily) visible on:
https://github.com/pevik/ltp/wiki/TEST

 doc/LTP-Release-Procedure.asciidoc | 160 +++++++++++++++++++++++++----
 1 file changed, 138 insertions(+), 22 deletions(-)

diff --git a/doc/LTP-Release-Procedure.asciidoc b/doc/LTP-Release-Procedure.asciidoc
index cd7682fb8..101a1b8cb 100644
--- a/doc/LTP-Release-Procedure.asciidoc
+++ b/doc/LTP-Release-Procedure.asciidoc
@@ -1,59 +1,175 @@
 LTP Release Procedure
 =====================
 
-This page contains quick summary of what needs to be done to do a LTP release. It's expected that LTP git is frozen and git HEAD was properly tested and that LTP git tree is cloned to a directory named 'ltp'.
+1. Release preparations
+-----------------------
+
+The release procedure generally takes a few weeks. In the first week or two
+patches that should go into the release are reviewed and possibly merged. These
+patches are either fixes or patches pointed out by the community.
+
+Patch review, when finished, is followed by a git freeze, which is a period
+where only fixes are pushed to the git. During that period community is
+expected to run a LTP pre-release tests, reports problems, and/or send fixes to
+the mailing list. In this period we are especially making sure that there are
+no regressions in the test results on a wide range of distributions and
+architectures.
+
+Once the stabilization period has ended the time has finally come to proceed
+with the release.
 
 NOTE: The string YYYYMMDD should be substituted to the current date.
 
-1. Tag the git
---------------
+2. Prepare the release notes
+----------------------------
+
+Part of the preparation is also to write the release notes, which are then add
+to GitHub release and also send as announcement to various mailing list (see below).
+
+Have a look at https://lore.kernel.org/ltp/ZGNiQ1sMGvPU_ETp@yuki/ to get the
+idea how it should look.
+
+3. Tag the git and push changes to github
+-----------------------------------------
 
 [source,sh]
 --------------------------------------------------------------------
 cd ltp
 echo YYYYMMDD > VERSION
-git commit -s -m 'LTP YYYYMMDD' VERSION
-git tag -a YYYYMMDD -m 'LTP YYYYMMDD'
+git commit -S -s -m 'LTP YYYYMMDD' VERSION
+git tag -s -a YYYYMMDD -m 'LTP YYYYMMDD'
+git push origin master:master
+git push origin YYYYMMDD
 --------------------------------------------------------------------
 
-2. Push changes to github
--------------------------
+NOTE: You can use './tools/tag-release.sh' script to have the above automated.
+      It allows you to verify the tag before pushing it and does other checks.
+
 [source,sh]
 --------------------------------------------------------------------
-git push
-git push --tags
+$ ./tools/tag-release.sh
+===== git push =====
+echo "new tag: 'YYYYMMDD', previous tag: '20230127'"
+tag YYYYMMDD
+Tagger: Person-who-released LTP <foo@example.com>
+Date:   Tue May 16 07:08:27 2023 +0200
+
+LTP YYYYMMDD
+-----BEGIN PGP SIGNATURE-----
+
+iQJDBAABCAAtFiEEIBb+pIWLHDazLoM6wN7C7nLzOl8FAmRjD8sPHHB2b3JlbEBz
+...
+-----END PGP SIGNATURE-----
+
+commit 3ebc2dfa85c2445bb68d8c0d66e33c4da1e1b3a7
+gpg: Signature made Tue 16 May 2023 07:08:08 AM CEST
+gpg:                using RSA key 2016FEA4858B1C36B32E833AC0DEC2EE72F33A5F
+...
+Primary key fingerprint: 2016 FEA4 858B 1C36 B32E  833A C0DE C2EE 72F3 3A5F
+Author: Person-who-released LTP <foo@example.com>
+Date:   Tue May 16 07:08:08 2023 +0200
+
+    LTP YYYYMMDD
+
+    Signed-off-by: Person-who-released LTP <foo@example.com>
+
+diff --git a/VERSION b/VERSION
+index af4c41fec..ae488c0e7 100644
+--- a/VERSION
++++ b/VERSION
+@@ -1 +1 @@
+-20230127
++YYYYMMDD
+
+Please check tag and signature. Proceed? [N/y]: y
+Pushing changes to upstream git. Proceed? [N/y]: y
+Enumerating objects: 1, done.
+Counting objects: 100% (1/1), done.
+Writing objects: 100% (1/1), 811 bytes | 811.00 KiB/s, done.
+Total 1 (delta 0), reused 1 (delta 0), pack-reused 0
+To github.com:linux-test-project/ltp.git
+ * [new tag]             YYYYMMDD -> YYYYMMDD
 --------------------------------------------------------------------
 
-3. Prepare tarballs
--------------------
+4. Prepare tarballs and metadata documentation
+----------------------------------------------
+
 [source,sh]
 --------------------------------------------------------------------
+# clone already clonned git repository to new folder
 cd ..
 git clone ltp ltp-full-YYYYMMDD
 cd ltp-full-YYYYMMDD
-# Update mce-inject submodule
-git submodule init
-git submodule update
+
+# update all submodules
+git submodule update --init
+
 # Generate configure script
 make autotools
-# Prepare the archives
+
+# Generate tarballs
 cd ..
 tar -cjf ltp-full-YYYYMMDD.tar.bz2 ltp-full-YYYYMMDD --exclude .git
 tar -cJf ltp-full-YYYYMMDD.tar.xz ltp-full-YYYYMMDD --exclude .git
+
+# Generate checksums
+md5 ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.md5
+sha1 ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.sha1
+sha256sum ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.sha256
+
+# Generate metadata documentation
+./configure --with-metadata-generator=asciidoctor
+make -C metadata
+cp -v docparse/metadata.html ../metadata.YYYYMMDD.html
 --------------------------------------------------------------------
 
-4. Upload the tarballs to GitHub
---------------------------------
+NOTE: You can use './tools/create-tarballs-metadata.sh' script to have the
+	  above automated. All generated files are placed in ltp-release-YYYYMMDD
+	  directory.
 
-Click on 'releases' then switch to 'tags' then click on 'Add release notes' there should be 'Attach binaries ...' link at the bottom of the page.
+[source,sh]
+--------------------------------------------------------------------
+$ ./tools/create-tarballs-metadata.sh
+===== git clone =====
+Cloning into 'ltp-full-YYYYMMDD'...
+done.
+===== Update submodules =====
+Submodule 'tools/kirk' (https://github.com/linux-test-project/kirk.git) registered for path 'tools/kirk'
+Submodule 'tools/ltx/ltx-src' (https://github.com/linux-test-project/ltx.git) registered for path 'tools/ltx/ltx-src'
+Submodule 'tools/sparse/sparse-src' (git://git.kernel.org/pub/scm/devel/sparse/sparse.git) registered for path 'tools/sparse/sparse-src'
+...
+===== Generate configure script =====
+sed -n '1{s:LTP-:m4_define([LTP_VERSION],[:;s:$:]):;p;q}' VERSION > m4/ltp-version.m4
+aclocal -I m4
+autoconf
+autoheader
+automake -c -a
+configure.ac:21: installing './compile'
+...
+make[1]: Leaving directory '/home/foo/ltp-release-YYYYMMDD/ltp-full-YYYYMMDD/testcases/open_posix_testsuite'
+===== Generate tarballs =====
+===== Generate checksums =====
+===== Generate metadata documentation =====
+checking for a BSD-compatible install... /usr/bin/install -c
+...
+asciidoctor -d book metadata.txt -b xhtml
+make[1]: Leaving directory '/home/foo/ltp-release-YYYYMMDD/ltp-full-YYYYMMDD/docparse'
+make: Leaving directory '/home/foo/ltp-release-YYYYMMDD/ltp-full-YYYYMMDD/metadata'
+'docparse/metadata.html' -> '/home/foo/ltp-release-YYYYMMDD/metadata.YYYYMMDD.html'
+Generated files are in '/home/foo/ltp-release-YYYYMMDD', upload them to github
+--------------------------------------------------------------------
 
-Don't forget to upload md5 and sha-1 sums for the tarballs as well.
+5. Upload the generated files to GitHub
+---------------------------------------
+
+Click on 'releases' then switch to 'tags', then click on 'Add release notes'.
+There should be 'Attach binaries ...' link at the bottom of the page.
+
+Don't forget to upload checksums for the tarballs and metadata documentation as well.
 
 5. Send release announcement
 ----------------------------
 
-Have a look at http://sourceforge.net/p/ltp/mailman/message/34429656/ to get the idea how it should look.
-
 The announcement is send to:
 
 * ltp at lists.linux.it
@@ -64,4 +180,4 @@ CCed to:
 
 * lwn at lwn.net
 * akpm at linux-foundation.org
-* torvalds at linux-foundation.org.
\ No newline at end of file
+* torvalds at linux-foundation.org.
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
