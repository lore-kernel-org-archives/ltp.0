Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5570DC79FBB
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 19:53:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67E8D3E9284
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 21:53:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE6423C2024
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 21:53:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6F45760046A
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 21:53:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DAAD221EBB;
 Thu, 10 Sep 2026 19:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789069992;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=okSwT653Aaygjaz6zxa7eHH8bhqTjLkI9TRyKEDefok=;
 b=MWitk1sn5FPpgXYBhmbkF9ZwIgrfhkSD0uUewwvctGUJebYzm5FxQOYFrm9n81BKlOttxr
 ekCoSv/GoanAm9+/f2YbQEYvLsCT2zOME3rMjoOlzcAU5uiAkT5uF2XL5d8eQ2TNFp9khZ
 5VCKzu0vogoey9IUe8Vmszm0Cpl2feA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789069992;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=okSwT653Aaygjaz6zxa7eHH8bhqTjLkI9TRyKEDefok=;
 b=GDzfeCeRAqldzji/d+ShycXyibG2rGSRXWUJVzqW6LeRPWBz9x0UyR2QcrcJ21vJ22OSZz
 lQhnXcW0dKRBn0Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789069987;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=okSwT653Aaygjaz6zxa7eHH8bhqTjLkI9TRyKEDefok=;
 b=bpnbEPjfziZvqZTQZr/3Hitxo7scy4f31oNpiMESIoeiOIjPhc+YtkWTFHJN9W/jVxNlCs
 6XjXWeBJ/OxXy7dyurvTW8olS8K4jQZndi4LtGSCgZdYu01Aoq98IqYqHl77uER2XpK9P3
 EM26JVYbAJ0V0Ne0ugokz/ZtlIt8kjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789069987;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=okSwT653Aaygjaz6zxa7eHH8bhqTjLkI9TRyKEDefok=;
 b=rhKsMo/ce7sWt/Ol0VTE6YDXmYZsiMLNnBFO72qqXeOjV3zVQx0KmodMMrqOW4OTinF8Aq
 zXs7yeEC8DnkqLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3176B1326D;
 Thu, 10 Sep 2026 19:53:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bp6SCKMKo2qxHQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 10 Sep 2026 19:53:07 +0000
Date: Thu, 10 Sep 2026 21:52:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260910195257.GB270563@pevik>
References: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
 <20260910-fix_documentation-v1-3-44313069bbe8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260910-fix_documentation-v1-3-44313069bbe8@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/9] doc: Clarify API coverage and navigation
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> +++ b/doc/developers/api_network_tests.rst
> @@ -1,7 +1,31 @@
>  .. SPDX-License-Identifier: GPL-2.0-or-later

> -.. Include headers in this file with:
> -.. .. kernel-doc:: ../../include/tst_test.h
Yeah, the docs is now kind of obvious.

> -
>  Developing using network API
>  ============================
> +
> +Overview
> +--------
> +
> +LTP network tests support both single-host and two-host test configurations.
nit: Maybe blank line here (it's own paragraph). But even this is going to lead
to duplicity (functionality described in both places).

> +Network stress tests and environment parameters are defined in
These variables are also for other network tests than just stress tests.

> +:shell_lib:`tst_net.sh` and documented in
> +:master:`testcases/network/README.md`.
The above is ok, but I would just point:

Network tests are documented in :master:`testcases/network/README.md`.
and delete the rest of the docs below ...

> +
> +Single-host configuration
> +~~~~~~~~~~~~~~~~~~~~~~~~~
... because this Single-host and Two-host related sections is a duplicity of
testcases/network/README.md. I'm ok to move testcases/network/README.md to
readthedocs, but it should not be on 2 places.  I recently spent time to remove
doc duplicity, because sooner or later one of them gets outdated, please don't
introduce it again.

The other unrelated changes are ok (feel free to add my RBT for them if in a
separate commit).

Kind regards,
Petr

> +
> +Single-host is the default configuration when the ``RHOST`` environment
> +variable is not defined. LTP creates an ``ltp_ns`` network namespace and
> +configures a ``veth`` pair according to LTP network environment variables.
> +
> +Two-host configuration
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +This setup requires the ``RHOST`` environment variable to be set to the
> +hostname or IP address of the remote test machine, along with passwordless
> +SSH access configured for root. Both machines must have LTP installed in
> +the same location.
> +
> +For more details on network test setup, server service dependencies, and
> +running the tests with ``network.sh``, see
> +:master:`testcases/network/README.md`.
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
