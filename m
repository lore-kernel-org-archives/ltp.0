Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F325C61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 14:42:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47F0C3EB0A9
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 16:42:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0BE73EAD60
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 16:42:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6ED7B2001A4
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 16:42:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9BAC31FE51;
 Thu,  3 Sep 2026 14:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788446541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d5Z8VE1h99xv6mwwx14sgjfz99m46YtyoxS+mjwqKjA=;
 b=GddHdBpnYZvpH81x8Njy5FtGa5pbx9aHv6KHWx0/W/FLmRoyj3I8ldDchsO33PhZByd1HU
 j00PJ+9++kccDeM7I3rugovvH5irDoTdON2+DcGDzKJjCFhk3GYCBIPnjV6MOexJ92iWVH
 Xf1Agwz56tskKKAJfEEsvdJIhp+np5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788446541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d5Z8VE1h99xv6mwwx14sgjfz99m46YtyoxS+mjwqKjA=;
 b=HoXIZvZpX1/T3MH5BpvTk3aJyxx4TEaMAEc5D0rB9VY0Aqu9VofrSCIFBj5jg9+/RuRYtI
 J5FzGMjux/jmZgCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788446537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d5Z8VE1h99xv6mwwx14sgjfz99m46YtyoxS+mjwqKjA=;
 b=GSAUpLy/TenwaPt9piexp9H7cTnJ1N6U9vVqE8sTCivH3FFiiza3PuMK2DuYoc0rt8NPiJ
 wWupt95tLevhQXWA5CrJ9iRL/HLpXqLv60+lHSFxHsjJgnxlvPTy5QngiJopBzRQPw6deH
 6Et33kL4N2ZblbwCFF3Ys0idkc2VR5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788446537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d5Z8VE1h99xv6mwwx14sgjfz99m46YtyoxS+mjwqKjA=;
 b=2GEuea+RpU4gxVBctuTNAby55LObLv0PhVGoTLwV6avHd9MjMfOKixfrfpzJSkj2ICeGIh
 O1/+DbQeY8KyGgDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74A1F136D9;
 Thu,  3 Sep 2026 14:42:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id chRyHEmHmWqCIgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 03 Sep 2026 14:42:17 +0000
Date: Thu, 3 Sep 2026 16:42:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <apmHTcCUhxRMdcVg@yuki.lan>
References: <20260825173613.8867-1-linuxtestproject.agent@gmail.com>
 <20260828152631.254653-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260828152631.254653-1-avinesh.kumar@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] uevent02: Make wait_for_uevents()
 order-independent
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
>  static inline void wait_for_uevents(int fd, const struct uevent_desc *const uevents[])
>  {
> -	int i = 0;
> +	const struct uevent_desc *pending[UEVENT_MAX_PENDING];
> +	int i, cnt = 0, remaining;
> +
> +	while (uevents[cnt]) {
> +		if (cnt >= UEVENT_MAX_PENDING)
> +			tst_brk(TBROK, "Too many expected uevents, increase UEVENT_MAX_PENDING");
> +		pending[cnt] = uevents[cnt];
> +		cnt++;
> +	}
> +	remaining = cnt;

We can as well count the uevents[] first, then create the pending[]
array with the cnt. Also I would have used array of bitflags.


	while (uevents[cnt])
		cnt++;

	uint8_t not_pending[cnt] = {};

	...
		if (not_pending[i])
			continue;

		if (uevent_match(buf, len, uevents[i])) {
			not_pendig[i] = 1;
			...
		}

With that we avoid copying the pointers and static limit.

But that is largerly cosmetic changes.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
