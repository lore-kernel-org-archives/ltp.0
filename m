Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6103FC6FD1F
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 14:30:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A31D23D0ECC
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 15:30:39 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60C683C02E6
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 15:30:24 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D5DDD601FC1
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 15:30:23 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 36E205D6EC;
 Tue, 26 Mar 2024 14:30:23 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 18CFD13215;
 Tue, 26 Mar 2024 14:30:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id dE8GBf/bAmZVSQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 26 Mar 2024 14:30:23 +0000
Date: Tue, 26 Mar 2024 15:30:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240326143021.GF715328@pevik>
References: <20240320102204.475230-1-pvorel@suse.cz>
 <20240320102204.475230-4-pvorel@suse.cz> <ZgKmScOuuiobsEdj@yuki>
 <20240326115356.GD715328@pevik> <ZgLCb2g9KJjPDcux@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZgLCb2g9KJjPDcux@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 36E205D6EC
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] fanotify14: fix anonymous pipe testcases
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
Cc: Mete Durlu <meted@linux.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > @Cyril, @Li: How about add 2 macros with '_SIZE' in the name?
> > (TST_EXP_FAIL_ARR_SIZE and TST_EXP_FAIL2_ARR_SIZE, see diff at the end).

> Maybe just _SZ instead of full _SIZE?

> Also the TST_EXP_FAIL_ARR() is rarely used so we may as well to change
> it to include the size argument explicitly, the worst case is that user
> would have to pass down ARRAY_SIZE(errnos), which is just one more
> argument. The macro is used by a single test at the moment so it's easy
> now. Doing that would at least slown down the combinatoric explosion of
> the test macros.

Good point, I just replace ARRAY_SIZE(errnos) with size parameter in the next
version. Thanks a lot for your input.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
