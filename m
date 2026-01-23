Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C48D6CFAE
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 01:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769131486; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=SbOPhV9w8deZitoAUsPkORPgzRxHnuiw8Phr8IOS0bY=;
 b=dUHmpCzIQAgDIIzZnXgAZ1QkybgKrMa9M0cO6nOPLkF+x7yhyuLkbmJ31X2OKJ9Yqjdl6
 mpV9+aFADr5ysY41A6n7LmDZn5YqnC9aBp5M/S/xFGqwUA81IaDbmc18+YXNZivISYtgqVa
 Glbs9DQdhWE94YGtQL56lMAvG9HejAI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C87583CAFA6
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 02:24:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA4733C7C2C
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 02:24:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 08F65140005F
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 02:24:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769131458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G1qv3eywnuBZbufBT/5ag78J5gNnMMEJulXy3e+SSMw=;
 b=gErJ8XkuTSUgQbGFJWEpjhflkxNZd9GkbG1df/C4VKu54UfzArJefHnk0JxGoQFGQRiHS1
 vWV9UcGao4OAuxINjfP7A+UCrdGGyyIBdraSIzMIKL63Pj7Y5NKem8q7XRb02kCbQEL1A8
 evGQegiFeu5GUyRrvY5KfY7wYGwVMh8=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-oscyBQ3WPQCljf_scCZaLQ-1; Thu, 22 Jan 2026 20:24:16 -0500
X-MC-Unique: oscyBQ3WPQCljf_scCZaLQ-1
X-Mimecast-MFC-AGG-ID: oscyBQ3WPQCljf_scCZaLQ_1769131455
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-11b21dfe918so1192956c88.0
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 17:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769131455; x=1769736255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G1qv3eywnuBZbufBT/5ag78J5gNnMMEJulXy3e+SSMw=;
 b=RARvYSypP5yESfRIhw3Eeo3FU5QpWnPxWIHN34AHFPy8dqJBRZRFb2rq/ws23tsVdR
 6WQncwSxdDTuj5VyHIiNtFFtStEV9fE1v7EQ3AXO0WFNrsWDdjFLB5GTAzVAXvaEMilo
 LYBXmbtKLSjfRZy/03opg0K1REAXwBPj3R2yNA8kIv5EeWn9M8M8CV3m5xAYiJR4tTZ5
 TAcZI0E0eWq7rR1fJ8XFSvWmydhoiTH8TIM+e45h0cXyIytDhReOunQcoGF3ueuRDL9U
 DM7lXw6javV46Pj84+48G2AYWOvIixu0n/7vUu+XDrm1+5o5vN3TdDhbqQMNg0j5C29B
 R0fw==
X-Gm-Message-State: AOJu0Ywctvvh6rKOC8ZM3H+VmouvzTpnUcd2UWX0kAohvzNHEdJvUcYV
 MkIKGuj5BOC2l0XFAgAHIyhQZ/FPFlCDUKKej7O0r1AyHSLFuVeH9kkCcegs12K0qRFrfQ2F3Wx
 TdmZjzEJYxsytovIsBWdCAeZrHLsftKidVZogABeMuNu1vBhDa7I/8vl3wyGMsj0CAVO5u/iaul
 B3SyKSaEUaaKgk22imzQwjy3pPhpw=
X-Gm-Gg: AZuq6aLUcfDd5xAMzJ0mkZ/yp5EGOpqQN4WAiI8VtFFp5UlVNwLmO12i2XlL7b5K59q
 Tn7llQKR+LWlhsfRS3Vhuh0kF+OQx3jLsRRcLxZ3PqZdxjM9dPMvrvW4edXK2bo0b2hSrZjeFka
 KQbRIhJinrkQeafHaUOUANYxJd/iFQq/WkCalzYROzJr5lNv5r1TzcX+KEWQN2FaIqZZY=
X-Received: by 2002:a05:7022:e19:b0:11b:ca88:c4f1 with SMTP id
 a92af1059eb24-1247d77f52fmr689079c88.20.1769131455364; 
 Thu, 22 Jan 2026 17:24:15 -0800 (PST)
X-Received: by 2002:a05:7022:e19:b0:11b:ca88:c4f1 with SMTP id
 a92af1059eb24-1247d77f52fmr689064c88.20.1769131454704; Thu, 22 Jan 2026
 17:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20260122175354.83833-1-pvorel@suse.cz>
In-Reply-To: <20260122175354.83833-1-pvorel@suse.cz>
Date: Fri, 23 Jan 2026 09:24:02 +0800
X-Gm-Features: AZwV_QgA63U9LD-IfN7vSDFQfVsws_x9yPJrRgialB2r2lcI_190TE90f5cbEs4
Message-ID: <CAEemH2ciW+Z5gq-8Lsjkpd+VEK9uZ=vKdsjHviZyttDVt+G28A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e1CJyK7uVx6fR_fSFQs5DXuBdXgU_wvKl7bWwgysBDc_1769131455
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/tls.h: Cleanup ifdefs
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKLS0gClJlZ2FyZHMsCkxp
IFdhbmcKCk9uIEZyaSwgSmFuIDIzLCAyMDI2IGF0IDE6NTTigK9BTSBQZXRyIFZvcmVsIDxwdm9y
ZWxAc3VzZS5jej4gd3JvdGU6Cj4KPiBmZTI0MTk2Y2UzIGFkZGVkIC5zdXBwb3J0ZWRfYXJjaHMg
aW50byBjbG9uZTEwLiBUaGVyZWZvcmUgdGhlcmUgaXMgbm8KPiBuZWVkIHRvIGtlZXAgYXJjaGl0
ZWN0dXJlIGNoZWNrIGFsc28gaW4gbGFwaS90bHMuaC4KPgo+IE1vcmVvdmVyICJVbnN1cHBvcnRl
ZCBhcmNoaXRlY3R1cmUgZm9yIFRMUyIgd2FzIG1pc2xlYWRpbmcgYXMgaXQgbG9va2VkCj4gYXMg
YSBtaXNzaW5nIGFyY2ggc3VwcG9ydCBpbiBrZXJuZWwsIGJ1dCBpdCdzIG91ciBhbGxvY2F0ZV90
bHNfYXJlYSgpCj4gaW1wbGVtZW50YXRpb24gd2hpY2ggZG9lcyBzdXBwb3J0IG9ubHkgMyBhcmNo
aXRlY3R1cmVzLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+
Cj4gLS0tCj4gSGksCj4KPiBiYXNlZCBvbiBhIHJlY2VudCBkaXNjdXNzaW9uIG9uIE1MCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjYwMTIyMTMwNjM0LkdBNzEyMTRAcGV2aWsvCj4K
PiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gIGluY2x1ZGUvbGFwaS90bHMuaCB8IDYgLS0tLS0t
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGFwaS90bHMuaCBiL2luY2x1ZGUvbGFwaS90bHMuaAo+IGluZGV4IGY3ZTJmNDgzZmUuLjQ2
OGZlMzA4NmQgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9sYXBpL3Rscy5oCj4gKysrIGIvaW5jbHVk
ZS9sYXBpL3Rscy5oCj4gQEAgLTUyLDIyICs1MiwxNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgKmFs
bG9jYXRlX3Rsc19hcmVhKHZvaWQpCj4KPiAgc3RhdGljIGlubGluZSB2b2lkIGluaXRfdGxzKHZv
aWQpCj4gIHsKPiAtI2lmIGRlZmluZWQoX194ODZfNjRfXykgfHwgZGVmaW5lZChfX2FhcmNoNjRf
XykgfHwgZGVmaW5lZChfX3MzOTB4X18pCj4gICAgICAgICB0bHNfcHRyID0gYWxsb2NhdGVfdGxz
X2FyZWEoKTsKPiAtI2Vsc2UKPiAtICAgICAgIHRzdF9icmsoVENPTkYsICJVbnN1cHBvcnRlZCBh
cmNoaXRlY3R1cmUgZm9yIFRMUyIpOwo+IC0jZW5kaWYKPiAgfQo+Cj4gIHN0YXRpYyBpbmxpbmUg
dm9pZCBmcmVlX3Rscyh2b2lkKQo+ICB7Cj4gICAgICAgICB1c2xlZXAoMTAwMDApOwo+IC0jaWYg
ZGVmaW5lZChfX3g4Nl82NF9fKSB8fCBkZWZpbmVkKF9fYWFyY2g2NF9fKSB8fCBkZWZpbmVkKF9f
czM5MHhfXykKPiAgICAgICAgIGlmICh0bHNfcHRyKSB7Cj4gICAgICAgICAgICAgICAgIGZyZWUo
dGxzX3B0cik7Cj4gICAgICAgICAgICAgICAgIHRsc19wdHIgPSBOVUxMOwo+ICAgICAgICAgfQo+
IC0jZW5kaWYKPiAgfQo+Cj4gICNlbmRpZiAvKiBMQVBJX1RMU19IX18gKi8KPiAtLQo+IDIuNTEu
MAo+CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
