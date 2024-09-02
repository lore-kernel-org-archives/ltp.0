Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBC5CD13CF
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 07:29:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 690CA3C32B1
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 09:29:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 459BE3C2FEB
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 09:29:01 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A620A2001D2
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 09:29:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED0F3219BB;
 Mon,  2 Sep 2024 07:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725262139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAsdbmNZDSB7MqXxwmHckxJ2Z1jwT1NrnrzGGUDP/Yk=;
 b=Jrrmv2c7SXzloxDh9aT1N4LIKu4xn5qov3r4ErvdQqLoguwQ/D9+hkmJS1wVxjLjUG0Yd5
 Y1RR5dwDI7yPUOSs6CEI4HeXag5VoAI+TMj4eVieQzI1Q3i/BwWjF5CvuF7olJpaxWP2hN
 HJN5+IO3inuy1xhAsj6Zo0d66Vbsq7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725262139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAsdbmNZDSB7MqXxwmHckxJ2Z1jwT1NrnrzGGUDP/Yk=;
 b=fv5NZAI/SwyL/aEEQk9bUeQoZDvP7x2eHbsfCGxz6apvTqvcCxhMsRN9ncTLGoqcCHqTyC
 2gxpvsG2NeCHOtAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YWsPFKjM;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FR6Tj2zB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725262138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAsdbmNZDSB7MqXxwmHckxJ2Z1jwT1NrnrzGGUDP/Yk=;
 b=YWsPFKjMAzQJ+eazOVKt31trBMlv3YVhEwMgRXBINL1v2/W351mjEGiPkvSbJ87Sy5qEo0
 WiZWJqcbwTirtMstTiMTCCI+cGUV1Mi3ZUFRYwetGDt1WUMmoB1tzrxgKmHR+UHMRTYbpG
 AGWIvqPu9GjM368e0OHXpqjtJEp1Gyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725262138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAsdbmNZDSB7MqXxwmHckxJ2Z1jwT1NrnrzGGUDP/Yk=;
 b=FR6Tj2zBK+EXHMo2TPOydTB0+WKaocheGTGof8tFO9L+oYPr/t7J3IhzHNLX/vHea73YFA
 +aQNxEmecw/KnmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8EC713A7C;
 Mon,  2 Sep 2024 07:28:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pWqVLzpp1WZELgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 02 Sep 2024 07:28:58 +0000
Date: Mon, 2 Sep 2024 09:28:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240902072842.GA280672@pevik>
References: <20240829114124.30299-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240829114124.30299-1-wegao@suse.com>
X-Rspamd-Queue-Id: ED0F3219BB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] hugemmap11.c: Change NORMAL_PATH to current
 working directory
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

Hi Wei, Li,

> Following error will happen on sle-micro system since "/" is read only
> tst_test.c:1062: TBROK: open(/ltp_hug9Iy6OR,16578,10247520240) failed: EROFS (30)

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
> index 496a814b5..67fca2ddf 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
> @@ -23,7 +23,7 @@

>  #define P0 "ffffffff"
>  #define IOSZ 4096
> -#define NORMAL_PATH ""
> +#define NORMAL_PATH "./"

Reviewed-by: Petr Vorel <pvorel@suse.cz>

@Li: Do you see any consequences?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
