Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F07C36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 09:03:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1F1A3CB5A4
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 11:03:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42F583C677D
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 11:02:50 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7C46A2009C4
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 11:02:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B6F411F456;
 Fri, 11 Apr 2025 09:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744362167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wdymslK/ahxhzvf1pu81EzjXSC2E2r9kqMWhouFIKwE=;
 b=VeN3UHtD39cbRMhkmaWWzc2000J/lxwvEuxbPhThZSVTW4ekLd1blY25PPRAoR6CG9l6OC
 e0LG0NNQu4bqB9Pyam1b2nSUGuGE0uoh3q6riw14uXSl5lXVs0hf06fPaWFw4i+AxC/7SA
 6ibkMkwHP6pps39sKPyvPL5y2sz5kZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744362167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wdymslK/ahxhzvf1pu81EzjXSC2E2r9kqMWhouFIKwE=;
 b=kUBO9k4q8VUV93TS/XWqp/T4NpxdPQsOzsclNn1YcjSoodjVH0Dt0p7i5iSS1MYk34DyBa
 /gGjJxvfGr0yZNAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744362167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wdymslK/ahxhzvf1pu81EzjXSC2E2r9kqMWhouFIKwE=;
 b=VeN3UHtD39cbRMhkmaWWzc2000J/lxwvEuxbPhThZSVTW4ekLd1blY25PPRAoR6CG9l6OC
 e0LG0NNQu4bqB9Pyam1b2nSUGuGE0uoh3q6riw14uXSl5lXVs0hf06fPaWFw4i+AxC/7SA
 6ibkMkwHP6pps39sKPyvPL5y2sz5kZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744362167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wdymslK/ahxhzvf1pu81EzjXSC2E2r9kqMWhouFIKwE=;
 b=kUBO9k4q8VUV93TS/XWqp/T4NpxdPQsOzsclNn1YcjSoodjVH0Dt0p7i5iSS1MYk34DyBa
 /gGjJxvfGr0yZNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A713B13886;
 Fri, 11 Apr 2025 09:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J1jwJrfa+Gf8HgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Apr 2025 09:02:47 +0000
Date: Fri, 11 Apr 2025 11:03:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Lu Fei <lufei@uniontech.com>
Message-ID: <Z_ja0Z4IVpCavGmj@yuki.lan>
References: <20250314044257.1673303-1-lufei@uniontech.com>
 <20250409074906.128290-1-lufei@uniontech.com>
 <CAEemH2ef7SZ_U5Z-rHst3Wcg-+fuRjSSOU9NxZOSW2Hjx3kiEg@mail.gmail.com>
 <CAEemH2ciHq6EVe8ChfJrHCx=FXRsxUpgbCR=9d5QsgX_K_Fjpw@mail.gmail.com>
 <E235D2DBCAA80A8D+Z/iwVNmdnxoxZyrN@rocky>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E235D2DBCAA80A8D+Z/iwVNmdnxoxZyrN@rocky>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] unshare03: set nr_open with sizeof(long)*8
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
Cc: ltp <ltp@lists.linux.it>, viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >unsigned int sysctl_nr_open __read_mostly = 1024*1024;
> >unsigned int sysctl_nr_open_min = BITS_PER_LONG;
> >/* our min() is unusable in constant expressions ;-/ */
> >#define __const_min(x, y) ((x) < (y) ? (x) : (y))
> >unsigned int sysctl_nr_open_max =
> >        __const_min(INT_MAX, ~(size_t)0/sizeof(void *)) & -BITS_PER_LONG;
> >...
> 
> >Then we need a filedescriptor that is >= 64 and set the nr_open to 64.
> 
> I'm using sizeof(long)*8 is because I was thinking only set
> filediscriptor >= BITS_PER_LONG and then set nr_open = BITS_PER_LONG
> could make EMFILE happen. Less than BITS_PER_LONG would trigger other 
> error than EMFILE.
> 
> Am I misunderstood Cyril?

The actual patch is fine. What they are asking for is a better
description. The patch description should tell _why_ the change is
needed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
