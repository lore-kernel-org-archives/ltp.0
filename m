Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC7ECCD199
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 13:33:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE98E3CEF7C
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 15:33:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0C3C3CECFE
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 15:33:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 16E3F10007CD
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 15:33:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D2B621189;
 Mon, 20 Oct 2025 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760967215;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qfUFRA/fj9my8Jsmb4JkWdysgbRG2z5peTMbBOKKHtA=;
 b=EtlgCk+9gkJhStqcE2sE6p4pf+gpUfcC1/xyUvQWHUnzbbbrLgSn11x4LbE5Xd7/tac8pC
 qthR9nJJOvc4Q/Y8WreftdfKfA7UEGGzDvd3RMvZ3XASCs7hKbOwyVLw91JMxQLeHDrK2Y
 agOKvHTpFoWbcBtwPN5YYedrIfBh6fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760967215;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qfUFRA/fj9my8Jsmb4JkWdysgbRG2z5peTMbBOKKHtA=;
 b=uPGXWh19T2i9uEHsH154Ehh8LDDomGiSPJa/o8WW1SzBauDUx7zvTGj9+8vcIavIL0pjfc
 IrBrEylbDl2JgvBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FZUzF681;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DwJTmZir
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760967211;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qfUFRA/fj9my8Jsmb4JkWdysgbRG2z5peTMbBOKKHtA=;
 b=FZUzF681Nj65akSOvqrigH1oFH7BbD/+AAORtwkytTZPR3Y1gROGsv+X/zUqPD8FmJQojI
 rkN6+G0nD1fCWBN5cUTwTWduUfpILCYMzsgwXnNHay2KalmvZu/OQp2/IcBULp602ybswM
 1HFJeMwIlXi4Ns434n/5NFaAl6VNnjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760967211;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qfUFRA/fj9my8Jsmb4JkWdysgbRG2z5peTMbBOKKHtA=;
 b=DwJTmZirOzwnx4ha5Eb7YlDHKczn8n2D9BTEDPz6p7cwrgnogSCKidxTAWBJ0RDnbCc7lb
 FHcPhgu6idyfHcCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4335113AAC;
 Mon, 20 Oct 2025 13:33:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZZToDis69mj1bAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 20 Oct 2025 13:33:31 +0000
Date: Mon, 20 Oct 2025 15:33:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251020133329.GB398576@pevik>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251017101011.3811-1-wegao@suse.com>
 <20251017101011.3811-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251017101011.3811-2-wegao@suse.com>
X-Rspamd-Queue-Id: 6D2B621189
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] lib: Add support option for .needs_cmds
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

...
> +++ b/lib/tst_cmd.c
> @@ -265,7 +265,12 @@ int tst_check_cmd(const char *cmd, const int brk_nosupp)
>  	str = strtok_r(NULL, " ", &next);

>  	if (tst_get_path(cmd_token, path, sizeof(path)))
> -		tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
> +		if (brk_nosupp) {
> +			tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
> +		} else {
> +			tst_resm(TCONF, "Couldn't find '%s' in $PATH", cmd_token);
> +			return 1;
> +		}

You ask me how you could split changes to be compilable and yet not in a single
commit.  This is a completely unrelated change, it should be in a separate
commit, with:

Fixes: 257394e4e3 ("Filter mkfs version in tst_fs")

Kind regards,
Petr

>  	if (!op_token)
>  		return 0;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
