Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495ECC43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 15:07:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4BB83E5CE1
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 17:07:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 748B83E5C9D
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 17:07:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 704231400DC8
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 17:07:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B4E5576274;
 Thu,  9 Jul 2026 15:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783609642;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HPVSPxADEFEH2mLhKiMf9krVCCugAPrOf0tDpsM+oI=;
 b=a0mBkXeW8M06fzaK9TsEfT276Ak2VEU5o58jDBVVaucqikUkLcSbM9spu4wDe1Zw5bXgjZ
 QEq2sSWNXusP5/zLE7Xz4S1hbF3ElpsFSwOoX1T03RASzZOvBuC5qzCT/SZIT6ixrsBgNc
 tys3MfNHHAJC8K/WQihkuVL0/pajNs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783609642;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HPVSPxADEFEH2mLhKiMf9krVCCugAPrOf0tDpsM+oI=;
 b=ORkJMprVEZUYdbCuEcKtuSv24usor0X5ivxXnDbyS4u4Q1oLlPwHadOrS2tttNvxUjOQb/
 IRfFeXUQJatBytCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783609642;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HPVSPxADEFEH2mLhKiMf9krVCCugAPrOf0tDpsM+oI=;
 b=a0mBkXeW8M06fzaK9TsEfT276Ak2VEU5o58jDBVVaucqikUkLcSbM9spu4wDe1Zw5bXgjZ
 QEq2sSWNXusP5/zLE7Xz4S1hbF3ElpsFSwOoX1T03RASzZOvBuC5qzCT/SZIT6ixrsBgNc
 tys3MfNHHAJC8K/WQihkuVL0/pajNs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783609642;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HPVSPxADEFEH2mLhKiMf9krVCCugAPrOf0tDpsM+oI=;
 b=ORkJMprVEZUYdbCuEcKtuSv24usor0X5ivxXnDbyS4u4Q1oLlPwHadOrS2tttNvxUjOQb/
 IRfFeXUQJatBytCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9827C779AA;
 Thu,  9 Jul 2026 15:07:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nTkZGym5T2oHEgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jul 2026 15:07:21 +0000
Date: Thu, 9 Jul 2026 17:07:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260709150719.GA999562@pevik>
References: <20260709130135.927868-2-pvorel@suse.cz>
 <20260709135357.4124-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260709135357.4124-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] build.sh: Add support for test-metadata
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

> Hi Petr,

> On Thu, Jul 09, 2026 at 15:01:33 +0200, Petr Vorel wrote:
> > build.sh: Add support for test-metadata

> --- [PATCH 1/3] ---

> The commit body is empty. Is there anything worth saying about why
> test-metadata deserves its own run-type, or why it is being added now?
> Even one sentence would help readers understand the motivation without
> having to read the whole series.

> --- [PATCH 3/3] ---

> >  	printf "* $i "

> $i is expanded directly into printf's format string. If a .c file
> is ever added whose name contains a percent sign, printf will interpret
> it as a format specifier and produce garbled output.

> The portable form is:

>     printf '* %s ' "$i"

I would say printf "* $i " is portable enough.

> Verdict - Needs revision

Yes, but not due the above problems but due out-of-tree build problems.

Unfortunately $(abs_builddir) is working only when called on the top level
Makefile, which is visible in lib/newlib_tests/runtest.sh which just tries to
detect this problem:

		case $res in
			0) tpass="$tpass $i";;
			1) tfail="$tfail $i";;
			2) tbrok="$tbrok $i";;
			4) twarn="$twarn $i";;
			32) tconf="$tconf $i";;
			127) runtest_brk TBROK "Error: file not found (wrong PATH? out-of-tree build without -b?), exit code: $res";;
			*) runtest_brk TBROK "Error: unknown failure, exit code: $res";;
		esac

I'll do handling like this as well into metadata/tests/test.sh.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
