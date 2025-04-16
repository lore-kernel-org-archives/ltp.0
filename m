Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9104BC369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 08:38:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CF303CB957
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 10:38:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0D193CB949
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 10:38:05 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1982A1A00215
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 10:38:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 361F1211F4;
 Wed, 16 Apr 2025 08:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744792684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGzDETu7GbAFzBrEIB6tX97Tdc38d9+qL1IOtNAkZMM=;
 b=oUeNYq6pcSpZwRXFMUPa87bqtrkr1Z8YQ8TWXlBm992Mk1ji3et0UFnY2lVJBnI32fzMWs
 JwMr6uDPemq2nZ/KcHcyCWbaM/hdfWbI2LNr66gC2N6kzrFz2XnA4qHJteRuqb60/uTSGk
 xA87T2YrY9q1r4biAK4bj16zfRTHoI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744792684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGzDETu7GbAFzBrEIB6tX97Tdc38d9+qL1IOtNAkZMM=;
 b=Vc1xlcK2HVTqgtlIIHhDkeIT19Sl9a9gV7n8TLvoCXvvARWe4JL5SGLFcVq/GIgMe8GQnk
 kIarcAvTbL/igoDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744792684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGzDETu7GbAFzBrEIB6tX97Tdc38d9+qL1IOtNAkZMM=;
 b=oUeNYq6pcSpZwRXFMUPa87bqtrkr1Z8YQ8TWXlBm992Mk1ji3et0UFnY2lVJBnI32fzMWs
 JwMr6uDPemq2nZ/KcHcyCWbaM/hdfWbI2LNr66gC2N6kzrFz2XnA4qHJteRuqb60/uTSGk
 xA87T2YrY9q1r4biAK4bj16zfRTHoI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744792684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGzDETu7GbAFzBrEIB6tX97Tdc38d9+qL1IOtNAkZMM=;
 b=Vc1xlcK2HVTqgtlIIHhDkeIT19Sl9a9gV7n8TLvoCXvvARWe4JL5SGLFcVq/GIgMe8GQnk
 kIarcAvTbL/igoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0163B139A1;
 Wed, 16 Apr 2025 08:38:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oKkhOmts/2d9YgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 16 Apr 2025 08:38:03 +0000
Date: Wed, 16 Apr 2025 10:38:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250416083800.GA577362@pevik>
References: <20250415-patchwork_ci-v7-0-bc0b9adca971@suse.com>
 <20250415-patchwork_ci-v7-2-bc0b9adca971@suse.com>
 <CAEemH2e3CX4-oW98HhPt7+CaiNf4OYE8k7EkvNnZCV7spuwQmA@mail.gmail.com>
 <3cfc1784-dbf1-4230-a1ff-3cce2336997f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3cfc1784-dbf1-4230-a1ff-3cce2336997f@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/4] ci: add patchwork communication script
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
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Andrea,

> Hi Li,

> On 4/16/25 09:04, Li Wang wrote:
> > Maybe better to move this independent tool to the script/ dir?
> > This ci/tools/=A0is so hidden that it can easily be overlooked.

> We thought about it, but since it's mostly a related CI script we decided=
 to
> move it into ci/tools. The scripts/ folder seems to be more related to LTP
> tests development, so I'm a bit puzzled now :-)

> I let Petr Vorel the last word about it

Li, FYI I asked Andrea to keep patchwork.sh script in ci/tools/ because it's
related to CI and probably nobody will use it directly. I would like to kee=
p in
script/ only the scripts which will be used by people.  If you really think=
 that
somebody will be using it, we can have it in script/. WDYT?

(And why in ci/tools/ and not in ci/? I'd like to keep ci/*.sh for LTP users
as an easy way to install the dependencies.)

Kind regards,
Petr

> - Andrea

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
