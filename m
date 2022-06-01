Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517B1C433EF
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 10:37:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 192873C6AE8
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 12:37:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84A843C62DF
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 12:37:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E274B600A34
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 12:37:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4C74C1F45B;
 Wed,  1 Jun 2022 10:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654079850;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NlJjEX3ZW/VvBQVHxfKEUPiQOJaWAkO68MTzH3AY7P8=;
 b=ZctMjFXVwzbX3HgF6jtaPzFo8rjEFFrj2LhHA2GJtIgvOhPngAtXDOPQTjgHKRee9s7yB4
 kop8bHfmYab2R8nAqduzazu+gs+e8ihH+TnIvedFmb03MAQovJrl+yAk9XHht6pT8nJ9ex
 WU2IieJU0yEWuV3ZdCdyvZvDvs2rUa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654079850;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NlJjEX3ZW/VvBQVHxfKEUPiQOJaWAkO68MTzH3AY7P8=;
 b=h+3oe/BURltookGWa2TyL0kbwZjHo7WN45LtapbU7oMs2VYc14Mm5Emfc5xasz4SvtX3nd
 gPA+Bi0ZkwLYddDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D34F91330F;
 Wed,  1 Jun 2022 10:37:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hppuL2lBl2KxFQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 01 Jun 2022 10:37:29 +0000
Date: Wed, 1 Jun 2022 12:37:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YpdBWNhnL7Tsndyd@pevik>
References: <20220512194557.30911-1-pvorel@suse.cz>
 <20220512194557.30911-6-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220512194557.30911-6-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/8] shell: Add tst_clear_device
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> --- /dev/null
> +++ b/testcases/lib/tst_clear_device.c
...
> +int main(int argc, char *argv[])
> +{
> +	/*
> +	 * Force messages to be printed from the new library i.e. tst_test.c
> +	 *
> +	 * The new library prints messages into stderr while the old one prints
> +	 * them into stdout. When messages are printed into stderr we can
> +	 * safely do:
> +	 *
> +	 * DEV=$(tst_device acquire)
> +	 */
> +	tst_test = &test;
I guess this whole workaround is not needed for binary being used only in new
shell API (note for myself in case we decided to introduce new binary wrapper).

Kind regards,
Petr

> +	struct stat st;
> +
> +	if (argc < 2)
> +		goto help;
> +
> +	if (stat(argv[1], &st) < 0 || !S_ISBLK(st.st_mode))
> +		goto help;
> +
> +	return tst_clear_device(argv[1]);
> +help:
> +	print_help();
> +	return 1;
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
