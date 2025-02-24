Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CCCC021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 16:07:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4F2A3C9966
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 17:07:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C35513C98CB
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 17:06:55 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F422E1022FBD
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 17:06:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740413213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPcK/JeJnxOgc6oXGJCNXMRybnyQ1Xk5C74SVj23czk=;
 b=bhpq8nN1eyV/yKCshJF8H9xFmlt/1OwUAMfs35BWTd5TzKaJKTa87ZKmtdsMx/HOhd6BYv
 XQiDLwkPCkQ7NTvIoDLqb4i/twCKFQKmN0hz7DzneGtyQQO+BUM9bsG3CjapimapsCqYuC
 Rm5rRgbv3HZQ7zU4D/b+NJGkTu+dPww=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-WJ68h-2HPrSuhusV8HuFZg-1; Mon, 24 Feb 2025 11:06:51 -0500
X-MC-Unique: WJ68h-2HPrSuhusV8HuFZg-1
X-Mimecast-MFC-AGG-ID: WJ68h-2HPrSuhusV8HuFZg_1740413211
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c0ae84aaceso784809585a.3
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 08:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740413211; x=1741018011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IPcK/JeJnxOgc6oXGJCNXMRybnyQ1Xk5C74SVj23czk=;
 b=dErmtEt71w1voAvm9nEGkvOt343+z6MiEC5ysqhZhHBgAs7AwvzuYtEV5nNiol5/dy
 UAhATJUSjOk1YHcl5yfcIF68wcntZFbPFGemYPOhQpBE0G3wApZQiQJd9u2zPaZG0wfk
 YzXM7kmOe5gJL5LyrKciIPufIYjngGfgVURbwFzbfEjo7KDgNGbyou1cyJE25bKfQvu8
 a8XfgRA6r2uz9RjtlfbLAmej4jC5b2xDf+HovMCoCMNsKrgJGuv5ZdkT+BeTrWTbMwZF
 8gs+7IkFlY+7lk/fZpJ5AD6gzLCWM4D9mzn8lYZRXS1pFyW0MA7BfQfGmelEq7/SUvLy
 Ow0Q==
X-Gm-Message-State: AOJu0YySvuBpGuLcsA1/xWKcO6qCOPtGuFApwQYqfvYTF3Egc9kvFgSd
 4xHjVH+k1pr0EzA4rK4t5qFq4W6FNJbix3RtVqWdgRh0bLHuc3eEvKAa18njhwmoBixSXEwCSqb
 uMoq1hnCFMamAQWSGei33DKKt1K5PhP/IBJIVaQKDae6RMYHYnqkvvdlnYZdG1457HT8IvBTQ8k
 2nq1PUINH4S6Vznlq6pTxywM4=
X-Gm-Gg: ASbGncviDx1GXaS+uaFVvt6ehZ18ZYKO2mIQv6dqe7msxdjWmRIKbDmj2GEwhvO3UH3
 +6RljAT+YmMuFiDjArl/9DHQO//HnRTtCIiruIz1X7GoDK3OyhQjzYiyCF1DbVqclWQA2kw==
X-Received: by 2002:a05:620a:171f:b0:7c0:b018:5935 with SMTP id
 af79cd13be357-7c0ceeec550mr2198109885a.8.1740413210695; 
 Mon, 24 Feb 2025 08:06:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyV+F8COhBeMSA7+KGVcH81sEGUsKkZPUPwYaQ4i6vTnWwUu/z6T5QdLPf9DehW563Wrq+nwctCXdf2ySDY3I=
X-Received: by 2002:a05:620a:171f:b0:7c0:b018:5935 with SMTP id
 af79cd13be357-7c0ceeec550mr2198105685a.8.1740413210305; Mon, 24 Feb 2025
 08:06:50 -0800 (PST)
MIME-Version: 1.0
References: <CAASaF6xJkkE8NEnDRwYEqs_abZxJqiuMnou+d=mYxmLRPddNKg@mail.gmail.com>
 <b70ade709f93e94f8219b5d18e1ce7be0578f183.1740396133.git.jstancek@redhat.com>
 <Z7yTEEf-BR3qnpz9@yuki.lan>
In-Reply-To: <Z7yTEEf-BR3qnpz9@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 24 Feb 2025 17:06:34 +0100
X-Gm-Features: AWEUYZnYjm4XK6h7qPNMjF2F6S-PSCiWKuNEygx6a-SMEtAJWAtDuLjLsbxberw
Message-ID: <CAASaF6y+tUoN9VZo635Z3nEbOZnxcRJzZs83QfNrGMtQ7D8Jaw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DrCZAIvZeLmL8Z69Ijrbcr--6zpmZ_L3Ca-DuluD1f8_1740413211
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/utime03: use realtime clock for upper
 bound check
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
Cc: ltp@lists.linux.it, chhrubis@suse.cz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBGZWIgMjQsIDIwMjUgYXQgNDo0MeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gVGhpcyB0ZXN0IHJhcmVseSBmYWlscyB3aXRoIHJl
Y2VudCBrZXJuZWxzIChhZnRlciA2LjEzLXJjMSk6Cj4gPiAgIHRzdF90ZXN0LmM6MTgzMzogVElO
Rk86ID09PSBUZXN0aW5nIG9uIGV4dDQgPT09Cj4gPiAgIHRzdF90ZXN0LmM6MTE3MDogVElORk86
IEZvcm1hdHRpbmcgL2Rldi9sb29wMCB3aXRoIGV4dDQgb3B0cz0nJyBleHRyYSBvcHRzPScnCj4g
PiAgIG1rZTJmcyAxLjQ3LjIgKDEtSmFuLTIwMjUpCj4gPiAgIHRzdF90ZXN0LmM6MTE4MjogVElO
Rk86IE1vdW50aW5nIC9kZXYvbG9vcDAgdG8gL3RtcC9MVFBfdXRpNDJVcEhqL21udHBvaW50IGZz
dHlwPWV4dDQgZmxhZ3M9MAo+ID4gICB1dGltZTAzLmM6NzQ6IFRQQVNTOiB1dGltZShURU1QX0ZJ
TEUsIE5VTEwpIHBhc3NlZAo+ID4gICB1dGltZTAzLmM6ODA6IFRGQUlMOiB1dGltZSgpIGRpZCBu
b3Qgc2V0IGV4cGVjdGVkIGF0aW1lLCBtaW50aW1lOiAxNzM4MjkxOTMwLCBtYXh0aW1lOiAxNzM4
MjkxOTMwLCBzdF9hdGltZTogMTczODI5MTkzMQo+ID4gICB1dGltZTAzLmM6ODU6IFRGQUlMOiB1
dGltZSgpIGRpZCBub3Qgc2V0IGV4cGVjdGVkIG10aW1lLCBtaW50aW1lOiAxNzM4MjkxOTMwLCBt
YXh0aW1lOiAxNzM4MjkxOTMwLCBzdF9tdGltZTogMTczODI5MTkzMQo+ID4KPiA+IFNpbmNlIDRl
NDBlZmYwYjU3MyAoImZzOiBhZGQgaW5mcmFzdHJ1Y3R1cmUgZm9yIG11bHRpZ3JhaW4gdGltZXN0
YW1wcyIpLAo+ID4gZmlsZXN5c3RlbSBjYW4gdXNlIG1vcmUgcHJlY2lzZSBjbG9jayB0byB1cGRh
dGUgdGhlIGlub2RlLgo+ID4KPiA+IFJlbGF4IHRoZSBjaGVjayBieSB1c2luZyByZWFsdGltZSBj
bG9jayBmb3IgdXBwZXIgYm91bmQgY2hlY2suCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogSmFuIFN0
YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICB0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL3V0aW1lL3V0aW1lMDMuYyB8IDQgKysrLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy91dGltZS91dGltZTAzLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL3V0aW1lL3V0aW1lMDMuYwo+ID4gaW5kZXggNTY0ZTFkZTNkZDc3Li41NmViOWU3MjI4
OTYgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3V0aW1lL3V0aW1l
MDMuYwo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91dGltZS91dGltZTAzLmMK
PiA+IEBAIC01NSw2ICs1NSw3IEBAIHN0YXRpYyB2b2lkIHJ1bih2b2lkKQo+ID4gICAgICAgc3Ry
dWN0IHV0aW1idWYgdXRidWY7Cj4gPiAgICAgICBzdHJ1Y3Qgc3RhdCBzdGF0YnVmOwo+ID4gICAg
ICAgdGltZV90IG1pbnRpbWUsIG1heHRpbWU7Cj4gPiArICAgICBzdHJ1Y3QgdGltZXNwZWMgdHM7
Cj4gPgo+ID4gICAgICAgdXRidWYubW9kdGltZSA9IHRpbWUoMCkgLSA1Owo+ID4gICAgICAgdXRi
dWYuYWN0aW1lID0gdXRidWYubW9kdGltZSArIDE7Cj4gPiBAQCAtNzAsNyArNzEsOCBAQCBzdGF0
aWMgdm9pZCBydW4odm9pZCkKPiA+ICAgICAgIFNBRkVfU0VURVVJRCh1c2VyX3VpZCk7Cj4gPiAg
ICAgICBtaW50aW1lID0gdHN0X2dldF9mc190aW1lc3RhbXAoKTsKPiA+ICAgICAgIFRTVF9FWFBf
UEFTUyh1dGltZShURU1QX0ZJTEUsIE5VTEwpKTsKPiA+IC0gICAgIG1heHRpbWUgPSB0c3RfZ2V0
X2ZzX3RpbWVzdGFtcCgpOwo+ID4gKyAgICAgdHN0X2Nsb2NrX2dldHRpbWUoQ0xPQ0tfUkVBTFRJ
TUUsICZ0cyk7Cj4gPiArICAgICBtYXh0aW1lID0gdHMudHZfc2VjOwo+ID4gICAgICAgU0FGRV9T
RVRFVUlEKHJvb3RfdWlkKTsKPiA+ICAgICAgIFNBRkVfU1RBVChURU1QX0ZJTEUsICZzdGF0YnVm
KTsKPgo+IFRoZXJlIGFyZSBzaXggdGVzdGNhc2VzIHRoYXQgdXNlIHRzdF9nZXRfZnNfdGltZXN0
YW1wKCkgaXMgdGhpcyB0aGUgb25seQo+IG9uZSB0aGF0IGZhaWxzPwoKR29vZCBwb2ludC4gSSBt
YW5hZ2VkIHRvIHJlcHJvZHVjZSBpdCB3aXRoIHV0aW1lMDEgYXMgd2VsbDoKdXRpbWUwMS5jOjUw
OiBURkFJTDogdXRpbWUoKSBkaWQgbm90IHNldCBleHBlY3RlZCBtdGltZSwgcHJlX3RpbWU6CjE3
NDA0MTE5MTcsIHBvc3RfdGltZTogMTc0MDQxMTkxNywgc3RfbXRpbWU6IDE3NDA0MTE5MTgKdXRp
bWUwMS5jOjU1OiBURkFJTDogdXRpbWUoKSBkaWQgbm90IHNldCBleHBlY3RlZCBhdGltZSwgcHJl
X3RpbWU6CjE3NDA0MTE5MTcsIHBvc3RfdGltZTogMTc0MDQxMTkxNywgc3RfYXRpbWU6IDE3NDA0
MTE5MTgKCj4KPiBBbHNvIGlmIHdlIGFyZSBnb2luZyB0byBkbyB0aGlzLCB3ZSBzaG91bGQgYXQg
bGVhc3QgcHV0IHRoZSBjb2RlIHRvIHRoZQo+IGxpYnJhcnkgYW5kIGludHJvZHVjZSB0d28gZGlm
ZmVyZW50IGZ1bmN0aW9ucyBvbmUgZm9yIHRoZSBzdGFydAo+IHRpbWVzdGFtcCBhbmQgb25lIGZv
ciB0aGUgZW5kIHRpbWVzdGFtcCBhbmQgbWFrZSB1c2Ugb2YgdGhhdCBpbiBhbGwgdGhlCj4gdGVz
dAo+Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1c2UuY3oKPgoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
