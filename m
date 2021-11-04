Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA80C433F5
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 19:46:18 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 105686103B
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 19:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 105686103B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E70E53C737F
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 20:46:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0748E3C7186
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 20:46:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3F2CC1400F53
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 20:46:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 51FE4218B2;
 Thu,  4 Nov 2021 19:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636055161;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=drn8ZjPMBZs6NMRZjm3q1R+4sb9/B57UZjGtqEHHIdE=;
 b=VmrGBjjDErGLS5+Z7c9ss9Dw3KpWgFbUvCqX8K4+kTFNsGya/TycLPh7KBVpwtSSto3qnH
 0AoO1x/ud92Y1i5KU1oA7xtboLOZLZ0XrE3BCshzRjbGVc6UiyhKODs2D1VWaF4aJ3qfgX
 XsJcEVgu8c6hWCivc0HNgwQKdiHKmMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636055161;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=drn8ZjPMBZs6NMRZjm3q1R+4sb9/B57UZjGtqEHHIdE=;
 b=PDF8fxzKyIwatkRbz1I/fnEu3kycHN5bKKcAl4NTMwIeY25xRWlKz6q+z8r/Y033eJYiLZ
 l8XmJOWAIeLWwIDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16A2113FCE;
 Thu,  4 Nov 2021 19:46:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id P6orOHg4hGGlYAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 Nov 2021 19:46:00 +0000
Date: Thu, 4 Nov 2021 20:45:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YYQ4dnFGVkzX4DCw@pevik>
References: <20211103160815.20282-1-pvorel@suse.cz>
 <YYPc0E/IUPBu1z2k@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYPc0E/IUPBu1z2k@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] configure.ac: Print lib & docparse summary
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

Hi Cyril,

> Hi!
> > Due many checks of structs, members etc are library presence and
> > docparser config results quite hidden. Print them in the end.

> Another option would be adding 'make info' target to the top level
> Makefile that would print these based on config.mk, not sure if that
> would be much better than this though.

While using config.mk would make things easier, I slightly prefer to have info
printed after running ./configure.  Maybe we could even have both. Unfortunately
each would have to have its own implementation, as configure.ac setup IMHO does
not allow to use config.mk output.

Whatever option we use, what'd be worth to print? Just libraries and docparse
(as done in this RFC) or more info from config.mk?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
