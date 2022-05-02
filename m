Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67B5C433F5
	for <ltp@archiver.kernel.org>; Mon,  2 May 2022 08:54:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F7473CA850
	for <ltp@archiver.kernel.org>; Mon,  2 May 2022 10:54:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF54D3C982E
 for <ltp@lists.linux.it>; Mon,  2 May 2022 10:54:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DC3F720039F
 for <ltp@lists.linux.it>; Mon,  2 May 2022 10:54:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 20E79210DE;
 Mon,  2 May 2022 08:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651481657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ifHICj9O6qsZcw8w/xyYhm9g/ECK2pXFde/nwIKu2J4=;
 b=ycmcmmDbhWMLPQuGkx6zcszHregf9ZhUTwx4MWBbpvBDBrmb+J+GGLBvSLruR1xqJw4KUK
 F+rFKeZjLKwEMy/ZgqF3YAAog8P40lfTgOp6MjvlXG5suzkvXjnvZZ4RSjhdMrZqz1I/tA
 u5Lh3iY9vE4Fd/obWhfo2lD0j+jQivU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651481657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ifHICj9O6qsZcw8w/xyYhm9g/ECK2pXFde/nwIKu2J4=;
 b=YydVBrpV7x3eDIaXX57F7VkwsP8iM3L8lTgAbJgy54RAc6HKp8+ab57Qq1tHIlHJDJ/KzU
 onGZEVSKDZqJiGCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02094133E5;
 Mon,  2 May 2022 08:54:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FIHuOjicb2IGGQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 02 May 2022 08:54:16 +0000
Message-ID: <cfabdc28-fef8-576f-7845-630a443833d1@suse.cz>
Date: Mon, 2 May 2022 10:54:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20220428065657.32046-1-pvorel@suse.cz>
 <539e2eb7-05d5-470c-3287-b1e9b7220532@suse.cz> <Ymwp2cilZtjn+g3y@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Ymwp2cilZtjn+g3y@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 5/5] busy_poll: Move TST_{SETUP,
 CLEANUP} to the tests
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

On 29. 04. 22 20:09, Petr Vorel wrote:
> I was thinking about it as well. Makes sense, but then it hides the fact that
> busy_poll_lib.sh contain other API variables (missing TST_TESTFUNC suggest that
> there are some variables in busy_poll_lib.sh). Anyway, I'm ok to move it there
> as well, just document that sharing variables between library and test will be
> always a bit problematic.

Now that you mention the other variables in busy_poll_lib.sh, I guess
that TST_MIN_KVER and TST_NEEDS_CMDS should use conditional expansion so
that the values can be changed in the tests.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
