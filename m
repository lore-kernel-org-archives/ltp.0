Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04064C44507
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 02:43:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D42A3E2181
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 04:43:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09F123E2181
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 04:43:22 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5BCDA1400076
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 04:43:22 +0200 (CEST)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4a496b6cc3dso659681b6e.0
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 19:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784169801; cv=none;
 d=google.com; s=arc-20260327;
 b=mVYU9kEtI0Lo6CHneLnFmHrrGmLxygzwZfNTzO52s40Xv1D4v/h2+GfWEk2MSaNAve
 fPV/9xqyW74uY9qO2hTqUVJOO950cbqX/0Fss7A7NQkZIDY75kw1RWsVSIFJshRtDCQj
 srR4Ui8DbIu2S0HTtMZDAs9CbTPbrS6sISOL2igEP3wVdHKbi+NnQr553N8VPmKIHwM2
 ztFDXb/8ydEq0S+bYxpPrq+ubq2ZNqOknHtiTyAsmO0amcK5CvoRwBXPS5bzVpJ8Cx8K
 3biu047L5PHzYC/7yEmZIy/91OLwzIvU19oIqwEkNrjkplx3FUcnl3+0ZXpmFjhe18Gx
 6Ueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ratBshA/WOHGhq5AKilfa5nkDobzoB3pu+9d9ebtPZ8=;
 fh=D4v5WNZvI3bCcsvChPNCYtz/eP7RAEima56un/nXtoM=;
 b=mH4GtllXh3EB/oNxLN4WHY5l34JCnSywpn+nQX1ax5OGzC6nkek0bAprI7J3Zw836x
 X5/JNAkqLHZCbU6ZoTq41IKJ6vhbEoFCYFfjvr+mCSr8XdFGx6HKGYIfi0bM/1S98Tbd
 pgKMFDNLtQil0/m0h2MoAO6H9bfCXDucL8qofesuslfC5qCY8n9nt6mJe8zXcJLjD2RD
 C4zuJdeza1XuhIlKW7FwFGnbTJZIwzOquZDXfocpQIitQf6N0msAvBVKV0A5LkjcR6iM
 GNGjkCqgng8KQxXajFpD40cdotREm/MBklXG9FMOyR7VJI8QHvaX3Od2WVU+oivhZPHd
 vEqQ==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784169801; x=1784774601; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ratBshA/WOHGhq5AKilfa5nkDobzoB3pu+9d9ebtPZ8=;
 b=OiH4ORHnqM6QuItLYPQ3ak3hlsW6nk1QTbClcNKr7uC5oa0CmpNZavRB4uO4YOPS0T
 fRrEi3ja2gq3UZo8DFIz9utCkn1g9VHdgFxGf5gaKy6Zd+5K5PjcE8pgumYERwIJsXNt
 j2HOz8lfVqNSWePcWfqvwZkzrh54fE3vhR3n+iUF67cXaJh1T14XlF+PygPYTpJN/jNu
 kjxvh8iYOns1YfmWEqJm1s6iiCnMLN+sRwlhahnyR7Jb3l2VHfPQT/y3EgKksLd2uAwN
 gie9zvf6LYPyZBnOP2e1gaHen6t9u50BSPPY4qhC7hbKSj8M7XwZyR7KTUJcaUm6FZPs
 lnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784169801; x=1784774601;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ratBshA/WOHGhq5AKilfa5nkDobzoB3pu+9d9ebtPZ8=;
 b=NVfgpjADcy2A43I6c15Oe6o/cJXP2f3l0NJv5iCPs6nHYAoa8VWZEr2hOGjGmH4Kar
 KzLDoLy8o/zspZ5I5VSZ4tCjsh6W0eE/h71FPirLpwU+16Ce5bd9tXEq2QVd53Kdlela
 mmjpaoRm9bmsc/gA/Vx2YTkSxDtept6EJ043UZkjCO/Et03AGLlaKwD+R/jOTnAz+zNw
 xriKE5SwepUsdNPqVXE2CLaW2KIdMUcmb/cGqWJO5tPEI5n+Qr4MESeJsfWf5kjiZgIt
 TbEQn/j53dG+KW1wpijT2tV8q/DWTdFVmNiDs2CLcWuB0Rp19u2jXb2aFyT4rO8cJ/Nm
 YIww==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3dgavSiSUQY6eEghkmM6uKCOzvxApYSOdyzEj7QOrin9sdif3lWzl4SNvkvqx6MRcX6Y=@lists.linux.it
X-Gm-Message-State: AOJu0YwRV7lUprn7nIrhqmfqR/R2bpG/XYMnc7jvIONEXZlKkj+U/3K5
 ET3pnWmTJg0WEO3jIcnSMw3zqKI68iW5YjqgD5cMNiJ3sKLUBr9H4QYSQZ1IfVQTwasS1mRzW5o
 o2zlhyGHAyGiRgt8PAnDG3HW3vgAdT0w=
X-Gm-Gg: AfdE7clU/RaTs6A9FssIBO1/+EDrRoeFcnivi5bWC5vceClDyK9y6vW2qYLU1/gLl+F
 6kUdf86oGnb0qAvkbIOICtgBEhmY2vzVGaTsUHLq6LtGUtTe4Lo2D9VfM0G6b7v7w98r+w5l+WK
 tu4Jo7mv2JCGekQAcR7jsEw4pJU8EsKsatN6Pltt9XI/0hjfs8Cj+bon7BomeCTR7zU75Mlj+Ue
 vq8Y+9rS+i7gSHfeYUShNRKmfnbw87735dWNKDLdMgrEW4lh8Lix/rY8+FM
X-Received: by 2002:a05:6808:15a9:b0:495:d0dd:c6db with SMTP id
 5614622812f47-4a47a7362b5mr6929845b6e.34.1784169800825; Wed, 15 Jul 2026
 19:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAOB9oOZaAan2bKWzu2XLeGkZVV1RO39YWuucmQK0tvvgVE4rUA@mail.gmail.com>
 <6a57ad4a.c799ffc2.29dc52.6d38@mx.google.com>
In-Reply-To: <6a57ad4a.c799ffc2.29dc52.6d38@mx.google.com>
From: Yizhou Tang <tangyeechou@gmail.com>
Date: Thu, 16 Jul 2026 10:43:08 +0800
X-Gm-Features: AUfX_mxCXDqzgurkxpXrLwpYFcRTZEczboUkCXfOpgEH-1K3gPlzBVlNTD98vpA
Message-ID: <CAOB9oOa39fuNukC2WOb4UTaBz-Gb5nY8mwAf9Udjrwq=zWNjjA@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Revert "tpci: unbind driver in test_assign_resources()"
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
Cc: Hongtao Zhang <zhanghongtao35@huawei.com>, ltp@lists.linux.it,
 linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKdWwgMTUsIDIwMjYgYXQgMTE6NTTigK9QTSBBbmRyZWEgQ2VydmVzYXRvCjxhbmRy
ZWEuY2VydmVzYXRvQHN1c2UuY29tPiB3cm90ZToKPgo+IEhpIFlpemhvdSwKPgo+ID4gSGksCj4g
Pgo+ID4gV2UgcmVjZW50bHkgY29uZmlybWVkIHRoaXMgY29tbWl0IGRvZXMgY2F1c2UgYSBmbG9v
ZCBvZiBJL08gZXJyb3JzIG9uCj4gPiB0aGUgcm9vdCBmaWxlc3lzdGVtIGluIG91ciB0ZXN0aW5n
LCBsZWF2aW5nIHRoZSBtYWNoaW5lIHVudXNhYmxlIHVudGlsCj4gPiByZWJvb3QuCj4gPgo+ID4g
R2l2ZW4gdGhhdCwgd2UnZCBhcHByZWNpYXRlIHRoZSBjb21tdW5pdHkgaGVscGluZyB0byBkZWNp
ZGUgc29vbgo+ID4gd2hldGhlciB0aGUgcmV2ZXJ0IGlzIHdhcnJhbnRlZC4KPgo+IEFyZSB5b3Ug
MTAwJSBzdXJlIHRoYXQgaXMgY2F1c2VkIGJ5IHRoZSBwYXRjaCB5b3Ugd2FudCB0byByZXZlcnQ/
Cj4gQmVjYXVzZSB0aGUgcGF0Y2ggbG9va2VkIG9rIHRvIG1lIHdoZW4gSSByZXZpZXdlZC4gV2Ug
bmVlZCB0byBoYXZlCj4gbW9yZSBjb250ZXh0IGFuZCBpbmZvIGFyb3VuZCB0aGUgaXNzdWUgd2hp
Y2ggaGFzIGJlZW4gZ2VuZXJhdGVkIGluCj4gb3JkZXIgdG8gYXZvaWQgYW55IHdvcmthcm91bmQg
Zm9yIGEgc3lzdGVtL2tlcm5lbCBidWcuCj4KCkhpIEFuZHJlYSwKCkkgY2FuJ3QgY2xhaW0gMTAw
JSBjZXJ0YWludHksIGFzIEknbSBub3QgYSBQQ0kgZXhwZXJ0LgoKTGV0IG1lIGdpdmUgeW91IHRo
ZSBjb250ZXh0IHdlIGhhdmUuIEVudmlyb25tZW50OiBVYnVudHUgMjQuMDQsIGtlcm5lbApidWls
dCBmcm9tIHRoZSBsYXRlc3QgNi42IHN0YWJsZSBicmFuY2guIFJvb3QgZmlsZXN5c3RlbSAvIGlz
IFhGUyBvbgovZGV2L3NkYTQuClJlcHJvZHVjZXI6IGtpcmsgLWYga2VybmVsX21pc2MgLXAgdHBj
aSAtdi4KCldpdGggZG1lc2cgLVQgLS1mb2xsb3cgd2UgY2FwdHVyZWQ6CltGcmkgSnVsIDEwIDE5
OjIyOjA4IDIwMjZdIGx0cF90cGNpOiBhc3NpZ24gcmVzb3VyY2UgIzYKW0ZyaSBKdWwgMTAgMTk6
MjI6MDggMjAyNl0gbHRwX3RwY2k6IG5hbWUgPSAwMDAwOmQ3OjEyLjIsIGZsYWdzID0gMCwKc3Rh
cnQgMHgwLCBlbmQgMHgwCltGcmkgSnVsIDEwIDE5OjIyOjA4IDIwMjZdIGx0cF90cGNpOiB0ZXN0
LWNhc2UgMTMKW0ZyaSBKdWwgMTAgMTk6MjI6MDggMjAyNl0gbHRwX3RwY2k6IHNhdmUgc3RhdGUK
W0ZyaSBKdWwgMTAgMTk6MjI6MDggMjAyNl0gbHRwX3RwY2k6IHNhdmVkIHN0YXRlIG9mIGRldmlj
ZQpbRnJpIEp1bCAxMCAxOToyMjowOCAyMDI2XSBsdHBfdHBjaTogdGVzdC1jYXNlIDE0CltGcmkg
SnVsIDEwIDE5OjIyOjA4IDIwMjZdIGx0cF90cGNpOiByZXN0b3JlIHN0YXRlCltGcmkgSnVsIDEw
IDE5OjIyOjA4IDIwMjZdIGx0cF90cGNpOiB0ZXN0LWNhc2UgMTUKW0ZyaSBKdWwgMTAgMTk6MjI6
MDggMjAyNl0gbHRwX3RwY2k6IGZpbmQgZGV2aWNlIGNhcGFiaWxpdHkKW0ZyaSBKdWwgMTAgMTk6
MjI6MDggMjAyNl0gbHRwX3RwY2k6IGRldmljZSBoYXMgUE0gY2FwYWJpbGl0eQpbRnJpIEp1bCAx
MCAxOToyMjowOCAyMDI2XSBsdHBfdHBjaTogdGVzdC1jYXNlIDE2CltGcmkgSnVsIDEwIDE5OjIy
OjA4IDIwMjZdIGx0cF90cGNpOiBkZXZpY2UgZG9lc24ndCBoYXZlIFBDSS1FWFAgY2FwYWJpbGl0
eQoKQXQgdGhpcyBwb2ludCB0aGVyZSBpcyBhIGdhcCBvZiByb3VnaGx5IG9uZSBtaW51dGUgdGhh
dCBubyBsb2cgY291bGQKbm90IGJlIGNhcHR1cmVkLiBEdXJpbmcgdGhhdCB3aW5kb3cgdGhlIGNv
bnNvbGUgc2Nyb2xsZWQgYSBsYXJnZQp2b2x1bWUgb2YgbWVzc2FnZXMgdG9vIGZhc3QgdG8gcmVj
b3JkLiBBbW9uZyB3aGF0IHdhcyB2aXNpYmxlIG9uIHRoZQpjb25zb2xlIHdhczoKWEZTIChzZGE0
KTogUGxlYXNlIHVubW91bnQgdGhlIGZpbGVzeXN0ZW0gYW5kIHJlY3RpZnkgdGhlIHByb2JsZW0o
cykuCldoYXQgZGlkIG1ha2UgaXQgaW50byB0aGUgbG9nIGFmdGVyd2FyZHMgaXMgb25seSB0aGUg
cmVzdWx0aW5nIEkvTy1lcnJvciBmbG9vZDoKCltGcmkgSnVsIDEwIDE5OjIzOjA2IDIwMjZdIHN5
c3RlbWQtam91cm5hbGRbODE4XTogRmFpbGVkIHRvIG9wZW4KL3Zhci9sb2cvam91cm5hbC8uLi46
IElucHV0L291dHB1dCBlcnJvciAoRHJvcHBlZCAyNzQ5IHNpbWlsYXIKbWVzc2FnZShzKSkKW0Zy
aSBKdWwgMTAgMTk6MjM6MDYgMjAyNl0gc3lzdGVtZC1qb3VybmFsZFs4MThdOiBGYWlsZWQgdG8g
cm90YXRlCi92YXIvbG9nL2pvdXJuYWwvLi4uL3N5c3RlbS5qb3VybmFsOiBJbnB1dC9vdXRwdXQg
ZXJyb3IgKERyb3BwZWQgNDgxNQpzaW1pbGFyIG1lc3NhZ2UocykpCltGcmkgSnVsIDEwIDE5OjIz
OjA2IDIwMjZdIHN5c3RlbWQtam91cm5hbGRbODE4XTogRmFpbGVkIHRvIHJvdGF0ZQovdmFyL2xv
Zy9qb3VybmFsLy4uLi91c2VyLTEwMDAuam91cm5hbDogSW5wdXQvb3V0cHV0IGVycm9yCltGcmkg
SnVsIDEwIDE5OjIzOjA2IDIwMjZdIHN5c3RlbWQtam91cm5hbGRbODE4XTogRmFpbGVkIHRvIG9w
ZW4KL3Zhci9sb2cvam91cm5hbC8uLi46IElucHV0L291dHB1dCBlcnJvciAoRHJvcHBlZCAyNDA2
IHNpbWlsYXIKbWVzc2FnZShzKSkKW0ZyaSBKdWwgMTAgMTk6MjM6MDYgMjAyNl0gc3lzdGVtZC1q
b3VybmFsZFs4MThdOiBGYWlsZWQgdG8gb3BlbgovdmFyL2xvZy9qb3VybmFsLy4uLjogSW5wdXQv
b3V0cHV0IGVycm9yCgpUaGUgbWFjaGluZSBpcyB1bnVzYWJsZSBhZnRlciB0aGlzIGFuZCBvbmx5
IHJlY292ZXJzIG9uIHJlYm9vdC4KClRoZSBvbmUgdGhpbmcgSSBjYW4gc3RhdGUgd2l0aCBjb25m
aWRlbmNlOiBhZnRlciByZXZlcnRpbmcgdGhpcyBwYXRjaCwKdGhlIHByb2JsZW0gbm8gbG9uZ2Vy
IHJlcHJvZHVjZXMgb24gdGhlIHNhbWUgc2V0dXAuCgpCZXN0IHJlZ2FyZHMsCllpCgo+Cj4gUmVn
YXJkcywKPiAtLQo+IEFuZHJlYSBDZXJ2ZXNhdG8KPiBTVVNFIFFFIEF1dG9tYXRpb24gRW5naW5l
ZXIgTGludXgKPiBhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
