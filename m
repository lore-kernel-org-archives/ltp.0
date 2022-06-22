Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4927C43334
	for <ltp@archiver.kernel.org>; Wed, 22 Jun 2022 07:39:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B989F3C94B1
	for <ltp@archiver.kernel.org>; Wed, 22 Jun 2022 09:39:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9CC73C0F84
 for <ltp@lists.linux.it>; Wed, 22 Jun 2022 09:39:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E476E200965
 for <ltp@lists.linux.it>; Wed, 22 Jun 2022 09:39:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 03087218ED;
 Wed, 22 Jun 2022 07:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655883558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6voar+03jBovhDPPjM6P+QAXreGctQImc/pflnsOHVI=;
 b=VcgNEh7BHU3KFgZB0pTDw4fbVXcuXuIa/POSH6aFSsyqWO8Z/xbygZpEYxpHsfcXa7dUyZ
 BxU+M7m/fOpV7PVZB6yApMlPn4JhG3ghS8ohIHYeM9y1WLzkbI/zXZIRA4IQgWFxHM/jNp
 9ZH03Sp376V9/B1jnwIUceGMuzlBig0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655883558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6voar+03jBovhDPPjM6P+QAXreGctQImc/pflnsOHVI=;
 b=UYBLqyZpba/+nD5UbFUAy0TIoyZHTXzKUX0+DjiCScpEc1UIYdWhxCnWFyXqYtM2BVmo6u
 HYp8x0/0uucRNuDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFB5B13A5D;
 Wed, 22 Jun 2022 07:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SCmvNSXHsmIEbAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 22 Jun 2022 07:39:17 +0000
Message-ID: <70e40ba4-0fb6-fdde-fecf-618c13a72cec@suse.cz>
Date: Wed, 22 Jun 2022 09:39:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To: Joerg Vehlow <lkml@jv-coder.de>, ltp@lists.linux.it,
 Richard Palethorpe <rpalethorpe@suse.com>
References: <010001816f3c352e-f5ee78c6-1425-42f5-b673-409a0a92ef74-000000@email.amazonses.com>
 <11d7d8a6-c062-03aa-7e7c-f7d3c3c2f095@jv-coder.de>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <11d7d8a6-c062-03aa-7e7c-f7d3c3c2f095@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] lkft ltp for 6763a36
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 21. 06. 22 9:15, Joerg Vehlow wrote:
>> * qemu_arm64, ltp-crypto-tests
>>   - af_alg07
> @Martin
> This test is very unstable, can we do anything about it?

The only thing that might improve stability is to increase timeout back
to the default 5 minutes. af_alg07 timeout is currently set to 150
seconds and fzsync library will exit after half that time. There is
unfortunately no reliable way to test the bug or even presence of a
supposed fix.

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
