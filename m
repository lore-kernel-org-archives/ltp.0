Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89BAC433EF
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 11:58:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47BC83C937C
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 12:57:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFD263C29FC
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 12:57:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5E678600277
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 12:57:48 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7024B1F393;
 Mon, 10 Jan 2022 11:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1641815867;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FGBAWY+e2GK5gTYqpNBwZV813cwdI1X4HI0X+DSS4Jc=;
 b=yhJxcrpGuja3Qk7n6u5Zop68BeytgeZwL2/s34T07igpEAskia+LtB7O+H4y3Op73TebTt
 EfBYsPyQbqvZfZW+DBDwDbOu79JMdqylqlWH5gFIlveojYUEqjFSDfAPVrLx04Uabd0DFl
 mlYAjL90XJPlchuDNMpMtfRR7RQ3c+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1641815867;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FGBAWY+e2GK5gTYqpNBwZV813cwdI1X4HI0X+DSS4Jc=;
 b=U34+LF5RGjkmuadEd9p1m7gKTdBcSCBP50hbKql0l5QxUJbuVxelOnMa4HSVfp1CXd7zUt
 bkiHz0VTX0sEQWDA==
Received: from g78 (unknown [10.163.24.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 369D4A3B87;
 Mon, 10 Jan 2022 11:57:47 +0000 (UTC)
References: <20211124080413.768368-1-lkml@jv-coder.de> <87tug2kldc.fsf@suse.de>
 <4b61c5e9-0976-9e5c-543f-f0ad29307b24@jv-coder.de>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 10 Jan 2022 11:57:12 +0000
In-reply-to: <4b61c5e9-0976-9e5c-543f-f0ad29307b24@jv-coder.de>
Message-ID: <87ee5f247c.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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

Hello,

Joerg Vehlow <lkml@jv-coder.de> writes:

> Hi,
>
>
> Am 11/24/2021 um 9:24 AM schrieb Richard Palethorpe:
>> Hello Joerg,
>> Joerg Vehlow <lkml@jv-coder.de> writes:
>> 
>>> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>>>
>>> Fix three errors:
>>>   1. read -d is not posix, but not even required,
>>>      because find and read work line-based
>>>   2. Setting cpuset.cpus to an empty string is not allowed.
>>>      -> If there are cpuset groups defined already, we need at least two cpus.
>>>      One is used for the test, the other one is used for existing groups.
>>>   3. Existing cgroup hierarchies were not handled correctly.
>>>      When setting the cpuset.cpus, it must be done first for parent groups,
>>>      otherwise cpu constraints for can be violated.
>>>
>>> Fixes: 6950e96eabb2 ("cpuset_regression_test: Allow running, if groups exist")
>>> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>> Looks Good!
>> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
>> 
>
> a little ping for merging this
>
> Joerg

Thanks, pushed!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
