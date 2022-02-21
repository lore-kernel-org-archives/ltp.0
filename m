Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621F5C433F5
	for <ltp@archiver.kernel.org>; Mon, 21 Feb 2022 13:24:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40D783CA165
	for <ltp@archiver.kernel.org>; Mon, 21 Feb 2022 14:24:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D46603C1041
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 14:24:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5BC8814052DE
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 14:24:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5CBF62113A;
 Mon, 21 Feb 2022 13:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645449871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Izirxz/Ioa6cXoab1G7DHJHSuH1NTu1dMhtiZKZoLR0=;
 b=J0ZaHPQg2Wdw6ML0fYefrmdJHJkCJx574WxoKoMtvJNu4NfYc0PZjqrZ3CWgtx3TGw1i42
 5ADb4q6AzRUmVnLuKQpZRrhNj5b6/svDFeltWG3da2gEQN0q+8gVe3DKjDYV9IkzHPXDzT
 n7JmtCl0LCmEVSi9DuLUIeTlcHl0IsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645449871;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Izirxz/Ioa6cXoab1G7DHJHSuH1NTu1dMhtiZKZoLR0=;
 b=FP3kjYA4A5go8zZFqTEIt2DIJCSPdwVAfwMcK3wtEt2MWkFIfvdBCfX2qYVWS1IMOEQoPZ
 JzkrCg4t6TKcFnAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43FE213A9C;
 Mon, 21 Feb 2022 13:24:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7KczDo+SE2IrBAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 21 Feb 2022 13:24:31 +0000
Date: Mon, 21 Feb 2022 14:26:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YhOTEWKaPpn9Z3yX@yuki>
References: <20220218164845.11501-1-pvorel@suse.cz> <YhOONDJPpHcX4bZW@yuki>
 <YhOQAEHFCeMkrYsE@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YhOQAEHFCeMkrYsE@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC??[DO_NOT_MERGE][PATCH v2 1/1] netstress: Fix race
 between SETSID() and exit(0)
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >         tst_res_ TINFO "run server 'netstress $s_opts'"
> >         tst_res_ TINFO "run client 'netstress -l $c_opts' $run_cnt times"
> 
> 
> Yes, this looks like enough. Do you want me to merge this proposal with added
> this change? Or you send a patch or just merge fix yourself?

Just merge it all into a single patch.

> > However the debugging took longer than I wanted to since the network
> > tests are such a mess. The server does exit by TBROK (which looks like
> > it's an expected behavior), only half of the sever log is printed on a
> > failure, etc. These should really deserve some cleanups...
> I'd say specifically tst_netload() (in tst_net.sh) and netstress.c deserve
> cleanup. Also, as we noticed several times shell tests tends to be buggy,
> specially in combination with C tests. But not sure if feasible to write
> everything in C.

I guess that we can do some minor fixes, but the whole codebase looks
like it needs to be rethinked and redesigned...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
