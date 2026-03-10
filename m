Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C453EB1050
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 11:43:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 069BE3E57E7
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 12:43:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 264853DE7E0
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 12:42:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 954412000CE
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 12:42:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 018724D1FD;
 Tue, 10 Mar 2026 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773142967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ySeah2LsA4EI9VjIve5fvQ0i9XALQ5TfeWsD+YBkEfw=;
 b=SDqyVC1wIIUIUugGPaka/keyDM/z7rh+LYKB20Qo0xNKsAyuyR+gkH9E1SGTTIWQN00dc8
 S2XF5KKP3JJwKe38YFZ5DoffXr/uKRyDTuPY0PWxoDQq1FnOQktR/AokBIRMucYN/tJba2
 e+Qozj1KNflZWdTwlnNxOc7S/DxvCdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773142967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ySeah2LsA4EI9VjIve5fvQ0i9XALQ5TfeWsD+YBkEfw=;
 b=Xev8/SHRMQSHA12Rdwq5TRYVC7qPq1NSQ9xo2xX9pjEdLWqEnKlJHCeLs70YAyHMojplXu
 Coo8bGxHAjGL3vDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773142967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ySeah2LsA4EI9VjIve5fvQ0i9XALQ5TfeWsD+YBkEfw=;
 b=SDqyVC1wIIUIUugGPaka/keyDM/z7rh+LYKB20Qo0xNKsAyuyR+gkH9E1SGTTIWQN00dc8
 S2XF5KKP3JJwKe38YFZ5DoffXr/uKRyDTuPY0PWxoDQq1FnOQktR/AokBIRMucYN/tJba2
 e+Qozj1KNflZWdTwlnNxOc7S/DxvCdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773142967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ySeah2LsA4EI9VjIve5fvQ0i9XALQ5TfeWsD+YBkEfw=;
 b=Xev8/SHRMQSHA12Rdwq5TRYVC7qPq1NSQ9xo2xX9pjEdLWqEnKlJHCeLs70YAyHMojplXu
 Coo8bGxHAjGL3vDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E06803F42F;
 Tue, 10 Mar 2026 11:42:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KIzONbYDsGklYgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 10 Mar 2026 11:42:46 +0000
Date: Tue, 10 Mar 2026 12:42:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Pavithra <pavrampu@linux.ibm.com>
Message-ID: <abADtgCruup_LMkj@yuki.lan>
References: <20260310094958.95381-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260310094958.95381-1-pavrampu@linux.ibm.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [PATCH] [PATCH v4] Migrating the
 libhugetlbfs/testcases/truncate_above_4GB.c test
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
> +static void run_test(void)
> +{
> +	static long long buggy_offset, truncate_point;
                                          ^
Looking closer at the code this variable is used uninitialized.

But there is a variable with the same name in the test setup. Wasn't
this supposed to be a global variable set in the test setup()?

Or we can get rid of the variable completely and use the FOURGIG
instead both in the setup and here.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
