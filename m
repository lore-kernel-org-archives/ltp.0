Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E12D5CCA1
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 12:14:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1876D3C97B6
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 13:14:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E8E63C1AFC
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 13:14:24 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 42E96242E65
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 13:14:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 12AC521BE7;
 Wed, 30 Oct 2024 12:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730290462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eBcfZDzwf/EVVOze/cZM9eSsGzOMTNT7LJa22eneqXw=;
 b=qpDp/oHV0OZa3lUR5PLL135PPnwDBzNCUngpeOBpj4YAHoTRYDm1x0IHbjTk24F6j3X5X9
 8Kh07BUM18tdIlwWsXy/MQUTKnLLBOUxD8ppTe02EgSMqsfsI61VcRiUsFKAfO0JJ85/Ly
 ri2Hzswi8FHQ2YuroYwq3BIkdb598O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730290462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eBcfZDzwf/EVVOze/cZM9eSsGzOMTNT7LJa22eneqXw=;
 b=t97l0XF3eKnf80EPmuG0SLxhsEfmcVtemUbru2Q81qh7DIaiPSvbIYRxyoSp6QGmpdeib3
 8i9XtH7ImyliAcAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZCj1WTta;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dV8c5bmH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730290461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eBcfZDzwf/EVVOze/cZM9eSsGzOMTNT7LJa22eneqXw=;
 b=ZCj1WTtaVQGUVZ4pXTqIglQCCLWPA9ae9kj8xdCoWWUafkvrT4wOGK5bg8DN7X4Y7bsp/d
 bdf2ARf4giw5HJCAOUh/eYcgkCxKWw7bWfNMuI3sUSWVmBHepj3ircMFcoe+yLmFsoMyjW
 LdMQdXDj0SOHL3ty8vI/vY1WTt+QDBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730290461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eBcfZDzwf/EVVOze/cZM9eSsGzOMTNT7LJa22eneqXw=;
 b=dV8c5bmHumt1W8kphX/ryjXflBzUe2jIfzBKQWXo9RLcvWLDfEpb2M4XOHEyMX2q3FiBg2
 DS3+Xfs8A4CSmeDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01B8613AD9;
 Wed, 30 Oct 2024 12:14:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JdYFOxwjImdwWAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 30 Oct 2024 12:14:20 +0000
Date: Wed, 30 Oct 2024 13:14:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZyIjHUuNFviz47gx@yuki.lan>
References: <20241030084558.195297-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241030084558.195297-1-liwang@redhat.com>
X-Rspamd-Queue-Id: 12AC521BE7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.47 / 50.00]; BAYES_HAM(-2.96)[99.81%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,yuki.lan:mid];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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
> The LTP test currently prints failure hints multiple times if a test
> encounters several TFAIL or TBROK results. This leads to unnecessarily
> verbose and duplicated logs.
> 
> This patch modifies the `print_failure_hints()` function to ensure that
> failure hints are printed only once per test run. By setting `show_failure_hints`
> to 0 after the first print, subsequent calls to `print_failure_hints()`
> will not produce redundant output.

Hmm, we do call print_failure_hints() from do_exit() that calls exit()
at the end of the function. We shouldn't print the hints twice, what do
I miss?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
