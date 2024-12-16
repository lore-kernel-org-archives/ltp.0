Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF60E77184
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 12:34:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7008C3EBDCC
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 13:34:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89CA93EB674
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 13:33:43 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 13D126508FB
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 13:33:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 40F2C2110B;
 Mon, 16 Dec 2024 12:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734352422;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dwiazZ45DchG1JrkciRyThC5Rs11al+PAbq6RlQbeJ8=;
 b=wBfHM2LkrRhpo8JFN0CoEQ1NSihsvV1i5JWT0J8+4eA2IZB18iwJFXpErkPRbdYyCo8n/0
 CFMHiMLZk92AqONfF1lAAKXR3/2GaqJgWwgeebrnLxuNHEo+LqoFwXJcqWtg9kcTTsd0z+
 WfpQQ3k0t6WPVDjSDyXDAQPuF9IjnV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734352422;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dwiazZ45DchG1JrkciRyThC5Rs11al+PAbq6RlQbeJ8=;
 b=HTVV5KlgsWsVmVsqEa5ZEJbYgS+JqjzsAtWLtLXdQeIKOEZ5Z4aw+Jg8eYAH74taUNr1CO
 d5NIEwOF7gJj2gDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734352422;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dwiazZ45DchG1JrkciRyThC5Rs11al+PAbq6RlQbeJ8=;
 b=wBfHM2LkrRhpo8JFN0CoEQ1NSihsvV1i5JWT0J8+4eA2IZB18iwJFXpErkPRbdYyCo8n/0
 CFMHiMLZk92AqONfF1lAAKXR3/2GaqJgWwgeebrnLxuNHEo+LqoFwXJcqWtg9kcTTsd0z+
 WfpQQ3k0t6WPVDjSDyXDAQPuF9IjnV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734352422;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dwiazZ45DchG1JrkciRyThC5Rs11al+PAbq6RlQbeJ8=;
 b=HTVV5KlgsWsVmVsqEa5ZEJbYgS+JqjzsAtWLtLXdQeIKOEZ5Z4aw+Jg8eYAH74taUNr1CO
 d5NIEwOF7gJj2gDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AF18137CF;
 Mon, 16 Dec 2024 12:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q1T4CCYeYGcISwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 16 Dec 2024 12:33:42 +0000
Date: Mon, 16 Dec 2024 13:33:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241216123340.GA588092@pevik>
References: <20241203151530.16882-1-chrubis@suse.cz>
 <20241203151530.16882-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241203151530.16882-3-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.49 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.19)[-0.947]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SUBJECT_HAS_EXCLAIM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] libs/ujson: Fix "Garbage after JSON string!"
 in strict mode
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

Hi Cyril,

> In strict mode warnings are converted into errors and filled into the
> error buffer rather than being printed right away. That means that we
> have to print error buffer after we issue a warning so that it's printed
> in the strict mode (UJSON_READER_STRICT) as well.

Acked-by: Petr Vorel <pvorel@suse.cz>

nit: maybe add Fixes: before merge?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
