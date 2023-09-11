Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C220DEE57DF
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 08:26:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D7583CB3DA
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 10:26:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAB1A3CB386
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 10:25:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1C6E31A027CB
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 10:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694420746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z7MFLxFK2dprDjnWmDkfQXsGzjWAhlyj99wh3wqnF5M=;
 b=E5K5HAR+A2sU2QH8DeHQwhtkmnTf/y0XV/9gqt/MgmsiRPJtnSV5+KbeHExNt6k747M0Oe
 /muyTLTcquJGM5IlDcTwRprPPU0vzF6GQWtay9z+g/hczWrKE78x63AVGYWnH0c5+8fWZv
 K8Fy1ZvAuPJ6qbuLfWbW6HMfH6u5dX0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-HtyZuYieOpCoqadhrdNjwg-1; Mon, 11 Sep 2023 04:25:44 -0400
X-MC-Unique: HtyZuYieOpCoqadhrdNjwg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-501ce5902faso2812486e87.0
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 01:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694420743; x=1695025543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z7MFLxFK2dprDjnWmDkfQXsGzjWAhlyj99wh3wqnF5M=;
 b=nZD1e7rVZDU56wPm8YO552nGGlKofOnF7iejKVm67bRZPbQ9MKBlnuqeDlSHDDGxOb
 VcLkEp7AuuxCg90M3jfpDF+Nwq3Keq4cPgExtwtsxfOR7oWtEkYjUIEIVjZUIXtNFVvm
 NgypwZVl8Asn5o1CFlrmt4cM25aomJA0AOtJTEwlrwdjP/GskOeTv6MwQ4IK3oIKIk6C
 +fcKZmgVp/aAzTW7WJVR/TSXa16dQCe2N0zF6nFnceNMidjJ4HRwgivU0SZNlt9iESVq
 lfJ+cXzvGGaH0OGUH9xjYPktfiDEBm6fpdns4U15LV8JYQP6i7JHyQRWGMet/ukETfKa
 loJg==
X-Gm-Message-State: AOJu0Yw0+MiDxS6+fnkvMaf5LhO4M2YAIuS4RFu+rbvwwh+xKHwKUQfM
 odmOahh+gPgNOzb8XfQ8Q8HuFyY7nbcR1Cfrw/J0BJ2vFg8ghu2syGIt0OmfQG5LpKCMcMzbJZ5
 ccWps26POpc2qUnhZ70A3hU48zR8=
X-Received: by 2002:a05:6512:31c7:b0:4fd:d254:edc6 with SMTP id
 j7-20020a05651231c700b004fdd254edc6mr4330730lfe.26.1694420743135; 
 Mon, 11 Sep 2023 01:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIQ8MfDGRK9wLYw8OVsV3JvVbiV1GvwRBMUSxYB6Prg++s3I0nN44tO5oBj42v0LVjvr84DgOMhvVX0DFlR0Y=
X-Received: by 2002:a05:6512:31c7:b0:4fd:d254:edc6 with SMTP id
 j7-20020a05651231c700b004fdd254edc6mr4330723lfe.26.1694420742836; Mon, 11 Sep
 2023 01:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230524093930.43971-1-liwang@redhat.com>
 <20230524093930.43971-2-liwang@redhat.com> <ZPm0St324pYfmCzj@yuki>
 <CAEemH2c0-bQ1+G6NaQGjh2KAO8qfPLvKh7UmiC2ETH1T__NL2w@mail.gmail.com>
 <ZP7Lxe_2NqAaZhb7@yuki>
In-Reply-To: <ZP7Lxe_2NqAaZhb7@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 11 Sep 2023 16:25:31 +0800
Message-ID: <CAEemH2eYQAUEy1rKos+LS1qd-JVcRzSPARVGVTkouvayhMzh4w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH 2/2] hugemmap33: Test to detect bug with
 migrating gigantic pages
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBTZXAgMTEsIDIwMjMgYXQgNDoxMeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiA+ID4gKyAgICAgaWYgKHRzdF90YWludF9jaGVjaygp
KQo+ID4gPiA+ICsgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCwgIlRlc3QgcmVzdWx0ZWQgaW4g
a2VybmVsIHRhaW50ZWQiKTsKPiA+ID4gPiArICAgICBlbHNlCj4gPiA+ID4gKyAgICAgICAgICAg
ICB0c3RfcmVzKFRQQVNTLCAiVGVzdCBjb21wbGV0ZWQgc3VjY2Vzc2Z1bGx5Iik7Cj4gPiA+Cj4g
PiA+IHRzdF90ZXN0LnRhaW50X2NoZWNrID8KPiA+ID4KPiA+Cj4gPiBXZSBoYXZlIHRvIGtlZXAg
dGhlc2UgY2hlY2sgc2VudGVuY2VzIG90aGVyd2lzZSBpdCB3aWxsCj4gPiBjb21wbGFpbiB3aXRo
IG5vIHJlcG9ydGluZyByZXN1bHRzLgo+ID4KPiA+ICAgdHN0X2h1Z2VwYWdlLmM6MTAzOiBUSU5G
TzogMiBodWdlcGFnZShzKSByZXNlcnZlZAo+ID4gICB0c3RfdGVzdC5jOjE1NjI6IFRJTkZPOiBU
aW1lb3V0IHBlciBydW4gaXMgMGggMDFtIDMwcwo+ID4gICBodWdlbW1hcDM0LmM6MTA3OiBUSU5G
TzogUnVudGltZSBleGhhdXN0ZWQsIGV4aXRpbmcKPiA+ICAgdHN0X3Rlc3QuYzoxMzk0OiBUQlJP
SzogVGVzdCBoYXZlbid0IHJlcG9ydGVkIHJlc3VsdHMhCj4KPiBSaWdodCB0aGUgLnRhaW50X2No
ZWNrIG9ubHkgcHJvZHVjZXMgVEZBSUwgd2hlbiBrZXJuZWwgdGFpbnQgZmxhZ3MKPiBjaGFuZ2Ug
ZHVyaW5nIHRoZSBkdXJhdGlvbiBvZiB0aGUgdGVzdC4KPgo+IFdlIGNhbiBhcyB3ZWxsIGRvIHRo
ZSBzYW1lIGFzIHdlIGRvIGluIG1vc3Qgb2YgdGhlIENWRSB0ZXN0cyB0aGF0IGhhdmUKPiB0aGlz
IGxpbmUgYXQgdGhlIGVuZCBvZiB0aGUgcnVuKCkgZnVuY3Rpb246Cj4KPiB0c3RfcmVzKFRQQVNT
LCAiTm90aGluZyBiYWQgaGFwcGVuZWQsIHByb2JhYmx5LiIpOwo+CgorMSB0aGlzIGlzIGJldHRl
ciwgYnV0IEkgaGF2ZSBzZW50IG91dCB0aGUgcGF0Y2gtdjIsIHNvbWVvbmUgd2hvCm1lcmdlIHBh
dGNoIGNhbiBoZWxwIGltcHJvdmUgdGhpcy4KCgo+IE9yIHdlIGNhbiBrZWVwIHRoZSB0c3RfdGFp
bnRfY2hlY2soKSBpbiB0aGUgY29kZSwgYnV0IEkgZ3Vlc3MgdGhhdCB3ZQo+IGFyZSBtaXNzaW5n
IHRzdF90YWludF9pbml0KCkgaW4gdGhlIHRlc3Qgc2V0dXAoKSwgb3IgYW0gSSBtaXN0YWtlbj8K
PgoKTm8gbmVlZCwgdHN0X3RhaW50X2luaXQoKSBoYXMgYmVlbiBpbnZva2VkIGluIGRvX3NldHVw
IGluIHRzdF90ZXN0LmMuCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
