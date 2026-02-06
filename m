Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CCEEA795E
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 09:45:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9A073C9CCA
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 10:45:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B87CF3C1CC0
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 10:45:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4ED9B60057C
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 10:45:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 922483E6C2;
 Fri,  6 Feb 2026 09:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770371116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lG8oANy1pmn2en5EjehHETZLljUfLcViyHDo6dX28cU=;
 b=rjpMxpUAJPqTtjvNtDbZLu71SABBf+65ANao6iKdRS1mTeUiD0N5obrVJQOOAO/A4R8eXR
 KfH9dos92e1EdCsPbCg74/cJe23CAoxnmz4W0/yKg4bfw3/JRyNX5y3jbLZWU8FsPpSji4
 qQPnIzgjlKGqiH5erl+ue4+cwJPARLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770371116;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lG8oANy1pmn2en5EjehHETZLljUfLcViyHDo6dX28cU=;
 b=kn0BxU49USln87ZeCB8wSGbq0IXzis6GjSNeCw/0CDfzdNczoTOTP2ZOjAx4cl8Fjjgb7l
 frXAHMFCgTJOqdCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770371116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lG8oANy1pmn2en5EjehHETZLljUfLcViyHDo6dX28cU=;
 b=rjpMxpUAJPqTtjvNtDbZLu71SABBf+65ANao6iKdRS1mTeUiD0N5obrVJQOOAO/A4R8eXR
 KfH9dos92e1EdCsPbCg74/cJe23CAoxnmz4W0/yKg4bfw3/JRyNX5y3jbLZWU8FsPpSji4
 qQPnIzgjlKGqiH5erl+ue4+cwJPARLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770371116;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lG8oANy1pmn2en5EjehHETZLljUfLcViyHDo6dX28cU=;
 b=kn0BxU49USln87ZeCB8wSGbq0IXzis6GjSNeCw/0CDfzdNczoTOTP2ZOjAx4cl8Fjjgb7l
 frXAHMFCgTJOqdCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 758393EA63;
 Fri,  6 Feb 2026 09:45:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id c6UyHCy4hWkRQwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 06 Feb 2026 09:45:16 +0000
Date: Fri, 6 Feb 2026 10:45:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aYW4KB4oKXurWohy@yuki.lan>
References: <20260205135724.23772-1-chrubis@suse.cz>
 <20260205174756.GA338897@pevik> <aYWfNaJeXqut0Isb@redhat.com>
 <aYWnRzaz7Luhm26x@yuki.lan> <20260206093715.GB374678@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260206093715.GB374678@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_kconfig: Add runtime checks
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
> > > > utsname01.c:39: TDEBUG: mmap((nil), 64, PROT_READ | PROT_WRITE(3), 33, -1, 0)
> > > > utsname01.c:40: TDEBUG: mmap((nil), 64, PROT_READ | PROT_WRITE(3), 33, -1, 0)
> 
> > Maybe we need TTRACE that would print syscall tracing like that and
> > TDEBUG for the rest of the messages.
> 
> I suppose TTRACE would be printed only for test process and not for the library,
> right?

Yes.

> And it'd be enabled only for debugging (existing -D or
> LTP_ENABLE_DEBUG=1):
> 
> if (ttype == TTRACE && context->lib_pid == getpid())
> 	return;
> 
> Other would we need a new switch and variable? (e.g. -T and
> LTP_ENABLE_TRACING_DEBUG=1)

I would go for LTP_ENABLE_TRACING=1.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
