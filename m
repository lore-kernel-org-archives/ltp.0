Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BC8C88E50
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 13:26:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEE9C3E9228
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 15:26:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05EAA3E2E82
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:26:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9FDC96002E5
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:26:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8F1EE21A00;
 Fri, 11 Sep 2026 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789133193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ADYmCrpqW4muqXvc2DE4Xw5x95gcExGx8FnTpqICj8M=;
 b=qSvv9iy+SiOCMVsdQweXhBQN0O3wv+lvQ0Wl7V3W1D8swiRzzkvsx552/tEAwT1fc2OhJ1
 5wwoZiyezGetU49u6LogBxMee5cgNsSA1pdTVHakmzKxLr93P/kA7tiv/zBATD7q9dM7Fi
 /F/eiA/sHSq/+pbcDQ9SA3MeD7P35u4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789133193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ADYmCrpqW4muqXvc2DE4Xw5x95gcExGx8FnTpqICj8M=;
 b=TvYzJOPexRNtDz69Ag+BBC30I/SS8mcW7qRGaRMPo+ttng7Z5it31YwFA4KPza0i2gR6f9
 5pil7BvkVj7+uIBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789133189;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ADYmCrpqW4muqXvc2DE4Xw5x95gcExGx8FnTpqICj8M=;
 b=rUODwJyzJJMqBxXQ8vCkIPBdsUJcQb2KVeoSqY1vANpOeP4Ymh+WaVINvHgeUgoZ8BGH84
 hOjPo6EVQ0A52QcU6dXfVN8OLfuhsT+EtyeVnxptMncotEtUU/n7vdvNjXChZLHvxMXbxZ
 DrpvHAR0jzB3gfrEtK0wqKnCvvUq/6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789133189;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ADYmCrpqW4muqXvc2DE4Xw5x95gcExGx8FnTpqICj8M=;
 b=CLaPcqx6/RkmidiumGsPSlm6V+W/3/p/PXjYo9N5zJFAdN0xGJEz8WUzwX0xcjOlktum6l
 htQV4oB2obnXRjCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58FEC132D3;
 Fri, 11 Sep 2026 13:26:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id k7C6FIUBpGqQOgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Sep 2026 13:26:29 +0000
Date: Fri, 11 Sep 2026 15:26:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
Message-ID: <20260911132627.GB1488703@pevik>
References: <20260828-mmap_32bit_coverage-v1-0-7f0b8b589773@suse.com>
 <20260828-mmap_32bit_coverage-v1-1-7f0b8b589773@suse.com>
 <20260911132038.GA1488703@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260911132038.GA1488703@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lapi/mmap: add MAP_32BIT fallback
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

> Hi Andrea,

> > +++ b/include/lapi/mmap.h
> > @@ -91,6 +91,10 @@
> >  # define MAP_DROPPABLE 0x08
> >  #endif

> > +#ifndef MAP_32BIT
> > +# define MAP_32BIT 0x40

> I know you guard the tests with .supported_archs to x86_64, but even that
> wouldn't be safer to define 0x40 only for x86_64?

> #ifndef MAP_32BIT
> # if defined __i386__ || defined(__x86_64__)
OK, only #ifdef __x86_64__

Kind regards,
Petr

> #  define MAP_32BIT 0x40
> # else
> #  define MAP_32BIT 0
> # endif
> #endif

> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
