Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1182D49C8D
	for <ltp@archiver.kernel.org>; Fri, 30 Jan 2026 09:50:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 480CB3CC14F
	for <ltp@archiver.kernel.org>; Fri, 30 Jan 2026 10:50:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38B6C3C6FFF
 for <ltp@lists.linux.it>; Fri, 30 Jan 2026 10:50:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7CDC66009BA
 for <ltp@lists.linux.it>; Fri, 30 Jan 2026 10:50:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0171B5BCE2;
 Fri, 30 Jan 2026 09:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769766611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1q1m0sbL+NZiRUG4w6pXVuaQXD5/Pl28Ih+gXagbCo=;
 b=APuinrwKVcgGFhf5JEA1As5dni2jQmR6xkTyKY59t7Lr6j2OaOaJ8JigMmBCF/6mns1jfd
 XvOoO3VCIPVSHz+QfWqbiUJYboUCsSTPQNbR9xYhSwrMtef0wwesm6ht1f2ESj+cYSlCzl
 6HRfE9DPi/+Eu4kstLFx9DO2a2jJpS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769766611;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1q1m0sbL+NZiRUG4w6pXVuaQXD5/Pl28Ih+gXagbCo=;
 b=CQWUMRcF5atCEuEVNNQ2QjGh2Exh5AsnhW4Yp7ec4QQ3bXekJ7nCdT5i8AxkETQjxpuan2
 acDB/tegcMoRfjBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769766610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1q1m0sbL+NZiRUG4w6pXVuaQXD5/Pl28Ih+gXagbCo=;
 b=Qw2tk23pQvFOA+HWZwAKsFhKul1W2VZj08XmqXaEiUSikZF8G4AZLszXRYnhg11dJwkLqI
 mAVvwVLB3FCwyowlFn8RJWJHHA43lbEZzHuEZYJb2TcMP0FchtOTp2Jn+SI9ps2RL84O1L
 nqr/T/qWtx6HsUXSUL1Ln5xKW7Y7mRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769766610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1q1m0sbL+NZiRUG4w6pXVuaQXD5/Pl28Ih+gXagbCo=;
 b=6bK7Xtca/NwOKFQ4rtsExkuENiYVyuVUxW8Cv1QdcSKT2GfJIEegpO9feIhXszJuw6l44b
 3AAeD2kG198fOoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBEB33EA61;
 Fri, 30 Jan 2026 09:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id C+0UNNF+fGlSMQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 30 Jan 2026 09:50:09 +0000
Date: Fri, 30 Jan 2026 10:51:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <aXx_IukiUbgkHKMI@yuki.lan>
References: <aWjZX0fsrTJMqq49@yuki.lan> <aXi4P0YdKx5rFZ8C@yuki.lan>
 <b8a027d4-241c-4934-95c4-61df15ccebe6@suse.cz>
 <42c5be4b-89cb-4a11-8e41-62f5afa7ab49@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <42c5be4b-89cb-4a11-8e41-62f5afa7ab49@suse.de>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preprations
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > I recommend removing the .min_kver attribute and checking for the =

> > presence of /dev/userfaultfd instead. If the file is missing and the =

> > kernel is older than v6.1, then TCONF, otherwise TBROK. =

> =

> Ok.=A0 Will try to submit a fix ASAP.

Please do so till the end of today, so that we can include that in the
release.

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
