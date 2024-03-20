Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF525C54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 16:23:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08A733CFFAE
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 17:23:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D6893CFFAB
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:20:49 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DB183603444
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:20:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A8D05BF32;
 Wed, 20 Mar 2024 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710951646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YK73hyvxct1uMvD/mlxFC663Km8nPvLrosnHMOrS1ZY=;
 b=Hxi7Bj7PGNkeJze4uIYevWzvEbQJXW/a1JOvyKptnDXvcLx7SmVRQIoZ9JGnxpVP68MaPH
 rB4pw5K8ky8JciCmYmSHXNL1bGroXc2zIUaW/4hHlMSavNv49du9JAlRBmuYbQPOO59tVt
 LGh149GFxVoxT4eUtoL6AeVb2AhVC4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710951646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YK73hyvxct1uMvD/mlxFC663Km8nPvLrosnHMOrS1ZY=;
 b=g3gaZ3imL4b0iNo1LW7foC3lfnWGaH1n0P//HqyoanBbywMJ3/qzevukdC5cdLi+j+hweq
 zoyEQXSXs7dBO0Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710951646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YK73hyvxct1uMvD/mlxFC663Km8nPvLrosnHMOrS1ZY=;
 b=Hxi7Bj7PGNkeJze4uIYevWzvEbQJXW/a1JOvyKptnDXvcLx7SmVRQIoZ9JGnxpVP68MaPH
 rB4pw5K8ky8JciCmYmSHXNL1bGroXc2zIUaW/4hHlMSavNv49du9JAlRBmuYbQPOO59tVt
 LGh149GFxVoxT4eUtoL6AeVb2AhVC4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710951646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YK73hyvxct1uMvD/mlxFC663Km8nPvLrosnHMOrS1ZY=;
 b=g3gaZ3imL4b0iNo1LW7foC3lfnWGaH1n0P//HqyoanBbywMJ3/qzevukdC5cdLi+j+hweq
 zoyEQXSXs7dBO0Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 846EB13974;
 Wed, 20 Mar 2024 16:20:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wAYQH94M+2U/ZgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 20 Mar 2024 16:20:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 20 Mar 2024 17:20:49 +0100
MIME-Version: 1.0
Message-Id: <20240320-new_website-v1-5-79b603c8aea1@suse.com>
References: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
In-Reply-To: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Hxi7Bj7P;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=g3gaZ3im
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[sourceware.org:url,suse.com:email,suse.de:dkim,linux.it:url,linux-foundation.org:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 9A8D05BF32
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 05/10] Refactor LTP release procedure documentation
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

The LTP release procedure documentation has been rewritten using the RST
format and some typo errors have been fixed.
---
 doc_new/maintainers/ltp_release_procedure.rst | 169 ++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/doc_new/maintainers/ltp_release_procedure.rst b/doc_new/maintainers/ltp_release_procedure.rst
index 808ff2211..f0bc01cee 100644
--- a/doc_new/maintainers/ltp_release_procedure.rst
+++ b/doc_new/maintainers/ltp_release_procedure.rst
@@ -2,3 +2,172 @@
 
 Release process
 ===============
+
+Preparations
+------------
+
+The release procedure generally takes a few weeks. In the first week or two,
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
+
+Prepare the release notes
+-------------------------
+
+Part of the preparation is also to write the release notes, which are then
+added to the GitHub release and also sent as announcement to various mailing
+lists (see below).
+
+Have a look at `this release letter <https://lore.kernel.org/ltp/ZGNiQ1sMGvPU_ETp@yuki/>`_
+to get the idea how it should look.
+
+Tag the git and push changes to github
+--------------------------------------
+
+.. code-block:: bash
+
+    cd ltp
+    echo YYYYMMDD > VERSION
+    git commit -S -s -m 'LTP YYYYMMDD' VERSION
+    git tag -s -a YYYYMMDD -m 'LTP YYYYMMDD'
+    git push origin master:master
+    git push origin YYYYMMDD
+
+The string ``YYYYMMDD`` should be substituted to the current date.
+
+You can use `tools/tag-release.sh <https://github.com/linux-test-project/ltp/blob/master/tools/tag-release.sh>`_
+script to have the above automated process.
+It allows you to verify the tag before pushing it and does other checks.
+
+.. code-block:: bash
+
+    $ ./tools/tag-release.sh
+    ===== git push =====
+    new tag: 'YYYYMMDD', previous tag: '20230127'
+    tag YYYYMMDD
+    Tagger: Person-who-released LTP <foo@example.com>
+    Date:   ...
+
+    LTP YYYYMMDD
+    -----BEGIN PGP SIGNATURE-----
+    ...
+    -----END PGP SIGNATURE-----
+
+    commit 3ebc2dfa85c2445bb68d8c0d66e33c4da1e1b3a7
+    gpg:                using RSA key ...
+    ...
+    Primary key fingerprint: ...
+    Author: Person-who-released LTP <foo@example.com>
+    Date:   ...
+
+        LTP YYYYMMDD
+
+        Signed-off-by: Person-who-released LTP <foo@example.com>
+
+    diff --git a/VERSION b/VERSION
+    index af4c41fec..ae488c0e7 100644
+    --- a/VERSION
+    +++ b/VERSION
+    @@ -1 +1 @@
+    -20230127
+    +YYYYMMDD
+
+    Please check tag and signature. Proceed? [N/y]: y
+    Pushing changes to upstream git. Proceed? [N/y]: y
+    ...
+    To github.com:linux-test-project/ltp.git
+     * [new tag]             YYYYMMDD -> YYYYMMDD
+
+Prepare tarballs and metadata documentation
+-------------------------------------------
+
+The following procedure will show how to create the release archives and the
+metadata documentation:
+
+.. code-block:: bash
+
+    # clone already clonned git repository to new folder
+    cd ..
+    git clone ltp ltp-full-YYYYMMDD
+    cd ltp-full-YYYYMMDD
+
+    # update all submodules
+    git submodule update --init
+
+    # Generate configure script
+    make autotools
+
+    # Generate tarballs
+    cd ..
+    tar -cjf ltp-full-YYYYMMDD.tar.bz2 ltp-full-YYYYMMDD --exclude .git
+    tar -cJf ltp-full-YYYYMMDD.tar.xz ltp-full-YYYYMMDD --exclude .git
+
+    # Generate checksums
+    md5 ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.md5
+    sha1 ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.sha1
+    sha256sum ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.sha256
+
+    # Generate metadata documentation
+    ./configure --with-metadata-generator=asciidoctor
+    make -C metadata
+    cp -v docparse/metadata.html ../metadata.YYYYMMDD.html
+
+You can use `tools/create-tarballs-metadata.sh <https://github.com/linux-test-project/ltp/blob/master/tools/create-tarballs-metadata.sh>`_
+script to have the above procedure automated. All generated files are placed
+in the ``ltp-release-YYYYMMDD`` directory.
+
+.. code-block:: bash
+
+    $ ./tools/create-tarballs-metadata.sh
+    ===== git clone =====
+    Cloning into 'ltp-full-YYYYMMDD'...
+    done.
+    ===== Update submodules =====
+    Submodule 'tools/kirk' (https://github.com/linux-test-project/kirk.git) registered for path 'tools/kirk'
+    ...
+    ===== Generate configure script =====
+    sed -n '1{s:LTP-:m4_define([LTP_VERSION],[:;s:$:]):;p;q}' VERSION > m4/ltp-version.m4
+    aclocal -I m4
+    ...
+    ===== Generate tarballs =====
+    ===== Generate checksums =====
+    ===== Generate metadata documentation =====
+    checking for a BSD-compatible install... /usr/bin/install -c
+    ...
+    'docparse/metadata.html' -> '/home/foo/ltp-release-YYYYMMDD/metadata.YYYYMMDD.html'
+    Generated files are in '/home/foo/ltp-release-YYYYMMDD', upload them to github
+
+Upload the generated files to GitHub
+------------------------------------
+
+Click on `Releases <https://github.com/linux-test-project/ltp/releases>`_, then
+switch to `Tags <https://github.com/linux-test-project/ltp/tags>`_. Click on
+'Add release notes'.  There should be 'Attach binaries ...' link at the
+bottom of the page.
+
+Don't forget to upload checksums for the tarballs and metadata documentation
+as well.
+
+Send release announcement
+-------------------------
+
+The announcement is sent to:
+
+* ltp at lists.linux.it
+* linux-kernel at vger.kernel.org
+* libc-alpha at sourceware.org
+
+CCed to:
+
+* lwn at lwn.net
+* akpm at linux-foundation.org
+* torvalds at linux-foundation.org

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
