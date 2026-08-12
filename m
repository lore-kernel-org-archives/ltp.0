Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6777C5AD5A
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 09:35:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 061BF3E6CAD
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 11:35:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7B373DD83B
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 11:35:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6914D14002B0
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 11:35:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E8B73E7C;
 Wed, 12 Aug 2026 09:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786527309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZmRj95Qxk+zsFsn1vvIlSqCSv9Y6Dg7u83pUrUQPrA8=;
 b=j+1/O3u7PylBgr7eaJKqRMCtCu/xkqxEiVjDTTmf2bZFrutZXLi0YyrTLUikpPKKeOu9vm
 heKFfMrZNdyRG07KJMw+s03z2S4GMC8CsyAX9+/UiyDt5eQ2kxowYWfWyz+vEe0zR4H+Uw
 HAxS+Z08WkF+9R74pasDMFV6TE0Tl9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786527309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZmRj95Qxk+zsFsn1vvIlSqCSv9Y6Dg7u83pUrUQPrA8=;
 b=sSbUoeUf0E0XajGUnXkf9p6yUmRm67/G5Ltop75USxPgU8LrKiP8BgJ/DQUlbwi/rAZIjq
 bsHlgYzipjMgyBBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786527305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZmRj95Qxk+zsFsn1vvIlSqCSv9Y6Dg7u83pUrUQPrA8=;
 b=CPQr0KQeWktUXNzZ8X0i72h662n8gcvmGNaPn1i9Hk/WQtgTNIQJg67gOvvao0IukREBe8
 44/GvgYsYQ0AQElG0QTNmlC4OXUjdgj0sk3s4hhEPm9Oc7Db2FmHwc0AB5L+SZES76kWyh
 EHFVQ1s4GcRofbUhVMtO10IajuDKdDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786527305;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZmRj95Qxk+zsFsn1vvIlSqCSv9Y6Dg7u83pUrUQPrA8=;
 b=DrgRIFiA0xoVT3E4F0ELzH2MjtiGW4//3zFSfFM0WnCxg9aepDJp7E19AvMFDdGy7oDJAC
 eCNV//gpfG8L18Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F14E779B3;
 Wed, 12 Aug 2026 09:35:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FU58FUk+fGpCAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 12 Aug 2026 09:35:05 +0000
Date: Wed, 12 Aug 2026 11:34:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <anw-Q92lT3CtUS-0@yuki.lan>
References: <20260805151451.648990-2-pvorel@suse.cz>
 <20260805173540.9276-1-linuxtestproject.agent@gmail.com>
 <20260810120208.GE918586@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260810120208.GE918586@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; TAGGED_RCPT(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_kvercmp: Factor out error handling
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > tst_kvercmp: Factor out error handling
> 
> > --- [PATCH 1/9] ---
> 
> > > static int _tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)
> 
> > Could this be renamed to parse_kver? File-scope identifiers beginning with an
> > underscore are reserved by C, and LTP's coding rules prohibit such names.
> 
> I thought this is wrong, because we have functions with underscore, but it's
> trailing underscore, not the leading one.
> 
> => I'll rename to tst_parse_kver_().
> 
> Also, agent does not know about LTP rule to have functions in lib with leading
> tst_.

This is a static function, so the identifier is not visible outside of
the file, therefore there is no need for the tst_ prefix. On the
contrary it's better if there is no prefix so that it's clear that it's
not external API.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
