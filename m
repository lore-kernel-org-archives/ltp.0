Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611F8CD128A
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 10:37:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87DFF3CF822
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 12:37:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C6E53C195B
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 12:37:05 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C014E600779
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 12:37:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4ED915BEAC;
 Thu, 11 Apr 2024 10:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712831822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yvd6vPjmj2Vb7cqUK5DozYiy6k/iCinI8fAd/Fv5KLo=;
 b=oEhObCxQb5hCrD+2kzKRHI1oURfOiOnRJdOmObg4WcSloGe+2NH1xwQQdl4boJtQ/UledU
 C9MlgXvAL5oDLfTthueMoHnP+cmYAu8zeAPOs7ZXcbXbpkq6NiLY+eZRYFG7wIu4PQ0Z16
 o1TLXivN9ANoEbAYgHYWKAz2fTUNUgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712831822;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yvd6vPjmj2Vb7cqUK5DozYiy6k/iCinI8fAd/Fv5KLo=;
 b=f0m7DQP0OCtJc778vEUGeu9xpriFSUIixd+E39XlXCF6v/dAFDIWxoGtfwgKkUyrE3bvj+
 1m9C7omIDSB1VpCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oEhObCxQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=f0m7DQP0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712831822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yvd6vPjmj2Vb7cqUK5DozYiy6k/iCinI8fAd/Fv5KLo=;
 b=oEhObCxQb5hCrD+2kzKRHI1oURfOiOnRJdOmObg4WcSloGe+2NH1xwQQdl4boJtQ/UledU
 C9MlgXvAL5oDLfTthueMoHnP+cmYAu8zeAPOs7ZXcbXbpkq6NiLY+eZRYFG7wIu4PQ0Z16
 o1TLXivN9ANoEbAYgHYWKAz2fTUNUgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712831822;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yvd6vPjmj2Vb7cqUK5DozYiy6k/iCinI8fAd/Fv5KLo=;
 b=f0m7DQP0OCtJc778vEUGeu9xpriFSUIixd+E39XlXCF6v/dAFDIWxoGtfwgKkUyrE3bvj+
 1m9C7omIDSB1VpCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4032113685;
 Thu, 11 Apr 2024 10:37:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r/e9Dk69F2bhdAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 11 Apr 2024 10:37:02 +0000
Date: Thu, 11 Apr 2024 12:36:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zhe9G-gWk6MA2Az8@yuki>
References: <20240320095927.19973-1-chrubis@suse.cz>
 <20240320095927.19973-3-chrubis@suse.cz>
 <20240321093350.GB548078@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240321093350.GB548078@pevik>
X-Spamd-Result: default: False [-3.89 / 50.00]; BAYES_HAM(-2.88)[99.50%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4ED915BEAC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls: Add test for splicing to /dev/zero
 and /dev/null
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
> > +#define _GNU_SOURCE
> > +#include "tst_test.h"
> > +
> > +static const char *test_devices[] = {
> checkpatch.pl suggests:
> static const char * const test_devices[] = {

Will fix and push.

> > +	"/dev/null",
> > +	"/dev/zero",
> > +};
> > +
> > +static void verify_splice(unsigned int n)
> > +{
> > +	char buf[1024];
> > +	char dev_fd;
> > +	int pipefd[2];
> > +
> > +	memset(buf, 0xff, sizeof(buf));
> > +
> > +	tst_res(TINFO, "Testing %s", test_devices[n]);
> > +
> > +	dev_fd = SAFE_OPEN(test_devices[n], O_WRONLY);
> > +
> > +	SAFE_PIPE(pipefd);
> > +	SAFE_WRITE(1, pipefd[1], buf, sizeof(buf));
> I wonder if write() fails, we don't get SAFE_CLOSE() calls, right?

We do not care here since these are just pipes, the test will fail with
TBROK and kernel will destroy the pipes once the process exits.

We have to close real files in test temporary directory, because if we
do not do so, tst_rmdir() may fail on nfs. E.g. if you create a file on
nfs, open it and unlink it, the directory is not empty as one would
expect and cannot be removed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
