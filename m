Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17177ECAAD3
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 09:59:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B29D3CABF8
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 11:59:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2ED93CABA8
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 11:59:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 42C581A00981
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 11:59:21 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 556C320C72;
 Thu, 15 Sep 2022 09:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663235961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vqa4T+gXRNFtiCJymlWreoHI7HEETw/H8B52Vk56vHU=;
 b=gd/sRJhOPG0Vj1mNKyFw4fRTR9+iPRYI7gaFVOHpurTfhvW7TL+65ufNwhoQmkf5+Lhhe3
 iVVxbVK6pWJn9R7Se87bwx6H3OU5jd+4qCtngMianqPQ/Y4tMlXVj498MeMTZZJC/vdmbe
 f41GM+5v0rz3qF04I5rATz0dCC2C05A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663235961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vqa4T+gXRNFtiCJymlWreoHI7HEETw/H8B52Vk56vHU=;
 b=OZRgMT8D0GQFBwjE7iwUoYg96RLXp5VqlP2+2tos3S2dxH6/ZWbb1P5ffuwSnPEUHykS98
 39H32bBVP0coUvCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3E92E13310;
 Thu, 15 Sep 2022 09:59:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id po6JDnn3ImPoLAAAGKfGzw
 (envelope-from <chrubis@suse.cz>); Thu, 15 Sep 2022 09:59:21 +0000
Date: Thu, 15 Sep 2022 12:01:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <YyL37oKstZnbFORf@yuki>
References: <20220915062715.233884-1-zhaogongyi@huawei.com>
 <20220915062715.233884-3-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220915062715.233884-3-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] io_uring.h: Remove
 io_uring_setup_supported_by_kernel()
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
> -static inline void io_uring_setup_supported_by_kernel(void)
> -{
> -	long ret;
> -	if ((tst_kvercmp(5, 1, 0)) < 0) {
> -		ret = syscall(__NR_io_uring_setup, NULL, 0);
> -		if (ret != -1)
> -			SAFE_CLOSE(ret);
> -		else if (errno == ENOSYS)
> -			tst_brk(TCONF,
> -				"Test not supported on kernel version < v5.1");
> -	}
> -}

I guess I see the problem now, with the CONFIG_IO_URING not set this
will fail to detect that io_uring() is not supported. So the easiest
solution here would be:

diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
index 397324511..43d28f74a 100644
--- a/include/lapi/io_uring.h
+++ b/include/lapi/io_uring.h
@@ -297,14 +297,22 @@ static inline int io_uring_enter(int fd, unsigned int to_submit,
 static inline void io_uring_setup_supported_by_kernel(void)
 {
        long ret;
+
+       ret = syscall(__NR_io_uring_setup, NULL, 0);
+
+       if (ret != -1) {
+               SAFE_CLOSE(ret);
+               return;
+       }
+
        if ((tst_kvercmp(5, 1, 0)) < 0) {
-               ret = syscall(__NR_io_uring_setup, NULL, 0);
-               if (ret != -1)
-                       SAFE_CLOSE(ret);
-               else if (errno == ENOSYS)
+               if (errno == ENOSYS)
                        tst_brk(TCONF,
                                "Test not supported on kernel version < v5.1");
        }
+
+       if (errno == ENOSYS)
+               tst_brk(TCONF, "CONFIG_IO_URING not set?");
 }


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
