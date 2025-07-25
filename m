Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37753C87FCE
	for <ltp@archiver.kernel.org>; Fri, 25 Jul 2025 13:46:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AC393CCE8C
	for <ltp@archiver.kernel.org>; Fri, 25 Jul 2025 15:46:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86C8E3C1CEA
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 15:46:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 13B5A1A00099
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 15:46:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D70C1F842;
 Fri, 25 Jul 2025 13:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753451192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wSKO1QX5Or1yalqVfoBqjHN+6hDO4dddfqviiF/9BCI=;
 b=g13Ye4htUuBs32/UlLqcYroxxKbIC7EGRwdW4rSy4VuHZJj/vRyVy6nyg3KcbcnVWzAho8
 RqQTEM8vHckk45pOjD6ACQTH4guwnZXBQSPD9vaC7MGqQVdb++MZ4fKTtZv6qSeaulRucW
 0erMh+K481TpgffcEt2K49Q31DUtFMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753451192;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wSKO1QX5Or1yalqVfoBqjHN+6hDO4dddfqviiF/9BCI=;
 b=B7UMCvMAtAS1705KMe/v3qgiJbId0yOhozbUVvjsk+g4SMtAiUgZgJc/iO8l5QTs8NxC8E
 Rxd4+71VfOHnGHAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WrK8l4Ut;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2kzcCmfm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753451191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wSKO1QX5Or1yalqVfoBqjHN+6hDO4dddfqviiF/9BCI=;
 b=WrK8l4Ut/73Ehmue5BoRVUf+X8eLY91pWZ88R93IEviBFpB2J3kE0NbRp80jYM2vzcOQDK
 4vWqqVsLjIb+2oYq+Bnb9/hTVta45wIwtOgITGy/v3T3KazH9o0e/iWeZVXa92pnMpL9hz
 7h1IB7oypwcRx9Hwr2yMTU8U/HUv+hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753451191;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wSKO1QX5Or1yalqVfoBqjHN+6hDO4dddfqviiF/9BCI=;
 b=2kzcCmfmplgXsCpbgn+kdT3OQnhT3wRVwvNYWKpc4dSOeP2hQe3hHEN2mmL26ccXd++1mR
 PcDRvelCnpcpydAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E1F11373A;
 Fri, 25 Jul 2025 13:46:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rloHIreKg2hlRQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 25 Jul 2025 13:46:31 +0000
Date: Fri, 25 Jul 2025 15:47:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aIOK5Nm_k8uJjOI8@yuki.lan>
References: <20250617-statmount_mnt_ns_id-v1-0-d8d81637d73e@suse.com>
 <20250617-statmount_mnt_ns_id-v1-1-d8d81637d73e@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250617-statmount_mnt_ns_id-v1-1-d8d81637d73e@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[yuki.lan:mid,suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Queue-Id: 9D70C1F842
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] Update statmount fallback definitions
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
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  include/lapi/mount.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/lapi/mount.h b/include/lapi/mount.h
> index aea6bca77ac0c52cbccb892cbd0a205994ab19be..0f7bb5e4327f64e2b0c96511845e86a6c6af8221 100644
> --- a/include/lapi/mount.h
> +++ b/include/lapi/mount.h
> @@ -51,6 +51,7 @@ struct mnt_id_req {
>  	uint32_t spare;
>  	uint64_t mnt_id;
>  	uint64_t param;
> +	uint64_t mnt_ns_id;
>  };
>  #endif

This change does not seem to be needed.

Actually when I was looking at the listmount04 test, we pass
MNT_ID_REQ_SIZE_VER0 to the syscall but use sizeof(struct mnt_id_req)
which may mean that we would allocate more bytes than strictly required
and we may not be able to catch write access after the buffer. I suppose
that regardless of this addtion we should do:

diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
index 503346de8..a52bad064 100644
--- a/testcases/kernel/syscalls/listmount/listmount04.c
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -135,7 +135,7 @@ static struct tst_test test = {
        .tcnt = ARRAY_SIZE(tcases),
        .min_kver = "6.8",
        .bufs = (struct tst_buffers []) {
-               { &request, .size = sizeof(struct mnt_id_req) },
+               { &request, .size = MNT_ID_REQ_SIZE_VER0 },
                {},
        },
 };


Apart from that the patchset looks good to me:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
