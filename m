Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413A9C27C79
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 23:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718666658; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=pjvR6i8e40FFMgxcNuqgk0Y7wNlPMA8KLkAv5nAZP1g=;
 b=Z6++qc3zP3YvxKymN55l0r3i8fZOZOydt/6Trh2/PpxAD5A4pvaM+6p5ro+RO2jcQanRf
 VIuNUPIR7NHy3ZcVRJr8LPFPFlJCJekjQY5fC8d93mmIMS+BQp6DDkwd9sKBwpOAk3vXdPI
 Av3YRg9vrQJjrGqKNJb6gshi3hOOMkI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB7D43D0D51
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 01:24:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C2683C02E7
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 01:23:55 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CEB48140077A
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 01:23:54 +0200 (CEST)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57a44c2ce80so5783251a12.0
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 16:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1718666634; x=1719271434; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jR5k8LC3p1ccXusd0RYMUAnk7u6bmSZaxTZU2vBhafM=;
 b=DV9QPNIbdYhCSBT/maGYTvC/1a5wP9NIKIp0B3erPBM/3r6a4pmmLK5T/Waa4dgtkd
 wBr8gTraifGxV9kBNQp3HbvOwvAnCckA5ZtltIU9NkfX4F0VapQJUZTp/BrXvx+m3lfX
 aogurM4uxrXEFZFu8fCGc1M50DquVvZIAfFMoxvxbFVKBYlt5SC0cNTpqAU4TPbCtl5I
 ukl6U3SZzio3cbh83htZR+FH7Xaxkp7n66YoM+4cg3WuJxSA3MIVy0vMYZfADfYF663x
 AvoTMA9Syn3c/CGKBmXHeuxFSstTsX9wpk8LAxtLnMZoRga2KiD4ULAX/l7H4sp4JVmR
 tZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718666634; x=1719271434;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jR5k8LC3p1ccXusd0RYMUAnk7u6bmSZaxTZU2vBhafM=;
 b=i19D4X9GG0nZcLIvDcG29BmKOwzpj6BJ7hStlooqkLevH357RaEyvUOKwGTAXX+ntn
 M0sr861P/SFAN267ITKeKlVKAUOxXhQwsiuv4vXAAQgb0m1y+njPr9hGPqa9Bn/wYTCp
 87znFlXeCbMkuBCMp9wDjDPnSL+rrgPMpKdrKRpqmWeJrLAS5oVh6u0dHG1sN90YYG5p
 TtvyjfqTkdCUF5Ypbbg7V/5WP1xhWlQ4KBCcapENySBqsLFWm134NbaCxAonpuEJKBmz
 /UHDO4NS7W7yS44uDyaVJzt4S1kPZoG6H7j0qOtoJc7maQy+I598srX6cakXVzAjVs8b
 ygfg==
X-Gm-Message-State: AOJu0Yyc03lBHKBYy3v2mYtTHrl0pHNH6I9Z3SYsT661ts1kZ7qvjFpY
 LJfUx2BCbyzlPxrnkzuicw6/BS61qhyTQ3i4uA2z/yBRW3eTn8VzYGNZfsnQSVOtkhbRR9rxKrM
 =
X-Google-Smtp-Source: AGHT+IH1tNsjgjrKoc1B6Gr7lD/OkXjUn5nWcuz8dbjsDBUfYrGui7lziM5mPKICEw1YwJlIExI+WA==
X-Received: by 2002:a50:8d11:0:b0:57c:672a:5f63 with SMTP id
 4fb4d7f45d1cf-57cbd8b9b81mr7610006a12.28.1718666634170; 
 Mon, 17 Jun 2024 16:23:54 -0700 (PDT)
Received: from wegao.248.176.137 ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72e9dbfsm7027672a12.54.2024.06.17.16.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 16:23:53 -0700 (PDT)
Date: Mon, 17 Jun 2024 19:23:47 -0400
To: Li Wang <liwang@redhat.com>
Message-ID: <ZnDFg2dHErNNbQe7@wegao.248.176.137>
References: <20240617033356.299491-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240617033356.299491-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] quotactl07: add _GNU_SOURCE define
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdW4gMTcsIDIwMjQgYXQgMTE6MzM6NTZBTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBUbyBnZXQgcmlkIG9mIGVycm9yIG9uIGltcGxpY2l0IGRlY2xhcmF0aW9uIChnbGliYy0yLjM5
KToKPiAKPiAgL3Vzci9pbmNsdWRlL3hmcy9saW51eC5oOjE4ODoxNTogZXJyb3I6IGltcGxpY2l0
IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uCj4gIOKAmGZhbGxvY2F0ZeKAmTsgZGlkIHlvdSBtZWFu
IOKAmGFsbG9jYeKAmT8gWy1XaW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4gIDE4OCB8
ICAgICAgICAgcmV0ID0gZmFsbG9jYXRlKGZkLCBGQUxMT0NfRkxfWkVST19SQU5HRSwgc3RhcnQs
IGxlbik7Cj4gICAgICB8ICAgICAgICAgICAgICAgXn5+fn5+fn5+Cj4gICAgICB8ICAgICAgICAg
ICAgICAgYWxsb2NhCj4gIG1ha2U6ICoqKiBbLi4vLi4vLi4vLi4vaW5jbHVkZS9tay9ydWxlcy5t
azo0NTogcXVvdGFjdGwwN10KPiAgRXJyb3IgMQo+IAo+IFNpZ25lZC1vZmYtYnk6IExpIFdhbmcg
PGxpd2FuZ0ByZWRoYXQuY29tPgo+IC0tLQo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3F1
b3RhY3RsL3F1b3RhY3RsMDcuYyB8IDIgKysKPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3F1b3RhY3Rs
L3F1b3RhY3RsMDcuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcXVvdGFjdGwvcXVvdGFj
dGwwNy5jCj4gaW5kZXggMzRmZjI3MDVkLi5kOGFkMzc2MGEgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9xdW90YWN0bC9xdW90YWN0bDA3LmMKPiArKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL3F1b3RhY3RsL3F1b3RhY3RsMDcuYwo+IEBAIC0xMyw2ICsxMyw4
IEBACj4gICAqICgieGZzOiBTYW5pdHkgY2hlY2sgZmxhZ3Mgb2YgUV9YUVVPVEFSTSBjYWxsIiku
Cj4gICAqLwo+ICAKPiArI2RlZmluZSBfR05VX1NPVVJDRQo+ICsjaW5jbHVkZSA8ZmNudGwuaD4K
PiAgI2luY2x1ZGUgPGVycm5vLmg+Cj4gICNpbmNsdWRlIDx1bmlzdGQuaD4KPiAgI2luY2x1ZGUg
PHN0ZGlvLmg+Cj4gLS0gCj4gMi40NS4yCj4gCj4gCj4gLS0gCj4gTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwClJldmlld2VkLWJ5OiBXZWkgR2Fv
IDx3ZWdhb0BzdXNlLmNvbT4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
