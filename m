Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A76CA0FED
	for <ltp@archiver.kernel.org>; Wed, 10 Sep 2025 16:26:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 652613CD7BB
	for <ltp@archiver.kernel.org>; Wed, 10 Sep 2025 18:26:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 808EA3CBD6F
 for <ltp@lists.linux.it>; Wed, 10 Sep 2025 18:25:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5CFA71400BC7
 for <ltp@lists.linux.it>; Wed, 10 Sep 2025 18:25:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3848666EB1;
 Wed, 10 Sep 2025 16:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757521542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33umnuPnNtdY9EpXayzUhuA34vxDJhMuu2BrUFA2+0w=;
 b=Gzq5F51rI1jBoaA5+NcKC+Q4hpGRRnEJEiw6rFvI4ZYGJldtpUL1AvOTzg4y3RdtBnAubA
 f6ZV9cqIFToLxP+7Rqmh7Nc68amQL8VPfhAUh0cAuM33DJ0MKiAdpBVOwNnz0eByjuSCqx
 mDIu+VYtUdFzciwE2DsaMvAu559byL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757521542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33umnuPnNtdY9EpXayzUhuA34vxDJhMuu2BrUFA2+0w=;
 b=VQ8lgTTQQsIdy1x7jbBy2Xrtgnv5GXijW0VkUhuD65+yDwvCTJpkmwm0NZ6/E/+ZyS18UG
 BXB9jUwYBCNOlFDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757521542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33umnuPnNtdY9EpXayzUhuA34vxDJhMuu2BrUFA2+0w=;
 b=Gzq5F51rI1jBoaA5+NcKC+Q4hpGRRnEJEiw6rFvI4ZYGJldtpUL1AvOTzg4y3RdtBnAubA
 f6ZV9cqIFToLxP+7Rqmh7Nc68amQL8VPfhAUh0cAuM33DJ0MKiAdpBVOwNnz0eByjuSCqx
 mDIu+VYtUdFzciwE2DsaMvAu559byL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757521542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33umnuPnNtdY9EpXayzUhuA34vxDJhMuu2BrUFA2+0w=;
 b=VQ8lgTTQQsIdy1x7jbBy2Xrtgnv5GXijW0VkUhuD65+yDwvCTJpkmwm0NZ6/E/+ZyS18UG
 BXB9jUwYBCNOlFDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F4F013310;
 Wed, 10 Sep 2025 16:25:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iZAeBoamwWj5SAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 10 Sep 2025 16:25:42 +0000
Date: Wed, 10 Sep 2025 18:26:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Message-ID: <aMGmpREL-beHg00i@yuki.lan>
References: <20250829-conversions-lchown-v5-0-7c3f25cd1de4@suse.com>
 <20250829-conversions-lchown-v5-4-7c3f25cd1de4@suse.com>
 <aLb-uPKS6ZCmpUTc@yuki.lan> <DCOCPDWMUTF5.PXSIFKQYF1IW@suse.com>
 <aMGeffv7V-wbLfCQ@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aMGeffv7V-wbLfCQ@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/4] syscalls: lchown03: Merge into lchown02
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > I guess the original code works because the final component is not a link.
> 
> Ah, yes, it's not as easy with lchown since the last component must not
> be a link, otherwise the call acts on the link.
> 
> And the original code creates a directory that points to itself, i.e.
> longpath/longpath points to ../longpath so each time longpath is
> resolved it just returns back. And with that we can trigger ELOOP by
> stacking enough of these redirections, which is the reason why we
> managed to get that. We would get the same result if we stacked enough
> links, e.g. symlink("a", "b"), symlink("b", "c") ... symlink("y", "z")
> and then trying to resolve "z/file" which may be less confusing than the
> directory pointing to itself magic.

Also quite possibly infinite loop with a file component at the end may
work:

	SYMLINK("inifinte1", "infinite2");
	SYMLINK("inifinte2", "infinite1");
	lchown("infinite1/foo", ...);

Since to locate foo kernel would attempt to resolve infinite1 and
trigger infinite loop.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
