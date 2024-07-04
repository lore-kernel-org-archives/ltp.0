Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589CEC3065C
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 06:22:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 835A33D3CC6
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 08:22:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31D9E3D05E3
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 08:21:52 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 057131B60ECB
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 08:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720074109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rh89+avjU74l+p+nK3o4An1lOB3oHj5AKgH4Rbe8kPo=;
 b=FGqFbzyAjR/+YzRJcm/ytYfX/+JHh7/U6Ap5uSrfo6gUr+x1TxNU44zPLcnFifNxZPSHCR
 E1iR7Sm3jkVq1sMuS2p8eO2nbW+mW0Ds/bX53EysAtHWbpCKlgzVfAvPSyJP/xwspoA6ek
 4kjKTLLv8ZwR2knkdYpuxfpyfSyt4EY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-GydRZnIUNkaAPybR_uvXRA-1; Thu, 04 Jul 2024 02:21:47 -0400
X-MC-Unique: GydRZnIUNkaAPybR_uvXRA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c98c453912so323656a91.2
 for <ltp@lists.linux.it>; Wed, 03 Jul 2024 23:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720074106; x=1720678906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rh89+avjU74l+p+nK3o4An1lOB3oHj5AKgH4Rbe8kPo=;
 b=kePdlydK//OXVtVff41hfQKyTWT6HvdZLy3WFSj93gDa5iCBsSsIwtyWTjl41rPxgu
 MT4W3JDm0cRxGHawmAnW6qyFt7bgFY/yG1R8VEuhPhEYx6i6yxfmQMVDqlKz3PKtQm9Y
 ZyYJbQVaHlBHddFUOIe+D9viZW0wVCsfeNaXBuPj5AMgEgRs6tssThB8Y+Wm5ULRV7+k
 3h/HkdpidKI9tNM2005tXfqD3o8Lkg9rEfomdSxMZVq+D/JhZhpgw9++HPYOMi/HiaGO
 Viqtqme8WdbJxyd9TDcdnsGKm1xZ7k/jjroBPIFPj+BQXIUchn6ie54rSKIKHTEbhx8n
 hjKQ==
X-Gm-Message-State: AOJu0YwbbnTqIV56YryXHQaxMVqAMqHdDhxNVphdcWdVFoDgewqe+YGY
 1MpzhExLv+1cw5dIH/8YKNXWXQQVo7jQEjYkWVHnkS9+hohf9n9pGMf21366MgpjgiWZvd2B4hf
 JqzUgkBQGPPkRqMtIurpxyKPT420HPSfuomIoKT0tltTbC+PT6BKFYHQqCrK5vDbm/jF6ZxCsMf
 r3L02YdMdpIT9D7IVvwG2aEzY=
X-Received: by 2002:a05:6a20:7346:b0:1be:85ca:9c7a with SMTP id
 adf61e73a8af0-1c0cc73f65amr607526637.21.1720074105874; 
 Wed, 03 Jul 2024 23:21:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCIncWQnMk92n73Ls/QXsaLwk1SmtoGjGlrE9OCwi5ayc2wFlEflmUdLz3M1F/JcxIQndqqhloxYtj6P4GFEA=
X-Received: by 2002:a05:6a20:7346:b0:1be:85ca:9c7a with SMTP id
 adf61e73a8af0-1c0cc73f65amr607510637.21.1720074105485; Wed, 03 Jul 2024
 23:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <SEZPR01MB4527B0054808F801B05EECB7A8DE2@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
In-Reply-To: <SEZPR01MB4527B0054808F801B05EECB7A8DE2@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Jul 2024 14:21:33 +0800
Message-ID: <CAEemH2cQ6ZkXdFMT2EFh_iHdrFA-yan+yW9EfBm24Twy7NxFyg@mail.gmail.com>
To: Jiwei Sun <sunjw10@outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] build.sh: delete outdated SKIP_IDCHECK parameter
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
Cc: ahuang12@lenovo.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKdWwgNCwgMjAyNCBhdCAxOjQw4oCvUE0gSml3ZWkgU3VuIDxzdW5qdzEwQG91dGxv
b2suY29tPiB3cm90ZToKCj4gRnJvbTogSml3ZWkgU3VuIDxzdW5qdzEwQGxlbm92by5jb20+Cj4K
PiBDb21taXQgMWFjY2IzZTAzZWMzNyAoIk1ha2VmaWxlOiBSZW1vdmUgSURjaGVjay5zaCIpIHJl
bW92ZWQgdGhlCj4gcGFyYW1ldGVyIFNLSVBfSURDSEVDSy4gUmVtb3ZlIGl0IGZyb20gYnVpbGQu
c2ggYW5kIElOU1RBTEwgaW4gb3JkZXIKPiB0byBhdm9pZCBjb25mdXNpb24uCj4KPiBSZXZpZXdl
ZC1ieTogQWRyaWFuIEh1YW5nIDxhaHVhbmcxMkBsZW5vdm8uY29tPgo+IFNpZ25lZC1vZmYtYnk6
IEppd2VpIFN1biA8c3VuancxMEBsZW5vdm8uY29tPgo+CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8
bGl3YW5nQHJlZGhhdC5jb20+CgotLS0KPiAgSU5TVEFMTCAgfCA2IC0tLS0tLQo+ICBidWlsZC5z
aCB8IDIgKy0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNyBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9JTlNUQUxMIGIvSU5TVEFMTAo+IGluZGV4IDk5Mzg2YmVkOC4u
ZGQ1N2Y2YTM4IDEwMDY0NAo+IC0tLSBhL0lOU1RBTEwKPiArKysgYi9JTlNUQUxMCj4gQEAgLTU1
LDEzICs1NSwxMCBAQCBpbiB0aGUgc2FtZSBkaXJlY3Rvcnkgd2hlcmUgdGhlIHNvdXJjZSBmaWxl
cyByZXNpZGUuCj4gICAgICAgICAkIG1ha2UgYWxsCj4gICAgICAgICAkIG1ha2UgXAo+ICAgICAg
ICAgICAiREVTVERJUj0kU1lTUk9PVCIgXAo+IC0gICAgICAgICBTS0lQX0lEQ0hFQ0s9WzB8MV0g
XAo+ICAgICAgICAgICBpbnN0YWxsCj4KPiAgLSBTcGVjaWZ5aW5nIERFU1RESVIgaXMgb3B0aW9u
YWwsIGJ1dCByZXF1aXJlZCB3aGVuIGluc3RhbGxpbmcgdG8gYQo+IG5vbi1ob3N0Cj4gICAgc3lz
cm9vdCwgYXMgb3Bwb3NlZCB0byB0aGUgaG9zdCBzeXN0ZW0ncyBzeXNyb290Lgo+IC0tIFNwZWNp
ZnkgU0tJUF9JRENIRUNLPTEgaWYgYW5kIHdoZW4geW91IGRvbid0IHdhbnQgdG8gbW9kaWZ5Cj4g
L2V0Yy97Z3JvdXAscGFzc3dkfQo+IC0gIG9uIHRoZSB0YXJnZXQgc3lzdGVtJ3Mgc3lzcm9vdC4K
Pgo+ICBJZiB5b3UgZ2V0IGEgYnVpbGQgZXJyb3IsIHBsZWFzZSByZXBvcnQgaXQgdG8gbHRwQGxp
c3RzLmxpbnV4Lml0IHdpdGgKPiAgZm9sbG93aW5nIGluZm9ybWF0aW9uLAo+IEBAIC05NSwxMyAr
OTIsMTAgQEAgaXRlbXMgd2hpY2ggbmVlZCBmaXhpbmcgaW4gdGhlIExUUCB0cmVlLgo+ICAgICAg
ICAgICAidG9wX3NyY2Rpcj0kVE9QX1NSQ0RJUiIgXAo+ICAgICAgICAgICAidG9wX2J1aWxkZGly
PSRPVVRfT0ZfQlVJTERfVFJFRV9ESVIiIFwKPiAgICAgICAgICAgIkRFU1RESVI9JFNZU1JPT1Qi
IFwKPiAtICAgICAgICAgU0tJUF9JRENIRUNLPVswfDFdCj4gICAgICAgICAgIGluc3RhbGwKPgo+
ICAtIFNwZWNpZnlpbmcgREVTVERJUiBpcyBvcHRpb25hbCwgYnV0IHJlcXVpcmVkIHdoZW4gaW5z
dGFsbGluZyB0byBhCj4gbm9uLWhvc3QKPiAgICBzeXNyb290LCBhcyBvcHBvc2VkIHRvIHRoZSBo
b3N0IHN5c3RlbSdzIHN5c3Jvb3QuCj4gLS0gU3BlY2lmeSBTS0lQX0lEQ0hFQ0s9MSBpZiBhbmQg
d2hlbiB5b3UgZG9uJ3Qgd2FudCB0byBtb2RpZnkKPiAvZXRjL3tncm91cCxwYXNzd2R9Cj4gLSAg
b24gdGhlIHRhcmdldCBzeXN0ZW0ncyBzeXNyb290Lgo+Cj4gIFF1aWNrIFN0YXJ0Cj4gIC0tLS0t
LS0tLS0tCj4gZGlmZiAtLWdpdCBhL2J1aWxkLnNoIGIvYnVpbGQuc2gKPiBpbmRleCAxNzY3Y2My
MWIuLjdiZDBkMzg1OSAxMDA3NTUKPiAtLS0gYS9idWlsZC5zaAo+ICsrKyBiL2J1aWxkLnNoCj4g
QEAgLTEzOCw3ICsxMzgsNyBAQCBpbnN0YWxsX2luX3RyZWUoKQo+ICBpbnN0YWxsX291dF90cmVl
KCkKPiAgewo+ICAgICAgICAgY2QgJEJVSUxEX0RJUgo+IC0gICAgICAgbWFrZSAkTUFLRV9PUFRT
X09VVF9UUkVFIERFU1RESVI9IiRwcmVmaXgiIFNLSVBfSURDSEVDSz0xIGluc3RhbGwKPiArICAg
ICAgIG1ha2UgJE1BS0VfT1BUU19PVVRfVFJFRSBERVNURElSPSIkcHJlZml4IiBpbnN0YWxsCj4g
IH0KPgo+ICB1c2FnZSgpCj4gLS0KPiAyLjI3LjAKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywK
TGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
