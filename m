Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70441C02181
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 12:30:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 610613C196B
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 13:30:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECCEB3C1845
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 13:30:16 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6E6D8600D47
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 13:30:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D808E1F7BD;
 Mon, 20 Jan 2025 12:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737376214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DQn/aWUh7On4/Ytjws3iGBNqA2ELzNCHPj3arJmmbps=;
 b=a1/bY6kJl80fh/FQ9DO4FyzFDEoxdjskNiteAsOeLC1a1aYZF1i3Hgt2VhCU37+PHCOdyJ
 hYPWJo5I2HeX7swH+myQP+rzBYpfXXbNex3AXFolyxNQiOR/BboTxRVp87QvOVJTki3rsa
 /NEMxZm/uKJJo5xA0MKmfeAbupwtLQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737376214;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DQn/aWUh7On4/Ytjws3iGBNqA2ELzNCHPj3arJmmbps=;
 b=CiJTa6yTB3lBu9Yp8xaXIJi799kevjggF9RUpsN5Tp6YmN3MLorlNx+zWvssDRqz7DwVgD
 HTl4/abwawcd/aDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ylUDAUwm;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QcMiRNsV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737376213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DQn/aWUh7On4/Ytjws3iGBNqA2ELzNCHPj3arJmmbps=;
 b=ylUDAUwmAqBviAikkOXIDfS8TZXdElxjvqbMTNC3Yf2lVJHACrnClO/xc1iagxjcOJhVTK
 knGZJR4XOrtjPT3NzmgcWLAUgQ8tIJx1NuGcbV9bqQz+J6EBADsyfv2S1PGOgjafUWBWmk
 QAaHUtVwwgVifk//70hy1b0Y5lM1vlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737376213;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DQn/aWUh7On4/Ytjws3iGBNqA2ELzNCHPj3arJmmbps=;
 b=QcMiRNsVTtrHRYG0gqouAxqE7FKfyjLCjfq9jfBlDPB9jEHFna7oVspsI1cFXw7Kshl5yK
 Dkmj5nEd3J7px8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD81B139CB;
 Mon, 20 Jan 2025 12:30:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kLloLdVBjmeWDAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 20 Jan 2025 12:30:13 +0000
Date: Mon, 20 Jan 2025 13:29:58 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Z45BxqUsOQXm12My@yuki.lan>
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250115224154.GA664782@pevik>
 <CAEemH2e+Cb8R0kS5a8FnETcMiafWeD529CO3=AtHk310vyckbg@mail.gmail.com>
 <20250120090740.GB794282@pevik> <20250120091137.GC794282@pevik>
 <CAEemH2e03yTcWBDw=BK7O6SU69mVXhO4zv2LUDgPLe0kD=w12Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e03yTcWBDw=BK7O6SU69mVXhO4zv2LUDgPLe0kD=w12Q@mail.gmail.com>
X-Rspamd-Queue-Id: D808E1F7BD
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[7];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] pidns05 timeout (was: [PATCH 1/2] lib:
 multiply the timeout if detect slow kconfigs)
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Yes, I understand your concern. I agree that we can avoid the
> kconfig detection for most faster test cases.
> 
> After reviewing my previous pre-release LTP test and compare to
> the current main branch test, it doesn't show much more time-consuming,
> maybe there is different HW/kernel factors, but the performance
> impact can be ignored.

I've just send a patch that caches the detection results, because in the
case of pins05 we did parse the config for each SAFE_CLONE() call.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
