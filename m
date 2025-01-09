Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302C2E77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 10:35:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB7373C2024
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 11:35:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52DD53C0652
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 11:35:08 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A8E6E140F66C
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 11:35:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5E57C21114;
 Thu,  9 Jan 2025 10:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736418905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UzKH73cPSEJaYmGxdyI5QS875WC6XGw3lVS0wVK28Zw=;
 b=wvSW0MXbJ3V3nOEfv9O1t7EU8tPrhcvedlbk5TYwewVs3wV9eqMUkd30e0/P1Dqthc/pa+
 g5aBSkNd2ZDA9tb3d14E5v6QN8FPMJLYfRrUbYAPCotvyawNku0kHUAkh7PuXcFyHXIUVZ
 gm1DzEFzZqbdt3HyTHzpPnIHOkSBovk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736418905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UzKH73cPSEJaYmGxdyI5QS875WC6XGw3lVS0wVK28Zw=;
 b=L2I2yOUuYjYt2FFPGLxEpDzysxSqkemWDiiD8oLW2E4VaUXHvBkIcMzoDLOslsSj12/Nxm
 U9fzI6n4nd53LhCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736418905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UzKH73cPSEJaYmGxdyI5QS875WC6XGw3lVS0wVK28Zw=;
 b=wvSW0MXbJ3V3nOEfv9O1t7EU8tPrhcvedlbk5TYwewVs3wV9eqMUkd30e0/P1Dqthc/pa+
 g5aBSkNd2ZDA9tb3d14E5v6QN8FPMJLYfRrUbYAPCotvyawNku0kHUAkh7PuXcFyHXIUVZ
 gm1DzEFzZqbdt3HyTHzpPnIHOkSBovk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736418905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UzKH73cPSEJaYmGxdyI5QS875WC6XGw3lVS0wVK28Zw=;
 b=L2I2yOUuYjYt2FFPGLxEpDzysxSqkemWDiiD8oLW2E4VaUXHvBkIcMzoDLOslsSj12/Nxm
 U9fzI6n4nd53LhCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CF10139AB;
 Thu,  9 Jan 2025 10:35:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Xpq/EVmmf2fbFAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 09 Jan 2025 10:35:05 +0000
Date: Thu, 9 Jan 2025 11:34:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Z3-mSNc5YtTMYmM0@yuki.lan>
References: <20250108071201.26984-1-liwang@redhat.com>
 <Z35C00m6FwH8P8BI@yuki.lan>
 <CAEemH2dYrPTT3iw69bWwpyS6uVf8wkZQESuUudp274A7hsmRUA@mail.gmail.com>
 <CAEemH2eAoto=mLFeiXG9WtwPgiwzF=NKbXDbE1eWTuo_QBW8Zw@mail.gmail.com>
 <Z35wmODIV_vuYBOA@rei>
 <CAEemH2eHfJDLNhMwomZ5VHBSwqpUZsD9GuaMDRnpY_XdfPjEdA@mail.gmail.com>
 <Z39_3BKj3d3nbfau@rei.lan>
 <CAEemH2c0ur5W=ntte7mamqMSC_GtH4Lb3W=cob-h8OPMYU=o1w@mail.gmail.com>
 <CAEemH2epi7XZiPXP=NOQpV0rLpOT7dxt8eoadZg5RR3r5c=mwA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2epi7XZiPXP=NOQpV0rLpOT7dxt8eoadZg5RR3r5c=mwA@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCh] lib: redefine the overall timeout logic of
 test
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
> > The reason for calling tst_set_runtime() in each iteration is that we can
> > directly utilize the real elapsed time as runtime and don't need to do
> > additional measurements.
> >
> 
> Forgot to say, that each iteration has four sub-tcases to accomplish.
> The recommended way (you gave above) is to regard them as one
> big test and reset timeout by heartbeat() in tst_test->tcnt. If this value
> is big enough, that's fine. But I fear that value (come from measurement)
> is still not covered all situations.

I agree that the test is a bit unpredictable, as it synces filesytem and
drops caches twice in each iteration. However the .timeout is a safety
mechanism, so nothing stops us for making it 4x or 8x of the usuall
test execution time on slower hardware.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
