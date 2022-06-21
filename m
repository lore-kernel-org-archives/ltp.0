Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F549C43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 06:56:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 529CA3C93F9
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 08:56:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23E0D3C641F
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 08:56:06 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9A4321400985
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 08:56:05 +0200 (CEST)
Received: from [10.40.94.3] (unknown [37.24.96.116])
 by mail.jv-coder.de (Postfix) with ESMTPSA id F41019F7FD;
 Tue, 21 Jun 2022 06:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1655794554; bh=dMUk55g4GicZoNxzgKMIWV3AyStqq4CPJkdb6ySqpSE=;
 h=Message-ID:Date:MIME-Version:Subject:From:To;
 b=e//R9mHhuYHp+u25EaHV9Ao3Pr9dr6OLR2eGSNw2Bjk51OpfBIGSDLvceBej4DYbs
 VOxbLGUtwFfPcedPlFE+67Lq+CXYPGDMlOa1A0B1CbJTmzAOtuQNaihYUYO5sVWMIX
 rj0FskhOh8VhFUFNskxqxEowg7OpnqMDKeymzJeo=
Message-ID: <7605268f-8c8b-fe95-3c58-a29544256dee@jv-coder.de>
Date: Tue, 21 Jun 2022 08:55:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
From: Joerg Vehlow <lkml@jv-coder.de>
To: Cristian Marussi <cristian.marussi@arm.com>, ltp@lists.linux.it
References: <20220620133746.99167-1-cristian.marussi@arm.com>
 <762be123-13ad-1fcf-e4f3-846c7e1b236a@jv-coder.de>
In-Reply-To: <762be123-13ad-1fcf-e4f3-846c7e1b236a@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Fix mountns01/02/03/04 final umounts using
 more peculiar dir names
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

Hi,

Am 6/21/2022 um 8:51 AM schrieb Joerg Vehlow:
>> ---
>>  testcases/kernel/containers/mountns/mountns.h  |  4 ++--
>>  .../kernel/containers/mountns/mountns01.c      | 18 +++++++++---------
>>  .../kernel/containers/mountns/mountns02.c      | 18 +++++++++---------
>>  .../kernel/containers/mountns/mountns03.c      | 18 +++++++++---------
>>  .../kernel/containers/mountns/mountns04.c      |  8 ++++----
>>  5 files changed, 33 insertions(+), 33 deletions(-)
>>
>> diff --git a/testcases/kernel/containers/mountns/mountns.h b/testcases/kernel/containers/mountns/mountns.h
>> index ad8befa71..347f0783a 100644
>> --- a/testcases/kernel/containers/mountns/mountns.h
>> +++ b/testcases/kernel/containers/mountns/mountns.h
>> @@ -10,8 +10,8 @@
>>  #include "tst_test.h"
>>  #include "lapi/namespaces_constants.h"
>>  
>> -#define DIRA "A"
>> -#define DIRB "B"
>> +#define DIRA "__DIR_A"
>> +#define DIRB "__DIR_B"
> This is the only non-comment change. How does renaming the directories
> change anything? Am I missing something?
Nevermind, now after I read the v1-thread, I get it..

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
