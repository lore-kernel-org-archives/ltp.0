Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD6EC87FCB
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 10:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754996265; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=AWPaROKIHLASXQnXibClwvAoEzfs4xoo1RRcOdoMnWY=;
 b=o7KFSN6Hh6GsiLeVO9JzP4BPcMoCps68RN6/XrUvDpiIFz4XlxuMbol3MHVB+7f7Wndyl
 8fZBDt54JLPD8zaBF6+eQMh4m/rx42IosvaWnIyeqqQTNM83vHieezm7TVOMk6JEX9cDxDX
 i1mbATEhMqtLtECXYDjsLFIOQ9x2Btk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BF473CB1C4
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 12:57:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2857E3C0639
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 12:57:23 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 78C6B14001F6
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 12:57:22 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-458b885d6eeso34043105e9.3
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 03:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754996242; x=1755601042; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bYc9OR3JfiLSWB+rVEwuVRK2AbClfw0mPQejLDBSyhE=;
 b=AcT9LYHewKkjCkJFaje9PIhqEfA0RTd04YNQKI0xdqYl6CMCwyF3qCVWp+dq75l7SY
 aqZMhgZG/rRhrhlVeASETXFWsn4xLRGAFpwMFfs8juTj9ot1A3hKBPZi7vWBYfkpb5L6
 +4UKGVHCkOqJjTrWTUTVFnTgySpqrnlbqJF+lpPV0NusHqSG+1vYiycf0pgNZURA+Qjq
 OZPe2t17lKrZKXE1XmWwvS9hl8IMp5E5/28OgUoPujdgFJuI7tC559tZdK8bn6a+71oB
 y1qhLs5mPkSoA4oLoUAj4TrKG3ye2PZtDxHXXykXUOlHGJ6Yi3rywBD3RKGtfbHYDD7H
 3ZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754996242; x=1755601042;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bYc9OR3JfiLSWB+rVEwuVRK2AbClfw0mPQejLDBSyhE=;
 b=ZEyxxRuRdKYAIxrijLq4T9ms2HLh9bGmaBxu1pPYMWazsd0/AK/QIakMAPWUVtqKWw
 GOoNRaju8JaQZGMa4QR/rwqMniC4vqmxK3GVPy9dBeJXbLm2RVdJVw89ioOV7ZkiIyGD
 iiKpcLQQ+2ANeyXDpWzje3EX2Z8v5TfFbOjq8a22os1tIRd4Lz2bKndIBnpvDhNSd3EO
 3+MzkZfHhkbrF1grACthGFN+sUbkaiNdnJSPvSUT5r76bO9gdB/oiQM6AfoeTqdO5HFb
 YjOCyuB+ZVOGRl3B66l8hhQjZFhoXqa50vUrBMmsDUpUeUT/mtcCbg45sANWFFj/YGcY
 46kQ==
X-Gm-Message-State: AOJu0YzO2vORMpYKubXyOjbVeWboua5Bz3i2hlnze0rUC/cj3lZTTxYE
 D+JY4k7S2p+EKHJiQ6tYfdTDezo0CCpFiTG5LqjNBnb/gpuu4ANWAMght/KevFQyJUA=
X-Gm-Gg: ASbGncu7bXzLFlmu7hYDX2PhZqUqLFQWDH+9FARzm+eliSgJlcxWMaOhT2Ox7mwnMHU
 Ze+KkeGkIOkgb1TgoArU/J29jfSgDSq4S/JTibh3BzhWxaIKb8cdrjvJ3pJM04sj+SUCSXVc2NE
 bBnY4E1wR+9qrhCK9ELVgTnzwCPdDm3HZh9TOse7R9n+OHDgnbt26jjXmdkEkJFLIWxXuB3QFxK
 pi3Dni3DmX+Q/1k1fk/p8KJgAaZF/MgNKdd/Bz8fx8hel2ekWSo1gwYz1TIWgL05WmvjFt8Sg45
 NPEvmCHun3jRdAuxrc+KRwJolqpvx3uyda1NJdWG7CCZxFmshPkVNQtMUwG+vqSUUies23XqrNw
 v+6ADqX89FLNdISKNz43quuUcocXaTorVTw==
X-Google-Smtp-Source: AGHT+IHQ3WSaMvectS3oJb4csQO2o6YMtNUv8f89jofPJPkh6zXs4ZhLnGPAeTUK293E7sA8oK0n6Q==
X-Received: by 2002:a05:600c:1d16:b0:453:23fe:ca86 with SMTP id
 5b1f17b1804b1-45a10b9f42cmr26462345e9.4.1754996241653; 
 Tue, 12 Aug 2025 03:57:21 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.217.151])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abeb2sm43901174f8f.11.2025.08.12.03.57.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 03:57:21 -0700 (PDT)
Message-ID: <d6ff8f3c-6ac6-4bd5-beac-036b775698ec@suse.com>
Date: Tue, 12 Aug 2025 12:57:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250812-cve_2025_38236-v1-1-e3617ada69c6@suse.com>
 <aJsMwaWb2kIQKEtF@localhost>
Content-Language: en-US
In-Reply-To: <aJsMwaWb2kIQKEtF@localhost>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve: add CVE-2025-38236 test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 8/12/25 11:43 AM, Wei Gao wrote:
> On Tue, Aug 12, 2025 at 10:45:59AM +0200, Andrea Cervesato wrote:
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>>
>> Test for CVE-2025-38236 fixed in kernel v6.16-rc4:
>> af_unix: Don't leave consecutive consumed OOB skbs.
>>
>> The bug is triggered by sending multiple out-of-band data to a socket and
>> reading it back from it. According to the MSG_OOB implementation, this
>> shouldn't be possible. When system is affected by CVE-2025-38236, instead,
>> skb queue holds MSG_OOB data, breaking recv() and causing a use-after-free
>> condition.
>>
>> Even if MSG_OOB is mostly used inside Oracle's product, it is enabled by
>> default in linux kernel via CONFIG_AF_UNIX_OOB. This is accessible via
>> Chrome's renderer sandbox, which might cause an attacker to escalate and to
>> obtain privileges in the system.
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   testcases/cve/.gitignore       |   1 +
>>   testcases/cve/cve-2025-38236.c | 101 +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 102 insertions(+)
>>
>> diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
>> index 3a2b2bed619c99a592f51afe50b7196c593f1f45..8eb17ce56b01070e47917f9bb44cf146c0c5b338 100644
>> --- a/testcases/cve/.gitignore
>> +++ b/testcases/cve/.gitignore
>> @@ -13,3 +13,4 @@ cve-2017-17053
>>   cve-2022-4378
>>   icmp_rate_limit01
>>   tcindex01
>> +cve-2025-38236
>> diff --git a/testcases/cve/cve-2025-38236.c b/testcases/cve/cve-2025-38236.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..68cb3d3ee2b624df2a6de2ce07da1d1e3efc8bb8
>> --- /dev/null
>> +++ b/testcases/cve/cve-2025-38236.c
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * Test for CVE-2025-38236 fixed in kernel v6.16-rc4:
>> + * af_unix: Don't leave consecutive consumed OOB skbs.
>> + *
>> + * The bug is triggered by sending multiple out-of-band data to a socket and
>> + * reading it back from it. According to the MSG_OOB implementation, this
>> + * shouldn't be possible. When system is affected by CVE-2025-38236, instead,
>> + * skb queue holds MSG_OOB data, breaking recv() and causing a use-after-free
>> + * condition.
>> + *
>> + * Even if MSG_OOB is mostly used inside Oracle's product, it is enabled by
>> + * default in linux kernel via CONFIG_AF_UNIX_OOB. This is accessible via
>> + * Chrome's renderer sandbox, which might cause an attacker to escalate and to
>> + * obtain privileges in the system.
>> + */
>> +
>> +#include "tst_test.h"
>> +
>> +static const struct timeval sock_timeout = {
>> +	.tv_sec = 1,
>> +};
>> +
>> +static char dummy;
>> +static int sock[2];
>> +
>> +static void run(void)
>> +{
>> +	int ret;
>> +
>> +	dummy = '\0';
>> +
>> +	tst_res(TINFO, "#1 send and receive out-of-band data");
>> +	SAFE_SEND(0, sock[1], "A", 1, MSG_OOB);
>> +	SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
>> +
>> +	tst_res(TINFO, "#2 send and receive out-of-band data");
>> +	SAFE_SEND(0, sock[1], "A", 1, MSG_OOB);
>> +	SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
>> +
>> +	tst_res(TINFO, "Send out-of-band data");
>> +	SAFE_SEND(0, sock[1], "A", 1, MSG_OOB);
> Thanks for your patch. I have some minor comments:
> 1) I suggest check dummy value after each SAFE_RECV above also
This is not useful because bug is triggered after the second send()
> 2) Better send different char for different sent such as A,B,C
This can be done
> 3) Is the second send operation necessary?
Yes (comment above)
>> +
>> +	tst_res(TINFO, "Receive data from normal stream");
>> +
>> +	ret = recv(sock[0], &dummy, 1, 0);
>> +	if (ret == -1) {
>> +		if (errno == EWOULDBLOCK)
>> +			tst_res(TPASS, "Can't read out-of-band data from normal stream");
>> +		else
>> +			tst_brk(TBROK | TERRNO, "recv error");
>> +	} else {
>> +		const char *msg = "We are able to read out-of-band data from normal stream";
>> +
>> +		if (dummy == 'A') {
>> +			tst_res(TFAIL, "%s", msg);
>> +		} else {
>> +			tst_res(TFAIL, "%s, but data doesn't match: '%c' != 'A'",
>> +				msg, dummy);
>> +		}
>> +
>> +		SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
> 4) I think we need check dummy == 'A' here and then report TFAIL with
> use-after-free
>> +
>> +		tst_res(TFAIL, "We are able to access data from skb queue (use-after-free)");
>> +	}
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sock);
>> +	SAFE_SETSOCKOPT(sock[0], SOL_SOCKET, SO_RCVTIMEO,
>> +		 &sock_timeout, sizeof(struct timeval));
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (sock[0] != -1)
>> +		SAFE_CLOSE(sock[0]);
>> +
>> +	if (sock[1] != -1)
>> +		SAFE_CLOSE(sock[1]);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.needs_kconfigs = (const char *[]) {
>> +		"CONFIG_AF_UNIX_OOB=y",
>> +		NULL
>> +	},
>> +	.tags = (const struct tst_tag[]) {
>> +		{"linux-git", "32ca245464e1"},
>> +		{"CVE", "2025-38236"},
>> +		{}
>> +	}
>> +};
>>
>> ---
>> base-commit: e2c58cfcb82be0b376098a67c8f45264282be67a
>> change-id: 20250812-cve_2025_38236-7cb0cd4fdbf5
>>
>> Best regards,
>> -- 
>> Andrea Cervesato <andrea.cervesato@suse.com>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
- Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
