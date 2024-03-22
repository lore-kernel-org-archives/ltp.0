Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10462C54E71
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 06:03:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66BF23CE623
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 07:03:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C2DA3C998A
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 07:02:48 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 02F6160B025
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 07:02:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 15CCA5F9A8;
 Fri, 22 Mar 2024 06:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711087367;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MlhAXgaG7hxUDuuKg/ivk4gBH+Az/BxR4G9a85qHcSk=;
 b=Hq2VESmCGbD1mGubE2hqhKvGlXedBK1yJm13icR5mf/H02uzM19Di29TTY04Bi+dXzU7ha
 AD0mH/pvb6Uxc8Xeakp8Tk87/4HvqskFaaf20Rnoh0O07G9Wc7xYV/qZNeg2nbNola8rva
 ftFKXlCeXbMJoFw43c+ielJsGc6Afo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711087367;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MlhAXgaG7hxUDuuKg/ivk4gBH+Az/BxR4G9a85qHcSk=;
 b=h98JEtqSzxIn3PvJ5eReteRppS5i9dw1AtBOy3Z+gwAblq0T27l+LaA6e08j7BeambBl8D
 OzLPTlznW5/udDCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711087367;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MlhAXgaG7hxUDuuKg/ivk4gBH+Az/BxR4G9a85qHcSk=;
 b=Hq2VESmCGbD1mGubE2hqhKvGlXedBK1yJm13icR5mf/H02uzM19Di29TTY04Bi+dXzU7ha
 AD0mH/pvb6Uxc8Xeakp8Tk87/4HvqskFaaf20Rnoh0O07G9Wc7xYV/qZNeg2nbNola8rva
 ftFKXlCeXbMJoFw43c+ielJsGc6Afo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711087367;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MlhAXgaG7hxUDuuKg/ivk4gBH+Az/BxR4G9a85qHcSk=;
 b=h98JEtqSzxIn3PvJ5eReteRppS5i9dw1AtBOy3Z+gwAblq0T27l+LaA6e08j7BeambBl8D
 OzLPTlznW5/udDCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0251613976;
 Fri, 22 Mar 2024 06:02:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I7pVOwYf/WWZAwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 22 Mar 2024 06:02:46 +0000
Date: Fri, 22 Mar 2024 07:02:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Shirisha G <shirisha@linux.ibm.com>
Message-ID: <20240322060245.GB589958@pevik>
References: <20240322052812.633953-1-shirisha@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240322052812.633953-1-shirisha@linux.ibm.com>
X-Spamd-Result: default: False [-1.45 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.95)[86.66%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Migrating the
 libhugetlbfs/testcases/truncate.c test
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

Hi,

> Test Description: Test is used to verify the correct functionality
nit: I would remove "Test Description: " and instead point out the link from
which test originated.

...
> +static void run_test(void)
> +{
> +	void *p;
> +	volatile unsigned int *q;
> +
> +	sigbus_count = 0;
> +	test_pass = 0;
> +
> +	struct sigaction my_sigaction;
> +
> +	my_sigaction.sa_handler = sigbus_handler;
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +			fd, 0);
> +	q = p;
> +	*q = 0;
> +	SAFE_SIGACTION(SIGBUS, &my_sigaction, NULL);
> +	SAFE_FTRUNCATE(fd, 0);
If any of these 2 SAFE_*() fails, we don't call SAFE_MUNMAP(), right?
But at least in hugemmap27.c it's happily ignored, I guess it can stay.

The rest LGTM.

Kind regards,
Petr

> +
> +	if (sigsetjmp(sig_escape, 1) == 0)
> +		*q;
> +	else
> +		sigbus_count++;
> +
> +	if (sigbus_count != 1)
> +		tst_res(TFAIL, "Didn't SIGBUS");
> +
> +	if (test_pass == 1)
> +		tst_res(TPASS, "Expected SIGBUS triggered");
> +
> +	SAFE_MUNMAP(p, hpage_size);
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
