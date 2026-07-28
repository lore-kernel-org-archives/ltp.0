Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6381C53219
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 21:02:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A6303E74A1
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 23:02:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EC573E525F
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 23:02:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D32A42002A6
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 23:02:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DBD9D3DF5;
 Tue, 28 Jul 2026 21:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785272556;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AMP/hZbJyFX4zCRqO8jGnZ9VNXW1b5LWPQTjs8q2sCE=;
 b=yDjrsB0cjdWYlqCZct2Bo0Yo3haX7CccHCTrc/LFgomM8D6MSgeb6NVGpD025B2i8l0TfZ
 MQeVi8bVzAldVSImI4yNvEtMPxr9mel/8M/YqCnxsc1fd8X60UgOiEu3hUuzrU9vhXFfHg
 sWOlG4BoBDn0+0ZvI4NsQ8MicJptxGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785272556;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AMP/hZbJyFX4zCRqO8jGnZ9VNXW1b5LWPQTjs8q2sCE=;
 b=onYJSUKKbf+YYtL206xAG6yibg7BqM+Y7Mh479T9ZhKO4wz6MlcCIkfsqbYsAD/jgl4lin
 rXXwP/7WV6+W5MDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785272551;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AMP/hZbJyFX4zCRqO8jGnZ9VNXW1b5LWPQTjs8q2sCE=;
 b=SDNUD8q0PkyUW5PUXPuPnQbhlC/eDAorBNfQaMEZcwfbkpiN2d3rfJozZuhainghSM9Xds
 P4vOjsw1brwv2X81z0CR6K5hvgTgebKgHvmNPuIz2h7nzMrdjFsm6d/bQJQIk6cgtcP/Cg
 1ncGhhmd7QQ9uVMaWheR5DsGcYqdCM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785272551;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AMP/hZbJyFX4zCRqO8jGnZ9VNXW1b5LWPQTjs8q2sCE=;
 b=vLRkgBdyw1rNjSS6UI1SSRPaqDfn4ZnIG4pIDgFxMKMqZG+xSgC289uGLZcZrT9DcqKfbj
 /gLDaEYRPN37EtAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7F0A779B1;
 Tue, 28 Jul 2026 21:02:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q+tsJ+cYaWquDAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 Jul 2026 21:02:31 +0000
Date: Tue, 28 Jul 2026 23:02:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260728210228.GA114518@pevik>
References: <20260728135858.GB1128467@pevik>
 <6a68ba6d.6ab3636b.1b6ed.778e@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a68ba6d.6ab3636b.1b6ed.778e@mx.google.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lib: Avoid loop_info.lo_name buffer overflow
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr,

> > I suppose strncpy() is recommended as safer alternative to strcpy(),
> > right? Shouldn't we check for strlen(file) is not longer than
> > sizeof(loopinfo.lo_name) -1 while we are at it?

> we don't need to check for strlen(file) because strncpy() copy
> min(strlen(loopinfo.lo_name), strlen(file)) chars at max.

I mean if file is longer, then only part will be copied and following ioctl()
will fail, right? Therefore warning about too long name would help.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
