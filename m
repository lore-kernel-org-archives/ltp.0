Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A208D5CC9F
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 12:15:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 014AE3CAE4D
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 13:15:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA2FF3CAE07
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 13:15:33 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 850ED100FB18
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 13:15:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2ADE1FB8A;
 Wed, 30 Oct 2024 12:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730290532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0P4iUnWmeZUYCxP4b7HrgC1D++4wwt4fNRp3wttlzk=;
 b=b5d+PF11kGQDbZUfkIU9295sTW7BI6zKSxthMxIi8hhECH5EjFV+m0RJHh99uuWQZIy2LN
 tfbCTwQ/q9Q8Lm1kcuMMSyCAFQAyv2prYFStCjwcQZxvI7TRVPsvB4av0P0tJ8HRw0oTdQ
 RvkrXgVVIqeh6AsLhKR8bql786C7UlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730290532;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0P4iUnWmeZUYCxP4b7HrgC1D++4wwt4fNRp3wttlzk=;
 b=RO8a9OvjOAV7hR8obhWRKCnLIyRmnDJSiz561rckM3mUYYK89bOrsUerIqVlsNtbGjrIFC
 D0tJk5XjQdqs3cCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730290532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0P4iUnWmeZUYCxP4b7HrgC1D++4wwt4fNRp3wttlzk=;
 b=b5d+PF11kGQDbZUfkIU9295sTW7BI6zKSxthMxIi8hhECH5EjFV+m0RJHh99uuWQZIy2LN
 tfbCTwQ/q9Q8Lm1kcuMMSyCAFQAyv2prYFStCjwcQZxvI7TRVPsvB4av0P0tJ8HRw0oTdQ
 RvkrXgVVIqeh6AsLhKR8bql786C7UlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730290532;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d0P4iUnWmeZUYCxP4b7HrgC1D++4wwt4fNRp3wttlzk=;
 b=RO8a9OvjOAV7hR8obhWRKCnLIyRmnDJSiz561rckM3mUYYK89bOrsUerIqVlsNtbGjrIFC
 D0tJk5XjQdqs3cCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABED813AD9;
 Wed, 30 Oct 2024 12:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gLLcKGQjImfrWAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 30 Oct 2024 12:15:32 +0000
Date: Wed, 30 Oct 2024 13:15:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZyIjZGIpFlFqLm42@yuki.lan>
References: <20241030084558.195297-1-liwang@redhat.com>
 <ZyIjHUuNFviz47gx@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZyIjHUuNFviz47gx@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: Print failure hints only once to reduce log
 duplication
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
> > The LTP test currently prints failure hints multiple times if a test
> > encounters several TFAIL or TBROK results. This leads to unnecessarily
> > verbose and duplicated logs.
> > 
> > This patch modifies the `print_failure_hints()` function to ensure that
> > failure hints are printed only once per test run. By setting `show_failure_hints`
> > to 0 after the first print, subsequent calls to `print_failure_hints()`
> > will not produce redundant output.
> 
> Hmm, we do call print_failure_hints() from do_exit() that calls exit()
> at the end of the function. We shouldn't print the hints twice, what do
> I miss?

Ah, right, we have two if () conditions that call the function in there,
so yes, we may print it twice.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
