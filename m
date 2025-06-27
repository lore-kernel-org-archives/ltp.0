Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6830C77B7F
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 09:53:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 832163C7ACE
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 11:53:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 483873C1924
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 11:53:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 229AE600138
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 11:53:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7472521174;
 Fri, 27 Jun 2025 09:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751017992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hkwOLKupK8qT/hBBjIDy34UVLdkRpA81IKI09yXKjLQ=;
 b=KvRzFuS2JEnTIlBWKwrp9q2fLot+Z5HUy04J2wLG5GhOhe0h/UfyJFIk9EcaRLMAq62hrR
 amM9wZr91+i1/n8Jsie7qV9AL1fzhyO9hWKEHOoiKE2I0YH87+i4HB1S5hneZl4TF1cO50
 FGp5I4fzAHHEMe35cMBGWCm0sz6abBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751017992;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hkwOLKupK8qT/hBBjIDy34UVLdkRpA81IKI09yXKjLQ=;
 b=KtZa/wr4VW0pUiVVWm1QOBWoyU/iA2maxpsGu8fngX7wduExeS5yQvGsEfPPGMQ6yvPzO/
 0iOqVgeDlUONwjBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KvRzFuS2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="KtZa/wr4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751017992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hkwOLKupK8qT/hBBjIDy34UVLdkRpA81IKI09yXKjLQ=;
 b=KvRzFuS2JEnTIlBWKwrp9q2fLot+Z5HUy04J2wLG5GhOhe0h/UfyJFIk9EcaRLMAq62hrR
 amM9wZr91+i1/n8Jsie7qV9AL1fzhyO9hWKEHOoiKE2I0YH87+i4HB1S5hneZl4TF1cO50
 FGp5I4fzAHHEMe35cMBGWCm0sz6abBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751017992;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hkwOLKupK8qT/hBBjIDy34UVLdkRpA81IKI09yXKjLQ=;
 b=KtZa/wr4VW0pUiVVWm1QOBWoyU/iA2maxpsGu8fngX7wduExeS5yQvGsEfPPGMQ6yvPzO/
 0iOqVgeDlUONwjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 652A913786;
 Fri, 27 Jun 2025 09:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PPmZFwhqXmjwdAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Jun 2025 09:53:12 +0000
Date: Fri, 27 Jun 2025 11:53:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aF5qMAHNB99t4qYz@yuki.lan>
References: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
 <20250626-ioctl_pidfd_suite-v1-4-165b9abf0296@suse.com>
 <aF5gXnHipDoPXla6@yuki.lan> <aF5orcIPzGviYyj6@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aF5orcIPzGviYyj6@yuki.lan>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 7472521174
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/6] Add ioctl_pidfd02 test
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
> > > +	TST_EXP_EQ_LI(info->mask & PIDFD_INFO_EXIT, PIDFD_INFO_EXIT);
> > > +	TST_EXP_EQ_LI(WIFEXITED(info->exit_code), WIFEXITED(status));
> > > +	TST_EXP_EQ_LI(WEXITSTATUS(info->exit_code), WEXITSTATUS(status));
> > 
> > And here we should check that we got the same fields set as in the
> > previous case when the process was still running plus the exit_code.
> > 
> > I suppose that we will need two info structures so that we can do the
> > comparsion. Also it wouldn't harm to clear the structures with memset
> > before use.
> 
> Ah no, if task has been reaped only exit value is available. So in the
> latter case only the PIDFD_INFO_EXIT should be set in flags.

Uff and it's the same in both of the cases actually. Since the process
is cloned into new pid namespace, we can only get the return value.

So what we should check in the first case when the process is stil
running is that the PIDFD_INFO_EXIT flag is not set, since that
indicates that the exit_code has been filled in.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
