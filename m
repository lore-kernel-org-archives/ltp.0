Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5FCEE4993
	for <ltp@archiver.kernel.org>; Tue, 22 Aug 2023 14:21:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03DD53CC732
	for <ltp@archiver.kernel.org>; Tue, 22 Aug 2023 16:21:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BBA83C8AC4
 for <ltp@lists.linux.it>; Tue, 22 Aug 2023 16:21:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D93546002C8
 for <ltp@lists.linux.it>; Tue, 22 Aug 2023 16:21:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E3B01F85D;
 Tue, 22 Aug 2023 14:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1692714088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MuKvReGJ6zitXcvA2a0CigJ2ioBo79MOET0I8RCh5W0=;
 b=MOQ+fpTGvlK3MtEG+O7SftkXFe6SKdqUCGEw/qRn0pFGdwzkTcX/XRUEerIOZFYPIJ4Te7
 +fRjWfjFyWmDzFfQwVNFvbV9DrLb0o0FnFRTLmCUgGA8IOuRJeu7oPLnwxzdaZywUo+Hlp
 ExspX+fTNTzY3MkGYNYZB0HhjUJO1tU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1692714088;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MuKvReGJ6zitXcvA2a0CigJ2ioBo79MOET0I8RCh5W0=;
 b=8OUmCvScqnWR69LzdXj7HhBezm+gJVvpE7vCV6DQBUA15vTby08Uy+2kwf8fpcZKNFhZVW
 Qpco3844HOuWKxCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D327D13919;
 Tue, 22 Aug 2023 14:21:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VlKkMmfE5GT7HQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 22 Aug 2023 14:21:27 +0000
Date: Tue, 22 Aug 2023 16:22:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZOTEiWZFdo3Kkhzs@yuki>
References: <1692700900-13521-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1692700900-13521-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] syscalls/faccessat201: Add new testcase
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
Pushed with minor changes, thanks.

- we have to include config.h in the lapi/faccessat.h so that we get
  eventually get the macro HAVE_FACCESSAT2 definition (if defined)

- the directory in the test temporary directory must be 0777 otherwise
  the test will fail with EACCESS when executed as non-root

- the abs_path is initialized in the test setup dynamically, it
  shouldn't be initialized in the .bufs structure

Full diff:

diff --git a/include/lapi/faccessat.h b/include/lapi/faccessat.h
index 5b42014d2..05997d975 100644
--- a/include/lapi/faccessat.h
+++ b/include/lapi/faccessat.h
@@ -9,6 +9,7 @@
 #define FACCESSAT2_H

 #include "tst_test.h"
+#include "config.h"
 #include "lapi/syscalls.h"

 #ifndef HAVE_FACCESSAT2
diff --git a/testcases/kernel/syscalls/faccessat2/faccessat201.c b/testcases/kernel/syscalls/faccessat2/faccessat201.c
index 88ee21522..012091752 100644
--- a/testcases/kernel/syscalls/faccessat2/faccessat201.c
+++ b/testcases/kernel/syscalls/faccessat2/faccessat201.c
@@ -61,7 +61,7 @@ static void setup(void)
        abs_path = tst_aprintf("%s/%s", tmpdir_path, RELPATH);
        free(tmpdir_path);

-       SAFE_MKDIR(TESTDIR, 0666);
+       SAFE_MKDIR(TESTDIR, 0777);
        dir_fd = SAFE_OPEN(TESTDIR, O_DIRECTORY);
        SAFE_TOUCH(abs_path, 0444, NULL);
        SAFE_SYMLINK(abs_path, TESTSYMLINK);
@@ -80,7 +80,6 @@ static struct tst_test test = {
        .cleanup = cleanup,
        .bufs = (struct tst_buffers []) {
                {&testfile, .str = TESTFILE},
-               {&abs_path, .size = sizeof(char)},
                {&rel_path, .str = RELPATH},
                {&sym_path, .str = TESTSYMLINK},
                {},


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
