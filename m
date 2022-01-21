Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A6DC433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 09:20:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 374F23C96F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 10:20:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5A363C9232
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 10:19:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 497F36002DE
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 10:19:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4577E21903;
 Fri, 21 Jan 2022 09:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642756797;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SdE2BP9EoXrSaSchtg6y/5KVik3O1xfIOVhz4P7Mmo=;
 b=RGeeVTVJlfulauqWp8MPyj342NSFzWYnsnvXXGJhObudJqVJGk01UihtViBJdfA1ge/mxn
 4ZrNoXmt4D88mqq5bWTrMCD7SjnYE+IWl8r9am8s7OH+Ql+txQwFtf/jmEamNqfMNZLf1r
 XfbbTx2IKYcccAE2DqAJFq0XErLZ3ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642756797;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SdE2BP9EoXrSaSchtg6y/5KVik3O1xfIOVhz4P7Mmo=;
 b=HEvNi9xezxrhqdP78yVh8zz98uwY0SpD4q8EtLR00MEex58iakUeNiPGCm5LeAV/k7dVWg
 82N5klAtgzcC+3AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22A1713C1A;
 Fri, 21 Jan 2022 09:19:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QnnSBr166mFoTgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 09:19:57 +0000
Date: Fri, 21 Jan 2022 10:19:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <Yep6u4N+phjB32Xd@pevik>
References: <20220120150421.26639-1-andrea.cervesato@suse.de>
 <YemAQcXuJMGLh/kc@yuki> <Yep1Wm84sKzl3iB6@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yep1Wm84sKzl3iB6@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Reduce needed memory by the dio_read test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> > But I'm not sure about the -s 5M part, the file size was always 128MB
> > before and reducing it to 5M sounds like too much. On my machine that
> > reduces the testing time from about one minute to a few seconds, that sounds
> > like change that is too radical without further explanation. If we want
> > to run the test with smaller file size I would go for 64M, that reduces
> > the runtime to half without reducing the changes for triggering a bug
> > too much.
> Good catch.

> I'm also going to verify ADSP075 dio_sparse  -w 518192k -s 518192k -n 1000
> from ltp-aiodio.part2. Cyril's suggestion is to use '-n 1' to emulate
> only single children in previous implementation.
No, this is wrong. Also the issue can be just a timeout.
ADSP074 (uses -n 512) runs framework ~3.5 min, ADSP075 (uses -n 1000) gets killed
by LTP timeout. Do we want to increase tst_test.timeout for test?

Am I correct that we cannot increase based on particular input (for particular
getopt value) as we cannot later update results.timeout during run?

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
