Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F39C3601E
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 14:18:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29F7E3C2E00
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 16:18:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 921533C03B0
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 16:18:00 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DC281602A08
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 16:17:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 123D7200A2;
 Tue, 17 Sep 2024 14:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726582678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rXe0KS5wQ3U6AzVzymco1Wmz5LMLeci4ScKc2ZWa0dA=;
 b=ifmzSZvnpswdHm4pGcjhV3E8ZzaK9vfOwcaM2zADlNDCI3rVB2+aCLZFo+VdAnmoAPQk5m
 /2+RriRQorcODNdycr1d15REmcW3tJ2HBi7csra9tYzkwyintkV4aNNw1j2Zn6SsxdrzNP
 /58RV6ytJuMAKd1jEsbiXM4rwlqy0KM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726582678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rXe0KS5wQ3U6AzVzymco1Wmz5LMLeci4ScKc2ZWa0dA=;
 b=yq9SgU71KZLIcG/y7zTD8FeS+w/Y6xHoe2Ru0LI0ubYso+hCXbx0Ch3jNsJUx0W99hheZH
 N3ntVCVuwGXd0/AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726582678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rXe0KS5wQ3U6AzVzymco1Wmz5LMLeci4ScKc2ZWa0dA=;
 b=ifmzSZvnpswdHm4pGcjhV3E8ZzaK9vfOwcaM2zADlNDCI3rVB2+aCLZFo+VdAnmoAPQk5m
 /2+RriRQorcODNdycr1d15REmcW3tJ2HBi7csra9tYzkwyintkV4aNNw1j2Zn6SsxdrzNP
 /58RV6ytJuMAKd1jEsbiXM4rwlqy0KM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726582678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rXe0KS5wQ3U6AzVzymco1Wmz5LMLeci4ScKc2ZWa0dA=;
 b=yq9SgU71KZLIcG/y7zTD8FeS+w/Y6xHoe2Ru0LI0ubYso+hCXbx0Ch3jNsJUx0W99hheZH
 N3ntVCVuwGXd0/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBF2813AB6;
 Tue, 17 Sep 2024 14:17:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uDhVOJWP6Wb7PgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 17 Sep 2024 14:17:57 +0000
Date: Tue, 17 Sep 2024 16:16:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "Xinjian Ma (Fujitsu)" <maxj.fnst@fujitsu.com>
Message-ID: <ZumPSk0VdqFa5Eqn@yuki.lan>
References: <20240910094755.57438-1-maxj.fnst@fujitsu.com>
 <ZuAbaUHY8ZPjN5ey@yuki.lan>
 <TY3PR01MB12071A725A400AA4C08040DBFE8652@TY3PR01MB12071.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <TY3PR01MB12071A725A400AA4C08040DBFE8652@TY3PR01MB12071.jpnprd01.prod.outlook.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] posix/conformance/interfaces/sem_timedwait/2-1:
 add _GNU_SOURCE define
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > That does not sound right, the open posix testsuite must not depend on anything
> > GNU specific.
> 
> I see. Thanks.
> But I tested both on Fedora and Ubuntu, they reported the same error
> if using the params " -std=c99 -D_POSIX_C_SOURCE=200809L
> -D_XOPEN_SOURCE=700" for gcc.

That is certainly unexpected. I managed to reproduce this on Debian 12.

Looks that on certain systems the MMAP_ANONYMOUS seems to be guarded by
__USE_MISC. The __USE_MISC is defined in /usr/include/features.h and set
if _DEFAULT_SOURCE is set which is set by _GNU_SOURCE.

I did double check the POSIX and I was probably confusing MAP_PRIVATE
and MAP_ANONYMOUS, sorry. Looks like MAP_ANONYMOUS is indeed not a part
of POSIX.

> How about manually defining MAP_ANONYMOUS like below?

Does not seem to be a good solution either, that will work only on
Linux. The open posix testsuite is supposed to run on any POSIX
compatible OS.

I'm afraid that the only solution we can use is to allocate the shared
memory via the posix shm. That means to get the file descriptor for
mmap() from shm_open() (followed by shm_unlink()).

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
