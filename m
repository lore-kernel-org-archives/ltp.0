Return-Path: <SRS0=cJ4o=OK=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988A0C433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 06:41:11 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB59560FED
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 06:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB59560FED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73EB13C8649
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 08:41:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EBD93C19F3
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 08:40:56 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5ABCA1A00E18
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 08:40:56 +0200 (CEST)
Received: from [192.168.178.40] (unknown [188.192.255.100])
 by mail.jv-coder.de (Postfix) with ESMTPSA id AA03F9F917;
 Mon, 20 Sep 2021 06:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1632120054; bh=7iPayDKhalyjHEFs7jz3gyyDOHU1pjMM//NDb4EeClo=;
 h=Subject:To:From:Message-ID:Date:MIME-Version;
 b=K7VWJCJTHi98Z+XQQbLEgXyuQUl0g9hsGNV/UMdyE185Si9WzYrKpT/mn9VOTX+Jv
 uftutHxFWwR+sBzax9jVyhuSLL0eRWHUYI1VPTkCeqDhsiJPV6q8YSsxBXsngI2Q8/
 8TXrQU9+GnMLLUAc5qDD+97lW4T/oK3uHd0goZCk=
To: ltp@lists.linux.it, Petr Vorel <pvorel@suse.cz>,
 Cyril Hrubis <chrubis@suse.cz>
References: <YTim11sKKT8ioZBe@yuki> <YUCPJlim3QFcoibU@yuki>
From: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <f8854610-bf63-be57-bdb8-e4e16345e34a@jv-coder.de>
Date: Mon, 20 Sep 2021 08:41:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUCPJlim3QFcoibU@yuki>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril and Petr,


On 9/14/2021 2:01 PM, Cyril Hrubis wrote:
> Hi!
>> And lastly but not least if you have some patches that should be
>> included in the release please make me know ASAP so that we have a
>> chance of getting them in.
> Gentle reminder, if there is anything that haven't been reviewed yet and
> should be part of the release let me know ASAP.
What about this patch?
https://lists.linux.it/pipermail/ltp/2021-September/024831.html

Late reply, because of my vacation for the last two weeks.


Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
