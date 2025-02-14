Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866C9C02198
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 10:16:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFAB43C9AE8
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 11:16:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FFBE3C79D3
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 11:16:26 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CEE9E21FC35
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 11:16:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E887D21DD7;
 Fri, 14 Feb 2025 10:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739528183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/v1q4nD5blqwg4Zw+LX2Z9XEU/Q/pUF6pvpHm11uJUY=;
 b=F0Ct8kdGFs6QWdCzzOAH8jJnncfETjsnXh3U3syLAWrKO0XZyb8Df5Q+GxP27IZ1CTBii6
 QFaae0XpeCcEBHkFV0u/diwnRgSJ5ehElpEmw4TNt94Yv7sYMVRF/H8rBT6ORJdqJUm9Vz
 jfjwm7b1rFZLLlVJ6d/wV2KfOwZHthE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739528183;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/v1q4nD5blqwg4Zw+LX2Z9XEU/Q/pUF6pvpHm11uJUY=;
 b=gLOkYo4qFDpsVYNs+T0GvEEdgY55iPwihhwf2se+C4n4NYxwc39F41iDNF3K/V7r4watmX
 uIq1Rkx/DcxjfWAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739528182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/v1q4nD5blqwg4Zw+LX2Z9XEU/Q/pUF6pvpHm11uJUY=;
 b=RZHhRZErrbabnkKY5yNUuk5Fu2MQsDptpuRYzljDkyqxDuYLC8OajpvXcl3uXlFuDCV2V4
 E47DtASrJWrqjsDnrGa8lCEbzcawmbL3UiVI5+jdwLkbQcCn+zoHRCjxGri1aczZm4HVPC
 GwRG60Bw86w2Zztt7vOnrRX+URG25s8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739528182;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/v1q4nD5blqwg4Zw+LX2Z9XEU/Q/pUF6pvpHm11uJUY=;
 b=/p9y7SFQvbMSIxJWbUw4hx6WDV7xPCfc6q4udCdJVrwRuq/oUdU9YLcJGtgVAHIFFqOhMx
 m6uExRBANqMhAZDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D769013285;
 Fri, 14 Feb 2025 10:16:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d1OKM/YXr2fFSgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 14 Feb 2025 10:16:22 +0000
Date: Fri, 14 Feb 2025 11:16:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z68X-GLzmpViuimC@yuki.lan>
References: <20250213133730.27999-1-andrea.cervesato@suse.de>
 <20250213133730.27999-3-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250213133730.27999-3-andrea.cervesato@suse.de>
X-Spamd-Result: default: False [-8.29 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-2.99)[99.95%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] options: add new --run-pattern
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
> Add the --run-pattern|-S option to filter tests based on a specific
> string pattern. This option accepts a list of strings, allowing users
> to specify multiple patterns. A common usage example is as follows:
> 
>     kirk --run-pattern sendfile madvice
> 
> Each string is compared against the labels defined in the runtest file,
> and only tests containing the specified patterns will be executed.

So this is a substring match, right? I wonder if we should use a regular
expression instead, so that we can do more complex matches.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
