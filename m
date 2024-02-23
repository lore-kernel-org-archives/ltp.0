Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E420C54798
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 12:43:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D07B13CF1B2
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 13:43:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BC4A3CE7BD
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 13:43:27 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C9560600C5F
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 13:43:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE5281FC0C;
 Fri, 23 Feb 2024 12:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708692205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0+x/uvv7oe0tbuq7VVwCmpcf5SC/oY1olCb2bQGHDc=;
 b=qwzMSd5cNhQFFOE1j+H94RrwYyRPAw+osW89bUAL66LdY92o5E3ESv9RGGzqjCjGwqlH2e
 mq67S1QP2IazVa+zgLAPncVGEkYK+lvDz9md5FywBIvoC17MCPw+ePfb/6qpRE5udeuJcb
 jA/yTfiThz1dkmi7V4VEmHqDCqhaNas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708692205;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0+x/uvv7oe0tbuq7VVwCmpcf5SC/oY1olCb2bQGHDc=;
 b=+8bY/3ASS+3pXmOWd/2j7POjXESJvWz5YOKvxToK3QyljdmcHP/CeHAN8LH+YeD9EbX+96
 85SFlq0qFiKxIaAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708692203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0+x/uvv7oe0tbuq7VVwCmpcf5SC/oY1olCb2bQGHDc=;
 b=1cc3PQ6tKejMnSuBh9tVLcm+v7cFhmGH295KzNK1Xpv16R5NKgY+WaHaWdACWhTRqtdY47
 Sl7bhGbw6oDzngIpt0NVxh6Ba9N56+20hcy2bN5yaaaOF0EWaCoHjA4/pibkG3E6IieHAj
 RyAPxBoVWFjH87s9LhLLdhBPyBJ1AmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708692203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0+x/uvv7oe0tbuq7VVwCmpcf5SC/oY1olCb2bQGHDc=;
 b=QgV0wJ7CZHbZdNpqwDoSGoenMBb4PiH+D/kajVLQsRtmSecRepPPXCZ/9MgSkYYIVGLUA5
 oxbeC9YqrdDQCbCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D146133DC;
 Fri, 23 Feb 2024 12:43:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ABj0JOuS2GXLdwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 23 Feb 2024 12:43:23 +0000
Date: Fri, 23 Feb 2024 13:42:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZdiSqReYgNf88ema@yuki>
References: <20240104204614.1426027-1-pvorel@suse.cz>
 <20240104204614.1426027-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240104204614.1426027-3-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1cc3PQ6t;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QgV0wJ7C
X-Spamd-Result: default: False [0.19 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[15.56%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AE5281FC0C
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/9] metadata: parse.sh: Allow to pass list of
 files
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
> +if [ $# -gt 0 ]; then
> +	tests=$*
> +else
> +	tests=$(find testcases/ -name '*.c' | sort)
> +fi

This unfortunately does not work when there are unexpected characters in
the paths. Which shouldn't happen unless you pass an absoulte path to
the script which contains for example space.

I do not think that we can safely pass a list in a variable without
breaking it in that case. E.g. it works directly with $* or $@ if it's
quoted properly as:

for test in "$@"; do
	...

But as long as you pass $@ indirectly it breaks on spaces.


Note that the subshell $() with find has the same problem, but there is
much less room for breaking something because that is passed relative
paths inside of LTP.

And yes I hate argument parsing in shell..

> +for test in $tests; do
>  	a=$($top_builddir/metadata/metaparse -Iinclude -Itestcases/kernel/syscalls/utils/ "$test")
>  	if [ -n "$a" ]; then
>  		if [ -z "$first" ]; then

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
