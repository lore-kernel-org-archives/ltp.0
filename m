Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95102E7717F
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 22:03:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40F163EB87D
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 23:03:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02E503EB61B
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 23:03:06 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 54CA463E95C
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 23:03:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EBFAE1F7A5;
 Fri, 13 Dec 2024 22:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734127385;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7uJTNRHAY8AmIxKoi9RiBcQAfJXcqsxxvA5Dixgj9A=;
 b=zDcZV2Ba3pyO9NGQ9dW7OZ7pepbeCg/avPH184/B0azI/XEC4s7u/lDAdqoqlPspM3GmKi
 pkzzqwxOMGW/kA9eKVPFs8d4BcFgrsNNrjUFUIMMnPjEZSRYUjqvSi9rUc6pRPNKnhaBhS
 loOu8fXwuYvq87m94L/MyOBYQn0MP3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734127385;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7uJTNRHAY8AmIxKoi9RiBcQAfJXcqsxxvA5Dixgj9A=;
 b=jS5/AIzLvGCdC8rVI6tHsITdVYESYyz6QIqBgL79/L9+HjN5TBYEkoEUwwbqIAYD+pI0UK
 lRU4w1pAhUAshSBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734127384;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7uJTNRHAY8AmIxKoi9RiBcQAfJXcqsxxvA5Dixgj9A=;
 b=0cECw8yCZ2vebWWpmL0V2tFBMI6LJzQsdjRrAXtxFOCFjXk2LKDvgQrEhinwxsr0iY/Vzf
 fxoIgry7Bt9RozX9bbCIERyr8eO2aquFED1rqmA6MQOenT2MK49g+113DDIKTKSL1HbUDW
 VuFIk076fluYmdMfxrK4zV6rAtXSP5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734127384;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7uJTNRHAY8AmIxKoi9RiBcQAfJXcqsxxvA5Dixgj9A=;
 b=9+ABp8pp2BHPTZ3/3XsyY8MFTR1Glp6a8qS6BSSjzTYpuDAwD/YBCGjuV4by+Em+Y8Rdmq
 uEsMjN8/59f/orBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A29BA137CF;
 Fri, 13 Dec 2024 22:03:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8obMJRivXGdCPQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 13 Dec 2024 22:03:04 +0000
Date: Fri, 13 Dec 2024 23:02:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20241213220258.GA1577592@pevik>
References: <20241211105500.13530-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241211105500.13530-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_creat_unlinked(): Add missing mode argument
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
Cc: Tarun Sahu <tsahu@linux.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> The open() syscall requires the mode parameter if O_CREAT flag is used.
> Add the missing mode parameter to the tst_creat_unlinked() helper function.

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

> During investigation of strange hugemmap11 failures I've noticed that
> the test tries to create a scratch file with uninitialized access mode.
> This was unrelated to the failures but should be fixed anyway.

Good catch, rebased and merged.

I see from man open(2):


	The mode argument specifies the file mode bits to be applied when a new file
	is created.  If neither O_CREAT nor O_TMPFILE is specified in flags, then
	mode is ignored (and can thus be specified as 0, or simply omitted).  The
	mode argument must be supplied if O_CREAT or O_TMPFILE is specified in
	flags; if it is not supplied, some arbitrary bytes from the stack will be
	applied as the file mode.

It looks like that all O_TMPFILE are covered. Too late now to check O_CREAT.

It would be handy if somebody spent time to add this check into our sparse
checks.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
