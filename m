Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFF5C433EF
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 06:43:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB04F3C8C68
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 07:42:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E8B53C06B2
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 07:42:51 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C6ED2600C34
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 07:42:50 +0100 (CET)
Received: from [192.168.178.40] (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id A2E0C9FB3D;
 Mon, 22 Nov 2021 06:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637563369; bh=0K+c9ftayFZ4Hvb0siXOemvDfLlVSPNlX0iS2c0z8Ls=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=Pn4NCZRj2wFaq69YZewRcsvIUw/f4jrJ6LbmzMqf6Mnt9Dgelaen3xfV6fNg5oqtl
 aibRiMeJaQN2oTuRGcgTyN5OMwkl8ku+UhdYXV9UDyXNgh7UdXUYrmmu8+8+0rFTui
 qapSK/F1+BOPhJytSNa6w9/vzZ34rUaZP8ZgDQwk=
Message-ID: <6c3b9cbe-f54d-b363-fdcf-4c1a9b7903b7@jv-coder.de>
Date: Mon, 22 Nov 2021 07:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20211119074602.857595-13-lkml@jv-coder.de> <YZfGNUGxPx3MOST4@yuki>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <YZfGNUGxPx3MOST4@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 12/12] posix/interface/conformance: Fix/supress
 all unused-result warnings
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-2.c
>> @@ -33,6 +33,9 @@
>>   #include "posixtest.h"
>>   #include "tempfile.h"
>>   
>> +#pragma GCC diagnostic push
>> +#pragma GCC diagnostic ignored "-Wunused-result"
>>
>>   #define WRITE(str) write(STDOUT_FILENO, str, sizeof(str) - 1)
> There is actually better trick than disabling the warning with pragmas,
> we use it in lib/tst_test.c as well:
>
> #define WRITE_MSG(msg) do { \
>          if (write(STDOUT_FILENO, msg, sizeof(msg) - 1)) { \
>                  /* https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66425 */ \
>          } \
> } while (0)
>
> I guess that we should add PTS_WRITE_MSG() to the posixtest.h and make
> use of it in all open posix tests.
>
> The rest of the patch looks good.
Ok I'll fix it like that. I also like one macro in posixtest.h better 
than in every file.


Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
