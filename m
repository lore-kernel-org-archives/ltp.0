Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4133ECEF17C
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 14:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728396740; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=KMAAIEggl4L72HOUkuC1tGmtB/au+jot9E5Q9UOTI54=;
 b=PwzxGF0glAVsP6P8Gq2oP2mvf5qCwfnz6+rKlcfI9CVa9mJ+wVqp/TbXbcPqPhVD5IKGI
 hVZVDTZJ+Cff31Yvw4GckDH5nb/EVjD4wfVNsW4Za+/OTUqq4waZlXkZZpBFp7qp8DaGsjf
 R7l93xwm4FdZ6geON6hoTbH3BkP+rDQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F96F3C1C6B
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 16:12:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 351343C08AA
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 16:11:59 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C66FD602AC5
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 16:11:58 +0200 (CEST)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53997328633so7491824e87.3
 for <ltp@lists.linux.it>; Tue, 08 Oct 2024 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1728396718; x=1729001518; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IVcVQKVbk/o+iWeMjd3Ty/Hpco1klI/iAjAe99T8nFg=;
 b=bxPGtolMGe0c0XujX/yNB8EkS3nkLDRtLihESmD88eHkzo+LtMVf8CoL4YF9zOmQHA
 KRUUocZtFkoWmdYzImKHP0WYYJ03QJTkslnaghQtp1eGyX74Sbi3lCT/9BKSWpqQ6P5+
 3E9vCZIeN7kmeslRj7GhrZzg2kaRKhGnLuI7ZjzLkPjOe4CKhAAu8kgOOqFDOUUVXV60
 9qwYohIciFKPhD6XyQBeMSV6IokXyFQzVocRZ3TRBQ9sVPCa7Qkxyt3XHuv36OtQuci0
 y6REreR9gWgNE8OSSzVBQXCwuPqAkQl5Qg7W52kT4FNUByiEtA9jXBNYRbZhzTn7Iwi4
 j2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728396718; x=1729001518;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IVcVQKVbk/o+iWeMjd3Ty/Hpco1klI/iAjAe99T8nFg=;
 b=QReGZiSC5/IG0xAX1FeB1wr9ef9ElR3svCxVaHgd4qFYYczr7trmMHqSEkn3SQlVIO
 BbvDr3DgQSkemupf5/nImXyxyS+6cRsQ5ZHQgxaV353zmib2tcAvZvS+ei6L+lTM+6E2
 7znvwMaZ4Hhv4do/cakyLYQOpnk7e05aybrzN2eyjzM3o/rG0Ilj9mLRFFoWIicfi2nu
 RW0y908Tnnpeeb8+GjpiLPBvz0XkcFRCYqVZsPueU7V8osNv4yYLqk5mdC5l41Pk9xzt
 2RgT5pI//vnJJ63uXMg1WZFVa4vewJ5xnSA66mV609HlF4uho1UYPWDLsa4bqNjNhdFb
 svTg==
X-Gm-Message-State: AOJu0YzPR4wwnMpl0fRddI6lqqYbKE6UgVegzrpNrVjqTUJN33/C8lAj
 hGxL7S0AiND/jFPS+vSYslxnyeFoiP3VQjHzllK6ED76vGZO0WWxWlSyMAYrM+9K07qfhrjYYxv
 Q
X-Google-Smtp-Source: AGHT+IH4ePPj/+2bOrKsSs1fh+Dg6DvF0Wr56zQaje+Pw4tB9D11lEl00fo900pxtBwckVM5f7yiQQ==
X-Received: by 2002:a05:6512:b29:b0:530:ab68:25c5 with SMTP id
 2adb3069b0e04-539ab84e022mr10118973e87.2.1728396717887; 
 Tue, 08 Oct 2024 07:11:57 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a996ebc30d6sm106336466b.101.2024.10.08.07.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 07:11:57 -0700 (PDT)
Message-ID: <21dd3054-d2e4-4b0c-97f8-94f6420a96e0@suse.com>
Date: Tue, 8 Oct 2024 16:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
 <20241008-listmount_statmount-v5-11-66f4e1a9e7db@suse.com>
 <ZwUfe1rysrK2MfDi@yuki.lan> <7a3a91f7-473e-4d25-ad5f-1b3b1ff4450f@suse.com>
Content-Language: en-US
In-Reply-To: <7a3a91f7-473e-4d25-ad5f-1b3b1ff4450f@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 11/16] Add statmount05 test
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

Ck9uIDEwLzgvMjQgMTU6NTcsIEFuZHJlYSBDZXJ2ZXNhdG8gd3JvdGU6Cj4gSGksCj4KPiBPbiAx
MC84LzI0IDE0OjAzLCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4+IEhpIQo+Pj4gK3N0YXRpYyB2b2lk
IHRlc3RfbW91bnRfcm9vdCh2b2lkKQo+Pj4gK3sKPj4+ICvCoMKgwqAgdHN0X3JlcyhUSU5GTywg
IlRlc3RpbmcgU1RBVE1PVU5UX01OVF9ST09UIik7Cj4+PiArCj4+PiArwqDCoMKgIGNoYXIgKmxh
c3Rfcm9vdDsKPj4+ICsKPj4+ICvCoMKgwqAgbWVtc2V0KHN0X21vdW50LCAwLCBTTV9TSVpFKTsK
Pj4+ICsKPj4+ICvCoMKgwqAgVFNUX0VYUF9QQVNTKHN0YXRtb3VudChyb290X2lkLCBTVEFUTU9V
TlRfTU5UX1JPT1QsIHN0X21vdW50LAo+Pj4gK8KgwqDCoMKgwqDCoMKgIFNNX1NJWkUsIDApKTsK
Pj4+ICsKPj4+ICvCoMKgwqAgaWYgKCFUU1RfUEFTUykKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1
cm47Cj4+PiArCj4+PiArwqDCoMKgIGxhc3Rfcm9vdCA9IHN0cnJjaHIobW50X3Jvb3QsICcvJyk7
Cj4+IFdvdWxkbid0IGxhc3Rfcm9vdCA9IHN0cnJjaHIoRElSQSwgJy8nKSBwcm9kdWNlIHRoZSBz
YW1lIHJlc3VsdD8KPj4KPj4gSSdtIGp1c3Qgd29uZGVyaW5nIHdoeSBNTlRfUk9PVCBpcyByZWxh
dGl2ZSBhbmQgTU5UX1BPSU5UIGlzIGFic29sdXRlCj4+IGhlcmUuCj4gQmVjYXVzZSBTVEFUTU9V
TlRfTU5UX1JPT1QgcmV0dXJucyB0aGUgcm9vdCBmb2xkZXIgYW5kIAo+IFNUQVRNT1VOVF9NTlRf
UE9JTlQgcmV0dXJucyB0aGUgbW91bnQgcG9pbnQgZm9sZGVyLCByZWxhdGl2ZSB0byB0aGUgCj4g
cm9vdCBmb2xkZXIuClRoYXQgc2VlbXMgbGlrZSB0aGUgd2F5IHN0YXRtb3VudCgpIGlzIHdvcmtp
bmcgYnkgdGhlIHdheS4gQWxzbyBpbiB0aGUgCmtzZWxmdGVzdHMgcm9vdCBmb2xkZXIgaXMgZ2l2
ZW4gd2l0aCBhIHJlbGF0aXZlIHBhdGgsIHdoaWxlIG1vdW50IHBvaW50IAppcyBjb250YWluaW5n
IHRoZSBhYnNvbHV0ZSBwYXRoLgo+Pj4gK8KgwqDCoCBUU1RfRVhQX0VRX0xJKHN0X21vdW50LT5t
YXNrLCBTVEFUTU9VTlRfTU5UX1JPT1QpOwo+Pj4gK8KgwqDCoCBUU1RfRVhQX0VRX1NUUihzdF9t
b3VudC0+c3RyICsgc3RfbW91bnQtPm1udF9yb290LCBsYXN0X3Jvb3QpOwo+Pj4gK30KPj4gT3Ro
ZXJ3aXNlOgo+PiBSZXZpZXdlZC1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+Cj4+
Cj4gQW5kcmVhCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
