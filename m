Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86540C5321E
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 12:50:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06E083D2738
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 14:50:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CFA23C093D
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 14:50:18 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B34D61000D2F
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 14:50:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724676616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XFmyhE/fGhqpbr2lDAYh+aei7vinexhPMQ9QJCYFvBc=;
 b=gfneCUTvWd+TUbiAMds4XWtjtMWbQYdegOIE3DArbY3oYRooDw7xIv/a/62RVNq5t1lhl9
 GCRV395JfW9m1/rqhHeBURU5ETmtJOiQeYcrMWOVPfyZ/tY45bLovZP3+Ho0glOdNMxwj2
 g0Mjr7p7lIFHuQPgy5xoscGA8JqtuHI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-byx6Fg01OQuFPelzLZXmug-1; Mon, 26 Aug 2024 08:50:13 -0400
X-MC-Unique: byx6Fg01OQuFPelzLZXmug-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2d3bd8a0bd4so4809616a91.0
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 05:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724676612; x=1725281412;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XFmyhE/fGhqpbr2lDAYh+aei7vinexhPMQ9QJCYFvBc=;
 b=AxqUZpbTsmXXydkNaakEBQJxUvegBB2iRZt1n8rt0u7S8+AeyZ9ywfUCXTeIOqnEg6
 CYxT4LG7nZ7XfexzHyPfSlTv51CscQmxxL0pE3hdaehRXJodU5dqW+c+4/An5DW576Ae
 2B+8kXUUzHFqsggXb6f6Xrt9fEJVWJ3/djUmXVNC/PH+myXahfQ0Ib8avqot1suL8JQY
 Q8iz88MCONPjT/1yy3BtCqaWNTDlCYcmGDqnM3isFD6xAi2iNs2IYWd7E/TGaKDrzMXN
 88bvYCHhFgJc601GGCFuKaRDdciymk7YzorX6W5tNUTY9OXNEvR7sTmL1uMm+l+B3gU8
 E2IA==
X-Gm-Message-State: AOJu0YxnYs5YztnfuprtMFfM0yIVRvQ34PRlbHx9pZFmTEqUQMZ+KC7L
 s7LP4f9me+V3x0/89Hx0qEyhffdiCtoBFitrhNTC6NZAnsxhhkOy79nQO9xdw1tDPfTkmsBtXod
 RleQ8lQYAQZeQYJnavDPajudYVe5gV8ZxaEiSRt8qrn+zvtxLgiwELQb+vwWfj2MpAyIKaRjdaq
 G2kuE5+mrJkvvQTuZbdjTn89/IMzoY2FuYyQ==
X-Received: by 2002:a17:90a:6403:b0:2d3:d7b9:2c7e with SMTP id
 98e67ed59e1d1-2d646bf24c6mr9827201a91.24.1724676612089; 
 Mon, 26 Aug 2024 05:50:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqpIcpMHJwgqIT2yedClZ0covVKHXBSL1dvkxOlo6jBJIfa7moODm1DeUtO9FVIk4qp4sQCrcRdvGSGiO/sjY=
X-Received: by 2002:a17:90a:6403:b0:2d3:d7b9:2c7e with SMTP id
 98e67ed59e1d1-2d646bf24c6mr9827182a91.24.1724676611722; Mon, 26 Aug 2024
 05:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240826120205.5506-1-liwang@redhat.com>
 <CAASaF6xA5rmWgVFFfpGMSXjyVRiFYf--ue=GzvjN+-vB26FOPg@mail.gmail.com>
In-Reply-To: <CAASaF6xA5rmWgVFFfpGMSXjyVRiFYf--ue=GzvjN+-vB26FOPg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Aug 2024 20:49:59 +0800
Message-ID: <CAEemH2cp=9+Ri8fTi3G4yX5ZhFx-17JUxUtPqUTcNf_TE3EC8g@mail.gmail.com>
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBBdWcgMjYsIDIwMjQgYXQgODo0NeKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKCj4gT24gTW9uLCBBdWcgMjYsIDIwMjQgYXQgMjowMuKAr1BNIExp
IFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBTaW5jZSBjb21taXQgOTQy
M2M2NTNmZTYxMTAgKCJsb29wOiBEb24ndCBib3RoZXIgdmFsaWRhdGluZyBibG9ja3NpemUiKQo+
IGtlcm5lbAo+Cj4gVGhpcyBjb21taXQgYWJvdmUgc2F5cyAiVGhlIGJsb2NrIHF1ZXVlIGxpbWl0
cyB2YWxpZGF0aW9uIGRvZXMgdGhpcwo+IGZvciB1cyBub3cuIiwKPiBzaG91bGRuJ3QgdGhhdCBz
dGlsbCBjYXRjaCB0aGUgZXJyb3JzPwo+CgpZZXMsIEkgb3Zlcmxvb2tlZCB0aGF0IGJlZm9yZSwg
YWZ0ZXIgcmVtb3ZpbmcgdGhlIGJsa192YWxpZGF0ZV9ibG9ja19zaXplKCkKZnJvbQprZXJuZWwg
c2lkZSwgdGVzdCBpb2N0bF9sb29wMDYgYWx3YXlzIGZhaWxlZCBvbiBwcGM2NGxlL2FhcmNoNjQu
CldlaXJkbHksIHg4Nl82NCBhbmQgczM5MHggd29yayB3ZWxsLiBJIGd1ZXNzIGl0J3MgcHJvYmFi
bHkgYSBrZXJuZWwgbmV3IGJ1Zy4KCgo+ID4gZHJvcCB2YWxpZGF0aW5nIGJsb2Nrc2l6ZSBmb3Ig
Ym90aCBsb29wX2NvbmZpZ3VyZSBhbmQKPiBsb29wX3NldF9ibG9ja19zaXplIHNvCj4gPiB0aGF0
IHNldCBsYXJnZSBibG9jayBzaXplIHN1Y2NlZWRzLgo+ID4KPiA+IEVycm9yIGxvZzoKPiA+ICAg
MTIgaW9jdGxfbG9vcDA2LmM6NzY6IFRJTkZPOiBVc2luZyBMT09QX1NFVF9CTE9DS19TSVpFIHdp
dGggYXJnID4KPiBQQUdFX1NJWkUKPiA+ICAgMTMgaW9jdGxfbG9vcDA2LmM6NTk6IFRGQUlMOiBT
ZXQgYmxvY2sgc2l6ZSBzdWNjZWVkIHVuZXhwZWN0ZWRseQo+ID4gICAuLi4KPiA+ICAgMTggaW9j
dGxfbG9vcDA2LmM6NzY6IFRJTkZPOiBVc2luZyBMT09QX0NPTkZJR1VSRSB3aXRoIGJsb2NrX3Np
emUgPgo+IFBBR0VfU0laRQo+ID4gICAxOSBpb2N0bF9sb29wMDYuYzo1OTogIFRGQUlMOiBTZXQg
YmxvY2sgc2l6ZSBzdWNjZWVkIHVuZXhwZWN0ZWRseQo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IExp
IFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAgdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9pb2N0bC9pb2N0bF9sb29wMDYuYyB8IDkgKysrKysrKysrCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsX2xvb3AwNi5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2lvY3RsL2lvY3RsX2xvb3AwNi5jCj4gPiBpbmRleCAzMTdmNjkzYTAuLjRhYWNkMjg0
YSAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGxf
bG9vcDA2LmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGxf
bG9vcDA2LmMKPiA+IEBAIC0yMyw2ICsyMyw3IEBAIHN0YXRpYyBjaGFyIGRldl9wYXRoWzEwMjRd
Owo+ID4gIHN0YXRpYyBpbnQgZGV2X251bSwgZGV2X2ZkLCBmaWxlX2ZkLCBhdHRhY2hfZmxhZywg
bG9vcF9jb25maWd1cmVfc3VwID0KPiAxOwo+ID4gIHN0YXRpYyB1bnNpZ25lZCBpbnQgaW52YWxp
ZF92YWx1ZSwgaGFsZl92YWx1ZSwgdW5hbGlnbl92YWx1ZTsKPiA+ICBzdGF0aWMgc3RydWN0IGxv
b3BfY29uZmlnIGxvb3Bjb25maWc7Cj4gPiArc3RhdGljIGludCBub3ZhbGlkYXRlX2Jsb2Nrc2l6
ZSA9IDA7Cj4gPgo+ID4gIHN0YXRpYyBzdHJ1Y3QgdGNhc2Ugewo+ID4gICAgICAgICB1bnNpZ25l
ZCBpbnQgKnNldHZhbHVlOwo+ID4gQEAgLTc0LDYgKzc1LDExIEBAIHN0YXRpYyB2b2lkIHJ1bih1
bnNpZ25lZCBpbnQgbikKPiA+ICAgICAgICAgc3RydWN0IHRjYXNlICp0YyA9ICZ0Y2FzZXNbbl07
Cj4gPgo+ID4gICAgICAgICB0c3RfcmVzKFRJTkZPLCAiJXMiLCB0Yy0+bWVzc2FnZSk7Cj4gPiAr
ICAgICAgIGlmICgoKih0Yy0+c2V0dmFsdWUpID09IGludmFsaWRfdmFsdWUpICYmIG5vdmFsaWRh
dGVfYmxvY2tzaXplKSB7Cj4gPiArICAgICAgICAgICAgICAgdHN0X3JlcyhUQ09ORiwgIktlcm5l
bCBkb2Vzbid0IHZhbGlkYXRlIGJsb2NrIHNpemUsIHNraXAKPiBpbnZhbGlkIHZhbHVlIHRlc3Qi
KTsKPiA+ICsgICAgICAgICAgICAgICByZXR1cm47Cj4gPiArICAgICAgIH0KPiA+ICsKPiA+ICAg
ICAgICAgaWYgKHRjLT5pb2N0bF9mbGFnID09IExPT1BfU0VUX0JMT0NLX1NJWkUpIHsKPiA+ICAg
ICAgICAgICAgICAgICBpZiAoIWF0dGFjaF9mbGFnKSB7Cj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICB0c3RfYXR0YWNoX2RldmljZShkZXZfcGF0aCwgInRlc3QuaW1nIik7Cj4gPiBAQCAtMTI2
LDYgKzEzMiw5IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gPiAgICAgICAgICAgICAgICAg
cmV0dXJuOwo+ID4gICAgICAgICB9Cj4gPiAgICAgICAgIGxvb3Bjb25maWcuZmQgPSBmaWxlX2Zk
Owo+ID4gKwo+ID4gKyAgICAgICBpZiAoKHRzdF9rdmVyY21wKDYsIDExLCAwKSkgPj0gMCkKPiA+
ICsgICAgICAgICAgICAgICBub3ZhbGlkYXRlX2Jsb2Nrc2l6ZSA9IDE7Cj4gPiAgfQo+ID4KPiA+
ICBzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4gPiAtLQo+ID4gMi40Ni4wCj4gPgo+Cj4KCi0t
IApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
