Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6DDC3ABB2
	for <ltp@archiver.kernel.org>; Wed, 28 May 2025 13:35:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E9B93C7615
	for <ltp@archiver.kernel.org>; Wed, 28 May 2025 15:35:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90BD53C6717
 for <ltp@lists.linux.it>; Wed, 28 May 2025 15:34:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F1D54200CEF
 for <ltp@lists.linux.it>; Wed, 28 May 2025 15:34:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 60A541F79C;
 Wed, 28 May 2025 13:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748439297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HL6162Os6GIHcvsjLb2m+lMfDrXf3CyntMgA7D6/P6k=;
 b=I6FoEkpVeLkqEjOTncMUATS3HxHwrY0pvG2Fj9T6OVaaf3iIWVVUxhwqD8vC+QXnb00Drc
 bUF11hrtVJAtbmGlvuLmY74o2mpKX9Ux3sXna5fYF2VM8n5fOiO5+LY9vwo5321UmkYdlw
 CY+snxSWxm5HzZb8cTtZbPacsjtHrtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748439297;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HL6162Os6GIHcvsjLb2m+lMfDrXf3CyntMgA7D6/P6k=;
 b=bzItVDTcWcoHup1FMFmuHuFZ3+z81r7/v32tmeWYPnh4gT9uNTW6N+CQdkLE/AWW8QsVJG
 I0VlRzCjWrT+pnAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=I6FoEkpV;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bzItVDTc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748439297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HL6162Os6GIHcvsjLb2m+lMfDrXf3CyntMgA7D6/P6k=;
 b=I6FoEkpVeLkqEjOTncMUATS3HxHwrY0pvG2Fj9T6OVaaf3iIWVVUxhwqD8vC+QXnb00Drc
 bUF11hrtVJAtbmGlvuLmY74o2mpKX9Ux3sXna5fYF2VM8n5fOiO5+LY9vwo5321UmkYdlw
 CY+snxSWxm5HzZb8cTtZbPacsjtHrtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748439297;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HL6162Os6GIHcvsjLb2m+lMfDrXf3CyntMgA7D6/P6k=;
 b=bzItVDTcWcoHup1FMFmuHuFZ3+z81r7/v32tmeWYPnh4gT9uNTW6N+CQdkLE/AWW8QsVJG
 I0VlRzCjWrT+pnAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F077136E3;
 Wed, 28 May 2025 13:34:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3y62EQERN2grPAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 28 May 2025 13:34:57 +0000
Date: Wed, 28 May 2025 15:35:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aDcRHXhOBcqVDp05@yuki.lan>
References: <CAEemH2czcnak7S50--_nh5Z2Ou+rF0=5kvY7Kx_87k_X5eEj4g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2czcnak7S50--_nh5Z2Ou+rF0=5kvY7Kx_87k_X5eEj4g@mail.gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 60A541F79C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; SUBJECT_ENDS_QUESTION(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Reduce .runtime for Long-Running Tests ?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> After reviewing some LTP HTML test reports, I noticed that the ten tests
> alone take nearly 20 minutes to complete. For example:
> =

> --------------------
> bind06           300.15s
> msgstress01      180.44s

Isn't this better after:

commit e3b85e50471b3892316a2b2c7c730e9dc8d9139e
Author: Ricardo B. Marli=E8re <rbm@suse.com>
Date:   Wed May 21 05:31:12 2025 -0300

    syscalls/msgstress01: Set upper bound for num_messages


> fsx22            170.47s
> pty07            150.04s
> pty06            150.02s
> gf18             121.09s
> gf17             120.82s
> gf16             120.13s
> dirtyc0w_shmem   120.11s
> setsockopt07      76.47s

As Peter pointed out, most of these are fuzzy sync tests and the runtime
is callibrated in order to get reasonable chance of reproducing the
results. But indeed the runtime does not scale with the speed of the
machine and we are not setting the pair exec_loops in the tests that run
for so long, so I suppose that callibrating the number of loops for
these tests that does not make the bug less reproducible would make
things better.

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
