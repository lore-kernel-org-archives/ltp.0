Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A770C4332F
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 14:05:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D7803CAD70
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 15:05:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C39D3CA6BA
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 15:05:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C9F5E6011AF
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 15:05:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DEA61F45F;
 Thu,  3 Nov 2022 14:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667484325;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j2VwIS7T0MbrcWBeoF/n3T4njCePLHhheTqihEh6Hhw=;
 b=uo777YhYfWCh+48a/ONDqLQwWoX2S4E6cntUD6vZMurnyCAE0NUmW6ZsM9FV+8UOacT13g
 +JOPjCN4Nr+zeHUc8cF3xri33uUH0JRiVjRKjED18JpifKLQzvZb1N2KQt0cvg8TRM/dIL
 dw4wqkOy5xxRefkaxkDVcS0GpB4W+8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667484325;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j2VwIS7T0MbrcWBeoF/n3T4njCePLHhheTqihEh6Hhw=;
 b=rjzTFU2F5oSYVgGEuo4jHZFXitoKK8x9FNycRm3Z6qfz7e0ALh0uhwARjBDi6U6yu+gcvg
 xkmemIQFEOzMarCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9FAB13480;
 Thu,  3 Nov 2022 14:05:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5jhcMaTKY2NhcQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 03 Nov 2022 14:05:24 +0000
Date: Thu, 3 Nov 2022 15:05:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Y2PKoqbsxun3eAVZ@pevik>
References: <20221102145935.24738-1-andrea.cervesato@suse.com>
 <61b788f9-3b62-d0dd-2679-e21cef89bffe@suse.cz>
 <1af8a502-c736-c31a-8794-c847788c8766@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1af8a502-c736-c31a-8794-c847788c8766@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Correctly check setitimer params in setitimer01
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
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> > > @@ -64,14 +66,18 @@ static void verify_setitimer(unsigned int i)
> > > =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_no_corefile(0);
> > > =A0 -=A0=A0=A0=A0=A0=A0=A0 set_setitimer_value(USEC1, 0);
> > > -=A0=A0=A0=A0=A0=A0=A0 TST_EXP_PASS(sys_setitimer(tc->which, value, N=
ULL));
> > > +=A0=A0=A0=A0=A0=A0=A0 set_setitimer_value(usec, 0);
> > > +=A0=A0=A0=A0=A0=A0=A0 TST_EXP_PASS(sys_setitimer(tc->which, value, 0=
));

> > Why change the third argument from NULL to 0?

> It's a mistake. I sent patch with 0 because I was tweaking with values
> during tests.

Good. I put it back and merged with updated copyright and adjusted the comm=
it
message and description.

Thanks!

Kind regards,
Petr

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
