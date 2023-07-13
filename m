Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262CFC001DC
	for <ltp@archiver.kernel.org>; Thu, 13 Jul 2023 11:58:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B47363CECEA
	for <ltp@archiver.kernel.org>; Thu, 13 Jul 2023 13:58:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7DB33C999C
 for <ltp@lists.linux.it>; Thu, 13 Jul 2023 13:57:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E6A1B1A00A27
 for <ltp@lists.linux.it>; Thu, 13 Jul 2023 13:57:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9C2DA1FD97;
 Thu, 13 Jul 2023 11:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689249470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wdOqf7IQZdLvimS2bJs5plkO3Xc3FjuLsO5M1bAA5jk=;
 b=AA5RmUijvkVXWUpeDBla2kXXE1h71U2LV2IhU9uVCrimg19OyH/HePuz0xYxfym5ncrzwg
 au+OhsZT22eErTCRm1OB6FXYoxsJqFAH69PqXZ1YbvPB9B48V/cbXckbC05sj/NX1KL6hS
 j23fYCiMK/jqbpksPfkPh9kN6S9vBQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689249470;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wdOqf7IQZdLvimS2bJs5plkO3Xc3FjuLsO5M1bAA5jk=;
 b=Xhbf3zsHyDicfCc83pXeNxZFXm3toReOOejz2pNmGgSqzPNUly3/LbmffcsjmvxwKmnJJi
 sUTQqmQ5JgdyXYAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86F1F133D6;
 Thu, 13 Jul 2023 11:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iaw3H77mr2Q+HAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 13 Jul 2023 11:57:50 +0000
Date: Thu, 13 Jul 2023 13:58:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZK_m_8OuewzitKmH@yuki>
References: <20230704091933.496989-1-pvorel@suse.cz>
 <20230704091933.496989-2-pvorel@suse.cz>
 <20230704092536.GA497945@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230704092536.GA497945@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/3] Makefile: Add C header with generated LTP
 version
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> obviously this is wrong, because $(top_srcdir)/Version (ltp-version.h
> dependency) is not specified in the top level Makefile (only Version is
> there). But I'm not sure if it should be changed to
> $(top_srcdir)/Version.
> 
> I suppose ltp-version.h should be in include/

Not reall, as long as it's used only in the library it can stay in the
lib/

> , but here I'm completely lost with dependencies under lib/. My goal
> is to type make in lib/ and make sure the header is generated
> (dependencies correctly resolved).

There is another problem as well, currently the Version file is
generated at the end of the LTP build, that means if you do a git pull
and make it's not updated until the build has finished.

Also we will have to rebuild tst_test.c each time Version file has been
rewritten, which actually happens each time make is build in the top
level directory, which would cause useless rebuilds.

The best I could came up with:

---
 lib/.gitignore     |  2 ++
 lib/Makefile       | 13 +++++++++++++
 lib/gen_version.sh | 16 ++++++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 lib/.gitignore
 create mode 100755 lib/gen_version.sh

diff --git a/lib/.gitignore b/lib/.gitignore
new file mode 100644
index 000000000..178867a94
--- /dev/null
+++ b/lib/.gitignore
@@ -0,0 +1,2 @@
+ltp-version.h
+cached-version
diff --git a/lib/Makefile b/lib/Makefile
index 9b9906f25..371119ede 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -20,6 +20,19 @@ pc_file			:= $(DESTDIR)/$(datarootdir)/pkgconfig/ltp.pc
 
 INSTALL_TARGETS		:= $(pc_file)
 
+tst_test.o: ltp-version.h
+
+ltp-version.h: gen_version
+
+MAKE_TARGETS+=gen_version
+
+.PHONY: gen_version
+gen_version:
+	@echo GEN ltp-version.h
+	@./gen_version.sh
+
+CLEAN_TARGETS+=ltp-version.h cached-version
+
 $(pc_file):
 	test -d "$(@D)" || mkdir -p "$(@D)"
 	install -m $(INSTALL_MODE) "$(builddir)/$(@F)" "$@"
diff --git a/lib/gen_version.sh b/lib/gen_version.sh
new file mode 100755
index 000000000..7ecfb9077
--- /dev/null
+++ b/lib/gen_version.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+touch cached-version;
+
+if git describe >/dev/null 2>&1; then
+	VERSION=`git describe`
+else
+	VERSION=`cat $(top_srcdir)/VERSION`
+fi
+
+CACHED_VERSION=`cat cached-version`
+
+if [ "$CACHED_VERSION" != "$VERSION" ]; then
+	echo "$VERSION" > cached-version
+	echo "#define LTP_VERSION \"$VERSION\"" > ltp-version.h
+fi

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
