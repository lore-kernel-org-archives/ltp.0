Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BFCC5321D
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 13:21:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26ED63C7F5D
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 15:21:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA25A3C655D
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 15:21:26 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0687A100092F
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 15:21:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724678484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VtOWUuZRTINmaESltZb3Jg6k19ZIVSMwtr88C8s6F+Y=;
 b=PwpRJddcjRvezpNeGBqwWn5jdN/A4dPLxnLPtiGY14O+EfoKx563Yo4BRbFTnJ/acnhT5f
 eJQ6mRUUBMFQi/gmaTCulh478sXGqD4Sy1/yEXOhS8I0VHaXkIpqB06c2xTHdNwfNMupeu
 qb2vhDbwK/2lor2aY3+FH9M7uT68MZM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-pD-dhAePP4aIaGbg5AEDRg-1; Mon, 26 Aug 2024 09:21:22 -0400
X-MC-Unique: pD-dhAePP4aIaGbg5AEDRg-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-6507e2f0615so3656047a12.1
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 06:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724678481; x=1725283281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VtOWUuZRTINmaESltZb3Jg6k19ZIVSMwtr88C8s6F+Y=;
 b=jsIsV9mocwsIUGDt6vD4Mtd72LkCe+/f05yKZ+6M/9Kc9mSXEbjRGYOnvUEU6PKsr9
 z69ankdSWKA95pBEEnM5IzT6/lbdQYLJ+UAVgbHyYJpTZU3l7brva9cnghwPuvaPd3UQ
 4iWMocXqEz/87MkAIWrNNervF4JaTIk4qr1GlYaVU5c6zMqdeuB90c9MoZvkkEisQjaU
 9D05a3Hyc+wGDR2LrCcZcZfKiVfoM+vwSa9FcOqS+6m3EPkeaZP9vh9bNRuUsc+rLwnQ
 CJgQWAMJ00YXuRjd00P9SRLBhQWwDzlOpR6lttF6ojF11vIuT1n/0vWbv62MfTjma/Sv
 fDZg==
X-Gm-Message-State: AOJu0YyRMklJ7MT1psVBmA+PAQnxl35bfsIqhGMMwdJyED1Zh5nsCVA4
 pd6pqgiqD6Ygsn4917C4zkuz5t9v4Hq7sHfdc6fzNMV6zXpEGp7JuI5zpWRIrU/K9GaASxsoPz8
 1vzMdHnPzK30wp4rkSj7pJGJ+ZS1vX7c/fGmsBOo7mNUo8jKPORw1e+xBiIQLbVlgBY4Eoft5i0
 Lxhy9iA7AYYap5EZYzrVxG0/I=
X-Received: by 2002:a05:6a20:2d07:b0:1ca:97e4:14f0 with SMTP id
 adf61e73a8af0-1cc89d19215mr11543676637.2.1724678481656; 
 Mon, 26 Aug 2024 06:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgEavbJ4yxKDsSdloT+6hh69lf8d6oFcOMWDhcC1LLaZY0aTamEKARONR9WDgSnv5JqIF4VEyMdKCqeDITP/A=
X-Received: by 2002:a05:6a20:2d07:b0:1ca:97e4:14f0 with SMTP id
 adf61e73a8af0-1cc89d19215mr11543650637.2.1724678481273; Mon, 26 Aug 2024
 06:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240826120205.5506-1-liwang@redhat.com>
 <CAEemH2dYB3tyG4xjE_b1rGBRqtCDOwByq5ZdA0VUxvL3nqW0Vw@mail.gmail.com>
 <CAASaF6xh7_wXiFn9LakEv-LY-szkZ+5fJ0B67ygdCV0g4T-89Q@mail.gmail.com>
In-Reply-To: <CAASaF6xh7_wXiFn9LakEv-LY-szkZ+5fJ0B67ygdCV0g4T-89Q@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Aug 2024 21:21:08 +0800
Message-ID: <CAEemH2eBjOmLL-=zVFhoQiJXVDU0h1WThu5AP_Wf5S51RAtx7w@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] ioctl_loop06: no validate block size
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
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Garry <john.g.garry@oracle.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBBdWcgMjYsIDIwMjQgYXQgOToxNeKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKCj4gT24gTW9uLCBBdWcgMjYsIDIwMjQgYXQgMjo0NuKAr1BNIExp
IFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBIaSBBbGwsCj4gPgo+ID4g
T24gTW9uLCBBdWcgMjYsIDIwMjQgYXQgODowMuKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiA+Cj4gPiA+IFNpbmNlIGNvbW1pdCA5NDIzYzY1M2ZlNjExMCAoImxvb3A6
IERvbid0IGJvdGhlciB2YWxpZGF0aW5nIGJsb2Nrc2l6ZSIpCj4gPiA+IGtlcm5lbAo+ID4gPiBk
cm9wIHZhbGlkYXRpbmcgYmxvY2tzaXplIGZvciBib3RoIGxvb3BfY29uZmlndXJlIGFuZAo+IGxv
b3Bfc2V0X2Jsb2NrX3NpemUKPiA+ID4gc28KPiA+ID4gdGhhdCBzZXQgbGFyZ2UgYmxvY2sgc2l6
ZSBzdWNjZWVkcy4KPiA+ID4KPiA+ID4gRXJyb3IgbG9nOgo+ID4gPiAgIDEyIGlvY3RsX2xvb3Aw
Ni5jOjc2OiBUSU5GTzogVXNpbmcgTE9PUF9TRVRfQkxPQ0tfU0laRSB3aXRoIGFyZyA+Cj4gPiA+
IFBBR0VfU0laRQo+ID4gPiAgIDEzIGlvY3RsX2xvb3AwNi5jOjU5OiBURkFJTDogU2V0IGJsb2Nr
IHNpemUgc3VjY2VlZCB1bmV4cGVjdGVkbHkKPiA+ID4gICAuLi4KPiA+ID4gICAxOCBpb2N0bF9s
b29wMDYuYzo3NjogVElORk86IFVzaW5nIExPT1BfQ09ORklHVVJFIHdpdGggYmxvY2tfc2l6ZSA+
Cj4gPiA+IFBBR0VfU0laRQo+ID4gPiAgIDE5IGlvY3RsX2xvb3AwNi5jOjU5OiAgVEZBSUw6IFNl
dCBibG9jayBzaXplIHN1Y2NlZWQgdW5leHBlY3RlZGx5Cj4gPiA+Cj4gPgo+ID4gSG1tLCBtYXli
ZSBJIHdhcyB3cm9uZyBoZXJlLCB0aGUgY29tbWl0IHNheXMKPiA+Cj4gPiAgICJUaGUgYmxvY2sg
cXVldWUgbGltaXRzIHZhbGlkYXRpb24gZG9lcyB0aGlzIGZvciB1cyBub3cuIgo+ID4KPiA+IHdo
aWNoIGluZGljYXRlcyB0aGUgdmFsaWRhdGlvbiBpcyBzdGlsbCBvbi4KPiA+Cj4gPiBTbyB0aGUg
dGVzdCBmYWlsdXJlIHByb2JhYmx5IG1lYW5zIGEga2VybmVsIGJ1ZyBidXQgbm90IGEgdGVzdCBw
cm9ibGVtLgo+Cj4gQmVmb3JlIHRoZSBwYXRjaCwgYmxrX3ZhbGlkYXRlX2Jsb2NrX3NpemUoKSBk
aWQgdmFsaWRhdGUgb3JpZ2luYWwKPiB2YWx1ZSBhcyB1bnNpZ25lZCBsb25nLAo+IGFmdGVyIHBh
dGNoIGl0J3MgdmFsaWRhdGVkIGFmdGVyIGNhc3QgdG8gdW5zaWduZWQgc2hvcnQuCj4KPiBJbiBM
VFAgdGhyZWFkIHlvdSBtZW50aW9uZWQgaXQgZmFpbGVkIG9uIHBwYzY0bGUvYWFyY2g2NCBhbmQg
d29ya2VkIG9uCj4geDg2XzY0IGFuZCBzMzkweC4KPiBJcyBpdCBieSBjaGFuY2Ugbm93IGZhaWxp
bmcgb25seSBvbiBrZXJuZWxzIHdpdGggNjRrIHBhZ2Ugc2l6ZT8KPgoKUmlnaHQsIEkgY2hlY2tl
ZCB0aGUgYXV0b21hdGlvbiBqb2JzLCBhbGwgcmVjZW50ICh2Ni4xMSkgYWFyY2g2NC1rZXJuZWwt
NjRrCnJlcG9ydHMgdGhhdCBmYWlsLgoKCgo+IChUZXN0IGF0dGVtcHRzIHRvIHNldCBibG9jayBz
aXplIHRvIDIqcGFnZSBzaXplLikKPgo+ID4KPiA+IENDIGJsb2NrIGRldnMgdG8gZ2l2ZSBzb21l
IGFkdmljZS4KPiA+Cj4gPgo+ID4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogTGkgV2FuZyA8
bGl3YW5nQHJlZGhhdC5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9pb2N0bC9pb2N0bF9sb29wMDYuYyB8IDkgKysrKysrKysrCj4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgOSBpbnNlcnRpb25zKCspCj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsX2xvb3AwNi5jCj4gPiA+IGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bF9sb29wMDYuYwo+ID4gPiBpbmRleCAzMTdmNjkzYTAu
LjRhYWNkMjg0YSAxMDA2NDQKPiA+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9p
b2N0bC9pb2N0bF9sb29wMDYuYwo+ID4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2lvY3RsL2lvY3RsX2xvb3AwNi5jCj4gPiA+IEBAIC0yMyw2ICsyMyw3IEBAIHN0YXRpYyBjaGFy
IGRldl9wYXRoWzEwMjRdOwo+ID4gPiAgc3RhdGljIGludCBkZXZfbnVtLCBkZXZfZmQsIGZpbGVf
ZmQsIGF0dGFjaF9mbGFnLCBsb29wX2NvbmZpZ3VyZV9zdXAKPiA9IDE7Cj4gPiA+ICBzdGF0aWMg
dW5zaWduZWQgaW50IGludmFsaWRfdmFsdWUsIGhhbGZfdmFsdWUsIHVuYWxpZ25fdmFsdWU7Cj4g
PiA+ICBzdGF0aWMgc3RydWN0IGxvb3BfY29uZmlnIGxvb3Bjb25maWc7Cj4gPiA+ICtzdGF0aWMg
aW50IG5vdmFsaWRhdGVfYmxvY2tzaXplID0gMDsKPiA+ID4KPiA+ID4gIHN0YXRpYyBzdHJ1Y3Qg
dGNhc2Ugewo+ID4gPiAgICAgICAgIHVuc2lnbmVkIGludCAqc2V0dmFsdWU7Cj4gPiA+IEBAIC03
NCw2ICs3NSwxMSBAQCBzdGF0aWMgdm9pZCBydW4odW5zaWduZWQgaW50IG4pCj4gPiA+ICAgICAg
ICAgc3RydWN0IHRjYXNlICp0YyA9ICZ0Y2FzZXNbbl07Cj4gPiA+Cj4gPiA+ICAgICAgICAgdHN0
X3JlcyhUSU5GTywgIiVzIiwgdGMtPm1lc3NhZ2UpOwo+ID4gPiArICAgICAgIGlmICgoKih0Yy0+
c2V0dmFsdWUpID09IGludmFsaWRfdmFsdWUpICYmCj4gbm92YWxpZGF0ZV9ibG9ja3NpemUpIHsK
PiA+ID4gKyAgICAgICAgICAgICAgIHRzdF9yZXMoVENPTkYsICJLZXJuZWwgZG9lc24ndCB2YWxp
ZGF0ZSBibG9jayBzaXplLAo+IHNraXAKPiA+ID4gaW52YWxpZCB2YWx1ZSB0ZXN0Iik7Cj4gPiA+
ICsgICAgICAgICAgICAgICByZXR1cm47Cj4gPiA+ICsgICAgICAgfQo+ID4gPiArCj4gPiA+ICAg
ICAgICAgaWYgKHRjLT5pb2N0bF9mbGFnID09IExPT1BfU0VUX0JMT0NLX1NJWkUpIHsKPiA+ID4g
ICAgICAgICAgICAgICAgIGlmICghYXR0YWNoX2ZsYWcpIHsKPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgdHN0X2F0dGFjaF9kZXZpY2UoZGV2X3BhdGgsICJ0ZXN0LmltZyIpOwo+ID4gPiBA
QCAtMTI2LDYgKzEzMiw5IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gPiA+ICAgICAgICAg
ICAgICAgICByZXR1cm47Cj4gPiA+ICAgICAgICAgfQo+ID4gPiAgICAgICAgIGxvb3Bjb25maWcu
ZmQgPSBmaWxlX2ZkOwo+ID4gPiArCj4gPiA+ICsgICAgICAgaWYgKCh0c3Rfa3ZlcmNtcCg2LCAx
MSwgMCkpID49IDApCj4gPiA+ICsgICAgICAgICAgICAgICBub3ZhbGlkYXRlX2Jsb2Nrc2l6ZSA9
IDE7Cj4gPiA+ICB9Cj4gPiA+Cj4gPiA+ICBzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4gPiA+
IC0tCj4gPiA+IDIuNDYuMAo+ID4gPgo+ID4gPgo+ID4gPiAtLQo+ID4gPiBNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPiA+ID4KPiA+ID4KPiA+
Cj4gPiAtLQo+ID4gUmVnYXJkcywKPiA+IExpIFdhbmcKPiA+Cj4gPiAtLQo+ID4gTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJl
Z2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
