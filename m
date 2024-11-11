Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF31D2E9FF
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 14:25:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E22BF3D555C
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 15:25:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B7523D5523
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 15:25:16 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8B4C410008F9
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 15:25:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AF4DC1F38E;
 Mon, 11 Nov 2024 14:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731335084;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OpYfHfobpw04WbHXdXzxeyPbMNDpBIc8h+3l8qdOWQA=;
 b=MIw8AfoyYBq75b615TW7KPeUaRiFjX75GyB3RJBJM24P4MbUlA2+jgehok+jaLUe7MjXdG
 6e+xyDTQw1cJMrNS7y3ZMmqZE6fPxZyKbonxlbO4A5W916Lf0rVF9UkYUyo3XrdSrv/E8Q
 sPkoVjma8cfDs9ayQvFSQzGXt7bz9gY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731335084;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OpYfHfobpw04WbHXdXzxeyPbMNDpBIc8h+3l8qdOWQA=;
 b=3dy3ate+oLVxnLmIZ1rBLRnVAiGDk0uXSLWM8N4zijhl5laguuy4aoMWKZovPOsgVQa9IK
 eSgmRZvOa/NLx+Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731335084;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OpYfHfobpw04WbHXdXzxeyPbMNDpBIc8h+3l8qdOWQA=;
 b=MIw8AfoyYBq75b615TW7KPeUaRiFjX75GyB3RJBJM24P4MbUlA2+jgehok+jaLUe7MjXdG
 6e+xyDTQw1cJMrNS7y3ZMmqZE6fPxZyKbonxlbO4A5W916Lf0rVF9UkYUyo3XrdSrv/E8Q
 sPkoVjma8cfDs9ayQvFSQzGXt7bz9gY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731335084;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OpYfHfobpw04WbHXdXzxeyPbMNDpBIc8h+3l8qdOWQA=;
 b=3dy3ate+oLVxnLmIZ1rBLRnVAiGDk0uXSLWM8N4zijhl5laguuy4aoMWKZovPOsgVQa9IK
 eSgmRZvOa/NLx+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDAC913301;
 Mon, 11 Nov 2024 14:24:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xaXNLqsTMmdcZgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 11 Nov 2024 14:24:43 +0000
Date: Mon, 11 Nov 2024 15:24:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241111142437.GB181734@pevik>
References: <20241108122139.87974-1-pvorel@suse.cz> <ZzHehDjWzY7ZMXyC@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZzHehDjWzY7ZMXyC@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] recvmmsg01: Workaround segfault on libc
 variant on 32 bit
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

Hi all,

...
> > +static void test_bad_addr(unsigned int i)
> > +{
> > +	struct time64_variants *tv = &variants[tst_variant];
> > +	void *timeout = bad_addr;
> > +	pid_t pid;
> > +	int status;
> > +
> > +	pid = SAFE_FORK();
> > +	if (!pid) {
> > +		verify_recvmmsg(i, timeout);
> > +		_exit(!TST_PASS);

> This should be just exit(0). The child should either crash or exit with
> 0 any other result should be considered a bug.

+1

> > +	}
> > +
> > +	SAFE_WAITPID(pid, &status, 0);
> > +
> > +	if (WIFEXITED(status))
>                              ^
> 			     && !WEXITSTATUS(status))

Ah, good point. I'll send a patch adding this to other tests, where it is
missing.

Merged with these fixes + wording from Wai.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
