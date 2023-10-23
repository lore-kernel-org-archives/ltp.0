Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124CCC25B41
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 08:07:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD7E13CCE41
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 10:07:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4595D3CB4A2
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 10:07:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4810A1A05C7C
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 10:07:32 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 532C221AB4
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 08:07:31 +0000 (UTC)
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id CE3D62C7B2;
 Mon, 23 Oct 2023 08:07:30 +0000 (UTC)
References: <20231020110918.26066-1-pvorel@suse.cz>
 <20231020110918.26066-2-pvorel@suse.cz>
 <ca93e490-bd8e-3ecc-9426-9637bb9a6c6b@suse.cz>
 <20231020144346.GA8789@pevik>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Oct 2023 09:05:22 +0100
Organization: Linux Private Site
In-reply-to: <20231020144346.GA8789@pevik>
Message-ID: <871qdlwym5.fsf@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-1.27 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(0.20)[suse.de];
 R_SPF_SOFTFAIL(0.60)[~all:c]; RCPT_COUNT_FIVE(0.00)[5];
 HAS_ORG_HEADER(0.00)[]; TO_MATCH_ENVRCPT_SOME(0.00)[];
 VIOLATED_DIRECT_SPF(3.50)[]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(0.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-2.06)[95.40%]
X-Rspamd-Queue-Id: 532C221AB4
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] setsockopt10: Use lapi/{socket,
 tcp}.h to fix compilation
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> HI Martin,
>> Hi,
>> I've checked that setsockopt10 will compile on SLE-15SP1. For both patches:
>
> thanks for testing. So we now have covered distros based with 4.12 and 5.3
> kernels and glibc 2.26.

Thanks for cleaning that up!

>
> Merged.
>
> Kind regards,
> Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
