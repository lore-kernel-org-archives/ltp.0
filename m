Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5EBC54E58
	for <ltp@archiver.kernel.org>; Tue, 12 Mar 2024 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1710256790; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=BQelry5tvvexY7AFjN5izaU1d7+ClefZUHPj+jQEu3M=;
 b=AZS1eng1zTW5If2yQaV8owZ569jkhhDbFoz+/ZJBmvQzjkxBC1/ARVo3LeGkyMrRQEH2W
 J1JGj6oBYlWXbFfvGjzSn1aUzo/zssG5HUCWl1bw9S3EKRXXs7T72uUUxU++6//LNuOF+Zh
 tyjaSVyf9PY0jYYaRMyn5tXws1MZbHQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85FB53D0621
	for <ltp@archiver.kernel.org>; Tue, 12 Mar 2024 16:19:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BA2B3CB2C6
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 16:19:25 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 679166012DA
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 16:19:24 +0100 (CET)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-568307fe62eso5832789a12.1
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710256764; x=1710861564; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=krJ0WWT8o/3XFuQSUbG+pvdPZSSM8VX+yAzjSiF6SWk=;
 b=M5HdEsFxVoAdo9RzfGc45UGNGPdGt0ACLEMF9XeQiUHfEpeFZ974hFwdWm44NJKtb+
 M2GYXKdzZTP5cDr5Ex0Bi1bvMqAmeDp9yoSeS98wwb/rGeVsqMt0Qjir++xibba8nfBW
 5gNE0ryK5HtotVd3JJUC3dCOuJ8Rx/rvL9aAi6x+zhZ4i932V1u3psuHJcSlqzBR2VPT
 H9VNJmaNfVDxc+1fb941X6+SlzVxYdB+m3UHz4HZs27U2O1EL69BBQXIddaThR9CgCTa
 Muslkp9nddwdWU73RW6NY0/ATakBrmXdfaaZw49yecD+3sUgeCbboqCaFGS2To6mOY2o
 TNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710256764; x=1710861564;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=krJ0WWT8o/3XFuQSUbG+pvdPZSSM8VX+yAzjSiF6SWk=;
 b=cU7Kw8OOIXz5cuSmmqfEAdEL1WeU6QEB8c1i26XBMk54QYjKMnhCDbdPXrlV+7OyBf
 UmXdxSDUTNh4/N7kxMI5MZoz6jpiOMs6RMQd5YUIsLznMtMr3IcQHyLWCOuK8IC9wY2m
 3Zl7B7h7PwT8nlNQF5H5tDBKi3HFP7myHz3nZbMJhuyasEPMpEs6PuJztZvKjlV9w1kP
 FHqWatpgIsmT8lLMgVvKHlx441vIXbnyI+FVjvTFUyO1mO0Cgz6zL5WxVEsXNlxUZjdo
 cIpVBo2VIpxEL9qX7NFK7LrAeTyd+MS1Ytz7ATQOJBs+o3bGGIkILZVAy1uH/0kkMHT+
 TJ6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIPxAqEwKwwJTKxT32M+oWeDbDXE/AYZKbef6SoN8USnDLY7zL0oh+A5cNGzRzKE48gPBlQAFxzH2x8dL6yH2f29g=
X-Gm-Message-State: AOJu0YwOxpdcZTPbzgoaaDumAQXz0t/1/RjH9tFrZF9rdSb/7vGx+QlB
 h1EPiupiFFRrv2/Fd9s1Sa00YQ542iMam7kkyaOnrquLnRVW2J2IQgVqmg65o6k=
X-Google-Smtp-Source: AGHT+IHKQrU4noQFVK4C2jNHo0wdA+owwqbrHIQ6LLHb6EushrSqNGJWYO9FAeTFWKaSqidvAWKh1Q==
X-Received: by 2002:a17:906:3ecf:b0:a44:4a94:a6d5 with SMTP id
 d15-20020a1709063ecf00b00a444a94a6d5mr6651738ejj.27.1710256763631; 
 Tue, 12 Mar 2024 08:19:23 -0700 (PDT)
Received: from [10.232.133.85] ([88.128.88.28])
 by smtp.gmail.com with ESMTPSA id
 ag14-20020a1709069a8e00b00a462e166b9bsm1753824ejc.112.2024.03.12.08.19.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 08:19:23 -0700 (PDT)
Message-ID: <11b59801-6d1a-4baf-a2cf-3b4d3c63cd06@suse.com>
Date: Tue, 12 Mar 2024 16:19:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Li Wang <liwang@redhat.com>
References: <20231120154248.15048-1-andrea.cervesato@suse.de>
 <20231128125632.GB381183@pevik> <977d4dc47fa4c5163afc1a6646d4fb5a@suse.de>
 <CAEemH2e3rshuygLTq5LcK69ONnMAGO+Mcy_FkZJVS4OCHHf5ZQ@mail.gmail.com>
 <20231220122903.GA393099@pevik>
In-Reply-To: <20231220122903.GA393099@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Delete fork09 test
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
Cc: pvorel <pvorel@suse.de>, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiAxMi8yMC8yMyAxMzoyOSwgUGV0ciBWb3JlbCB3cm90ZToKPj4gT24gVHVlLCBEZWMg
MTksIDIwMjMgYXQgMTA6NTXigK9QTSBwdm9yZWwgPHB2b3JlbEBzdXNlLmRlPiB3cm90ZToKPj4+
IEhpIGFsbCwKPj4+IE9uIDIwMjMtMTEtMjggMTM6NTYsIFBldHIgVm9yZWwgd3JvdGU6Cj4+Pj4g
SGkgQW5kcmVhLAo+Pj4+PiBGcm9tOiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRv
QHN1c2UuY29tPgo+Pj4+PiBUaGUgZm9yazA5IHRlc3QgaXMgYWN0dWFsbHkgdGVzdGluZyB3aGF0
IGZvcmsxMCBpcyBhbHJlYWR5IHRlc3Rpbmc6Cj4+Pj4+IGFjY2Vzc2luZyBhbiBvcGVuIGNoaWxk
J3MgZmlsZSBmcm9tIHBhcmVudC4gRm9yIHRoaXMgcmVhc29uLCB3ZSBkZWxldGUKPj4+Pj4gaXQg
YW5kIGxldCBmb3JrMTAgZG9pbmcgaXRzIGpvYi4KPj4+PiBpbiBmb3JrMDkgcGFyZW50IG9wZW5z
IG1heGltdW0gbnVtYmVyIG9mIGZpbGVzLCBjaGlsZCBjbG9zZXMgb25lIGFuZAo+Pj4+IGF0dGVt
cHRzIHRvCj4+Pj4gb3BlbiBhbm90aGVyLiBUaGF0IGlzIG5vdCBleGFjdGx5IHRoZSBzYW1lLCBi
dXQgaXQncyB2ZXJ5IHNpbWlsYXIuCj4+Pj4gSSdtIG5vdCBzdXJlIGlmIHRoZSBzY2VuYXJpbyB3
b3VsZCByZWFsbHkgdGVzdHMgZGlmZmVyZW50IGNvZGUgcGF0aCBpbgo+Pj4+IGtlcm5lbC9saWJj
IG9yIG5vdCBhbmQgd2UgY2FuIGhhcHBpbHkgZGVsZXRlIGl0Lgo+Pj4+IEN5cmlsLCBXRFlUPwo+
Pj4gQExpLCBXRFlUPwo+Cj4+IFBldHIsIEkgdGhpbmsgeW91J3JlIHJpZ2h0LCB0aGV5J3JlIG5v
dCB0aGUgc2FtZSB0ZXN0Lgo+PiBJbiBmb3JrMTAgcGFyZW50IHRyaWVzIHRvIHZlcmlmeSB0aGUg
Y29udGVudHMgb2YgdGhlIGZpbGUgdGhhdCByZXNldCB0aGUKPj4gZmlsZSBvZmZzZXQgcG9pbnRl
ciBieSBjaGlsZC4KPj4gQnV0IGZvcjA5IGlzIGEgYm91bmRlciB0ZXN0IHRvIHZlcmlmeSBpZiB0
aGUgY2hpbGQgY2FuIG9wZW4gb25lIG1vcmUgZmlsZQo+PiB3aGVuICdmZCcgbnVtYmVyIGFwcHJv
YWNoZXMgKE9wZW5NYXgtMSkuCj4gVGhhbmsgeW91ISBDbG9zaW5nIHRoaXMgYXMgcmVqZWN0ZWQs
IEFuZHJlYSBmZWVsIGZyZWUgdG8gcmV3cml0ZSB0aGUgdGVzdCBhcwo+IHdlbGwuCgpUaGUgcmVh
c29uIHdoeSB0aGlzIHRlc3Qgc2hvdWxkIGJlIGRlbGV0ZWQgaXMgY29udGFpbmVkIGluIHRoZSBm
b2xsb3dpbmcgCmRpc2N1c3Npb24sIGJ1dCBJIGNhbiByZXdyaXRlIGl0IGlmIGl0J3Mgc3RyaWN0
bHkgbmVjZXNzYXJ5LgoKaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2x0cC9w
YXRjaC8yMDIzMDkwNzE1MDUzOC4xNjc3Mi0xLWFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5kZS8KPiBL
aW5kIHJlZ2FyZHMsCj4gUGV0cgoKQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
