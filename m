Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B152C25B10
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 19:42:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 007523CDA1F
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 21:42:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96BB93CB5B3
 for <ltp@lists.linux.it>; Mon,  6 May 2024 21:42:02 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F0AC31B61042
 for <ltp@lists.linux.it>; Mon,  6 May 2024 21:42:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9142521B41;
 Mon,  6 May 2024 19:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715024520;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rk4bVsx9+MXVuclOF3LvsaynE2zbVEPAknfaScJSADs=;
 b=ynxqG7siyjbK6bslSwdPhr/yNVhdc+45EZT4d3lkXGNr+oGAiLOPeu4kekkEKRsnZhBjBj
 peI+ddt6sRXUGktVzSyp4B7u437uq8wfqpuzrm27+e96zuowNjKvh9aN/i07f6Tw853MYg
 cbmCBNrTVchfiuGZks2f5uY472iyK8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715024520;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rk4bVsx9+MXVuclOF3LvsaynE2zbVEPAknfaScJSADs=;
 b=/bj+6I+Wzu2Lx/z//e1QpM816kIYBhgWgSKkWWZDD7m4V0NLYDE+Qakuukw2JjT6o5tyl6
 9h8u3Nmn9RIV/kAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715024520;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rk4bVsx9+MXVuclOF3LvsaynE2zbVEPAknfaScJSADs=;
 b=ynxqG7siyjbK6bslSwdPhr/yNVhdc+45EZT4d3lkXGNr+oGAiLOPeu4kekkEKRsnZhBjBj
 peI+ddt6sRXUGktVzSyp4B7u437uq8wfqpuzrm27+e96zuowNjKvh9aN/i07f6Tw853MYg
 cbmCBNrTVchfiuGZks2f5uY472iyK8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715024520;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rk4bVsx9+MXVuclOF3LvsaynE2zbVEPAknfaScJSADs=;
 b=/bj+6I+Wzu2Lx/z//e1QpM816kIYBhgWgSKkWWZDD7m4V0NLYDE+Qakuukw2JjT6o5tyl6
 9h8u3Nmn9RIV/kAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A13113A25;
 Mon,  6 May 2024 19:41:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 79Z8C4cyOWZZVgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 06 May 2024 19:41:59 +0000
Date: Mon, 6 May 2024 21:41:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240506194156.GA38981@pevik>
References: <20240430122208.13043-1-mdoucha@suse.cz>
 <20240430122208.13043-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240430122208.13043-2-mdoucha@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/9] KVM: Disable EBP register use in 32bit code
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

Hi Martin,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> The EBP register points to the stack segment by default but GCC uses
> it to access data segment without the proper prefix. This works fine
> on most systems because the stack and data segments are usually
> identical. However, KVM environment intentionally enforces strict
> limits on the stack segment and access to the data segment using
> unprefixed EBP would trigger stack segment fault exception in 32bit
> LTP builds (stack segment limits are ignored in 64bit mode).

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/kernel/kvm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
> index ce4a5ede2..c85790e11 100644
> --- a/testcases/kernel/kvm/Makefile
> +++ b/testcases/kernel/kvm/Makefile
> @@ -22,7 +22,7 @@ ifeq ($(HOST_CPU),x86_64)
>  endif

>  ifeq ($(HOST_CPU),x86)
> -	GUEST_CFLAGS += -m32
> +	GUEST_CFLAGS += -m32 -ffixed-ebp

FYI this will fail on 32 bit build on clang:

clang: error: unknown argument: '-ffixed-ebp'

I don't want to block this patchset which brings important test, but it'd be
great to fix it.

Is there clang equivalent? Or is it even needed for clang?

Either way, we need to detect clang. I don't think simple

ifeq ($(CXX),clang)

would be enough, because cc can be alias to clang.

Maybe wrap it with version detection:

ifeq ($(shell $(CC) -v 2>&1 | grep "clang version"), 1)
	GUEST_CFLAGS += -ffixed-ebp
endif

Kind regards,
Petr

>  	ASFLAGS += --32
>  endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
