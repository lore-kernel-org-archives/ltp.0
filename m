Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754A3EE49AE
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 09:34:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 550783CC5BB
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 11:34:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9646D3C98FC
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 11:34:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 140BA2010F3
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 11:34:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 08C6F206C4;
 Wed, 23 Aug 2023 09:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1692783250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=08q4gfS4/oQ3yY5LPeOlCSHbBWLdJTuFFqyciAlGCgA=;
 b=lDYMBXeIDl+tWPq5pAQ8Hj5jMFOLOiPBYUiz+5fVrUj2L5z7/XrT0b8wF84qs8+u8TEpEa
 SgAQJc1eWNW80frv6DXvstuBwcvx0EMK1FH8wMsO6Ca4hbaKobR3YQa31Cl3pMBiTbpkza
 HtxLVQm8vm9fGj4jEeGdEDaBBWokh2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1692783250;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=08q4gfS4/oQ3yY5LPeOlCSHbBWLdJTuFFqyciAlGCgA=;
 b=E3yuCYtLCs6Wg70VX+2epqQYrO5NeRVILYULXrOpH3E/kn0yuSjDFubXVKMW5XDaE0XZYR
 cVdKmd51zxkaWVBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E898F1351F;
 Wed, 23 Aug 2023 09:34:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Kh4bOJHS5WTTewAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 23 Aug 2023 09:34:09 +0000
Date: Wed, 23 Aug 2023 11:34:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZOXSs_mwxB_9kn23@yuki>
References: <1692768242-5649-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1692768242-5649-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/faccessat202: Add new testcase
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
I've added short descriptions to the testcase structure and pushed,
thanks.

Full diff:

diff --git a/testcases/kernel/syscalls/faccessat2/faccessat202.c b/testcases/kernel/syscalls/faccessat2/faccessat202.c
index e6cd1ec5e..a60db2bf8 100644
--- a/testcases/kernel/syscalls/faccessat2/faccessat202.c
+++ b/testcases/kernel/syscalls/faccessat2/faccessat202.c
@@ -46,13 +46,15 @@ static struct tcase {
        int mode;
        int flags;
        int exp_errno;
+       const char *desc;
 } tcases[] = {
-       {&atcwd_fd, &bad_path, R_OK, 0, EFAULT},
-       {&atcwd_fd, &rel_path, R_OK, -1, EINVAL},
-       {&atcwd_fd, &rel_path, -1, 0, EINVAL},
-       {&bad_fd, &rel_path, R_OK, 0, EBADF},
-       {&fd, &rel_path, R_OK, 0, ENOTDIR},
-       {&atcwd_fd, &rel_path, R_OK, AT_EACCESS, EACCES},
+       {&atcwd_fd, &bad_path, R_OK, 0, EFAULT, "invalid address"},
+       {&atcwd_fd, &rel_path, R_OK, -1, EINVAL, "invalid flags"},
+       {&atcwd_fd, &rel_path, -1, 0, EINVAL, "invalid mode"},
+       {&bad_fd, &rel_path, R_OK, 0, EBADF, "invalid fd"},
+       {&fd, &rel_path, R_OK, 0, ENOTDIR, "fd pointing to file"},
+       {&atcwd_fd, &rel_path, R_OK, AT_EACCESS, EACCES,
+         "AT_EACCESS and unprivileged EUID"},
 };

 static void verify_faccessat2(unsigned int i)
@@ -63,7 +65,7 @@ static void verify_faccessat2(unsigned int i)
                SAFE_SETEUID(ltpuser->pw_uid);

        TST_EXP_FAIL(faccessat2(*tc->fd, *tc->filename, tc->mode, tc->flags),
-                    tc->exp_errno, "faccessat2()");
+                    tc->exp_errno, "faccessat2() with %s", tc->desc);

        if (tc->exp_errno == EACCES)
                SAFE_SETEUID(0);

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
