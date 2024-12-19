Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E36CE7718B
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 12:54:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C83F3ED414
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 13:54:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93ECA3EC0CB
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 13:54:06 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0B64921537F
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 13:54:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 80039210E9;
 Thu, 19 Dec 2024 12:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734612844;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EuFFIOCEFjCtR6JuMNmwLW436ykhQs6pYTZrn30lZVc=;
 b=D85RtWfWkv0TY+xERXi8+2+NLaSfB8uficikKw66j1S4oekg/Sgfegg7gnXk/uPXG7wEt4
 pW9OZqBHCuGYgwqeAzpRGBLSGFYa1YblG5h+amvENQvMlor4ujIrkkokwg0ojDPVEmNzgO
 S/48StNGLHKK70kE3WzrhHrna7QmCeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734612844;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EuFFIOCEFjCtR6JuMNmwLW436ykhQs6pYTZrn30lZVc=;
 b=EgsZVkSdiiO2FCzrFf4pSFN/B+guohDh4hG+t8zOJIMsigUGoPtQkaPg9lCT8l7fLXSX+M
 abvCLs8gopaJBNDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=D85RtWfW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EgsZVkSd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734612844;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EuFFIOCEFjCtR6JuMNmwLW436ykhQs6pYTZrn30lZVc=;
 b=D85RtWfWkv0TY+xERXi8+2+NLaSfB8uficikKw66j1S4oekg/Sgfegg7gnXk/uPXG7wEt4
 pW9OZqBHCuGYgwqeAzpRGBLSGFYa1YblG5h+amvENQvMlor4ujIrkkokwg0ojDPVEmNzgO
 S/48StNGLHKK70kE3WzrhHrna7QmCeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734612844;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EuFFIOCEFjCtR6JuMNmwLW436ykhQs6pYTZrn30lZVc=;
 b=EgsZVkSdiiO2FCzrFf4pSFN/B+guohDh4hG+t8zOJIMsigUGoPtQkaPg9lCT8l7fLXSX+M
 abvCLs8gopaJBNDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A67213A32;
 Thu, 19 Dec 2024 12:54:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RlHRDGwXZGc3DQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 19 Dec 2024 12:54:04 +0000
Date: Thu, 19 Dec 2024 13:53:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20241219125358.GA93828@pevik>
References: <20241212060448.204158-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241212060448.204158-1-liwang@redhat.com>
X-Rspamd-Queue-Id: 80039210E9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

...
> +++ b/lib/tst_test.c
> @@ -555,6 +555,9 @@ static int multiply_runtime(int max_runtime)

>  	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);

> +	if (tst_has_slow_kconfig())
> +		max_runtime *= 4;

FYI this change prolongs some fuzzy sync tests, e.g. setsockopt06 or writev03.
I guess this is a side effect, or not? Or does slow machine really needs to run
longer in order to trigger bug in fuzzy sync?

We have 900 sec timeout in openQA (default LTP timeout is 600 sec), but it's not enough.
Sure, the solution is to increase it to 2400 (4*600), but then we need really to
have more precise .max_runtime setup otherwise tests which got stuck will
prolong testing 4x times.

This is for syscalls, I haven't checked other runtests (specially these which
have high .max_runtime, e.g. ltp-aio-stress).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
