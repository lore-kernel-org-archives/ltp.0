Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2BACE79AD
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 07:44:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B3753CDEB9
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 09:44:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F1573CA3D7
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 09:44:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 64851615C0F
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 09:44:08 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 68CBC22638
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 07:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695195847;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5refSPTV/RQSRGMaHkbCi151rrDCmFcIVVIxJKwHv7c=;
 b=GOnuYhZcAKATNwvIoWG3R9JHNBQKdZsT5VOme/sNKqsl/GbJXGdeIj4Ik/6aR7nKSytC6v
 s9FmW4hkyQithYjRDSS8st2zZlVl9Oco9l9BluF2F2f+7Jpham4inYasabsJhvjQ9j5uNG
 uUrbTTg3KKWNWobjzgRxlEorHakz294=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695195847;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5refSPTV/RQSRGMaHkbCi151rrDCmFcIVVIxJKwHv7c=;
 b=BgaYQbHt2aFPxSDTjOwJaqgE6rHqjs8CG4v7oOqUJB5X/84WmhF5+1bisqBU0Qk72vaPud
 kY5kEzhLxP7YTBDg==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 18BAF2C143;
 Wed, 20 Sep 2023 07:44:07 +0000 (UTC)
References: <20230919083827.8423-1-rpalethorpe@suse.com>
 <a2aa6bf8-2299-daad-2291-750c7db6e143@suse.cz>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 20 Sep 2023 08:41:10 +0100
Organization: Linux Private Site
In-reply-to: <a2aa6bf8-2299-daad-2291-750c7db6e143@suse.cz>
Message-ID: <87sf79ffw9.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kvm: Fix Nix build failure by moving
 -fno-stack-protector to CFLAGS
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

Martin Doucha <mdoucha@suse.cz> writes:

> Hi,
> pvorel should have a look whether it doesn't break the other systems
> where -fno-stack-protector is needed, but otherwise:
>
> Reviewed-by: Martin Doucha <mdoucha@suse.cz>

Compilation appears to be fine:
https://github.com/richiejp/ltp/actions/runs/6232857602/job/16916865952

The tests just TCONF on my hardware, but I guess the risk of breaking
the test at runtime is low?

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
