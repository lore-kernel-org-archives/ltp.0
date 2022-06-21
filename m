Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3BFC433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 07:56:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBB4F3C94F6
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 09:56:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA9B63C0726
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 09:56:23 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 18ACF60090D
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 09:56:22 +0200 (CEST)
Received: from [10.40.94.3] (unknown [37.24.96.116])
 by mail.jv-coder.de (Postfix) with ESMTPSA id A8AC69F7FD;
 Tue, 21 Jun 2022 07:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1655798182; bh=AFa7/QWMDSEvu4iRQPswmZkWQ4r1+p7TfOSMveva3Cg=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=OFX9jbVJ/2lF0DPbtArAsTO0vsC6PqF7ihlsD0eq5YbbFq0p7cphOjNcZCt0skf74
 zdJvb6jeV9BzZlzCIxevtGjK4riVQWpIJaqcDtcFH53YmLu9ledTupAfYowu5sm5WR
 zlYMHjlZtYUGBEBGYVu8eBhRn0atJ3ePIrce7eas=
Message-ID: <60876a29-d589-1de9-b4fd-a9000b8e7d68@jv-coder.de>
Date: Tue, 21 Jun 2022 09:56:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: Jan Stancek <jstancek@redhat.com>
References: <010001816f3c352e-f5ee78c6-1425-42f5-b673-409a0a92ef74-000000@email.amazonses.com>
 <11d7d8a6-c062-03aa-7e7c-f7d3c3c2f095@jv-coder.de>
 <CAASaF6wyH7YJtNaGfR9n-yhnHv9Pc7BvCMYe1EWvwnCMtNhfDQ@mail.gmail.com>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <CAASaF6wyH7YJtNaGfR9n-yhnHv9Pc7BvCMYe1EWvwnCMtNhfDQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] lkft ltp for 6763a36
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
Cc: LTP List <ltp@lists.linux.it>, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

Am 6/21/2022 um 9:22 AM schrieb Jan Stancek:
> On Tue, Jun 21, 2022 at 9:15 AM Joerg Vehlow <lkml@jv-coder.de> wrote:
>>
>> Hi,
>>
>> Am 6/17/2022 um 3:17 AM schrieb lkft@linaro.org:
>>> * qemu_i386, ltp-fs-tests
>>>   - read_all_proc
>> I've seen this test fail a lot, has anyone ever tried to analyze it? I
>> was unable to reproduce the problem when running the test in isolation.
> 
> I see it hit timeouts too (read_all_sys as well). I think it needs
> runtime restored to 5minutes as well, atm. it has 30s.
Didn't think about that, but at least for the failures I've seen, this
is not the reason. The message printed by the test is "Test timeout 5
minutes exceeded."

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
