Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E64CD4F24
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 16:21:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D65333D787F
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 18:21:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E5933CC026
 for <ltp@lists.linux.it>; Tue, 12 May 2026 18:21:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AC97C1400261
 for <ltp@lists.linux.it>; Tue, 12 May 2026 18:21:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E74175E46;
 Tue, 12 May 2026 16:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778602870;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I4/nZUozEpVQfble0EqHUtPVfax6iwvm24DhBDmy0UQ=;
 b=Qbd4vais05cuEucBQlJjcg9Kxbk08xV7Q+1ZCwiI2eJ6MQSWslMRl6KJp5HjlwS169uyQs
 codcgNi5o5EvEhurJeq8VoNVy0puhKBtyntZ6gcAjg292CEWw6+BPeqvc/aRtSQvNjPcfh
 4D509XLtuNU3b9FwI98K4e6YTY9uKro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778602870;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I4/nZUozEpVQfble0EqHUtPVfax6iwvm24DhBDmy0UQ=;
 b=JldBNRwtj5ULjs5TcRRz6ioaRIEJfpFMbnth1Fs5y3sj+642iywfEXsMbPckWs4SCsXDkP
 A0WzBH2sccdgJCBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778602866;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I4/nZUozEpVQfble0EqHUtPVfax6iwvm24DhBDmy0UQ=;
 b=BSpWK4wnpzKwtJ+VD4f4+2GDqJFiMVhD3Eo0Sf4HOPIRH+rTVUifL5zGyh93zM3HP4Uwey
 5Q6zzktFIZzTBOlHrwW5lXVegbO0ihMVZ0GqP9wqw0sbZfve//ZGQE2Je4aATwhvzsMCc2
 hIdC7zit1U0+vnRTs335VvsleJeZ6ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778602866;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I4/nZUozEpVQfble0EqHUtPVfax6iwvm24DhBDmy0UQ=;
 b=25e6W5IkuMmT4x3aAsEsOPrUhI+nn8s5nHZCMAxbIP65PgJPdMZk+77Xl8vnx8TI9a1Wp/
 kgtSS7P/ghZmbuAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8255593A9;
 Tue, 12 May 2026 16:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zaFaM3FTA2rEBQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 May 2026 16:21:05 +0000
Date: Tue, 12 May 2026 18:21:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Sachin Sant <sachinp@linux.ibm.com>
Message-ID: <20260512162103.GA38597@pevik>
References: <20260511070852.90379-1-pvorel@suse.cz>
 <dc4311f6-014b-4fe1-b7ee-5e3399d0a0e5@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dc4311f6-014b-4fe1-b7ee-5e3399d0a0e5@linux.ibm.com>
X-Spamd-Result: default: False [-3.10 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 URL_IN_SUBJECT(0.40)[www.cve.org];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,cve.org:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,cve.org:url];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/cve_catalog: Link CVE to www.cve.org
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

thanks for your review, merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
