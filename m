Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6AEC55ABF
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 05:38:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25D593E27FA
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 07:38:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA5A13C991D
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 07:38:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4357E1400323
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 07:38:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6901F3DF6;
 Thu,  6 Aug 2026 05:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785994685;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMfwIH//B+Z+9mqDg25C3bBTqfT5J0N1G9mJG2Rb2Es=;
 b=SUAr8lKj+29NrRKwJ6XBzbWdu9hEjTRm4Rn6R0pcG9gsGz8a0Ducnbj2zXtN3g4KCzHYkU
 sIdI+pfQdSZSvzBJcDpQ2DVSEn0Sz+sevFNigKs/C0s2nFPUX981Y3AzXD7ErgD2HE3u+r
 Z/7wpJOq7MO46jbY7RNbdudHItkE/5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785994685;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMfwIH//B+Z+9mqDg25C3bBTqfT5J0N1G9mJG2Rb2Es=;
 b=/MaoPQxlzokcicaJpL43N4nSqKpXE+velEzbJziO9QujAqsIFIyaQONQOyciFaf5Y+XU17
 hYEmb3TVjwG9u7Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785994681;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMfwIH//B+Z+9mqDg25C3bBTqfT5J0N1G9mJG2Rb2Es=;
 b=NPu2vJUMQJTD6zlgscvsnyl9fAyRWCjSxxU8rysNJ2tlxJ7qDuDTzWo0/utRADLoR54u3+
 9R15FDaT8TD6XUeyzFxDZ1bVUclMWfoTbwqMLSnrX+UbPu5ysY26xqjPI7XIN1GwX/a5t6
 MsdtI9SVOOK2KNBmlv1qqXUTS8aPmAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785994681;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMfwIH//B+Z+9mqDg25C3bBTqfT5J0N1G9mJG2Rb2Es=;
 b=41sNNm5YExO2KihMeoKUH3KhVOOORSV31gepb3mFdcJMhvGpR1rl4fhZp5+QSRxhmWrxtY
 mJ8vRcFKL7mUg9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A8DA779B6;
 Thu,  6 Aug 2026 05:38:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 65NADLkddGrjRQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Aug 2026 05:38:01 +0000
Date: Thu, 6 Aug 2026 07:37:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20260806053751.GA657385@pevik>
References: <20260805151451.648990-1-pvorel@suse.cz>
 <20260805151451.648990-10-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260805151451.648990-10-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 9/9] [RFC] metaparse: Check {min,
 max}_kver validity
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

I'm sorry, this last commit breaks out-of-tree build.

...
> +++ b/metadata/Makefile
> @@ -3,13 +3,15 @@

>  top_srcdir		?= ..

> -include $(top_srcdir)/include/mk/env_pre.mk
> -include $(top_srcdir)/include/mk/functions.mk
> +include $(top_srcdir)/include/mk/testcases.mk

>  MAKE_TARGETS		:= ltp.json
>  HOST_MAKE_TARGETS	:= metaparse metaparse-sh
>  INSTALL_DIR		= metadata

> +metaparse: HOST_CFLAGS		+= -I$(abs_srcdir)/../include -L$(abs_builddir)/../lib
Either this is wrong, or the change in previous commit was not enough.
Investigating.

Kind regards,
Petr

> +metaparse: HOST_LDLIBS		+= -lltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
