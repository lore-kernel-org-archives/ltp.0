Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4C4CAC5A5
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 13:16:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E1FB3CDF4B
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 15:16:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77EF73CDC15
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 15:15:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A97BF1A0090E
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 15:15:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F5995C78F;
 Wed, 24 Sep 2025 13:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758719749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mz8Tmu1svlZeLJk1lv6su4I48dDJrtsIAQjMN1O60Zc=;
 b=caC0YuF8m40jfqII5EDIh2tCsL0E9HVHRV4PFEU10avFGco/F4uSPHpfcKqz4MloleHMHa
 R34DubVmRijvDYpVHeBglq/SnmwgNDNb4EDipJrGL7c6BbvRjAD9nuaSZOlbDSb88vyS6r
 7lnlCsFLZYnHTrnj3yyu7ffQLDab95I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758719749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mz8Tmu1svlZeLJk1lv6su4I48dDJrtsIAQjMN1O60Zc=;
 b=VauGMyFLsf1nyBoY3W0ntTsJ9FxQ1rWKWX7/wqrxNmRoOcRllqVgFRy5svFprl0aCoMucn
 xO481vFq6ae8XZCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=caC0YuF8;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VauGMyFL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758719749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mz8Tmu1svlZeLJk1lv6su4I48dDJrtsIAQjMN1O60Zc=;
 b=caC0YuF8m40jfqII5EDIh2tCsL0E9HVHRV4PFEU10avFGco/F4uSPHpfcKqz4MloleHMHa
 R34DubVmRijvDYpVHeBglq/SnmwgNDNb4EDipJrGL7c6BbvRjAD9nuaSZOlbDSb88vyS6r
 7lnlCsFLZYnHTrnj3yyu7ffQLDab95I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758719749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mz8Tmu1svlZeLJk1lv6su4I48dDJrtsIAQjMN1O60Zc=;
 b=VauGMyFLsf1nyBoY3W0ntTsJ9FxQ1rWKWX7/wqrxNmRoOcRllqVgFRy5svFprl0aCoMucn
 xO481vFq6ae8XZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E38B13A61;
 Wed, 24 Sep 2025 13:15:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7dh8IQXv02gKZAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Sep 2025 13:15:49 +0000
Date: Wed, 24 Sep 2025 15:16:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <aNPvMlvtNd-4K9K8@yuki.lan>
References: <20250923154827.74305-1-mdoucha@suse.cz>
 <aNOyLCG_Yhv4Rk30@yuki.lan>
 <1c7404a7-87aa-4c1f-a8f5-08fab2c69fea@suse.cz>
 <aNPbb6IDKO2IaMaj@yuki.lan>
 <48487e51-0e3d-4dcd-b25f-2dc9dba74172@suse.cz>
 <aNPfJMs4nWRSeEu8@yuki.lan>
 <44c9d5e1-c190-43f1-a600-97d3bddf2b6d@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <44c9d5e1-c190-43f1-a600-97d3bddf2b6d@suse.cz>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email, suse.cz:dkim]
X-Rspamd-Queue-Id: 9F5995C78F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] epoll_pwait06: Skip BPF map file descriptor
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
> Sure, we can add another test for epoll_ctl() later. I wrote 
> epoll_pwait06 because I actually ran into the timeout regression while 
> playing a game at home. I decided to loop over multiple file descriptor 
> types because it's simple enough and provides better coverage for edge 
> cases.
> 
> Now, should I resubmit with that EPERM check or is the one-line fix good 
> enough as is?

Let's go with that for the release as long as you promise to add more
tests later.

For the original patch:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
