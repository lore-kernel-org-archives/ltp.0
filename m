Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80560A2619
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=TWkXXbIf;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XHz879cE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=TWkXXbIf;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XHz879cE
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 373B03EB5CE
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 20:39:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C5833C69BF
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 20:39:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CC6E6600837
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 20:39:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 48A8C22079;
 Mon,  9 Nov 2026 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794253162;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XjzzfrUXU8EVD0n3Q/GtP7hItV+OQ5CO5fo1fIwG3fw=;
 b=TWkXXbIfoGyddzmblpOrZ6FlaTeLw7BI8VcllVSuo5+nHzOBOismdoIkvquZd1CfCf9Kir
 ZuVt3JZ5Se70Y3x6NawtmYD3YWE7XoPfo+yCweUfZsqBYW0RrNfx+jkjvVupHmvfbTdK+g
 tgONgpmtmO/k5Jly1ndd76bwq/6r1DE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794253162;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XjzzfrUXU8EVD0n3Q/GtP7hItV+OQ5CO5fo1fIwG3fw=;
 b=XHz879cE9XlU1FQDZfjb6SQksFJKMEl5e7ajHQUjjnDot8AUqkuzRZQ8c78tp4ug7HXLzl
 /KglvDWYmKENHoAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794253162;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XjzzfrUXU8EVD0n3Q/GtP7hItV+OQ5CO5fo1fIwG3fw=;
 b=TWkXXbIfoGyddzmblpOrZ6FlaTeLw7BI8VcllVSuo5+nHzOBOismdoIkvquZd1CfCf9Kir
 ZuVt3JZ5Se70Y3x6NawtmYD3YWE7XoPfo+yCweUfZsqBYW0RrNfx+jkjvVupHmvfbTdK+g
 tgONgpmtmO/k5Jly1ndd76bwq/6r1DE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794253162;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XjzzfrUXU8EVD0n3Q/GtP7hItV+OQ5CO5fo1fIwG3fw=;
 b=XHz879cE9XlU1FQDZfjb6SQksFJKMEl5e7ajHQUjjnDot8AUqkuzRZQ8c78tp4ug7HXLzl
 /KglvDWYmKENHoAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E43DC13319;
 Mon,  9 Nov 2026 19:39:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oag5LWkh8moIKgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Nov 2026 19:39:21 +0000
Date: Mon, 9 Nov 2026 20:39:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <20261109193919.GA665818@pevik>
References: <20261106164105.615423-1-pvorel@suse.cz>
 <avG4D4xe2XW9JrIQ@yuki.lan> <20261109131211.GB631538@pevik>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261109131211.GB631538@pevik>
X-Spam-Level: 
X-Spamd-Result: default: False [-12.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.50
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] zram01.sh: Rewrite to run by single filesystem
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Hi!

Anyway, I've sent a patch which rewrites test zram_fill_fs() to use write file
with single 'dd' instead of many 'dd' while loop for 1kb.

https://lore.kernel.org/ltp/20261109193344.669217-1-pvorel@suse.cz/T/#u
https://patchwork.kernel.org/project/ltp/patch/20261109193344.669217-1-pvorel@suse.cz/

...
> What is the exact problem you are trying to fix?

I owe you an explanation. zram01.sh is very slow on btrfs.
More info is in thread of that patch.
https://lore.kernel.org/ltp/20261109193809.GA669592@pevik/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
