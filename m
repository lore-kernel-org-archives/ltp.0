Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25E6C27C55
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 08:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717747755; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=Mdg2+sBaqzMI5hw766VtoTFLeZWpRTrrcgHQlhtxse4=;
 b=qMc4Sc9Jh5FZfrXOmQulkeYt5peaAG2brtdlh+R793uPpZ7GAgu6v5GROk/EYvZgvzKYg
 vsgYPbHl3PT0b1fXGqHarYa/QO2r1yOd2kRqxYXd8U7RapG+izNwkt/e3TekXWrxMDetRKk
 lxyzr1zKqMufnbDq9palOfybq+luUgs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0DF63D0A80
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 10:09:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B82A03CB987
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 10:08:53 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 787141A00E30
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 10:08:52 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-35ef3a037a0so992853f8f.0
 for <ltp@lists.linux.it>; Fri, 07 Jun 2024 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717747732; x=1718352532; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Idf9/ApdapA62Km7pXQ2cp/igqi76mp+skqih6ODUEo=;
 b=JmC2XHVUxf3/476E8q8vi3NlK0jY8Tgq4jNohdh7YPhCks0Xqg8VMU6qPxLdm5SvDV
 7al1byDDTS4OlExNxU3lPoOcPZbLAhk4cwnmMIAslf0iOLWGIf6+hqz/4Uyxl3kmZBLA
 x04R0lvh8DdfCd0gDDp+LN3buuyUI61BvUqhOC4klgEf/MSByjsEAb4/TGYsPEhkbtNE
 t9xTF3xRZrC5f4OrHSnJB8ioJK7IKhDg/2GWn2t8g/oxtbDlazodC7bHHGZ7fi3r5XDf
 e+cuEQwBTX0li2FAMcO1b4h+14J6H9Tdvh5VEQ0G/7IzCldq1a978l6RezPvRoGtJu/n
 EJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717747732; x=1718352532;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Idf9/ApdapA62Km7pXQ2cp/igqi76mp+skqih6ODUEo=;
 b=sQ17E/hQ7ykmpQ9OlQuI66pq8rroFt0DADdSRz9X+BsD/U5bMCTDJPHbHMxPQg9Srd
 vZROYCM3v5tN3vT3Nu4uLgCKH9FCASPj6R3MB8XaDlB+jb3g48JVuQ7KT2N7D/E86W09
 Df1kP74h01dvKuIqgUa28MQLsUkAtSFRlAc9+atmiRu43ubOCUGxg+yH/tH5s/6PaTCr
 l60sk/BZaTxV7HN19WrAnRPZdfTPeyoNF08+rse6L7kMmA757H2gHwxtsOT1+/E3fUL+
 635OwT89h9lFvIluLxQSIhovqo/wtgvSNfcL+SB0MffK7OsdauKmOh8JuyApngh6jHWt
 tGpw==
X-Gm-Message-State: AOJu0Yy/H4pb0ko9pocPDdQ4mUCv9nVlgGmZfqNQgO+vPa2QaYPx0BMQ
 5xbVYmuVkEp7t68MbdYwgQJOTMVg1vMCKzYVdbGODFzVDBWUc7LGmhGICkVS2Nw=
X-Google-Smtp-Source: AGHT+IHxLaDcgarHFXQdQU0G/OLXkKGmlW9XqexrrOY/QdRrL+4mywWQ8076rj8Q1zxmifesa2l0jQ==
X-Received: by 2002:a5d:64e1:0:b0:35e:537c:b1ac with SMTP id
 ffacd0b85a97d-35ef0ddc7b0mr5256955f8f.34.1717747731818; 
 Fri, 07 Jun 2024 01:08:51 -0700 (PDT)
Received: from [10.232.133.65] ([88.128.88.163])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd76b16dsm28214655ad.74.2024.06.07.01.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 01:08:51 -0700 (PDT)
Message-ID: <fa9f917b-2c19-4bbd-b04c-fd958dc11610@suse.com>
Date: Fri, 7 Jun 2024 10:08:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240527-shutdown-v1-0-1feffca5e3df@suse.com>
 <20240527-shutdown-v1-1-1feffca5e3df@suse.com>
 <20240605202434.GA452540@pevik>
Content-Language: en-US
In-Reply-To: <20240605202434.GA452540@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Add shutdown01 test
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

Hi!

On 6/5/24 22:24, Petr Vorel wrote:
> Hi Andrea,
>
> ...
>> diff --git a/testcases/kernel/syscalls/shutdown/shutdown01.c b/testcases/kernel/syscalls/shutdown/shutdown01.c
>> new file mode 100644
>> index 000000000..b68b14ae8
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/shutdown/shutdown01.c
>> @@ -0,0 +1,136 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * This test verifies the following shutdown() functionalities:
> nit: here needs to be blank line to get list formatting.
>
>> + * * SHUT_RD should enable send() ops but disable recv() ops
>> + * * SHUT_WR should enable recv() ops but disable send() ops
>> + * * SHUT_RDWR should disable both recv() and send() ops
>> + */
> ...
>> +static void test_shutdown_recv(void)
>> +{
>> +	int client_sock;
>> +	char buff[MSGSIZE] = {0};
> Wouldn't it be better to send some data?
> Or is it not important, we use guarded buffers?
In this case, data is not really important because we need to test if 
send/recv are disabled after shutdown().
>
>> +
>> +	client_sock = start_test();
>> +
>> +	tst_res(TINFO, "Testing SHUT_RD flag");
>> +
>> +	TST_EXP_PASS(shutdown(client_sock, SHUT_RD));
>> +	TST_EXP_EQ_LI(recv(client_sock, buff, MSGSIZE, 0), 0);
> Interesting, I would expect failure ("If how is SHUT_RD, further receptions will
> be disallowed.")
>
> And maybe use SAFE_RECV()?
>
>> +	TST_EXP_EQ_LI(send(client_sock, buff, MSGSIZE, 0), MSGSIZE);
> And SAFE_SEND() here?
>> +
>> +	SAFE_CLOSE(client_sock);
>> +	TST_CHECKPOINT_WAKE(0);
>> +}
> nit: I would also use struct tcase and .tcnt, because all 3 tests are nearly
> identical.
>
> Otherwise LGTM.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr

I will fix the rest.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
