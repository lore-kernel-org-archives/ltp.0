Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F3BC46CA1
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 11:43:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 782A13CE4DB
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 13:43:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 271C63CAA05
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:43:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4769B1A00EE7
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:43:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A53E1FE36;
 Mon, 18 Sep 2023 11:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695037411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+UEl9x6LNm8swbskfO6RSD/qvmqzOga5xtF8wkHpSE=;
 b=fe+kFIiVdHbvtjLAbdXQ4hGdNjcIc4KoGr++jWjI++Yi6/JWtjyCEuNWbZFAeIaTmIPBAd
 S5kxrBDyNJReY9kHjGrJojiHV7HH0Tdyh/txiamvEPEY+1/YVCUTdU4QQKpMlVgrO4LTLY
 w3I+qibs6V3yltq14x0Jc1vf/o7rOX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695037411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+UEl9x6LNm8swbskfO6RSD/qvmqzOga5xtF8wkHpSE=;
 b=J4i/EZam7Fl03XUPXEGY4zgb9kJi7XXalBkz25zySA6euhfsAA+34ckcF7Jt+Zo83u432/
 NxBcojaJ/cqgxyBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5095B13480;
 Mon, 18 Sep 2023 11:43:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YM6ZEuM3CGVEXwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 18 Sep 2023 11:43:31 +0000
Date: Mon, 18 Sep 2023 13:44:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <ZQg4EN2EYZnjP5Sr@yuki>
References: <20230918112358.25858-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230918112358.25858-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] kvm: Fix Nix build failure by specifying
 -fno-stack-protector again
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
Cc: mdoucha@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I found that adding the GUEST_LDFLAGS to the lib_*.o compilations
> fixes the issue on Nix.

I suppose that, if nothing else, we should add just -fno-stack-protector
to the GUEST_CFLAGS instead.

> ---
>  testcases/kernel/kvm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
> index d9eb10728..ddb24fabe 100644
> --- a/testcases/kernel/kvm/Makefile
> +++ b/testcases/kernel/kvm/Makefile
> @@ -46,7 +46,7 @@ MAKE_TARGETS =
>  endif
>  
>  lib_guest.o $(ARCH_OBJ): CPPFLAGS	:= $(GUEST_CPPFLAGS)
> -lib_guest.o $(ARCH_OBJ): CFLAGS		:= $(GUEST_CFLAGS)
> +lib_guest.o $(ARCH_OBJ): CFLAGS		:= $(GUEST_CFLAGS) $(GUEST_LDFLAGS)
>  
>  kvm_svm03: CFLAGS += -pthread
>  kvm_svm03: LDLIBS += -pthread
> -- 
> 2.40.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
