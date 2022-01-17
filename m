Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3FCC433F5
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 15:31:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00B623C964B
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 16:31:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F9223C732F
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 16:31:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7D7831A00359
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 16:31:11 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id AF45D21138;
 Mon, 17 Jan 2022 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642433470;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hxuZ5TCBeCN/FGSGaBixMIqTkoSechJKSQCzKKAs/54=;
 b=hdFjekO+eBgRMkz8Mv6flBQdTn0XA0UNSxHLHCetheEUbltyRooZbCSsOjhbKgeMEo++96
 Ap4GmGaC5vuoaIe+4q5OCbmWplQKKSMWgbdmA2gJcElEP4w5/mRX7dUDUVyv+TZPcRajHU
 vMGsuLJ5KnLVMI09gFT0mWNluK3vSpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642433470;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hxuZ5TCBeCN/FGSGaBixMIqTkoSechJKSQCzKKAs/54=;
 b=VtGwl5cVVmlEvGmi5F8IKbXgneCdKmpDhZS8iCoHMzj3ufRI3ZDCdElK58HuawTl1mCOJi
 sYyDYs30lUwwxVBA==
Received: from g78 (unknown [10.163.24.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7835EA3B87;
 Mon, 17 Jan 2022 15:31:10 +0000 (UTC)
References: <YSz36VZ18+N4YsM/@yuki>
 <20210831091005.25361-1-rpalethorpe@suse.com>
 <20210831091005.25361-4-rpalethorpe@suse.com>
 <7cf81226-52ca-5016-5041-ce12b93b534f@jv-coder.de>
 <875yqq1fo7.fsf@suse.de>
 <5de1ae7d-139a-8f76-1e99-27d4491eae15@jv-coder.de>
 <871r1c10my.fsf@suse.de>
 <d68d8f72-fdc9-3a2e-991d-682d8274070f@jv-coder.de>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 17 Jan 2022 15:11:22 +0000
In-reply-to: <d68d8f72-fdc9-3a2e-991d-682d8274070f@jv-coder.de>
Message-ID: <87sftmz8ef.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] bpf_prog05: Drop CAP_BPF and check if ptr
 arithmetic is allowed
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

Hello Joerg,

> I did some more digging and bisecting. First I bisected the mainline
> kernel and found, that the commit 2c78ee898 ("bpf: Implement CAP_BPF")
> makes the check run successful. This is only in linux >= 5.8.
> But my 5.4 ubuntu kernel also successfully ran the check, so I also
> bisected ubuntu sources [1] and found this commit to be the fix here:
> 2fa9ab45c ("bpf: No need to simulate speculative domain for immediates")
> This commit is also in the mainline kernel, but only in >= 5.13.

Uffff, interesting, some of the things mentioned in this commit seem
familiar. I did start working on other BPF reproducers, but gave up for
the time being.

>
> I guess the check you implemented now disables the test for a lot of
> kernels, that do not have a patch like this... I will stop here and just
> accept, that the test is not running successfully in my case. But still
> wanted to share this information.

Thanks, yes this could be useful.

>
> Joerg
>
>
> [1]
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/focal/commit/?id=2fa9ab45c53e8b104ba8f7d3a953131cc818fcc0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
