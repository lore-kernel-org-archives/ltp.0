Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ABBC67861
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712328011; h=mime-version :
 date : message-id : references : in-reply-to : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Hqo23IdraEL6LzvjXOJS3WTKDCoLRUD5yg6QY9ta7H4=;
 b=RewKeClsvYeMANZiy3zOvB8LLEOFdSyneDaEWkxLTQTrIDAwxsj/+7f1azHrD3OCDd/t9
 Krh/bC4J7tEVymkNuy+b86KU959pOx4uB5hWGF7n6C4iWa2dia9CJZtHPlG3LlEidsRT2CO
 Rm5UbKyuAjwsb+GOk2mHR8d9Dn0Yr5c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C01AB3CEF3A
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 16:40:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A11B03CE213
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 16:39:51 +0200 (CEST)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E2DC71013048
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 16:39:50 +0200 (CEST)
Received: by mail-ej1-x641.google.com with SMTP id
 a640c23a62f3a-a4a393b699fso379475466b.0
 for <ltp@lists.linux.it>; Fri, 05 Apr 2024 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1712327990; x=1712932790; darn=lists.linux.it;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:from:to:cc:subject:date:message-id
 :reply-to; bh=QhEp4IVAU3T9aCAMKtwIVJaACKF0CNAIaYEXbHdVh7s=;
 b=JKEf+sLNJ/tnK0Nr2Xt4PrquWuTINJMEcDTWxZMlOQ636tN6qTc5LQVpd7Iyo8NUj8
 2mK+qs3A4rpEXSpPwGXiB2skXzW11Q7QGh4YktT/ls9Fy9bZJQIvF5wwoLMz45JPGv/0
 9mN4Uj4Yq1pmMa/+ttPukHx9LPmZzejafQgTOMhNXfBnhH7qzn6R5l+v38/6m7nyG4Cm
 fatUZxG7eFpMLyiqnL9ZirqPtrHU2CvNqTjhwSiFKnBYqFlEi7/IwWZC3dccmImuaFB8
 taQlpS6H6PFd/t4EDkRzyMVQflBQmNs6cLMe8jhg49oUuDqtiFCVFMTmIxYBot3oxwWe
 eYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712327990; x=1712932790;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhEp4IVAU3T9aCAMKtwIVJaACKF0CNAIaYEXbHdVh7s=;
 b=CFTnXYUCpXUT8GcKe9sOkR3rUQSzhkdMmiWu3YUQqWBxlTbp06z3kFf6EuHLcn9/G7
 V5sdG8y3Y7iL8YnmJwUVMC3gLElSId1t79eHNVXZscoI2tt0e8gnj/z7wu4jMi0qpOJb
 vkbocqeJFQEjNoX7tK0u1OxGotDP37qjf7A6vm60TRtNOhbdBLL+3GcTYzDSaGiuWPNk
 iLovre/c4I5MqXPcW6pJeJ1Hq3ocWf3DZvfdHX8FKHY3LCpPyZSlhWsb/0hUMYf/PyMr
 CaO7zcf5YE+2MjGBH4pPaX33lgsU3d4FRQavmR6WNPaHdfZ3/2mxEotVA59aGhw1QRt8
 bBBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOmCAgQgklYcri/q1GOTZ8PkF3ywg7X/LcwruzSydqCjyz6Qk4LsoDIjxd/YZLDV4L1LI9orHCWU0pFVaLKcnaTUk=
X-Gm-Message-State: AOJu0YxY3XPJ34WuEfXdI4elF6npkKxYT2IriDILusQRBqOd2pvPPx9h
 9KCWM+4dh3jltJ77tVZ+CzDgo48XVPgMlqn8bQ97IAqRZHV3qqiaQ5/i/OJwsFM=
X-Google-Smtp-Source: AGHT+IHEJzjONZERuOpUFdLh9J8dOuHS3DsGn/XOvm6RVLDXMPRnp3Vb0j1GF+ISHZS/+XEMnGU8JA==
X-Received: by 2002:a17:906:53d2:b0:a50:9190:fe51 with SMTP id
 p18-20020a17090653d200b00a509190fe51mr1850486ejo.3.1712327990208; 
 Fri, 05 Apr 2024 07:39:50 -0700 (PDT)
Received: from smtpclient.apple ([37.160.74.118])
 by smtp.gmail.com with ESMTPSA id
 jy23-20020a170907763700b00a4ea0479235sm901717ejc.107.2024.04.05.07.39.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 07:39:49 -0700 (PDT)
Mime-Version: 1.0 (1.0)
Date: Fri, 5 Apr 2024 16:39:38 +0200
Message-Id: <64E6149E-C134-4C8F-AFB8-ECDF7B2B2B46@suse.com>
References: <20240405142219.GA637941@pevik>
In-Reply-To: <20240405142219.GA637941@pevik>
To: Petr Vorel <pvorel@suse.cz>
X-Mailer: iPhone Mail (21E236)
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] New LTP documentation
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
Cc: Mike Frysinger <vapier@gentoo.org>, ltp@lists.linux.it,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>, linux-kernel@vger.kernel.org,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHRoZSBtZXJnZSEKSSBob3BlIHRoaXMg
aXMgdGhlIHN0YXJ0IGZvciBhIGJldHRlciBwcm9qZWN0IHVuZGVyc3RhbmRpbmcgYW5kIEkgYWxz
byBob3BlIGNvbW11bml0eSB3aWxsIGJlbmVmaXQgZnJvbSB0aGlzIGltcG9ydGFudCBjaGFuZ2Uu
CgpUaGFuayB5b3UgQ3lyaWwgZm9yIGRvY3VtZW50aW5nIEMgQVBJLiBJ4oCZbSBsb29raW5nIGZv
cndhcmQgdG8gc2VlIHRoZSByZW1haW5pbmcgb25lcywgSSBrbm93IHNvbWUgb2YgdGhlbSBhcmUg
YWxyZWFkeSBvbmdvaW5nLgoKS2luZCByZWdhcmRzLApBbmRyZWEgQ2VydmVzYXRvCgo+IE9uIDUg
QXByIDIwMjQsIGF0IDE2OjIyLCBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4g
Cj4g77u/SGkgYWxsLAo+IAo+IHRvZGF5IEkgbWVyZ2VkIEFuZHJlYSdzIGFuZCBDeXJpbCdzIHdv
cmsgbWlncmF0aW5nIG91ciBHaXRIdWIgYmFzZWQgZG9jcyB0bwo+IHJlYWR0aGVkb2NzLm9yZy4g
QW5kcmVhLCBDeXJpbCwgdGhhbmsgeW91IGZvciB0aGlzIHdvcmssIHdlJ3JlIG5vdyB1c2luZyBm
b3IKPiBkb2NzIHRoZSBzYW1lIGFwcHJvYWNoIGFzIHRoZSBMaW51eCBrZXJuZWwuCj4gCj4gT3Vy
IG5ldyBkb2N1bWVudGF0aW9uIGlzIG5vdyBvbiBodHRwczovL2xpbnV4LXRlc3QtcHJvamVjdC5y
ZWFkdGhlZG9jcy5pby9lbi9sYXRlc3QvLgo+IAo+IEkgY29uZmlndXJlZCB0aGUgaG9vayBvbiBy
ZWFkdGhlZG9jcy5vcmcsIHRodXMgYW55IGRvY3MgdXBkYXRlIHNob3VsZCB0cmlnZ2VyCj4gcmVh
ZHRoZWRvY3Mub3JnIHJlYnVpbGQuCj4gCj4gSSBhbHNvIGRpc2FibGVkIG91ciB3aWtpIG9uIEdp
dEh1YiBbMl0sIGl0IHJlZGlyZWN0cyB0byBvdXIgaG9tZXBhZ2UuIEl0IHdvdWxkCj4gYmUgZ29v
ZCB0byBiZSBhYmxlIHRvIHJlZGlyZWN0IGl0IHRvIG91ciBuZXcgcmVhZHRoZWRvY3Mub3JnIGRv
Y3MgWzFdLgo+IAo+IEkgYWxzbyByZW1vdmUgKHdpdGggQ3lyaWwncyBhY2spIHRoZSBjb250ZW50
IG9mIG91ciBnaXRodWIuaW8gcGFnZSBbM10gdG8gb3VyCj4gbmV3IHJlYWR0aGVkb2NzLm9yZyBk
b2NzIFsxXS4KPiAKPiBUaGUgZG9jcyBpcyBtb3N0bHkgZG9uZSwgYnV0IHNvbWUgYml0cyBhcmUg
bWlzc2luZyAoZS5nLiBDIFRlc3QgTmV0d29yayBBUEkgWzRdLAo+IEtWTSBUZXN0IEFQSSBbNV0s
IHNoZWxsIEFQSSBbNl0pLCB0aHVzIHdlIGtlcHQgdGhlbSBpbiBkb2Mvb2xkIGZvbGRlci4gVGhp
cwo+IGZvbGRlciB3aWxsIGJlIHJlbW92ZWQgb25jZSB3ZSBmaW5pc2ggdGhlIG1pZ3JhdGlvbi4K
PiAKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+IAo+IFsxXSBodHRwczovL2xpbnV4LXRlc3QtcHJv
amVjdC5yZWFkdGhlZG9jcy5pby9lbi9sYXRlc3QvCj4gWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9s
aW51eC10ZXN0LXByb2plY3QvbHRwL3dpa2kvCj4gWzNdIGh0dHBzOi8vbGludXgtdGVzdC1wcm9q
ZWN0LmdpdGh1Yi5pby8KPiBbNF0gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVj
dC9sdHAvYmxvYi9tYXN0ZXIvZG9jL29sZC9DLVRlc3QtTmV0d29yay1BUEkuYXNjaWlkb2MKPiBb
NV0gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvYmxvYi9tYXN0ZXIv
ZG9jL29sZC9LVk0tVGVzdC1BUEkuYXNjaWlkb2MKPiBbNl0gaHR0cHM6Ly9naXRodWIuY29tL2xp
bnV4LXRlc3QtcHJvamVjdC9sdHAvYmxvYi9tYXN0ZXIvZG9jL29sZC9TaGVsbC1UZXN0LUFQSS5h
c2NpaWRvYwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
