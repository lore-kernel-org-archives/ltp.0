Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D98E7717F
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 17:29:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B75B43EC40A
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 18:29:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E79F03EC3E1
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 18:29:27 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5E1B4602A0B
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 18:29:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6AFBC1F395;
 Mon, 16 Dec 2024 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734370166;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=azf2W7n6pLCxVzragcprysHi25rIbZOq5/03kRTugtE=;
 b=1UQrS7k4R8kgKHFfFl2K1KAKopGud43UpHIjcsCJuEAcUGlG1iqe83ZONGqh7K8lFeadWc
 0EFv21qm1+VUnX/+WFk083y4t2uPXTeKCeQveK6L6kZh4ZB6ICuJ3Je5LROLfNFWn4Ukhn
 m1Dr90QsA7R5PpaGQctUT/R89O5vJss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734370166;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=azf2W7n6pLCxVzragcprysHi25rIbZOq5/03kRTugtE=;
 b=W7ndL5ikwbYBmY6c5iatTuDh+btip+cjDwvkSaqNqBaXDH5ljZ4XBDNtblcbO4YBA8hCr1
 utiwL/6+ZCqlNkCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734370166;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=azf2W7n6pLCxVzragcprysHi25rIbZOq5/03kRTugtE=;
 b=1UQrS7k4R8kgKHFfFl2K1KAKopGud43UpHIjcsCJuEAcUGlG1iqe83ZONGqh7K8lFeadWc
 0EFv21qm1+VUnX/+WFk083y4t2uPXTeKCeQveK6L6kZh4ZB6ICuJ3Je5LROLfNFWn4Ukhn
 m1Dr90QsA7R5PpaGQctUT/R89O5vJss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734370166;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=azf2W7n6pLCxVzragcprysHi25rIbZOq5/03kRTugtE=;
 b=W7ndL5ikwbYBmY6c5iatTuDh+btip+cjDwvkSaqNqBaXDH5ljZ4XBDNtblcbO4YBA8hCr1
 utiwL/6+ZCqlNkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CA19139D4;
 Mon, 16 Dec 2024 17:29:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bUX1DHZjYGeeMAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 16 Dec 2024 17:29:26 +0000
Date: Mon, 16 Dec 2024 18:29:24 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241216172924.GA603881@pevik>
References: <20241212060448.204158-1-liwang@redhat.com>
 <20241213224041.GB1577592@pevik> <Z2AkZabEU12gomtZ@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z2AkZabEU12gomtZ@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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
> > > +	if (tst_has_slow_kconfig())
> > > +		max_runtime *= 4;
> > Maybe note here what we do? (TINFO)

> That really depends on how verbose we want to be, we already print the
> overall test timeout which is timeout + runtime. So it's somehow visible
> in the test runtime has been increased. Maybe we should make the info
> message in set_timeout() better by printing the runtime separately there
> if non-zero.

Sounds useful to me.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
