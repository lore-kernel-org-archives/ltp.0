Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A793C433EF
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 07:40:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61E193C9417
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 08:40:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9EF83C1B7F
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 08:40:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EF47712959C5
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 08:40:20 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 15F2F1F44E
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 07:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647502820;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9joAW7wf3xtsDsvHZ57kYS0QjJYgt6bre6NYtqFIH5I=;
 b=D6uQWCjaUtVJf8TKs6wrG3wKRqqC2p17DdjFv50XfPp1huSIERfu4khIlMw12jl/LKYfxF
 uhIL48vsnJ2bq0+IjLAknTTtjAm744WGwKb71kC3yX19Ol5ZqHwKmdTPeomdc2Tulfefu+
 R80xAvQ6L/i4GUmyuIgC9f6DWSfKRbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647502820;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9joAW7wf3xtsDsvHZ57kYS0QjJYgt6bre6NYtqFIH5I=;
 b=VWHxUDObUZC5962hgnTVmoh3jAe9wmHrQ4EzpS1rVPPV8+v2ZtIVeAc+Cs/5DzXMBjl1MC
 JWS0lH/cEgzKw+Bg==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D8D73A3BA4;
 Thu, 17 Mar 2022 07:40:19 +0000 (UTC)
References: <20220309164954.23751-1-mdoucha@suse.cz>
 <20220309164954.23751-2-mdoucha@suse.cz> <87o8275lbi.fsf@suse.de>
 <f7972d11-de50-d9bc-3abc-dcba53dc3936@suse.cz> <87fsnj5hi9.fsf@suse.de>
 <dd1485f7-1f0d-3360-451f-99656b0fbe9d@suse.cz>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 17 Mar 2022 07:35:51 +0000
In-reply-to: <dd1485f7-1f0d-3360-451f-99656b0fbe9d@suse.cz>
Message-ID: <874k3x58nw.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add test for CVE 2021-38198
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

Hello Martin,

Martin Doucha <mdoucha@suse.cz> writes:

> On 15. 03. 22 16:44, Richard Palethorpe wrote:
>> Martin Doucha <mdoucha@suse.cz> writes:
>>> So somebody will have to revert the fix and run the test on
>>> custom kernel to answer that question.
>> 
>> Did you reproduce the bug?
>> 
>> I could try this next week.
>
> Yes, I've verified the reproducer on older SLE-12SP5 and SLE-15SP3
> kernels. But none of them currently have the tdp_mmu sysfile so the test
> had to use the Intel/AMD KVM module reload fallback.

I see, in that case I don't think it's important to check it.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
