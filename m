Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51A1C3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 10:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743415343; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=mGGz4D4gvRxqnRDIJTcKNgG156QNVpUkZtEvI7UzQlU=;
 b=oUjfcLR57RT4caw+h3lpYObtWtsrXjWeKJXVTLcDEUy570ZSTC/ji2Evgol+XQdQwPSNf
 iGUwzdlSVkDZzqIaSbOIZnKjH9QLCt78w9Udgxf530cdmvtAJUbO+i2uDLdHqfauvnus4pa
 eLhxSjhBvZv4HAtedwHWnJmn3Ogr0zs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 445BC3CAB50
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 12:02:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDD473C1ABC
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 12:02:02 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B5F79600D7C
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 12:02:01 +0200 (CEST)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac2ab99e16eso861626966b.0
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743415321; x=1744020121; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/NtBNkxZ4QOPppZJBflQQNL3q9BQ9pDJoKCpnlLyrwA=;
 b=Oagjl0Y3g2VBVI6qX5eD6muxoUEQXmH2Gz5ZI/JDlvZpzv556D2MX1o/A4Rw/LTs0t
 7VdvxTJGXIigTFTeRvYkoexm4zKgZCGjR9L4vJoCUm/KQuLgfvFvg6cJXWyoBHblPnjX
 pTyOyJP5F0XSL/SN0e6SVndUN2IGOqjpx3YHnaqttyQ/KSR+P37bvH9GF16LfmAtGc38
 k1CiM+POJAvjfB5gkTFYQd9fkxuOB19iZZIKAU0fTA0KLUKOQHr9MT4B/AwtQjDsAcuS
 x0r08mgLnS2aoWy5pvyjlGCzEWQtjfayrMJfvUW4Isp4gewzw4dBHDXkVILrJ212sbX+
 cHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743415321; x=1744020121;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/NtBNkxZ4QOPppZJBflQQNL3q9BQ9pDJoKCpnlLyrwA=;
 b=UcKhuJQ05YSnjhKxo/2VuETWRgt4COXz9vkm8xU/GDaGQyNhtquTFuIAeRgNSpLmu1
 r5ASRZzTqG3Ezm7J+OGH/7ZYc+5JfNxpOfJvKTnwinIU+p3tuSN941OSqa0IYrqCDbPa
 oP8dmaJm1wp6gDGp0MlaH3O3PfutI4tkvyGzZQhn9AvEtgTMDUH65UVMaO+32tEahTSU
 RWmH1yfstvfgYHV11D9OyjQYV+08fUkD3BUKrnfCF0hfARzV+DwChhlMZq7B2CeLIKdR
 +UX2/idYYZhIuPJhmBn5B8/OaJG3v6gd4e9L53SLpRGmJUd1K1tttiVajmGEwIhVs1Xw
 MJVQ==
X-Gm-Message-State: AOJu0Yx6VJT2vc05hHJZTJYgHzxePUAToTnyxCY90wHatYrFkTwba6Ud
 xQTKOIoBb5YDdoRpVvhdkZZoVKCQ2w0ulLUxHJ7GModDXlRrZxG8VNp9YP/Ucqo=
X-Gm-Gg: ASbGnctoG+sl6g35+b1U+FL91soWOOFEbj8w7RUguENYbpL/0Mb+6Z16ScYNQYiH4rC
 W6xHm8A4EQeyq5+uiseAwT1c0c4s6bW7ziC174Ikwm89mfvmvhcps8GbUGvqHbSP3Az3yhXLVGr
 T70e/a1M0V55DwMK2nhY8nx40iVN/SxIFr5LlK910UXInVq0AkpNSiczKq3b4kfnSCGz29rxOck
 XTg+zJHnZvHdJfAHzyvHzEAaKqEhTyDyJEK5dA4YD/BE9u6KyqZTcKMW4i1wU6U9T7+tre1Klgu
 9giARFATARZFwWqQrJDAOXnNqm5kzsgUxuyXManW1qSLYdf4zWRGb4xo3vjcV9WmSdtnGkZnSpK
 oU/XQrflzhuPrn3Reb2ahJoWGakQ=
X-Google-Smtp-Source: AGHT+IHKFFU0TAgLgqSAUUWy9LySyps1wEMaq0ADTIINkVYAgsFIbwV2rLCXlYXSE1V9p9trj6AT/A==
X-Received: by 2002:a17:907:9708:b0:ac1:fab4:a83 with SMTP id
 a640c23a62f3a-ac738a50828mr738129966b.25.1743415321096; 
 Mon, 31 Mar 2025 03:02:01 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7192e7d36sm599379466b.77.2025.03.31.03.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 03:02:00 -0700 (PDT)
Message-ID: <09e1347c-0d2b-437f-bea3-4a6da4067584@suse.com>
Date: Mon, 31 Mar 2025 12:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250331-fix_fanotify_i586-v1-1-4f9edd380d00@suse.com>
 <20250331095550.GA234056@pevik>
Content-Language: en-US
In-Reply-To: <20250331095550.GA234056@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify: fix missing fallback for
 FAN_RESPONSE_ERRNO
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

TWVyZ2VkLCB0aGFua3MgZm9yIHRoZSBmYXN0IHJlcGx5LgoKLSBBbmRyZWEKCk9uIDMvMzEvMjUg
MTE6NTUsIFBldHIgVm9yZWwgd3JvdGU6Cj4gSGkgQW5kcmVhLCBhbGwsCj4KPiBbIENjIGZhbm90
aWZ5IGRldmVsb3BlcnMgKyBhY3RpdmUgTFRQIG1haW50YWluZXJzIGZvciBDSSBjaGFuZ2UgZGVj
aXNpb24gXQo+Cj4gUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+Cj4g
UGxlYXNlIGFkZCBiZWZvcmUgbWVyZ2U6Cj4KPiBGaXhlczogYzA4ODMxNjQ1MiAoImZhbm90aWZ5
MjQ6IEFkZCB0ZXN0IGZvciBGQU5fUFJFX0FDQ0VTUyBhbmQgRkFOX0RFTllfRVJSTk8iKQo+Cj4+
IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4+IEZp
eCB0aGUgZm9sbG93aW5nIGJ1aWxkIGVycm9yIG9uIGk1ODY6Cj4+IGZhbm90aWZ5MjQuYzogSW4g
ZnVuY3Rpb24g4oCYZXhwZWN0ZWRfZXJybm/igJk6Cj4+IC4uCj4+ICAgIDE3MyB8ICAgICAgICAg
ICAgICAgICByZXR1cm4gRkFOX1JFU1BPTlNFX0VSUk5PKHJlc3BvbnNlKTsKPj4gICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn4KPj4gICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICBGQU5fREVOWV9FUlJOTwo+PiBtYWtlWzRdOiAqKiogWy4uLy4u
Ly4uLy4uL2luY2x1ZGUvbWsvcnVsZXMubWs6NDg6IGZhbm90aWZ5MjRdIEVycm9yIDEKPiBUaGlz
IGlzIG5vdCBpNTg2IHNwZWNpZmljLCBpdCBmYWlscyBpbiBvdXIgT0JTIGFsc28gb24geDg2XzY0
IFsxXS4gSW4gZmFjdCBpdCdzCj4gbm90IGFuIGFyY2ggc3BlY2lmaWMgLSBpdCBmYWlscyBvbiBh
bGwgYXJjaHMsIGUuZy46IGFhcmNoNjQgWzJdIHBwYzY0bGUgWzNdLgo+IFRoaXMgaXMgYWN0dWFs
bHkgY2F1c2VkIGJ5IHVwZGF0ZSBvZiAvdXNyL2luY2x1ZGUvbGludXgvZmFub3RpZnkuaCBmcm9t
IGtlcm5lbAo+IDYuMTQgKGluIG9wZW5TVVNFIFR1bWJsZXdlZWQgcHJvdmlkZWQgYnkgbGludXgt
Z2xpYmMtZGV2ZWwtNi4xNC0xLjEpLgo+IFBsZWFzZSBmaXggdGhlIGNvbW1pdCBtZXNzYWdlIGJl
Zm9yZSBtZXJnZS4KPgo+IEFuZCBJIGFncmVlIHRoYXQgdGhlIGJlc3QgdG8gYXZvaWQgdGhpcyBp
biB0aGUgZnV0dXJlIGlzIHRvIGFkZCBhIGd1YXJkIHRvIGFueQo+IGRlZmluaXRpb24uCj4KPiBA
QW5kcmVhIEBMaSBAQ3lyaWwgV2UgaGFkIGluIHRoZSBwYXN0IFR1bWJsZXdlZWQsIGJ1dCBkdWUg
aW50ZXJuYWwgcmVwbyBwcm9ibGVtCj4gaXQgc29tZXRpbWVzIGZhaWxlZC4gSSB3b25kZXIgaWYg
aXQncyBhIHRpbWUgdHJ5aW5nIHRvIHJlaW50cm9kdWNlIGl0IGFnYWluIHRvCj4gY2F0Y2ggdGhp
cy4gIElmIGl0J3Mgbm90IHdvcmtpbmcsIHdlIG1pZ2h0IHRyeSBGZWRvcmEgcmF3aGlkZSAoQExp
IG5vdCBzdXJlIGlmCj4gcmF3aGlkZSBpcyBnZW5lcmFsbHkgdXNhYmxlIGZvciBDSSkuCj4KPiBL
aW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gWzFdIGh0dHBzOi8vYnVpbGQub3BlbnN1c2Uub3JnL3Bh
Y2thZ2UvbGl2ZV9idWlsZF9sb2cvYmVuY2htYXJrOmx0cDpkZXZlbC9sdHAvb3BlblNVU0VfRmFj
dG9yeS94ODZfNjQKPiBbMl0gaHR0cHM6Ly9idWlsZC5vcGVuc3VzZS5vcmcvcGFja2FnZS9saXZl
X2J1aWxkX2xvZy9iZW5jaG1hcms6bHRwOmRldmVsL2x0cC9vcGVuU1VTRV9GYWN0b3J5X0FSTS9h
YXJjaDY0Cj4gWzNdIGh0dHBzOi8vYnVpbGQub3BlbnN1c2Uub3JnL3BhY2thZ2UvbGl2ZV9idWls
ZF9sb2cvYmVuY2htYXJrOmx0cDpkZXZlbC9sdHAvb3BlblNVU0VfRmFjdG9yeV9Qb3dlclBDL3Bw
YzY0bGUKPgo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVz
YXRvQHN1c2UuY29tPgo+PiAtLS0KPj4gVGhlIHJlYXNvbiBvZiB0aGUgZmFpbCBpcyByZWxhdGVk
IHRvIHRoZSBGQU5fUkVTUE9OU0VfRVJSTk8KPj4gZGVmaW5pdGlvbiwgd2hpY2ggaXMgc2tpcHBl
ZCBpbiB0aGUgZmFsbGJhY2sgaGVhZGVyIGZpbGUuCj4+IGh0dHBzOi8vb3BlbnFhLm9wZW5zdXNl
Lm9yZy90ZXN0cy80OTYxMTYzI3N0ZXAvaW5zdGFsbF9sdHAvODIKPj4gLS0tCj4+ICAgaW5jbHVk
ZS9sYXBpL2Zhbm90aWZ5LmggfCAzICsrKwo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKykKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGFwaS9mYW5vdGlmeS5oIGIvaW5jbHVkZS9s
YXBpL2Zhbm90aWZ5LmgKPj4gaW5kZXggNzY5MDdlYTVmMjE5ODljNTE4NTQ3OGQzZDRmNTU3N2Q5
NDAzZTUxOS4uOGQwNGM4ZjI4OTY5ZDBiM2Q1ZmVjNzE4MjRkNTY5YjAxYzllYzA1NCAxMDA2NDQK
Pj4gLS0tIGEvaW5jbHVkZS9sYXBpL2Zhbm90aWZ5LmgKPj4gKysrIGIvaW5jbHVkZS9sYXBpL2Zh
bm90aWZ5LmgKPj4gQEAgLTEyOCw2ICsxMjgsOSBAQAo+PiAgICNpZm5kZWYgRkFOX0RFTllfRVJS
Tk8KPj4gICAjZGVmaW5lIEZBTl9FUlJOTyhlcnIpICgoKCgoX191MzIpKGVycikpICYgMHhmZikg
PDwgMjQpKQo+PiAgICNkZWZpbmUgRkFOX0RFTllfRVJSTk8oZXJyKSAoRkFOX0RFTlkgfCBGQU5f
RVJSTk8oZXJyKSkKPj4gKyNlbmRpZgo+PiArCj4+ICsjaWZuZGVmIEZBTl9SRVNQT05TRV9FUlJO
Two+PiAgICNkZWZpbmUgRkFOX1JFU1BPTlNFX0VSUk5PKHJlcykgKChpbnQpKChyZXMpID4+IDI0
KSkKPj4gICAjZW5kaWYKPgo+PiAtLS0KPj4gYmFzZS1jb21taXQ6IDFhY2EyOTc5MzhjODViNDFl
NDFjOTEzZDRmZmMwZWNjMzQ1ZDAyZDQKPj4gY2hhbmdlLWlkOiAyMDI1MDMzMS1maXhfZmFub3Rp
ZnlfaTU4Ni1lOTZlZTNkMDYyNzUKPj4gQmVzdCByZWdhcmRzLAoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
