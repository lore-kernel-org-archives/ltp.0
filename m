Return-Path: <SRS0=Ux39=O7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5829C433F5
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 08:05:40 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9EE160D42
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 08:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9EE160D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE63A3C0376
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 10:05:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B3883C0264
 for <ltp@lists.linux.it>; Mon, 11 Oct 2021 10:05:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 781CD1A014D9
 for <ltp@lists.linux.it>; Mon, 11 Oct 2021 10:05:16 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B17B920037
 for <ltp@lists.linux.it>; Mon, 11 Oct 2021 08:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1633939515;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vFCJFSj6NtGo4k5EI20W5uFFhyQERa+qWRjvl7UEt10=;
 b=p60eKa8Eqp2FZlTxfE0NDi/0jSLrs4C4PuyeNTGpLL07dnMWhpFNbE4TKcj2XzazE1Sl+B
 wZo9SytUvDIbFESZeKgMDCEvxpo6q+D148R0L6WqrFFeSCekZ9XMFYGjQeyRmgePXHMzoC
 Ts3odMOtdHtHHiLiqyvv/ifLCUfx0Oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1633939515;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vFCJFSj6NtGo4k5EI20W5uFFhyQERa+qWRjvl7UEt10=;
 b=8jKAAq1ti717BS4FlCzOROgUWkqMVT9irzUsD6IlUVdoUOfaMuSpk/A1zj4yIsQAJAeMBU
 vU83FZPNLr03PYBQ==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 810A2A3B81;
 Mon, 11 Oct 2021 08:05:15 +0000 (UTC)
References: <20211005134640.12565-1-rpalethorpe@suse.com>
 <YWAh9obO/u22saM8@yuki>
User-agent: mu4e 1.6.5; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 Oct 2021 09:05:03 +0100
In-reply-to: <YWAh9obO/u22saM8@yuki>
Message-ID: <871r4sasw4.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] clock_nanosleep01: Avoid dereferencing bad
 pointers in libc
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

Hi,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Pushed thanks!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
