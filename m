Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDA0C76195
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 11:14:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED10C3CCB2E
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 13:14:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D4643CCB2B
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 13:13:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1AFD6200AE5
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 13:13:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30E34219BC;
 Tue, 28 Mar 2023 11:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680002036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hEhaBlrdDvjb45MeRKmyJd0osfX7BwCOi1yyw1fJi4A=;
 b=lyAzRqsHtUxs9pBpwN4oJptzCVUauJe0tSedXEjDga4QjaIWOTRbpnUTmvB0w9ScK16QLy
 o3afJhleJdMts0Rbzz+OplrvN9+f3Wo1hYRWI4VCuUyHuS1vh/FjFDlDB95K0g9OMOudSw
 N5fAR2O7LQ5JIpJ9IWLlPwLw9BuGdM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680002036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hEhaBlrdDvjb45MeRKmyJd0osfX7BwCOi1yyw1fJi4A=;
 b=S5HXM4D9EV2hOx9vgDgNd9qG2XAYrMPIuPU8DYb/zkTo2OvVKO9E1E4aE/ifTH7iTmFMps
 yhAn6z0gPuhAl2Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1F671390B;
 Tue, 28 Mar 2023 11:13:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AKYMKvPLImR9CAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 28 Mar 2023 11:13:55 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 Mar 2023 13:13:38 +0200
Message-Id: <20230328111338.766712-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230328111338.766712-1-pvorel@suse.cz>
References: <20230328111338.766712-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 2/2] doc: Add Release procedure
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

This slightly outdated document exists in LTP wiki, start versioning it
in the original repository. The only unversioned file in the wiki is
now Home.rest.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
This should be updated, so I'm ok not to merge it and prepare more up to
date version (although I'd need Cyril's help).

Also (separate effort), there is unversioned script, which could be
added to git. And we could remove Makefile.release, which IMHO is not
used (although it solves dependency: running autotools and distclean;
maybe we could combine both: Add script and add make target which would
run the script after solving the dependencies).

Kind regards,
Petr

 doc/LTP-Release-Procedure.asciidoc | 67 ++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 doc/LTP-Release-Procedure.asciidoc

diff --git a/doc/LTP-Release-Procedure.asciidoc b/doc/LTP-Release-Procedure.asciidoc
new file mode 100644
index 000000000..cd7682fb8
--- /dev/null
+++ b/doc/LTP-Release-Procedure.asciidoc
@@ -0,0 +1,67 @@
+LTP Release Procedure
+=====================
+
+This page contains quick summary of what needs to be done to do a LTP release. It's expected that LTP git is frozen and git HEAD was properly tested and that LTP git tree is cloned to a directory named 'ltp'.
+
+NOTE: The string YYYYMMDD should be substituted to the current date.
+
+1. Tag the git
+--------------
+
+[source,sh]
+--------------------------------------------------------------------
+cd ltp
+echo YYYYMMDD > VERSION
+git commit -s -m 'LTP YYYYMMDD' VERSION
+git tag -a YYYYMMDD -m 'LTP YYYYMMDD'
+--------------------------------------------------------------------
+
+2. Push changes to github
+-------------------------
+[source,sh]
+--------------------------------------------------------------------
+git push
+git push --tags
+--------------------------------------------------------------------
+
+3. Prepare tarballs
+-------------------
+[source,sh]
+--------------------------------------------------------------------
+cd ..
+git clone ltp ltp-full-YYYYMMDD
+cd ltp-full-YYYYMMDD
+# Update mce-inject submodule
+git submodule init
+git submodule update
+# Generate configure script
+make autotools
+# Prepare the archives
+cd ..
+tar -cjf ltp-full-YYYYMMDD.tar.bz2 ltp-full-YYYYMMDD --exclude .git
+tar -cJf ltp-full-YYYYMMDD.tar.xz ltp-full-YYYYMMDD --exclude .git
+--------------------------------------------------------------------
+
+4. Upload the tarballs to GitHub
+--------------------------------
+
+Click on 'releases' then switch to 'tags' then click on 'Add release notes' there should be 'Attach binaries ...' link at the bottom of the page.
+
+Don't forget to upload md5 and sha-1 sums for the tarballs as well.
+
+5. Send release announcement
+----------------------------
+
+Have a look at http://sourceforge.net/p/ltp/mailman/message/34429656/ to get the idea how it should look.
+
+The announcement is send to:
+
+* ltp at lists.linux.it
+* linux-kernel at vger.kernel.org
+* libc-alpha at sourceware.org
+
+CCed to:
+
+* lwn at lwn.net
+* akpm at linux-foundation.org
+* torvalds at linux-foundation.org.
\ No newline at end of file
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
