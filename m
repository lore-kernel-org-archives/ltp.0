Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FFDC61DA4
	for <ltp@archiver.kernel.org>; Fri, 24 Feb 2023 15:02:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9ECE3CBB6B
	for <ltp@archiver.kernel.org>; Fri, 24 Feb 2023 16:02:23 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0735C3CB05A
 for <ltp@lists.linux.it>; Fri, 24 Feb 2023 16:02:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 740D3200C99
 for <ltp@lists.linux.it>; Fri, 24 Feb 2023 16:02:12 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6BC7F38DA5;
 Fri, 24 Feb 2023 15:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1677250931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jet+701xYgvLczSxZgKpp3eOF/bRWV7Zc1+PF8rerlg=;
 b=qdpvaoZB8ZasL+h64TFqIDhkcCqYLfZE7yi1X6CgoeXbtdrz55XDn77a6ofCtN6HGLz6Hf
 b47td7pj8ffvXzcIuW4Z21TF7eKje6fumU5oxSqLf69s3tca9abEj0vvYkuGh3Nk/Y5WTm
 BPc5Xjy9gJg7FmTVBcOtLNrdn6TW6vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1677250931;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jet+701xYgvLczSxZgKpp3eOF/bRWV7Zc1+PF8rerlg=;
 b=0x+GCbJDfzuxuNg61oKeOcF41qN78k916BZe4v1Iy2ROyjeo9QfPTtvL8OFllBMkvcXKsC
 1vutjga85OFKTNDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 553CB13A3A;
 Fri, 24 Feb 2023 15:02:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eX86E3PR+GMBfwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 24 Feb 2023 15:02:11 +0000
Date: Fri, 24 Feb 2023 16:03:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <Y/jRxug4oBqJeEmy@yuki>
References: <20230222034501.11800-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230222034501.11800-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mknod01: Rewrite the test using new LTP API
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
> +	if (S_ISCHR(tcases[i]))
> +		dev = makedev(1, 3);
> +	else
> +		dev = 0;

Reading 'man 2 mknod' I suppose that we should pass non-zero dev for
block devices as well. Hoever the test seems to work fine with zero dev
for both cases.

Btw makedev(1, 3) seems to be the /dev/null char device and it should
work for block devices since block makedev(1, 3) would be /dev/ram3, so
what about:

diff --git a/testcases/kernel/syscalls/mknod/mknod01.c b/testcases/kernel/syscalls/mknod/mknod01.c
index d4b8c7bf8..7a4d5b43f 100644
--- a/testcases/kernel/syscalls/mknod/mknod01.c
+++ b/testcases/kernel/syscalls/mknod/mknod01.c
@@ -31,12 +31,10 @@ static int tcases[] = {

 static void run(unsigned int i)
 {
-       dev_t dev;
+       dev_t dev = 0;

-       if (S_ISCHR(tcases[i]))
+       if (S_ISCHR(tcases[i]) || S_ISBLK(tcases[i]))
                dev = makedev(1, 3);
-       else
-               dev = 0;

        TST_EXP_PASS(mknod(PATH, tcases[i], dev),
                                "mknod(PATH, %o, %ld)",


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
