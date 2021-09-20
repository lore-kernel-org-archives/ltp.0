Return-Path: <SRS0=cJ4o=OK=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8681C433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 07:41:33 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A7160F26
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 07:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4A7160F26
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71CB63C863E
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 09:41:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C27AC3C1B0A
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 09:41:21 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D1AB8600157
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 09:41:20 +0200 (CEST)
Received: from [192.168.178.40] (unknown [188.192.255.100])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 7D71C9F917;
 Mon, 20 Sep 2021 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1632123679; bh=kgTgFDM54QRkoTDupL8MyfsI9FITOsDYEP5osW2ZqeY=;
 h=Subject:To:From:Message-ID:Date:MIME-Version;
 b=Wg7yQVZvg9TG72MSRSMa6uG3z3WEuhVVHYPPGfwWG3GBsuL3vkk/Ql0YlriwbZql/
 492ygQKJ5H9PE+SiLuzOzPRABgRMNobrlvmfgfasaCXFtlkO4eR9B3GPzcTTBCpmTD
 ucQrvPhAIZONB9RG659quoTpmVjsu1CYc/Jgtm0Y=
To: Cyril Hrubis <chrubis@suse.cz>
References: <YTim11sKKT8ioZBe@yuki> <YUCPJlim3QFcoibU@yuki>
 <f8854610-bf63-be57-bdb8-e4e16345e34a@jv-coder.de> <YUg6smoADvGb+zTI@yuki>
From: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <714a9a19-d002-26aa-8226-401ab167a805@jv-coder.de>
Date: Mon, 20 Sep 2021 09:41:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUg6smoADvGb+zTI@yuki>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release planning
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi



On 9/20/2021 9:39 AM, Cyril Hrubis wrote:
> Hi!
>> What about this patch?
>> https://lists.linux.it/pipermail/ltp/2021-September/024831.html
>>
>> Late reply, because of my vacation for the last two weeks.
> That one is already in:
>
> https://github.com/linux-test-project/ltp/commit/80659d062575912c6e589d42d53d3259e0f74571
Sorry, I was only looking for "merged" message on the mailing list. I 
guess I need another vacation :D

Joerg



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
