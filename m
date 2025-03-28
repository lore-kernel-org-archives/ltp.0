Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508F2C28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 12:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743164464; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Q5dTRbWkAXENaGitmphW8NQFSy/tKUuA6JE8iU26NxI=;
 b=I9LzrieGSxp7OoxW/mvNhZzOk2+at1Nab4Hom1FGIqqVaircYcCbwMFA8Y1LnSuwrnzD1
 +lbZZZwCxs/dbQYr36h+2Kn1ZhufR+nUqQ1y8P9c4Kge5UKDZgtAs+zoNg8GY5HvEYmsHWt
 KX8WM77whyryxVEvH2F7v/dq/nx8VdM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA74F3CA30B
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 13:21:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEC083C0280
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 13:20:41 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1C49A1A00243
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 13:20:41 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso14405205e9.2
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743164440; x=1743769240; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Fxl4Ec/Uq66vrOI5j7nLTmD2OZZblv2wj05fJvSvUc8=;
 b=bxxmJweguDm37NjR2pxxkKqsTlO8PWzd7QghC0bpjSW8H1oIAfXZpAUDC7OhAGWyoP
 3xkpuCralMwoDKJU9Zgce54/htrcKdtW7dsPKnijrcAzhbOFCaWwBYgW7NUJf8d/KMIv
 P57dkgQnpxWagXDU4KZQrXtNzdu9bfBLXWKZYTsyT00bugsuVmGI+p7i1Ygjq1jY4h5c
 elNbi/reMN0M5B9z3BD0wRJfgsVEpsaGF8hOusj5gDNZhydVxFyTBDv5VfikSl/aLMYF
 bDuKbbGEGm2ZtX6N6Lz6TEeCBEJRmH9ULJYoiAt2sjtPh0QWTlih8yS9LLmcrpjpAx20
 9H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743164440; x=1743769240;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Fxl4Ec/Uq66vrOI5j7nLTmD2OZZblv2wj05fJvSvUc8=;
 b=pO6Gy0uLgqnGzT9rZR3cfScUIlpU45Tt8EZImA+q1O3wqmlSR/eCu2xxS9Dl5h+oR1
 8iexO2j3g7NwgJAD9tcSvc8j0yFi0CnZOBdWlbm/C6s+MUiMt20HNZDe+zTCE6gEHyBO
 gXuN8o+JvStErTKkFOna4LS8CSsr1xgQ7BXMq7v6oDA0uzWjLHMdsO8g9uzKQXJ3cRUk
 VFGLLP0QPf8Cm353Kv/s1fXzldhLVU/dkRZcBHubMlEr9qAmRJkzhuZBLvSBkXX7Lxvo
 Zt94nleGCeKy0SqPWf3HB+T1dW3IiHYHs5Xm9prr2uZ8juhwhkLfoGTxqKPzWvP8/vpC
 QG/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtjPuu8lpO5k0JWlmXd+M8ETa5krTQ1zje+aV22GF+07i45jzEkek2jGTb1q0gc9J5E10=@lists.linux.it
X-Gm-Message-State: AOJu0YzSNTNicPszm2FwykcRs+cepzqrGHntvpVy60aY13fY25UmswdT
 24gRpV9hzihDgUB2kpoWvr2roAb7bLMn+2Q50CsCRUSXHept9Qq5V8L9A5RK7ddg24MDa+ye95c
 qgg+FAQ==
X-Gm-Gg: ASbGncvoGFDJX+dj+QCLmWsYfsbUAjwidWnuf1BBuYtrrhKQkWubgLYIM/n9EnSReJq
 hfDYu2Q5iXgXaTCasPDBn2sggfeWJLYLATF0qu1rlV/ka2MFIAuPslAmKaZ+AkaiyZyVekTepQZ
 dBDZUTb3KI5aX/mrAYLv9yAsJUfJLuapWu6p8VB0OXD6CTW0vW37Uy6lWZUVNgdaBAKqDyWmq3C
 pLkEo2ArEIco8vMylKSVEQyTh3UyrvAG+j3jJVV3Uo11hswkjSh0xvUOixpMQvPXpvWZlcja0MT
 LpjGeAeHtcAip7tfFSw1Y0toqfaaQNNZhB7tx6ZgWKCvWS6FrrOXzzLShjHV/gu3oOMcp0YRf9W
 nVRyKa/bZt0WLgLTevfeRSHf5MyIzZ8OW+sCydCnotPTjynAwAHrKXjkUvO+XbBei+VAv4kJExN
 yf+KQLnaI=
X-Google-Smtp-Source: AGHT+IHg+79i6eYhb3yhwg3KHshEDWRtueycL4j3K4cT8dWkZ2DZdN0YjoSzSF8F4x0Do7Tbn7V3oA==
X-Received: by 2002:a05:600c:1d85:b0:43d:94:cfe6 with SMTP id
 5b1f17b1804b1-43d850fd32dmr85825025e9.16.1743164440415; 
 Fri, 28 Mar 2025 05:20:40 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b60a9ddsm2523262f8f.0.2025.03.28.05.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 05:20:39 -0700 (PDT)
Message-ID: <6e266ced-f7a8-4598-9fc7-9d12317ba775@suse.com>
Date: Fri, 28 Mar 2025 13:20:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250327-conversions-modify_ldt-v2-0-2907d4d3f6c0@suse.com>
 <20250327-conversions-modify_ldt-v2-6-2907d4d3f6c0@suse.com>
 <9e4e8c75-bec7-4242-b825-dd56030a1ae1@suse.com>
 <D8RTI5TKSDCB.3CKAT58NVFMCQ@suse.com>
Content-Language: en-US
In-Reply-To: <D8RTI5TKSDCB.3CKAT58NVFMCQ@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 6/6] syscalls/set_thread_area01: Refactor into
 new API
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpPbiAzLzI4LzI1IDExOjEyLCBSaWNhcmRvIEIuIE1hcmxpw6hyZSB3cm90ZToKPiBPbiBG
cmkgTWFyIDI4LCAyMDI1IGF0IDY6NTAgQU0gLTAzLCBBbmRyZWEgQ2VydmVzYXRvIHdyb3RlOgo+
PiBIaSEKPj4KPj4gVGhpcyB0ZXN0IGlzIHdlaXJkLiBJdCBzdGF5cyBpbnNpZGUgc2V0X3RocmVh
ZF9hcmVhIGZvbGRlciwgYnV0IGl0J3MKPj4gdGVzdGluZyBnZXRfdGhyZWFkX2FyZWEoMikgYXMg
d2VsbC4gV2Ugc2hvdWxkIHByb2JhYmx5IGNyZWF0ZSBhIG5ldwo+PiB0ZXN0aW5nIGZvbGRlciBm
b3IgZ2V0X3RocmVhZF9hcmVhKDIpLCBzcGxpdHRpbmcgdGVzdCBpbiB0d28sIGRvaW5nIHRoZQo+
PiBleGFjdCBzYW1lIHRoaW5nOiB2ZXJpZnlpbmcgdGhhdCBzeXNjYWxscyBjYW4gYmUgZXhlY3V0
ZWQgY29ycmVjdGx5IGFuZAo+PiByYWlzZXMgdGhlIGNvcnJlY3QgZXJyb3JzLgo+IFRoYXQgaXMg
bm90IHRoZSBvcmlnaW5hbCBpbnRlbnQgb2YgdGhlIHRlc3QsIHdoaWNoIGRlcGVuZHMgb24gd2hh
dAo+IGhhcHBlbnMgd2hlbiBjYWxsaW5nIHNldF90aHJlYWRfYXJlYSB3aXRoIHRoZSBjb3JyZWN0
IHZhbHVlLCB3aGljaCB0aGVuCj4gY2hhbmdlZCB3aGF0IGhhcHBlbnMgd2l0aCB0aGUgZ2V0X3Ro
cmVhZF9hcmVhIGNhbGwuClRoYW5rcyBmb3IgY2xhcmlmeWluZy4gVGhlbiB0aGUgd2F5IGl0J3Mg
aW1wbGVtZW50ZWQgbmVlZHMgc29tZSAKYXR0ZW50aW9uLCBiZWNhdXNlIHRoZSBgc3RydWN0IHRl
c3RgIGlzIG1pc2xlYWRpbmcuIFRlc3QgY2FzZXMgYXJlIAppbmRlcGVuZGVudCBmcm9tIGVhY2gg
b3RoZXJzIGJ5IGRlZmluaXRpb24uCldlIHNob3VsZCBwdXQgdGhlIHJpZ2h0IHNlcXVlbmNlIG9m
IHN5c2NhbGxzIGluc2lkZSB0aGUgcnVuIHRlc3QgCmZ1bmN0aW9uIGFuZCB0byBvYnRhaW4gdGhl
IHJpZ2h0IG91dHB1dC4KCkkgc3RpbGwgYmVsaWV2ZSB0aGVzZSB0d28gdGVzdHMgY291bGQgYmUg
ZWFzaWx5IGNyZWF0ZWQgYW5kIHRoZXkgd291bGQgCmluY2x1ZGUgdGhlIGN1cnJlbnQgdGVzdGlu
ZyBzY2VuYXJpbyBmb3IgZnJlZS4KCkFuZHJlYQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
