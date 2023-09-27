Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE307E82CD1
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 20:22:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF5C73CDC70
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 22:22:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 305293CBA91
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 22:21:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E60091400BDD
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 22:21:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7368A1F891;
 Wed, 27 Sep 2023 20:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695846086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gS2WKQwJZLmsZsa2+oX5QLx/ny8DNhL88Dn9i3Gif4E=;
 b=hZo1ZF3bJ4B+IbRyuNB+IU4FFzh5hGHjtOVWx89O0liLd5KilD2hoqFi5Rt6X/2vLKlHyz
 3cHMsL7lcTb2Tu+Os5bS5nITa/Dq4QL/aoSbIF1Ay7CRKGddPl5kawaUVdv4J29w0ZedMs
 dcDDGpzesXKqS87wyUAKHT63M2FHYOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695846086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gS2WKQwJZLmsZsa2+oX5QLx/ny8DNhL88Dn9i3Gif4E=;
 b=b6Frz2xDqcxjUtFcDhlyYqSC9KjcAttBB3aE0WXdZKzSWAGycAGaGXKv5MKyCCEFNDMsh5
 O18vdNWvngl1h7CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1181013479;
 Wed, 27 Sep 2023 20:21:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4HMnAsaOFGWGewAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Sep 2023 20:21:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 27 Sep 2023 22:21:19 +0200
Message-Id: <20230927202121.300325-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927202121.300325-1-pvorel@suse.cz>
References: <20230927202121.300325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/6] doc: Add Release procedure
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

This slightly outdated document exists in LTP wiki, start versioning it
in the original repository. The only unversioned file in the wiki is
now Home.rest.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
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
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
