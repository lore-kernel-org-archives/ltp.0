Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4089C3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 15:27:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3048B3D3866
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 17:27:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3D4D3D3819
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 17:26:57 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 182EC601931
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 17:26:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B07B1F836;
 Wed, 10 Jul 2024 15:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720625216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZOGWHrhLeJn+Lff6WwaVj+sPgHCaERyMf5clZeUdUY=;
 b=WUteEpOuWxyVZkRoIecNIcp/8uFBfwXnU094HOAABtnkexNnK1sDsz/eqCKimJWlsqwKK5
 kPtKg4/HEVwZdUZs0VjQAuGLl+c5/oIewYC8JmUrF+ShExlEuaRoAuUQGM62/o+LpinZ6F
 Bz50DZpKWSWLj14MaQ5BgWtjcwLkpQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720625216;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZOGWHrhLeJn+Lff6WwaVj+sPgHCaERyMf5clZeUdUY=;
 b=/9Ez4AStwIGeBUtT96HdJKfrqR8Pb1nhn3DJF5kmK3a+6Z0aDKSXmwfHCvTLLavQeOorzi
 QfiVffdhSBcU0wBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720625216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZOGWHrhLeJn+Lff6WwaVj+sPgHCaERyMf5clZeUdUY=;
 b=WUteEpOuWxyVZkRoIecNIcp/8uFBfwXnU094HOAABtnkexNnK1sDsz/eqCKimJWlsqwKK5
 kPtKg4/HEVwZdUZs0VjQAuGLl+c5/oIewYC8JmUrF+ShExlEuaRoAuUQGM62/o+LpinZ6F
 Bz50DZpKWSWLj14MaQ5BgWtjcwLkpQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720625216;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZOGWHrhLeJn+Lff6WwaVj+sPgHCaERyMf5clZeUdUY=;
 b=/9Ez4AStwIGeBUtT96HdJKfrqR8Pb1nhn3DJF5kmK3a+6Z0aDKSXmwfHCvTLLavQeOorzi
 QfiVffdhSBcU0wBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0994B1369A;
 Wed, 10 Jul 2024 15:26:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wmlXAUCojmY6TwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 10 Jul 2024 15:26:56 +0000
Date: Wed, 10 Jul 2024 17:26:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Zo6oO7qukDzxqDXO@yuki>
References: <09c8813ad86c4a8034e3e35a183355c4f887f1b4.1720527432.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <09c8813ad86c4a8034e3e35a183355c4f887f1b4.1720527432.git.jstancek@redhat.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kallsyms: skip user-space mapped addresses
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
Cc: liwan@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static int is_address_mapped(unsigned long addr)
> +{
> +	int i;
> +
> +	for (i = 0; i < ranges_len; i++) {
> +		if (ranges[i*2] <= addr && addr < ranges[i*2 + 1])
> +			return 1;
> +	}
> +	return 0;
> +}

I would put the ranges into an array of structures so that we have a
slightly more readable code, e.g.

	if (ranges[i].start <= addr && addr < ranges[i].end)
		return 1;

And the 2 * would vanish from most of the places in the code that reads
the maps as well...

But otherwise the code looks good.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
