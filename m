Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B753DC54798
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 14:38:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F393A3CF97E
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 15:38:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EB363CEA31
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 15:38:00 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7450D60B042
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 15:38:00 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 778D821F34;
 Fri, 23 Feb 2024 14:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708699077;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KV8CVcI3VBL1zBoyO+JLLGPvEBBrlqCQZK1ZivDTyYQ=;
 b=Xuli/2ls9lpCenAIXkfVF7osP2e7nZW56sTn3WSNYdFMqyiQyiBb/5m23D4xsd1rp5B44m
 prKEYa97qEjOyjQIKe/24zKY9G1yMn16iWbtGm+6MR+Atvn3CCplavch5hqPo8Nmb5RQrH
 Gy8E7vf50ggG/d3UPFadFRnfWQw+6Kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708699077;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KV8CVcI3VBL1zBoyO+JLLGPvEBBrlqCQZK1ZivDTyYQ=;
 b=3w/L/TyEe897KvLrF0k5UdTHRiOVxH12Fn9swAEp/AhOIuZjlNrZNOaEXI9OLaGz2dKnVa
 0fIftKIZgoQy9RDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708699077;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KV8CVcI3VBL1zBoyO+JLLGPvEBBrlqCQZK1ZivDTyYQ=;
 b=Xuli/2ls9lpCenAIXkfVF7osP2e7nZW56sTn3WSNYdFMqyiQyiBb/5m23D4xsd1rp5B44m
 prKEYa97qEjOyjQIKe/24zKY9G1yMn16iWbtGm+6MR+Atvn3CCplavch5hqPo8Nmb5RQrH
 Gy8E7vf50ggG/d3UPFadFRnfWQw+6Kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708699077;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KV8CVcI3VBL1zBoyO+JLLGPvEBBrlqCQZK1ZivDTyYQ=;
 b=3w/L/TyEe897KvLrF0k5UdTHRiOVxH12Fn9swAEp/AhOIuZjlNrZNOaEXI9OLaGz2dKnVa
 0fIftKIZgoQy9RDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CB5013419;
 Fri, 23 Feb 2024 14:37:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id YmScEcWt2GX1BwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 23 Feb 2024 14:37:57 +0000
Date: Fri, 23 Feb 2024 15:37:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <20240223143755.GF1463543@pevik>
References: <20240104204614.1426027-1-pvorel@suse.cz>
 <20240104204614.1426027-4-pvorel@suse.cz> <ZdiTsXWqH-LkoxSQ@yuki>
 <20240223143344.GE1463543@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240223143344.GE1463543@pevik>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Xuli/2ls";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="3w/L/TyE"
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[26.86%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 778D821F34
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/9] metadata: parse.sh: Pass -v to metaparse on
 VERBOSE=1
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

> Hi Cyril,

> > Hi!
> > > +[ "$VERBOSE" ] && v="-v"

> > The build system uses just V=1 for a verbose mode so we should probably
> > be consistent...

> We actually use both, see include/mk/env_pre.mk

> ifeq ($V,1)
> VERBOSE=1
> endif

> Therefore should I use both here as well?

> [ "$VERBOSE" -o "$V" ] && v="-v"

[ "$V" ] && VERBOSE=1
...
a=$($top_builddir/metadata/metaparse $VERBOSE -Iinclude -Itestcases/kernel/syscalls/utils/ "$test")

(for global scope variable is better to use upper case)

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
