Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEFF103E16D
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 12:26:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D89AF3E58F3
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 13:26:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA91E3E48F8
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 13:26:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 653501000DE7
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 13:26:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 927DF5BEB9;
 Wed, 18 Mar 2026 12:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773836763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xBLwn0hq3CDUXPTbC1M34AGmsvOVW69AR64Rttk/xOs=;
 b=cIh+S5JI9u5daN0QxUdL9/eLgtz/SrzW0EgXalgszG2ctJuFM7un1YvTpiz45/5NMqL25b
 CzWwguA2R/U75wQqEiDRnCHdgWeMps4ef7ym/6o+yrNzfXlMS2aykicC8E3zEr3GutPjuQ
 Nrg6kTVk+cNkR4lzPPdONPvqUNsiIBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773836763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xBLwn0hq3CDUXPTbC1M34AGmsvOVW69AR64Rttk/xOs=;
 b=EXFVnQ4MNbNNNNFdZ7Escize+KRxtfl/d41JUuwT0aQZn6iaFmKWCgAHR6eCnzigdt7uok
 3O5Uln9IMsTYzIBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773836763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xBLwn0hq3CDUXPTbC1M34AGmsvOVW69AR64Rttk/xOs=;
 b=cIh+S5JI9u5daN0QxUdL9/eLgtz/SrzW0EgXalgszG2ctJuFM7un1YvTpiz45/5NMqL25b
 CzWwguA2R/U75wQqEiDRnCHdgWeMps4ef7ym/6o+yrNzfXlMS2aykicC8E3zEr3GutPjuQ
 Nrg6kTVk+cNkR4lzPPdONPvqUNsiIBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773836763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xBLwn0hq3CDUXPTbC1M34AGmsvOVW69AR64Rttk/xOs=;
 b=EXFVnQ4MNbNNNNFdZ7Escize+KRxtfl/d41JUuwT0aQZn6iaFmKWCgAHR6eCnzigdt7uok
 3O5Uln9IMsTYzIBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 810394273B;
 Wed, 18 Mar 2026 12:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SC1hHtuZumlIXwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Mar 2026 12:26:03 +0000
Date: Wed, 18 Mar 2026 13:26:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <abqZ3h1iVo5DaQ_4@yuki.lan>
References: <20260313142600.243939-1-pvorel@suse.cz>
 <20260313142600.243939-6-pvorel@suse.cz>
 <abkh9aPkKAewapRr@redhat.com> <abqLM0iQY7nwPaDm@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <abqLM0iQY7nwPaDm@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/6] [WIP,RFC] tst_run.sh: Run setup() only once
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> It's a bit more complicated we do not have only iterations but also
> duration and timeout per iteration. So we would need a function that
> would return if the script should continue or not and also call the
> heartbeat() function. Something as:
> 
> int tst_next_shell_iteration(void)
> {
> 	int cont = 0;
> 	static int iteration = 0;
> 
> 	if (iteration < iterations)
> 		cont = 1;
> 
> 	if (stop_time && get_time_ms() < stop_time())
> 		cont = 1;
> 
> 	if (!cont)
> 		return 0;
> 
> 	heartbeat();
> 	return ++iteration;
> }
> 
> The shell helper would call this and we would use it in tst_run.sh and
> loop the tst_test() until we are said to stop.

Note also that this solution would move the iteration into the shell
script, since if we do not iterate in the shell, we will end up with a
different environment in the second and subsequent iterations. That
means that any variables exported in setup() would be lost in subsequent
iterations, the pid of the shell would be different, etc.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
