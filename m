Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9503AC47077
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 17:49:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 059FB3CCACF
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 18:49:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93B463C62AB
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 18:49:31 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2A9B114010DE
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 18:49:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BD1BD1FD59;
 Tue, 16 Jan 2024 17:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705427368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QHqFdfuh4rDUUmJUdQk9EM8pTm/g210yGmw6UEYdlnc=;
 b=lrON8hiq1LosuJJKyOWWfF1DLFVP/obBPj7boLipKDqJ3m9zs5XRkeGpZSHaWcASpbrd1N
 zYW31pSDilX54Gh9z0rdZiulemzKB6Er4/gTCV6L5mR35SvvWoGRVRJit75+gExR4X4oIW
 svzLaG13ZVpCBObjeNptAONHZcQICQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705427368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QHqFdfuh4rDUUmJUdQk9EM8pTm/g210yGmw6UEYdlnc=;
 b=7F0WozmWtXO9U6NX90yMjfeH605mYJCgJyf248r8SEaAvQieRBefM4fN2S9RIV+5ZmCKaI
 1Z7l9W/uEPP0daAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705427368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QHqFdfuh4rDUUmJUdQk9EM8pTm/g210yGmw6UEYdlnc=;
 b=lrON8hiq1LosuJJKyOWWfF1DLFVP/obBPj7boLipKDqJ3m9zs5XRkeGpZSHaWcASpbrd1N
 zYW31pSDilX54Gh9z0rdZiulemzKB6Er4/gTCV6L5mR35SvvWoGRVRJit75+gExR4X4oIW
 svzLaG13ZVpCBObjeNptAONHZcQICQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705427368;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QHqFdfuh4rDUUmJUdQk9EM8pTm/g210yGmw6UEYdlnc=;
 b=7F0WozmWtXO9U6NX90yMjfeH605mYJCgJyf248r8SEaAvQieRBefM4fN2S9RIV+5ZmCKaI
 1Z7l9W/uEPP0daAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74F7113751;
 Tue, 16 Jan 2024 17:49:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nI1KFqjBpmU0OQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 16 Jan 2024 17:49:28 +0000
Date: Tue, 16 Jan 2024 18:49:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240116174926.GA2617288@pevik>
References: <20240111012650.9731-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240111012650.9731-1-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lrON8hiq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7F0WozmW
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[24.36%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BD1BD1FD59
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add TST_EXP_FAIL_PTR
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

Hi Wei,

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/tst_test_macros.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

> This is draft patch and should rebase after following patch merge.
> https://patchwork.ozlabs.org/project/ltp/patch/20240103115700.14585-1-chrubis@suse.cz/

Patch was accepted, please rebase. Also, please add at least one test which
uses it.

Also, I wonder if we need TST_EXP_PASS_PTR().

> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index 3f4f9f11d..6e45e0b27 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -212,6 +212,26 @@ extern void *TST_RET_PTR;
>  		}                                                              \
>  	} while (0)

> +#define TST_EXP_FAIL_SILENT_PTR_(SCALL, SSCALL, ERRNO, ...)             \
> +	do {                                                                   \
> +		TESTPTR(SCALL);                                                   \
> +		                                                               \
> +		TST_PASS = 0;                                                  \
> +		                                                               \
> +		if (TST_RET_PTR) {                                               \
> +			TST_MSG_(TFAIL, " succeeded", SSCALL, ##__VA_ARGS__);  \
> +		        break;                                                 \
> +		}                                                              \
> +		                                                               \
> +		if (TST_ERR == (ERRNO)) {                                      \
> +			TST_PASS = 1;                                          \
> +		} else {                                                       \
> +			TST_MSGP_(TFAIL | TTERRNO, " expected %s",             \
> +				  tst_strerrno(ERRNO),                         \
> +				  SSCALL, ##__VA_ARGS__);                      \
> +		}                                                              \

Maybe follow the pattern of already used tests (break saves else clause)?
 		if (TST_ERR != (ERRNO)) {                                      \
			TST_MSGP_(TFAIL | TTERRNO, " expected %s",             \
				  tst_strerrno(ERRNO),                         \
				  SSCALL, ##__VA_ARGS__);                      \
			break;                                                 \
		}                                                              \
                                                                               \
		TST_PASS = 1;                                                  \


> +	} while (0)
> +

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
