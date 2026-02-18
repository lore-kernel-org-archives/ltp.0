Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E558AE9A03E
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 10:49:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EC303D06EA
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 11:49:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 337E73CE321
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 11:49:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E3CC01A007F2
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 11:49:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D3755BCCA;
 Wed, 18 Feb 2026 10:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771411744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jlw3CRds5gdSRDB1RXY3/QcqCZYaNKQ11crPdSjDldM=;
 b=lenYbb0mIxKRu6loOpOjph4exAhpjW5/ECon8fUzA9I8KBiqy8wPl+iOu0ZmIxWaSMzRgy
 cat2UQIJY2ukGONwppqRM+RThM/N092V7TiO8OtRNkfZ7eIR9fnfw9IQBPJpcWOaPcDnuy
 iYlKo/qxmjiKuyteHksvUIraZm+mrnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771411744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jlw3CRds5gdSRDB1RXY3/QcqCZYaNKQ11crPdSjDldM=;
 b=nCo789Oyd5Lwa60c+IlfWSKuAGyNHm6ytjQKTqcW8W2ThF/1zwPsfG9L01j/rv2qq8dCz6
 UAGnjzwDPMUIbNAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771411744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jlw3CRds5gdSRDB1RXY3/QcqCZYaNKQ11crPdSjDldM=;
 b=lenYbb0mIxKRu6loOpOjph4exAhpjW5/ECon8fUzA9I8KBiqy8wPl+iOu0ZmIxWaSMzRgy
 cat2UQIJY2ukGONwppqRM+RThM/N092V7TiO8OtRNkfZ7eIR9fnfw9IQBPJpcWOaPcDnuy
 iYlKo/qxmjiKuyteHksvUIraZm+mrnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771411744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jlw3CRds5gdSRDB1RXY3/QcqCZYaNKQ11crPdSjDldM=;
 b=nCo789Oyd5Lwa60c+IlfWSKuAGyNHm6ytjQKTqcW8W2ThF/1zwPsfG9L01j/rv2qq8dCz6
 UAGnjzwDPMUIbNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E3DF3EA65;
 Wed, 18 Feb 2026 10:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Abp3FSCZlWnnNwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Feb 2026 10:49:04 +0000
Date: Wed, 18 Feb 2026 11:49:01 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <aZWZHec0KoEH42H5@yuki.lan>
References: <20260206155244.243291-1-rbranco@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260206155244.243291-1-rbranco@suse.de>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.cz:email,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] userfaultfd: Add test using UFFDIO_POISON
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static void *handle_thread(void)
> +{
> +	static struct uffd_msg msg;
> +	struct uffdio_poison uffdio_poison = {};
> +	struct pollfd pollfd;
> +	int nready;
> +
> +	SAFE_PTHREAD_BARRIER_WAIT(&barrier);

I still do not understand why we need the barrier here. The thread that
tries to access the memory should block until this thread processes the
event sicne the usefaultfd range was registered before the memory is
accessed. 

Also the same pattern is present in rest of the usefaultfd tests, so
either we need this barrier in all of them, or it shouldn't be needed
here.

And the test seems to work just fine if I remove the barrier code.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
