Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE37ECAAA3
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 08:19:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19B213CA49A
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 10:19:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40E783C8765
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 10:19:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8D4751000348
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 10:19:16 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 77E062246E;
 Fri, 26 Aug 2022 08:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661501955;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n0b+OWeDiRGnWDAIY7+5h3GAf+vmC/oPnqXeZGarE80=;
 b=IDDtseBXV95i9yLlmPazFqBv39Q0JqYx4dowAqxMWdzJAA/+ycqXkMWpD+eMBcWOlkrSgZ
 SN6dPHHZF/QarYJ/yXD9FlEm/klo7bL4dAcPTNmHjIPnVGhgVBiR0rFNLsc2DXUA8Uv/oO
 W2IrOEnorhOUcxnceCipS9ofzTwU4s0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661501955;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n0b+OWeDiRGnWDAIY7+5h3GAf+vmC/oPnqXeZGarE80=;
 b=WlJSyDd0fi+IJIRo7FuAj2DWH9d8Yy195Uww/2FOApYVPE7v9CvJqtlKiS+7z0AIEETcUp
 CfFiYiLIgnrDmDAg==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id DF7EC2C141;
 Fri, 26 Aug 2022 08:19:14 +0000 (UTC)
References: <20220825105204.953388-1-dylan@andestech.com>
 <87k06v1pwp.fsf@suse.de> <Ywh5G6RQi+zitagg@atcsi01>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Dylan Jhong <dylan@andestech.com>
Date: Fri, 26 Aug 2022 08:53:22 +0100
In-reply-to: <Ywh5G6RQi+zitagg@atcsi01>
Message-ID: <877d2v1kot.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/semctl03: Solve kernel panic in semctl03
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
Cc: "Randolph Sheng-Kai Lin\(\(\(\(\(\(\(\(\(\(\)" <randolph@andestech.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "x5710999x@gmail.com" <x5710999x@gmail.com>, "Alan
 Quey-Liang Kao\(\(\(\(\(\(\(\(\(\(\)" <alankao@andestech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Dylan Jhong <dylan@andestech.com> writes:

> Hi Richard,
>
> Thanks for your reply.
> My opinion is the same as yours, libc should do more checking and
> protection for incoming parameters

This is not my opinion.

Are you saying that libc segfaults? This is an acceptable outcome for
the LTP. To stop the test failing we can fork the test and check if the
child segfaults. However it seems the EFAULT test is already skipped if
we use libc, which is also acceptable.

However the patch title says that this resulted in a kernel panic due to
a null pointer dereference? This is a serious kernel bug that may be
exploitable.

>
> In semctl03.c, the two tv->semctl() implementation functions, which are libc_semctl() and sys_semctl(),
> do not pass the 4th argument ".buf" to the next level system call.
> At present, the 4th argument of semctl() implemented in semctl03.c is hard-coded,
> I think passing parameters instead of hardcoding should be more better for this testcase.
> Should we pass all parameters to the next level semctl() system call?

A 4th arg is never passed, if you remove the vararg the test compiles
and runs fine. So the vararg should be removed, but this is relatively
minor compared to a kernel null pointer dereference.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
