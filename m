Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3037DCA5FA5
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 14:45:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D65DF3E586F
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 16:45:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 465283C2169
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:45:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BD6F21000A5D
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:45:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C719C1F449;
 Tue, 29 Sep 2026 14:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790693117;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FCUz90eY5IV5L6Ah5N+MGCidTbPzL7w4wBHeumt+BO4=;
 b=Td5GfgfeneyjyyK3OTNIVEOGgwM48hm4q6J9tCFkpxy45Coebl0UadZ6SpA1HYGjVq9jK2
 2nBjQNWcEyb2UNj4L6u9Y99+jxibUdWLRllE3XVuIc2eicdjewnvYIE2Seb27q6AiuZKpU
 V04nIGsDtfkUKUvV4MMaeXqD62YO3TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790693117;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FCUz90eY5IV5L6Ah5N+MGCidTbPzL7w4wBHeumt+BO4=;
 b=T2or2jJghj8qBs5kTn1KLRJD105axvIjYWCexqIXtr96n9jbHTUcKZbXbWQhUiGoRIuavz
 InGOeGISVbI6LzCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790693112;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FCUz90eY5IV5L6Ah5N+MGCidTbPzL7w4wBHeumt+BO4=;
 b=xB5sjGZQUbgKsZ2AO9HbGFMhICIL0wSX4a2qu+oNVk6dbNqsp+uuqpNYWxVwITmgn2yoDo
 KaufDNl2bbK93iDS+ppGPfgHzEBqEfGLSnGlE7tAacDZFcSRN5H/50AYuZnAW519iz+G8T
 msnxgiMDEG0GgeWml8iTe7TwetmHk3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790693112;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FCUz90eY5IV5L6Ah5N+MGCidTbPzL7w4wBHeumt+BO4=;
 b=x5IKwaTbKGDeJp1A0FJkPMWePthNgU5PlaG71uHj9h7cOawfor5s7uYXjfGUFWsYBeBmT5
 T3uYiaXKkLDD+QAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71DF5133F1;
 Tue, 29 Sep 2026 14:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZB+QDvjOu2r8bwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 29 Sep 2026 14:45:12 +0000
Date: Tue, 29 Sep 2026 16:45:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "Kubaj, Piotr" <piotr.kubaj@intel.com>
Message-ID: <20260929144510.GC2462033@pevik>
References: <20260904124042.212065-1-piotr.kubaj@intel.com>
 <281763bcdff18b7512ee8f851979d015e482e987.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <281763bcdff18b7512ee8f851979d015e482e987.camel@intel.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_EQ_ADDR_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCPT_COUNT_FIVE(0.00)[6]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] pmc_core: cover the PkgC LTR blocker counters
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
Cc: "Niestepski, Daniel" <daniel.niestepski@intel.com>, "Ossowski,
 Tomasz" <tomasz.ossowski@intel.com>, "Dubel,
 Helena Anna" <helena.anna.dubel@intel.com>, "Wysocki,
 Rafael J" <rafael.j.wysocki@intel.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

<snip>

> Hello,

> for some reason I haven't got any reply either from the developers or
> the AI bot. However, all the CI tests at
> https://patchwork.kernel.org/project/ltp/list/?series=1164357 seem to
> pass. Is there any remaining issue?

We strive to do LTP release, no more time for completely new tests. Please be
patient.

Quiet agent: end of the month, likely out of tokens.

> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
> Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

Please reconsider dropping this when posting to ML
https://subspace.kernel.org/etiquette.html#do-not-include-confidentiality-disclaimers

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
