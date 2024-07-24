Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0575BC3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 13:38:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 314143D0895
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 15:38:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A66DF3C21BC
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 15:38:03 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 49AE0100079B
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 15:38:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721828280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2q73u5a5ixPeWpOMlCA/WntrdA/X92uU6ctnPquH/dw=;
 b=f6YV7EbFJQ8XZG9CeGDoTPpP9qohXfEFwsfTYH/0WuVOJgIt0Vhj19fxk9IqhnKpvbnoXV
 tTOLR9liEzvBIGyascn71yaAbveuHLW28IcjfJjDSCDCJO7fIbEkgua6t/Viqxk/z5nZPd
 FYFVK5Rhf/oqsGlBvDp2RJSvPoT5fHQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-xTy_f5evPVu4b4lbj-pnGA-1; Wed, 24 Jul 2024 09:37:58 -0400
X-MC-Unique: xTy_f5evPVu4b4lbj-pnGA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cb6c5f9810so6329681a91.2
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 06:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721828277; x=1722433077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2q73u5a5ixPeWpOMlCA/WntrdA/X92uU6ctnPquH/dw=;
 b=imuOKyN5Zioajs4hIqoq4+/ClYg3unubyUb7pldw7fbqxp6qF9EIcvDZuW67u7+oFm
 uM3eKJ7fjdlGDZzqwOQXJedS4LU5V3+SmcfFwJqUTOdhi0+lEwl0QVzKH5iRWhjdd3ZA
 t2YmTKXqdbWzJ7DtTZHwZpAbp4Ksw+7DznN/jgHJq0cA6EdHuTrixAbVhblA2x+BATK5
 pdGhjf5VYoNhkGVZVOpN/R2dahRgDUtQSJzbSBIQ9VWe7ALbDsBwxfYK/HU+9+DbN38S
 MgIlb1u9TzRSVIRxeqyaU1PruF5iuedJJLxRCZ28zHWzg8GpkCxCg2X3juUwsDRQZIVx
 JqIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRxIVYOkq6YbRkX7S8WggaG15Hvg9ZBXg0vzSBn94yFOH3iRyHDLu4Zi2U8EPNiz5+6vmcG70bffRt8ck2y+Z8j0c=
X-Gm-Message-State: AOJu0Yw4N19en3umRFuHqEdBp5Wi5sv2Ws01H85loxePY12uj9p0kMPg
 /h8FTP2T6GgPs3dI38lGo1m4Ue6lqoSuKPFPuM1U396LRDAgOjmpNDa/3CHb2rLm2JNCL5GwRnm
 fNKKUrzoaq+TYhcPGDlMvF0ZE0C0OfoDJ88+wzve31jWLgYQ/TN+5LTzl2qtQsv2H86jH+81fdJ
 lVQqjA9n9RQN6cf44gcI1FCKIX2pcgDb3Xsw==
X-Received: by 2002:a17:90a:634a:b0:2c8:65cf:e820 with SMTP id
 98e67ed59e1d1-2cdae33829emr3077049a91.2.1721828276627; 
 Wed, 24 Jul 2024 06:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu3SGPzBd2mKLmfsfA4aLvTMbFgud/JPOTT5ZGN52ltZPTe0WwrLl0ms80rKSEKHfK/0dT5aysd2CUzhCo2nc=
X-Received: by 2002:a17:90a:634a:b0:2c8:65cf:e820 with SMTP id
 98e67ed59e1d1-2cdae33829emr3077020a91.2.1721828276215; Wed, 24 Jul 2024
 06:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-9-c7b0e9edf9b0@suse.com>
 <20240716172725.GC549165@pevik>
 <CAEemH2fP9eGdHs1Wb5JLhS-H-XXxKB=73n8WAXqj3ZNxw9xDVA@mail.gmail.com>
 <20240724133003.GB950793@pevik>
In-Reply-To: <20240724133003.GB950793@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 24 Jul 2024 21:37:42 +0800
Message-ID: <CAEemH2c5r=AaiSGPfdvXSZ9G=iTa2c2eSRHd-WLL9hL_wHvK7w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 09/11] Add landlock04 test
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
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKdWwgMjQsIDIwMjQgYXQgOTozMOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksIEFuZHJlYSwKPgo+ID4gSGkgUGV0ciwgQW5kcmVhLAo+IC4u
Lgo+ID4gPiAuLi4KPiA+ID4gdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jOjk3OiBUSU5GTzogS2Vy
bmVsIHN1cHBvcnRzIHRtcGZzCj4gPiA+IHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzo0OTogVElO
Rk86IG1rZnMgaXMgbm90IG5lZWRlZCBmb3IgdG1wZnMKPiA+ID4gdHN0X3Rlc3QuYzoxNzQ2OiBU
SU5GTzogPT09IFRlc3Rpbmcgb24gZXh0MiA9PT0KPiA+ID4gdHN0X3Rlc3QuYzoxMTExOiBUSU5G
TzogRm9ybWF0dGluZyAvZGV2L2xvb3AxIHdpdGggZXh0MiBvcHRzPScnIGV4dHJhCj4gPiA+IG9w
dHM9JycKPiA+ID4gbWtlMmZzIDEuNDcuMCAoNS1GZWItMjAyMykKPiA+ID4gdHN0X3Rlc3QuYzox
MTIzOiBUSU5GTzogTW91bnRpbmcgL2Rldi9sb29wMSB0bwo+IC90bXAvTFRQX2xhbnQ2V2JLSi9z
YW5kYm94Cj4gPiA+IGZzdHlwPWV4dDIgZmxhZ3M9MAo+ID4gPiBsYW5kbG9ja19jb21tb24uaDoz
MDogVElORk86IExhbmRsb2NrIEFCSSB2Mwo+ID4gPiBsYW5kbG9jazA0LmM6MTUxOiBUSU5GTzog
VGVzdGluZyBMQU5ETE9DS19BQ0NFU1NfRlNfRVhFQ1VURQo+ID4gPiBsYW5kbG9jazA0LmM6MTIz
OiBUSU5GTzogRW5hYmxlIHJlYWQvZXhlYyBwZXJtaXNzaW9ucyBmb3IKPiA+ID4gL3Vzci9saWIv
aTM4Ni1saW51eC1nbnUvbGliYy5zby42Cj4gPiA+IGxhbmRsb2NrMDQuYzoxMzE6IFRCUk9LOiBs
YW5kbG9ja19hZGRfcnVsZSgzLCAxLCAweGY3ZjEzZmY0LCAwKTogRUlOVkFMCj4gPiA+ICgyMikK
Pgo+Cj4gPiBQb3NzaWJseSB0aGF0J3MgYmVjYXVzZSB0aGUgJ0xBTkRMT0NLX1JVTEVfUEFUSF9C
RU5FQVRIJyAgd2FzCj4gPiByZWZhY3RvcmVkIGZyb20gdGhlIHY2LjcgbWFpbmxpbmUga2VybmVs
LCBzbyBpdCBjYW4ndCBhZGQgdGhlIHJ1bGUKPiBjb3JyZWN0bHkKPiA+IHdpdGggb2xkZXIga2Vy
bmVscy4KPgo+ID4gY29tbWl0IDBlMGZjN2U4ZWI0YTExYmQ5Zjg5YTljNzRiYzdjMGUxNDRjNTYy
MDMKPiA+IEF1dGhvcjogS29uc3RhbnRpbiBNZXNraGlkemUgPGtvbnN0YW50aW4ubWVza2hpZHpl
QGh1YXdlaS5jb20+Cj4gPiBEYXRlOiAgIFRodSBPY3QgMjYgMDk6NDc6NDYgMjAyMyArMDgwMAo+
Cj4gPiAgICAgbGFuZGxvY2s6IFJlZmFjdG9yIGxhbmRsb2NrX2FkZF9ydWxlKCkgc3lzY2FsbAo+
Cj4gPiBCdXQgdGhpcyBpcyBteSBndWVzcyAodGhyb3VnaCByZWFkaW5nIHRoZSBjb2RlKSwgSSBk
aWRuJ3QgZG8gbW9yZSB0bwo+ID4gdmVyaWZ5IHRoYXQgYnkgaW5zdGFsbGluZyBzdWNoIGEga2Vy
bmVsLgo+Cj4gVGhhbmtzLCBMaSwgIGZvciBhIGhpbnQuIFF1aWNrIHRlc3Qgc2hvd3MgdGhhdCBp
dCdzIHdvcmtpbmcgb24gNi45LjksIGJ1dAo+IGJyb2tlbgo+IHdpdGggd2l0aCA2LjYueCBvciA2
LjUueCwgYWxzbyByZXByb2R1Y2VkIG9uIG1vcmUgZGlzdHJvcy4gSSdsbCB2ZXJpZnkgdGhpcwo+
IHNwZWNpZmljIGNvbW1pdCwgSSBzdXBwb3NlIHdlIHNob3VsZCByZXF1aXJlIDYuNywgcmlnaHQ/
Cj4KCkkgdGhpbmsgWUVTLCA2LjcgaW5jbHVkZXMgc29tZSB2aXRhbCBpbXByb3ZlbWVudCBvbiB0
aGUgbGFuZGxvY2sgc3lzY2FsbC4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
