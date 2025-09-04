Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D547CA1015
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 05:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756964560; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=t1t9gDqq//NdoUnSfIlOP/JGx7qTFtSchI82pn9X4qk=;
 b=p32X3vQa0aePxNDdgQASDO6gh88gETVVA8zqcEeqBZ+/GzmEWVoPSP29lkBvE3apLRppD
 2+WrHcmIyPUVNq0Di5COycdBGEKtslb5s35RaRY4HCvMr0KpGcf++j/dAkXPpMcX9n6kWCk
 BAZkniM1kAwO2DwjqQYCQ1+r2YNP0gI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FD4E3CD3EC
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 07:42:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FB3F3CB462
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 07:42:19 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6F7A214002AA
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 07:42:18 +0200 (CEST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b046fc9f359so111296666b.0
 for <ltp@lists.linux.it>; Wed, 03 Sep 2025 22:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756964538; x=1757569338; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jq89Dbtwbo6BTaWCbd0+czCiK8hcxKDZZ7jRcfO2JfY=;
 b=Bib9ONkhzKCxfr6y6AoYjS+Ui4VgiBhtmUmUVt8plCsl1bQpVkbQxNM7aYccstCNjn
 7yvLEiIa3sV2zQ8iY9m1waBQYSIVaygJ3J0vsK1n1lFGnzMyRx/rlMDYKV/Z0PA6rw+o
 HXY9wU/JdrvT4YukXaNylh0Sg3p28xbpunNUfV0x5VAebIrknM7lI0CLhIDi6iIOEnV6
 M8GGYuhNctiuqmRDcF8CpLKKU5OpGKBj3BKR+Cn+xT1esYq8UOFiHo01kRFWs/2b/Xik
 DLyzFTWXK6dVq33TbuuPOemMjl1KH8kpAuhkkFa5AgpBhYY8lo319q681BJizVyOO5Z3
 k8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756964538; x=1757569338;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jq89Dbtwbo6BTaWCbd0+czCiK8hcxKDZZ7jRcfO2JfY=;
 b=PAuMr2ctSUiGLqdGiTTt+/nm+5JSzlAkBW4OVw0ECC6mZcE/jg5p36gQmSLvYFuzPK
 Uwd8qejsTCVO9Tz780OCdmhm0Wt28vC2ja3PO1z4WH+QhCYvmKpS/ICJuoOoxG3jq2of
 xJbFc3ovN1N/XWrdzOq9kxSUqcd8Of7wYjPrgDCnGnHjic44ORonUlvlh5nMjRUV4lnj
 SlhHuCB8jA3oC67Vkc7KDu+fUng9H4N0c+G/YWBLc9Vvo0iZcEg+cldZmOeb4l0zHTC1
 VTpKsV04sy5DeMh9/Tc7fxBJXEH8APokaB95Wmpy0H6Le/DIBkYo8SPENasHJFyxelup
 kaug==
X-Gm-Message-State: AOJu0YxoUeWq3GO8ZrZFHTtKEWRFPF1F+DwYfGH/HYYQipcJn0o4ON9j
 +qbMtSX7qid0/DA8omgRbe9hxHOqGQOiKSV7SGBzR4enU96oHawR9EISIZgKFVYMIcAI7VCmwbD
 aZmkq+Bw=
X-Gm-Gg: ASbGncurBGsAeQnS+ivzaRg7PGsJacSB9CYXTpXqINTx1wag5y5LGwhcpHLVurIaXi0
 Lms/52jLdgsJQhwg1bcDh17CIYnRGJd9FaP/RmqtPjIrYx/2UveDsCMVx3PUsVdgX32NOIFba2W
 drhTBcm9dGsmHPZajKh7s927Wsf8lRG4gtiIrlMRxj0nhktNBknsWOG7yGK/lSsByez9CHgy/xe
 TEvLUkqa+WYS52D3l+kJx3NlALv8BdY3iQxpKGLCo2qEl0jsW+rKrp5Q1or7Y1GT/yJzLgTyvKC
 UMHqId8/9ot4P+GslxqSCKJCYqKt5IQ0IgXyCUkoOE/vckPSzbQrfXX137gEpRU6/flSiznP6uj
 KFCyOyL8XuKzMNWOaKp1JAeJku8qa9T+KCZg4KYy0T85eoUra9j/KRyux658pzfJPrOQ21ptX8P
 wh4cYabVF4lTpVUQS7
X-Google-Smtp-Source: AGHT+IE9OIveevpytupPDtxtFzq+QWs4Z8v2zJom9fdccj/35mIZ9Ot6poEQKeC6VvSaepTIWtRfiA==
X-Received: by 2002:a17:907:7207:b0:b04:26a7:f77e with SMTP id
 a640c23a62f3a-b0426a81cd5mr1353458466b.51.1756964537763; 
 Wed, 03 Sep 2025 22:42:17 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b041565ca98sm1106805266b.86.2025.09.03.22.42.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 22:42:17 -0700 (PDT)
Message-ID: <a991f7b9-0493-46e4-b0e2-a3ec284b3e13@suse.com>
Date: Thu, 4 Sep 2025 07:42:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
References: <aLVzVyaVhr4IHkyd@yuki.lan>
 <f014f48a-294c-4205-b147-e20074a8da48@suse.com> <aLgxmUJ7e05X1seP@yuki.lan>
 <aLhAj_-gzjmzvOoX@yuki.lan>
 <CAEemH2dzju5n1FZ8TyG0=YBJY-A80VD7Sv1PLJZuj_AYNERYvg@mail.gmail.com>
 <CAEemH2dPTgYX3LZ4Ux6YUZ3vuddNsOSoGw=eN-dD=-qOodkLzg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2dPTgYX3LZ4Ux6YUZ3vuddNsOSoGw=eN-dD=-qOodkLzg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP Release preparations
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

SGkgTGksCgpPbiA5LzQvMjUgNTowNiBBTSwgTGkgV2FuZyB3cm90ZToKPgo+Cj4gT24gVGh1LCBT
ZXAgNCwgMjAyNSBhdCAxMDozOeKAr0FNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPiB3cm90
ZToKPgo+ICAgICBIaSBDeXJpbCwgQW5kcmVhLAo+Cj4gICAgIE9uIFdlZCwgU2VwIDMsIDIwMjUg
YXQgOToyMOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKPgo+ICAg
ICAgICAgSGkhCj4gICAgICAgICA+ID4gQWZ0ZXIgYW4gYW5hbHlzaXMgd2UgYXJlIG5vdyBzdXJl
IHRoYXQgaXQncyBub3QgYSBwcm9kdWN0Cj4gICAgICAgICBidWcgYnV0IGEgdGVzdAo+ICAgICAg
ICAgPiA+IGlzc3VlLiBUaGVyZSBtaWdodCBiZSBhIG5lZWQgdG8gZmFsbGJhY2sgdGhlIHBhdGNo
IGlmIHdlCj4gICAgICAgICBjYW4ndCBmaXggdGhlCj4gICAgICAgICA+ID4gdGVzdCBiZWZvcmUg
cmVsZWFzZS4gQExpIFdEWVQ/Cj4KPiAgICAgICAgID4KPiAgICAgICAgID4gVHJ5IHRoaXM6Cj4g
ICAgICAgICA+Cj4gICAgICAgICA+IGRpZmYgLS1naXQKPiAgICAgICAgIGEvdGVzdGNhc2VzL3Jl
YWx0aW1lL2Z1bmMvc2NoZWRfZm9vdGJhbGwvc2NoZWRfZm9vdGJhbGwuYwo+ICAgICAgICAgYi90
ZXN0Y2FzZXMvcmVhbHRpbWUvZnVuYy9zY2hlZF9mb290YmFsbC9zY2hlZF9mb290YmFsbC5jCj4g
ICAgICAgICA+IGluZGV4IDA2MTdiZGI4Ny4uMGQ2NDIxMGIwIDEwMDY0NAo+ICAgICAgICAgPiAt
LS0gYS90ZXN0Y2FzZXMvcmVhbHRpbWUvZnVuYy9zY2hlZF9mb290YmFsbC9zY2hlZF9mb290YmFs
bC5jCj4gICAgICAgICA+ICsrKyBiL3Rlc3RjYXNlcy9yZWFsdGltZS9mdW5jL3NjaGVkX2Zvb3Ri
YWxsL3NjaGVkX2Zvb3RiYWxsLmMKPiAgICAgICAgID4gQEAgLTExNSw4ICsxMTUsOCBAQCB2b2lk
IHJlZmVyZWUoaW50IGdhbWVfbGVuZ3RoKQo+ICAgICAgICAgPsKgIMKgIMKgIMKgIMKgbm93ID0g
c3RhcnQ7Cj4gICAgICAgICA+Cj4gICAgICAgICA+wqAgwqAgwqAgwqAgwqAvKiBTdGFydCB0aGUg
Z2FtZSEgKi8KPiAgICAgICAgID4gLcKgIMKgIMKgIMKgdHN0X2F0b21pY19zdG9yZSgwLCAmdGhl
X2JhbGwpOwo+ICAgICAgICAgPsKgIMKgIMKgIMKgIMKgcHRocmVhZF9iYXJyaWVyX3dhaXQoJnN0
YXJ0X2JhcnJpZXIpOwo+ICAgICAgICAgPiArwqAgwqAgwqAgwqB0c3RfYXRvbWljX3N0b3JlKDAs
ICZ0aGVfYmFsbCk7Cj4gICAgICAgICA+wqAgwqAgwqAgwqAgwqBhdHJhY2VfbWFya2VyX3dyaXRl
KCJzY2hlZF9mb290YmFsbCIsICJHYW1lX3N0YXJ0ZWQhIik7Cj4gICAgICAgICA+Cj4gICAgICAg
ICA+Cj4gICAgICAgICA+IFdlIGhhdmUgdG8gYmUgc3VyZSB0aGF0IHRoZSBkZWZlbnNlIGhhcyBz
dGFydGVkIGJlZm9yZSB3ZQo+ICAgICAgICAgY2xlYXIgdGhlCj4gICAgICAgICA+IGJhbGwuIFBy
ZXZpb3VzbHkgd2UgaGFkIHRoZSBsb29wIHRoYXQgd2FpdGVkIGZvciB0aGUgcGxheWVycwo+ICAg
ICAgICAgdG8gYmUgcmVhZHkKPiAgICAgICAgID4gYmVmb3JlIHdlIGNhbGxlZCByZWZlcmVlKCkg
ZnVuY3Rpb24gc28gYWxsIHRoZSBwbGF5ZXJzIHdlcmUKPiAgICAgICAgIHJlYWR5IHdoZW4KPiAg
ICAgICAgID4gd2UgY2xlYXJlZCBpdC4KPgo+ICAgICAgICAgVWZmIGFuZCB3ZSBoYXZlIHRvIGdl
dCB0aGUgZmluYWwgYmFsbCBwb3NpdGlvbiBiZWZvcmUgd2Ugc3RvcCB0aGUKPiAgICAgICAgIHRo
cmVhZHMgYXMgd2VsbCwgb3RoZXJ3aXNlIHRoZXJlIGlzIGFsd2F5cyBjaGFuY2UsIHRoYXQgd2Ug
bWF5Cj4gICAgICAgICBlbmQgdXAKPiAgICAgICAgIG1vdmluZyB0aGUgYmFsbCByaWdodCBhZnRl
ciB0aGUgaGlnaCBwcmlvcml0eSBkZWZlbmNlIHRocmVhZHMKPiAgICAgICAgIGhhcyBiZWVuCj4g
ICAgICAgICBzdG9wcGVkOgo+Cj4KPiAgICAgVGhpcyBtYWtlcyBzZW5zZSEgSG93ZXZlciwgZnJv
bSBteSBleHRlbnNpdmUgdGVzdGluZywgSSBzdGlsbCBzZWUKPiAgICAgb2NjYXNpb25hbCBmYWls
cyBvbiBLVk0vRGVidWcgcGxhdGZvcm1zLgo+Cj4gICAgIEkgc3VzcGVjdCB0aGUgZXhpc3Rpbmcg
YmFycmllcnMgZW5zdXJlIGFsbCB0aHJlYWRzIGFyZSBjcmVhdGVkIGJlZm9yZQo+ICAgICB0aGUg
Z2FtZSBzdGFydHMsIGJ1dCBzbWFsbCBzY2hlZHVsZXIgc2tld3MgY2FuIHN0aWxsIGFsbG93IHRo
ZQo+ICAgICBhdHRhY2tpbmcKPiAgICAgdGhyZWFkIHRvIHJ1biBmb3IgYSBmZXcgY3ljbGVzIGJl
Zm9yZSB0aGUgZGVmZW5kaW5nIHRocmVhZCBtaWdyYXRlcywKPiAgICAgZXNwZWNpYWxseSBvbiBk
ZWJ1Zy9SVCBrZXJuZWxzLgo+Cj4KPiBTb3JyeSB0eXBvLCBSVCAtLT4gbm9uLVJUIGtlcm5lbHMu
Cj4KPiBTaW5jZSByZWd1bGFyIGtlcm5lbHMgdXNlIHRoZSBDRlMgc2NoZWR1bGVyLCB3aGljaCBp
cyBtb3JlIGxpa2VseSB0bwo+IGhhdmUgc3VjaCBkZXZpYXRpb25zLCBJIHRob3VnaHQgaXQgd291
bGQgYmUgYmV0dGVyIHRvIHJ1biB0aGlzIHRlc3QgdXNpbmcKPiB0aGUgUlQga2VybmVsLgo+Cj4g
QWZ0ZXJsb29raW5nIHlvdXIgdGVzdCBqb2IsIGl0IGFwcGVhcnMgdGhhdCA2LjE2LjMtMS1kZWZh
dWx0IGlzIGEgCj4gc3RvY2sga2VybmVsLAo+IHNvIEknbSBub3Qgc3VycHJpc2VkIGJ5IHRoZSBm
YWlsdXJlLgo+Cj4gLS0gCj4gUmVnYXJkcywKPiBMaSBXYW5nCgpJIHNlZSwgYXJlIHlvdSBwbGFu
bmluZyB0byBzZW5kIGEgcGF0Y2ggdG8gZml4IHRoZSB0ZXN0PwoKLSBBbmRyZWEKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
