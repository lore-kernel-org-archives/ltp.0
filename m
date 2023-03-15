Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40946C6FD1D
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 10:35:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1F6C3CB7B9
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 11:35:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1B753CAC7C
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 11:35:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A73B7200BB0
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 11:35:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 39897219A7;
 Wed, 15 Mar 2023 10:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678876518;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+a5XmNtJ7H4M5XIVQMW4BmymIojHls1CCYDqTE7MGiw=;
 b=pWf7cXZd48nkkdB3LqE9l9R7qvczI6mamx1JtbNJqXP/LqOuTzWpEYb9wx4JBGr3CvKECH
 YnXTXTfCWw9qnLQkVaXK5LTb6riDTS9m7ZKXAY+rxvss9Q33TSb0nITH/8/gCaHAYluNx3
 7xOV14/Pqu1zzY/pNTwVgUvnevicbJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678876518;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+a5XmNtJ7H4M5XIVQMW4BmymIojHls1CCYDqTE7MGiw=;
 b=GAzUg9MWDIS8/0LI3U9QMBOM/q25+FPkYSRyyE6nb0xRQqu9+rhX3D2+qxBqL2RHA1uTKZ
 D0+e0f/B7q6MMxDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A25613A00;
 Wed, 15 Mar 2023 10:35:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id axfwBGafEWQdTQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Mar 2023 10:35:18 +0000
Date: Wed, 15 Mar 2023 11:35:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230315103516.GB148236@pevik>
References: <20230309145917.26846-1-pvorel@suse.cz>
 <20230315005637.GB18639@localhost> <20230315020140.GA138022@pevik>
 <20230315043857.GA5336@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230315043857.GA5336@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ns_ifmove.c: Rewrite to new API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> > > should we use tst_res(TINFO) instead of printf?

> > NO. If you look into testcases/lib/, none of *.c tools use tst_res().
> > The only separation between API for tests and API for tools / library
> > than TST_NO_DEFAULT_MAIN.
> Got it, this is lib API. Why ns_ifmove.c's parent directory name is 
> "share" instead of "lib" or at least contain "lib" key word?

The move is in another patchset:
https://lore.kernel.org/ltp/20230310124125.14279-1-pvorel@suse.cz/

> > Actually, unless SAFE_*() are useful to use (here SAFE_SOCKET() and
> > SAFE_IOCTL()), we prefer to not use tst_test.h at all (see tst_cgctl.c,
> > tst_device.c, ...)


> > I also think that tst_get_free_pids.c does not need TST_NO_DEFAULT_MAIN and
> > tst_test workarounds.
> Is there possible split current tst_test.h to two files and remove 
> TST_NO_DEFAULT_MAIN workaround? Such as tst_tools.h(include SAFE*) for lib api
> and main.h for testcase.

IMHO that would not be trivial, i.e. not worth of the effort.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
