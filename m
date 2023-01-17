Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F44C3DA78
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 14:04:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47DCB3CC8B8
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 15:04:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DAA83C9F6B
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 15:03:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D8F5F600835
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 15:03:51 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B210B687F0;
 Tue, 17 Jan 2023 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673964230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qOB+MuDXDpEI1nFLRjpwgbkFxOMSRLk/VuiUvQ7Aco=;
 b=VRniWCHdo5Ak0EY7Hm9CaOSo+gwjj13NQs2rvxFcmvcfDfxvbH3QxDIwy9YHgRTemAK7nx
 Fcz0UxSTVRa/So2qfbJB09SFsn717roButAlR2B2yRFJ7iu1YFpMLPK+Hw7lHJXig0FN/O
 L5c8Mzy7NAGlIhGVvy7RK1d9yXT2Cx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673964230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qOB+MuDXDpEI1nFLRjpwgbkFxOMSRLk/VuiUvQ7Aco=;
 b=cI+CHLMlRMMEzK06IGi4MjzpDQtKoaIN2dEtLcV0SbL5PLzOZrmVTvprbdWo5Rl1oO/fnS
 Khv8u1sivy7wvTBQ==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 689E22C141;
 Tue, 17 Jan 2023 14:03:50 +0000 (UTC)
References: <20230111091341.13346-1-pvorel@suse.cz> <87o7qywxr7.fsf@suse.de>
 <Y8V5P+j7IL/pvbUs@pevik>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 17 Jan 2023 13:57:55 +0000
Organization: Linux Private Site
In-reply-to: <Y8V5P+j7IL/pvbUs@pevik>
Message-ID: <87y1q1uuka.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/1] aio-stress.c: Remove useless iteration
 variable
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

> Hi Richie, all,
>
>> Hello,
>
>> I have merged this and my/Petr's aiocp patches.
> Thanks!
>
>> Petr I'm not sure what motivated some of these changes? Although clearly
>> the code was incorrect, I don't see the test failures in OpenQA?
>
> These tests fail on by default on distros with /tmp using tmpfs
> (e.g. openSUSE by default and likely many other distros).
>
> We test them on openSUSE with TMPDIR set to folder on Btrfs.
>
> Also I wonder if run aio-stress or other of aio/aiodio tests with
> .all_filesystems = 1 (filter out MS filesystems - run only normal Linux
> filesystems).

Sigh, I suppose so. In fact testing on tmpfs will have very limited
coverage. all_filesystems is more or less a requirement for I/O tests.

>
> Kind regards,
> Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
