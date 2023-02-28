Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FD2C64EC7
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 09:38:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA91A3CCE34
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 10:38:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B1483C01AA
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 10:38:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 644B8200345
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 10:38:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F4591FDC1;
 Tue, 28 Feb 2023 09:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1677577110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TQAO7mk54EiS2fj5nAtSI17HMB+8DqJ7ai1ZuNheGI4=;
 b=xLkYnJDaFajZyg4fFzjPif/vfmftWDtgYMkLrSFsLdTK36L4vCAthpeFX1drEjjaKFEXzI
 Msia0aVyKFR+RDtWAyLXPyO6WQj0VT/WA1giqmKQyMvdnSbRq6zG4hRLviswQWGZwAjRxe
 Tgq0U6GxUpYFUPIeoSvOrnZyISvFBdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1677577110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TQAO7mk54EiS2fj5nAtSI17HMB+8DqJ7ai1ZuNheGI4=;
 b=/yQnJv5ZJOKheR8FksR3jU+DhPb3xkFWTT3v1erltVoALedY2S0CIcn919P7MRkbgkKDhP
 F7lr0u1k7RL9Y/Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D5171333C;
 Tue, 28 Feb 2023 09:38:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id z8AZCpbL/WN0OQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 28 Feb 2023 09:38:30 +0000
Date: Tue, 28 Feb 2023 10:39:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Y/3L6GjSfRHT7+ir@yuki>
References: <1677573864-5319-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <13c9ecd8-48d7-dccc-a3b7-ec934e2f1369@suse.com>
 <f80d0b90-f7c7-d979-9a97-22655f7ff1b2@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f80d0b90-f7c7-d979-9a97-22655f7ff1b2@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] containers/utsname04: don't use TST_EXP_EQ_LI for
 tst_clone
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
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Did you try this?
> > 
> > TST_EXP_FAIL(tst_clone(&cargs), EPERM);
> 
> I don't try this because I remembered TST_EXP_FAIL only thinks the 
> correct return value is -1.
> 
> tst_test.c:1560: TINFO: Timeout per run is 0h 00m 30s
> utsname04.c:27: TINFO: Dropping root privileges
> utsname04.c:33: TFAIL: tst_clone(&cargs) invalid retval -2: EPERM (1)

It's actually the tst_clone() that returns -2 if fallback to __NR_clone
failed.

@Ritchie Is there actually a good reason why tst_clone() returns -2 on a
         fialure? Can we fix the code by:

diff --git a/lib/tst_clone.c b/lib/tst_clone.c
index ecc84408c..bacd269d9 100644
--- a/lib/tst_clone.c
+++ b/lib/tst_clone.c
@@ -39,8 +39,5 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
        pid = syscall(__NR_clone, flags, NULL);
 #endif
 
-       if (pid == -1)
-               return -2;
-
        return pid;
 }


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
