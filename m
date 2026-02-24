Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAB2EFB815
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 08:30:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 740703D0F75
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 09:30:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A57B3CB958
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:30:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 74730140074A
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:30:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E79E5BCD5;
 Tue, 24 Feb 2026 08:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771921819;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0EVdBdYF/zlw7EMj60sU7IMdmeBmheNozYiPcYDlYJ0=;
 b=1d7XWdtXySXk467BVQfFMr85gTsPTeydA5xWci+eXwfd4bEu4YI32qly/SfJcqRYavVJuX
 zUiweQdpZ8vUIyJcNC/N7xhklGu5x8wvU8Xaq0dczHDDvxUpzm6hzecAZe8VQ+9rbOI590
 Qhi1MIx/6bHip68MUBtQRu9I+Qj9LiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771921819;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0EVdBdYF/zlw7EMj60sU7IMdmeBmheNozYiPcYDlYJ0=;
 b=ihDIJKHKt8sIErQrPpoOfugyUxPu5ZoT2qLbUmYYXecsnnGQGzt3C9tpSEmgv7V8+286rb
 NVHhcbZZi7Z94DCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1d7XWdtX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ihDIJKHK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771921819;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0EVdBdYF/zlw7EMj60sU7IMdmeBmheNozYiPcYDlYJ0=;
 b=1d7XWdtXySXk467BVQfFMr85gTsPTeydA5xWci+eXwfd4bEu4YI32qly/SfJcqRYavVJuX
 zUiweQdpZ8vUIyJcNC/N7xhklGu5x8wvU8Xaq0dczHDDvxUpzm6hzecAZe8VQ+9rbOI590
 Qhi1MIx/6bHip68MUBtQRu9I+Qj9LiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771921819;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0EVdBdYF/zlw7EMj60sU7IMdmeBmheNozYiPcYDlYJ0=;
 b=ihDIJKHKt8sIErQrPpoOfugyUxPu5ZoT2qLbUmYYXecsnnGQGzt3C9tpSEmgv7V8+286rb
 NVHhcbZZi7Z94DCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 149783EA68;
 Tue, 24 Feb 2026 08:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uxFHApthnWnvQwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 24 Feb 2026 08:30:19 +0000
Date: Tue, 24 Feb 2026 09:30:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260224083017.GB28159@pevik>
References: <20260224-remove_runltp-v2-1-f38862a85b97@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260224-remove_runltp-v2-1-f38862a85b97@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 4E79E5BCD5
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Remove runltp `scenario_groups` leftovers
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v2:
> - forgot to keep runltp script
> - Link to v1: https://lore.kernel.org/r/20260224-remove_runltp-v1-1-7baa79b65acd@suse.com
> ---
>  scenario_groups/Makefile | 38 --------------------------------------
>  scenario_groups/default  | 28 ----------------------------
>  scenario_groups/network  | 20 --------------------

I thought people are using scenario_groups as kind of list of runtest files.
But maybe I'm wrong.

Also, you need to modify top level Makefile, otherwise make install/clean fails.
=> v3 or don't forget to fix before merge.

Kind regards,
Petr

>  3 files changed, 86 deletions(-)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
