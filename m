Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA50C52D7C
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 08:20:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCCF13D2106
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 10:20:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 302DF3D2038
 for <ltp@lists.linux.it>; Wed,  7 Aug 2024 12:00:01 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 701D5601FAB
 for <ltp@lists.linux.it>; Wed,  7 Aug 2024 12:00:01 +0200 (CEST)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5bb477e3a6dso1946400a12.0
 for <ltp@lists.linux.it>; Wed, 07 Aug 2024 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723024801; x=1723629601; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=95MOr2Nqpzaj8+hgDHljrv8kJYESZgT7/x0j3jGO6bQ=;
 b=tGhss9uXiyof3aV3eTbUFwBxMyImA3+Tsx+muA7rQH2gKmj7V+3IxSEEGGt1RpDPu4
 geT0wF7y2IZTF2ol4mIhf/+uZtAwBH2lB18TxQzCXhQBvVfQyz5KQwJ/0EcIDrPsm4cC
 6nNUUXw4R+asuBeXZ+5z+uABi2mKBZ9CysmaB4F/d7r9L5M8dc3VhzWkEu41jo4kQlw+
 9V8O0RSgt7ffVPH7LULln7eM6VVfFoU8IT6hovRlJ6KqEnPognCWOW+4ITFn4X7lKwdd
 NTf9NCdZ07PeXIoqVQZEYzkL+gErSXhvkk1P5j1XDwEc5B9eun8N+AfjT5X42rrg7xkF
 ObPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723024801; x=1723629601;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=95MOr2Nqpzaj8+hgDHljrv8kJYESZgT7/x0j3jGO6bQ=;
 b=PGBaSc55zy4Vq1WwCj/oHl0f8PD8Oy5ePzqGYKJTIAwbouhkxUijTjmC6cxv8+/kkM
 tGmpn5BUPGORVTrSy7OjNXtCMXDAEpOnvN7KvqzFoY4zROrL5YGuOdoFA5ZKd/DBTiNu
 07Uh6w61estjCUDBWSFgMIS9Vi+xwsDk+pwzkcm+vxF24nXylTsjh2HF7yWRTyvX6LGX
 pjwcqCZF9BL3BwBInF6+TZOIAPCIcBABEpCDBc6dzwfrbmLuG5UN8hGO9OEliEURllME
 hjxoW4UyxdAJB1WqE26Ei1BIRWdNUzwS0/yxt0sIg8NQeDgs8SQxaVG4GxVHh5w9q8F1
 z+lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5wk3cd/Cm5GKs1mb69qWbxono0sbu5kwu3KAJDEBcIXphDIlimUDsH1fsxmaMOD3QtF/+3A0Dq0dJcMCjDmSCsgM=
X-Gm-Message-State: AOJu0YwNpfp48RybnX3bVAVR/GOtj6c6EI0J3XHwGmR2BYSBqmmOyFZU
 CjXp5+HMxkhgVmtbRl5D4skDoIsrxEiwZMCm/QE1V+BidcnA3HubGsX1Cp6QXgQ=
X-Google-Smtp-Source: AGHT+IF+gip/DTvnEMfinas8Dy//yVlsojjlA4Pv9/lXs0zNoaaogYms61L9cR7FBQ8BvCrZVYEkbQ==
X-Received: by 2002:a17:907:934a:b0:a7a:a5ed:43d0 with SMTP id
 a640c23a62f3a-a7dc5071046mr1387925166b.47.1723024800697; 
 Wed, 07 Aug 2024 03:00:00 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.215])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0cbe6sm625039366b.71.2024.08.07.02.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 03:00:00 -0700 (PDT)
Message-ID: <79fb2439-db38-4aad-bf91-2d3b031309a8@linaro.org>
Date: Wed, 7 Aug 2024 10:59:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mark Brown <broonie@kernel.org>, Josef Bacik <josef@toxicpanda.com>
References: <20240531-beheben-panzerglas-5ba2472a3330@brauner>
 <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
 <f8586f0c-f62c-4d92-8747-0ba20a03f681@arm.com>
 <9bfb5ebb-80f4-4f43-80af-e0d7d28234fc@sirena.org.uk>
 <20240606165318.GB2529118@perftesting>
 <1eaedeba-805b-455e-bb2f-ed70b359bfdc@sirena.org.uk>
 <550734af-e115-4048-8a8f-0fdaa199c956@sirena.org.uk>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <550734af-e115-4048-8a8f-0fdaa199c956@sirena.org.uk>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 13 Aug 2024 10:19:42 +0200
Subject: Re: [LTP] [PATCH] fs: don't block i_writecount during exec
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
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>, "lee@kernel.org" <lee@kernel.org>,
 jack@suse.cz, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 david@fromorbit.com, Christian Brauner <brauner@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 William McVicker <willmcvicker@google.com>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 hch@lst.de, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 6/6/24 6:49 PM, Mark Brown wrote:
> On Thu, Jun 06, 2024 at 06:33:34PM +0100, Mark Brown wrote:
>> On Thu, Jun 06, 2024 at 12:53:18PM -0400, Josef Bacik wrote:
>>> On Thu, Jun 06, 2024 at 04:37:49PM +0100, Mark Brown wrote:
>>>> On Thu, Jun 06, 2024 at 01:45:05PM +0100, Aishwarya TCV wrote:
>>
>>>>> LTP test "execve04" is failing when run against
>>>>> next-master(next-20240606) kernel with Arm64 on JUNO in our CI.
>>
>>>> It's also causing the LTP creat07 test to fail with basically the same
>>>> bisection (I started from next/pending-fixes rather than the -rc so the
>>>> initial phases were different):
>>
>>>> tst_test.c:1690: TINFO: LTP version: 20230929
>>>> tst_test.c:1574: TINFO: Timeout per run is 0h 01m 30s
>>>> creat07.c:37: TFAIL: creat() succeeded unexpectedly
>>>> Test timeouted, sending SIGKILL!
>>>> tst_test.c:1622: TINFO: Killed the leftover descendant processes
>>>> tst_test.c:1628: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
>>>> tst_test.c:1630: TBROK: Test killed! (timeout?)
>>
>>>> The code in the testcase is below:
>>
>>> These tests will have to be updated, as this patch removes that behavior.
>>
>> Adding the LTP list - looking at execve04 it seems to be trying for a
>> similar thing to creat07, it's looking for an ETXTBUSY.
> 
> Or not since they reject signed mail :/

FYI, I encountered the same test failures. I opened a bug on the github
ltp project suggesting that the tests need to be updated. Here it is:
https://github.com/linux-test-project/ltp/issues/1184

Cheers,
ta

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
