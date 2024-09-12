Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A963EEB561
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 08:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726129576; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=oXoRA/GQi+z4Mm68iFThZuinOD0W9BNBsP9k2PNXqIo=;
 b=pM3LTf5rFZ9HR9/Rx7UQndglgmlOjcXhQWxDnjVDiqD99rrrnxIIJ1qcZnixw4ZSLOcYx
 xnlKXunAAQgPYbmd7qJg1UIp6S5OHpGEPz6eRsGicGdWsuoioCSKTm4gcMo5DkY3LZB+aOJ
 wigB7xN4RKbJPqYeNjQcs9ixZZ4bfcI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22A023C2460
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 10:26:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B6B93C1D41
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 10:25:55 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 789D11027575
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 10:25:54 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so99781866b.1
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 01:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1726129554; x=1726734354; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19TMrdiAye1VlsklxbzLJm1cda5cPiPxntJ+kqT+dxg=;
 b=S2a9wrjUsmBT/yYYkhiyZA8rWJB3LGCw8vSNbr7SFFY24PO8el0tam4ZmhOntWcBqq
 BrthJIy5IaVftThf6HyDiuLRi0u4t1DgNYNFLh90fePaaSejhLrveZ5qEt9JfUbzxEHH
 1b5W1pBbG5OF1vtZdPOxdBY8EGJNgqYg4LvyUFes7z3AqZHqZD3EK9elIE8wus+Js+PU
 SKNxEWsRd9gGoO0f+DzF5Kdk6YFzQkSJL0ybtDzuj5OR/kiWR1RLSletfS6HkS0bCN4J
 0EeVRcEZhqF5xC2vUPZDKJCS6vYpI6gbVGfbea1UlLQ9/3Gi4FnisrpJjsmz+GN9ckxI
 3bVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726129554; x=1726734354;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=19TMrdiAye1VlsklxbzLJm1cda5cPiPxntJ+kqT+dxg=;
 b=Qw8wq91adbJloGKCJhk5HOBxCUdx0RM/fTb2OpPsw5oeYvJ5f29JFv4W+W0D21Myxg
 munhExyfQe20T0QoT0keOQPVcE5jvTkOh3zdoOUPZBROlu1Tz1L9oSwBKmUE6dbNjB+w
 xAE1kDm0zqFyj1LGsLR2bzLvNE0I+CXmnIHcJvE08yCxFBpJApa/s6blTracUmhtSh3t
 3R3fwcJPink+Bsv1FVhINlcHUVlLOnuvhSCMTwnyUtMbNOti7wkBR3vTWs7K/wjskGTu
 HuBwxJbdV1+OeISjb/a8bVhDqBR9g7FM3oWfEfPXljaHWIWtATW0AZVOBkiCdY7Q1ltJ
 1stg==
X-Gm-Message-State: AOJu0YxZJwGQmkB/2cX9XPzdQlVWnsgsLfqNkIWIyczzcebTIrWo0eGF
 MJ549ARNQDDm97boqOWhiW9om6q+cHDvfj0ne+47iz4g1dJsZNrEr8WIf/YVkSSCWvhodDaXHET
 AnmQ=
X-Google-Smtp-Source: AGHT+IGW8x9u6pgQZXlneCk/hIglYH/XWKkL8Pcet14FOw3HMNv0rxys0rr8RyUIsimSTcGs/seyxA==
X-Received: by 2002:a17:906:c146:b0:a86:82da:2c3c with SMTP id
 a640c23a62f3a-a90296eaaa3mr216304966b.40.1726129552867; 
 Thu, 12 Sep 2024 01:25:52 -0700 (PDT)
Received: from [192.168.178.49] ([212.86.36.216])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2595122asm716205666b.65.2024.09.12.01.25.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 01:25:52 -0700 (PDT)
Message-ID: <4ea18511-bce1-4401-8e68-99696258bff2@suse.com>
Date: Thu, 12 Sep 2024 10:25:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240911133019.11059-1-andrea.cervesato@suse.de>
 <CAEemH2ehvQxCpufKNFoDVPmXdsrJoL0B2fB2hL_txfJxjacFXA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2ehvQxCpufKNFoDVPmXdsrJoL0B2fB2hL_txfJxjacFXA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] Add rename15 test
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U3VyZSwgdGhhbmtzIGZvciBrZWVwaW5nIHVzIHVwZGF0ZWQuIEdvbm5hIGZpeCB0aGUgcGF0Y2gg
YW5kIHNlbmQgdjUKCkFuZHJlYQoKT24gOS8xMi8yNCAwMjo0OCwgTGkgV2FuZyB3cm90ZToKPgo+
IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5kZT4gd3JvdGU6Cj4KPiAg
ICAgK8KgIMKgIMKgIMKgb2xkbmFtZSA9IHRzdF90bXBkaXJfbWtwYXRoKE9MRE5BTUUpOwo+ICAg
ICArwqAgwqAgwqAgwqBuZXduYW1lID0gdHN0X3RtcGRpcl9ta3BhdGgoTkVXTkFNRSk7Cj4gICAg
ICvCoCDCoCDCoCDCoG9iam5hbWUgPSB0c3RfdG1wZGlyX21rcGF0aChPQkpOQU1FKTsKPgo+Cj4g
Tml0OiB0aGUgZnVuY3Rpb24gaGFzIGJlZW4gcmVuYW1lZCB0byB0c3RfdG1wZGlyX2dlbnBhdGgs
IHNvbWVib2R5IAo+IHdob8KgYXBwbGllcwo+IHRoaXMgcGF0Y2ggY2FuIGhlbHAgYWRqdXN0IGl0
Lgo+Cj4gLS0gCj4gUmVnYXJkcywKPiBMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
