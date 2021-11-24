Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A0CC433F5
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 08:29:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1FC93C697C
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 09:29:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1947C3C1DFE
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 09:29:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 809B82011B1
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 09:29:10 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B54AE21954;
 Wed, 24 Nov 2021 08:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637742549;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ls+3KExHslPEnjH/dofnkeUGG49BwulY8rUWxAYOZf4=;
 b=q8RYsEAHSe96vqt23pVI02x8wDyUTdBnPOzfap/hNuuvctv8jWyfqd97gbW1ZsGkt1xND9
 kpOKJKiVEXlayTlp5+H2leStg3p9XQEqS216iHrNr1hNNgYXY4fFKYFnRJaGXL28sA2PRZ
 NhywT7V4Rxf+PYqKxBmQfKOAIg1cK00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637742549;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ls+3KExHslPEnjH/dofnkeUGG49BwulY8rUWxAYOZf4=;
 b=r+XxHE03CcnZs01fQk7wnt+m/xaTpgDA045KyGeaGo0cBE0dQOS2gNUBc++d4SsIIUm8NV
 r4eZXBBN3CwYBDDA==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 6572FA3B84;
 Wed, 24 Nov 2021 08:29:09 +0000 (UTC)
References: <20211124080413.768368-1-lkml@jv-coder.de>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 24 Nov 2021 08:24:53 +0000
In-reply-to: <20211124080413.768368-1-lkml@jv-coder.de>
Message-ID: <87tug2kldc.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cpuset_regression_test: Fix test,
 if cpuset groups exist already
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Joerg,

Joerg Vehlow <lkml@jv-coder.de> writes:

> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>
> Fix three errors:
>  1. read -d is not posix, but not even required,
>     because find and read work line-based
>  2. Setting cpuset.cpus to an empty string is not allowed.
>     -> If there are cpuset groups defined already, we need at least two cpus.
>     One is used for the test, the other one is used for existing groups.
>  3. Existing cgroup hierarchies were not handled correctly.
>     When setting the cpuset.cpus, it must be done first for parent groups,
>     otherwise cpu constraints for can be violated.
>
> Fixes: 6950e96eabb2 ("cpuset_regression_test: Allow running, if groups exist")
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Looks Good!

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
