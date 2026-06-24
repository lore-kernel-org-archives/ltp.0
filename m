Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE258CDB47C
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:09:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D37F3E6207
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 13:09:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A22D03D0E80
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 13:08:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 67F322003A2
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 13:08:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BCA156D95C;
 Wed, 24 Jun 2026 11:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782299331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8VgrtCf+IYfsxBhcXL0kNjY9//S/r6G89nLN8pYut64=;
 b=KQAsKtKNM+CJtufsHG8aZjaXEYWokVZu3aDtc8mKf4PRsVHkhD1xM1Uud7cvhwIjVIP0AA
 Bt9gSr3jLrrOiWMh5nzQf8Q2FeiU1I4mIsWF4mPIsJk+XR4OPq6vT4YJl8muG+0TbdvSSU
 bH3le01mFfU4u3fv/t02BclTI4esftw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782299331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8VgrtCf+IYfsxBhcXL0kNjY9//S/r6G89nLN8pYut64=;
 b=paA2jyqzDhXtlUJQXe7jXOMbM2bBsoCozqViRN2SS4Qy5BRpL7gbqQJUpcx9Q8cBWABMUx
 W6CR5+1OQ6llrQBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782299331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8VgrtCf+IYfsxBhcXL0kNjY9//S/r6G89nLN8pYut64=;
 b=KQAsKtKNM+CJtufsHG8aZjaXEYWokVZu3aDtc8mKf4PRsVHkhD1xM1Uud7cvhwIjVIP0AA
 Bt9gSr3jLrrOiWMh5nzQf8Q2FeiU1I4mIsWF4mPIsJk+XR4OPq6vT4YJl8muG+0TbdvSSU
 bH3le01mFfU4u3fv/t02BclTI4esftw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782299331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8VgrtCf+IYfsxBhcXL0kNjY9//S/r6G89nLN8pYut64=;
 b=paA2jyqzDhXtlUJQXe7jXOMbM2bBsoCozqViRN2SS4Qy5BRpL7gbqQJUpcx9Q8cBWABMUx
 W6CR5+1OQ6llrQBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD66E779A8;
 Wed, 24 Jun 2026 11:08:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id O+CXKcO6O2rbfQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jun 2026 11:08:51 +0000
Date: Wed, 24 Jun 2026 13:08:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <aju6w11EaBhHGnqM@yuki.lan>
References: <20260624091900.4107041-3-chrubis@suse.cz>
 <20260624105728.4178-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260624105728.4178-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_test: Add may_kmemleak flag and annotate tests
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
> > tst_test: Add may_kmemleak flag and annotate tests
> 
> --- [PATCH 1/13] ---
> 
> > This information was so far recoded only in the comment in the cve
> 
> Typo: "recoded" should be "recorded".
> 
> --- [PATCH 8/13] ---
> 
> > lib: tst_test: Move the iterations to struct tst_test
> 
> > -		iterations = SAFE_STRTOL(optarg, 0, INT_MAX);
> > +		tst_test->iterations = SAFE_STRTOL(optarg, 0, UINT_MAX);
> 
> safe_strtol() takes `long min, long max` parameters. On 32-bit
> systems where sizeof(long) == 4, passing UINT_MAX (4294967295U) as
> a long overflows to -1, making the valid range [0, -1]. This causes
> the range check to reject all positive values, breaking the -i
> option on 32-bit.
> 
> Should this use INT_MAX (as before) or SAFE_STRTOUL?

Good catch, indeed this should be changed to SAFE_STRTOUL()

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
