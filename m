Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057F5C9832A
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 15:08:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB5843E587A
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 17:08:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BC623C54C9
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 17:07:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D3FA01400159
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 17:07:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5911421D65;
 Tue, 29 Sep 2026 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790694469;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=swPrzZasIYUWbIZvXbnFP59HkluLdv2dtfm3HXjkc3E=;
 b=s+ogcpaISIiVcU+ZtrAVoqlz6p7UGiOgBZAxyR4venMzQetl7QiroN2CAuyRGTSaAIBk3w
 6csHNY/21PrwxbDzjIpUEe/1bya55+Zn5+pd3DxWoeWjrt0/lboz07gbjwXKJze8gyrKOg
 JR4ykX7NH7Tf7sf1auKyZCirLDqmR4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790694469;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=swPrzZasIYUWbIZvXbnFP59HkluLdv2dtfm3HXjkc3E=;
 b=PI+bnDOlVYISTxj47bvx5lpVOz6bdhZbdFYVfpFL4IPFblFWPEMHsNLjgt4nb8hOIB8rNt
 5anlbDQlEteSoVCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790694465;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=swPrzZasIYUWbIZvXbnFP59HkluLdv2dtfm3HXjkc3E=;
 b=OX3v0x46TWosHyIFq4lgXqIrQOx0o7+Xf9TiV9yxdptDuM5i6/RXICOoOyOrEKfcgnqw5e
 xtlGK4lG/oa3DkdrdoOxabIx1zIZ/InIkCXmNg1urOVpKNkGmFq3ULgJEn/ZlUIr3TG+1O
 nbTf3FLz6bVaKcSGBUJY8XYXl/e5+ZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790694465;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=swPrzZasIYUWbIZvXbnFP59HkluLdv2dtfm3HXjkc3E=;
 b=jBzwpRNMCUqNALarazKd3DwHWZHoU//Vy1jgy/KhlXUiiZMRHwAQwZ/VZKWKPYbC3iA5r1
 RFZHdg6Q6+6MpnAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14369133F1;
 Tue, 29 Sep 2026 15:07:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id M8ZBNUDUu2qdCgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 29 Sep 2026 15:07:45 +0000
Date: Tue, 29 Sep 2026 17:07:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <20260929150743.GE2462033@pevik>
References: <20260928212721.2834101-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260928212721.2834101-1-anders.roxell@linaro.org>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[linaro.org:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,linaro.org:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openposix: lib: Use the configured compiler
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Anders,

> The lib Makefile does not include env.mk, so it does not get CC from
> config.mk. When we cross compile, libcommon.a gets built with the host
> compiler. Then the linker skips it and most tests fail to build.

> Include env.mk, like the other Makefiles do.

Make sense, thanks!
Verified and merged even close before the release.

Kind regards,
Petr

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  testcases/open_posix_testsuite/lib/Makefile | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/testcases/open_posix_testsuite/lib/Makefile b/testcases/open_posix_testsuite/lib/Makefile
> index ad6a9d7e6a1b..e63ee42647ac 100644
> --- a/testcases/open_posix_testsuite/lib/Makefile
> +++ b/testcases/open_posix_testsuite/lib/Makefile
> @@ -1,6 +1,8 @@
>  top_srcdir?=		..
>  subdir=			lib

> +include $(top_srcdir)/include/mk/env.mk
> +
>  AR?=			ar
>  RANLIB?=		ranlib
>  CFLAGS+=		-I$(top_srcdir)/include

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
