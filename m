Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF1FC5475B
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 09:00:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9A823CE9C6
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 10:00:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E79A13CBE41
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 10:00:35 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dbrendel@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 447E71009BC2
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 10:00:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709715632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pTM8R1DjPE61ZP8cRcY0d2/XqrLsAuW1hdq9iXpyQQw=;
 b=Ita8oMytRsmUOe9kQo7El9M90SiZMS2n6IYosGRmkV6dATX+uHKjEHOiaVPmbvb6hZhfkL
 wsEhJBLQyRj3nPQfZu/aP4gQ9EpN/DUht0/iwDe5FAEoRd+Y7fQJFKrs8ASfSjr6KWJ8XJ
 0jJRRyRvI6ogDYK/wySP0VXEB4O2raQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-MDSq1xudMb6G2QJAf-yjCA-1; Wed, 06 Mar 2024 04:00:31 -0500
X-MC-Unique: MDSq1xudMb6G2QJAf-yjCA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-78838d3c2cbso144254485a.2
 for <ltp@lists.linux.it>; Wed, 06 Mar 2024 01:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709715631; x=1710320431;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pTM8R1DjPE61ZP8cRcY0d2/XqrLsAuW1hdq9iXpyQQw=;
 b=Vci0acPvMqVXxfTQHWkz/elY+1E8xHVK5YKjoFO96HWIg9djP7HvsMz4SVfJflUHOA
 oOkWdof8cMgPS7tT1ztfEC+M/aLvub55WrgjCjZxIsawOMVALrcAI6dbXyeUooWz5PJB
 7Cu9SkP9pej9qNLDQil2QCD2ESbL1w/fZqwISeLp/xU2Hbpr94aCFSMXjM1C1R1T+Z2d
 l1VhlLL6pSSUJVWOLrR8PR5rNADmbA4ZuCsfRBCgun2unm2hSA6iZRtVvZIIpwDbKfmZ
 HD9kE8x9EBAQI/X3xeU18Ma1xu8eltGnAHkKn0Gr5AZMGByWluUp9R9hOHbJ3+QZJYAJ
 e51A==
X-Gm-Message-State: AOJu0YwSJMQR10JUw8fLw+hUEbPSW6POtNIKg/nLi9g4m+K1pkzg1fCr
 EkJrh1Ou6wcyIvaQq0LZxIBxOM2vdh9w/ik4VN5jVmKRkphHiRmEz7iDmopQJBCs0sJJMqQNdwV
 V83nbesTSeOfGzWw362vlbOxAHrdjZSMHOzmcuKfcADPiCX3L
X-Received: by 2002:a05:622a:614:b0:42e:f8c8:3246 with SMTP id
 z20-20020a05622a061400b0042ef8c83246mr4883210qta.41.1709715630783; 
 Wed, 06 Mar 2024 01:00:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzaP4hPH8tc2CrF/6FibM8w+CQaBkkPhXCx4BaIBlSmU04CNtcnkOL8NwTozswaufm+SQtrw==
X-Received: by 2002:a05:622a:614:b0:42e:f8c8:3246 with SMTP id
 z20-20020a05622a061400b0042ef8c83246mr4883188qta.41.1709715630473; 
 Wed, 06 Mar 2024 01:00:30 -0800 (PST)
Received: from [192.168.176.20] (103-200-156-095.ip-addr.knet-kl.de.
 [95.156.200.103]) by smtp.gmail.com with ESMTPSA id
 z17-20020a05620a101100b007876e91f392sm4474825qkj.79.2024.03.06.01.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 01:00:29 -0800 (PST)
Message-ID: <1a27ec16-e4ca-4790-81f7-8aac5e28cca4@redhat.com>
Date: Wed, 6 Mar 2024 10:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <6dfa210d-1c9a-4888-9408-eccc3068cd2a@redhat.com>
 <20240305213050.GB44833@pevik>
From: Dennis Brendel <dbrendel@redhat.com>
Autocrypt: addr=dbrendel@redhat.com; keydata=
 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
In-Reply-To: <20240305213050.GB44833@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] munlockall: add test case that verifies memory
 has been unlocked
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 3/5/24 22:30, Petr Vorel wrote:
>> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
>> +
>> +	if (size == 0UL)
>> +		tst_brk(TBROK, "Locked memory after mlockall() should be "
>> +			       "greater than 0, but is %ld", size);
> I suppose < 0 really means no memory locked, thus really safe to quit before
> munlockall(), right?

Forgot to reply to that.

< 0 should not happen due to unsigned type.

If the size is 0 then it is safe to quit. In general it should always be safe
to exit even if there was memory locked, i.e. when the parsing of
/proc/self/status is faulty or when wrong numbers are reported.

Dennis


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
