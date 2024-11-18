Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCC2D49205
	for <ltp@archiver.kernel.org>; Mon, 18 Nov 2024 09:45:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E8A03D810F
	for <ltp@archiver.kernel.org>; Mon, 18 Nov 2024 10:45:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEEAD3D80ED
 for <ltp@lists.linux.it>; Mon, 18 Nov 2024 10:45:31 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F171E6029F9
 for <ltp@lists.linux.it>; Mon, 18 Nov 2024 10:45:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731923129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P1c3a2Hp6xYTJsiXVJ8dO+DuIhNZ8kCWoCPzMROXn6c=;
 b=AB4BqMs70Dlyx6QKYZt/2Cm+Qv9y3zXLf82Muqid6lMZFpQeX7OqnqreZ8nB8e5wr0cw1v
 ANcTGa/uQWpDeH+0PPZK9ys5KAfiAjCWOmP5HC7MdsNG7taYZT0fcA2GTgR7YBovLJdjji
 qKpROYlOYd/X0xNUJHsenAXf1EEKA4E=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-nQAEuPUWOICWOUdlrMZwGg-1; Mon, 18 Nov 2024 04:45:27 -0500
X-MC-Unique: nQAEuPUWOICWOUdlrMZwGg-1
X-Mimecast-MFC-AGG-ID: nQAEuPUWOICWOUdlrMZwGg
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-29678d451b1so363104fac.3
 for <ltp@lists.linux.it>; Mon, 18 Nov 2024 01:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731923126; x=1732527926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P1c3a2Hp6xYTJsiXVJ8dO+DuIhNZ8kCWoCPzMROXn6c=;
 b=IIgrjsTbNT5XpseTDrJ86VxOB3EdMc5E5LNnrbgwmpZFhiKN6bbA3xcwbFiEyq4d2p
 OnRQ6S0V1Tu5opSR/1MJSAyaYgaxo5AAHNgiA2Id4StcO7HBpdMZGuJN1w7O3g/pQBry
 BVikBMSopivrZPyM8Cyylkl7jovOW70U+3m8+3qcpQ/e1n/yrKJORM8a+nXnnnHtw5Id
 r5WXg/ez25LaXe+coukGhsNTfzSHMKFsD1Uq+ZHU4IXdmGW3aDQlsfSXJYinNaD30UqJ
 ap9olF/tAHlgydP6S67RaRuib3jP4TJC2z/MCNIh0rD2Y3XqAdGfbXOQrZRABx9HgrmK
 E5bQ==
X-Gm-Message-State: AOJu0Yz1AZ/r+CA8gaIw5eTRZB5fT0F2m0cqB5/JSCzPgDyi46yD9muM
 Ri/yax3hx67rXYLsPERbEcDEyl5oETaOvi+kUpIV3tlkNS0U+QKFXSR/5PSLk3nejQ8zOqwrOtz
 7U5C8nFoUVSKBtJjNDmff0Sn6n7IyTwMDADTIGyT3DBriWWSBzR+OtAbEJW1lC3We6HC4K+dYyj
 hbZ1DSDBq9DIGib4JVpA347zg=
X-Received: by 2002:a05:6870:6b8d:b0:259:ae64:9234 with SMTP id
 586e51a60fabf-2962dd17ba8mr8654588fac.13.1731923126683; 
 Mon, 18 Nov 2024 01:45:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnBOJPdZ6gcer3WCOPMlr3r8ddJ5ElMhcMNj8spY2n83O44giL3qZAlD/kTXaWT7Vgwn8bz5Rr82xfazg1K7w=
X-Received: by 2002:a05:6870:6b8d:b0:259:ae64:9234 with SMTP id
 586e51a60fabf-2962dd17ba8mr8654569fac.13.1731923126291; Mon, 18 Nov 2024
 01:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20241114144029.349559-1-pvorel@suse.cz>
 <20241114144029.349559-4-pvorel@suse.cz>
 <CAASaF6z3quzaFkgo47SZgpPxK=Ny_2f3C07LR7=8eVFrTa6CfQ@mail.gmail.com>
 <20241115140005.GD1718754@pevik>
In-Reply-To: <20241115140005.GD1718754@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 18 Nov 2024 10:45:10 +0100
Message-ID: <CAASaF6xC-PJC79cSbH_NVGYcTTkApYuOkyXDL8p8GQa0k=-vgw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VIiMrrDxvihEtxjYXub6rIjz0NS6hOnBSSt59vGFNSc_1731923126
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] mq_timedsend01: Workaround segfault on libc
 variant on 32 bit
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

T24gRnJpLCBOb3YgMTUsIDIwMjQgYXQgMzowMOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEphbiwKPgo+ID4gT24gVGh1LCBOb3YgMTQsIDIwMjQgYXQgMzo0
MOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKPgo+ID4gPiBFRkFVTFQg
dGVzdCBzZWdmYXVsdHMgb24gbmV3ZXIga2VybmVscyAoZS5nLiA2LjQpIG9uIGxpYmMgdmFyaWFu
dCBvbgo+ID4gPiAzMmJpdC4gIFNpbWlsYXJseSB0byAxZDRkNWEwNzUwIHVzZSB0eXBpY2FsIExU
UCB3b3JrYXJvdW5kIHRvIHRlc3QgYnkKPiA+ID4gZm9ya2VkIGNoaWxkICsgY2hlY2tpbmcgdGhl
IHRlcm1pbmF0aW5nIHNpZ25hbC4KPiAuLi4KPiA+ID4gK3N0YXRpYyB2b2lkIHRlc3RfYmFkX2Fk
ZHIodW5zaWduZWQgaW50IGkpCj4gPiA+ICt7Cj4gPiA+ICsgICAgICAgc3RydWN0IHRpbWU2NF92
YXJpYW50cyAqdHYgPSAmdmFyaWFudHNbdHN0X3ZhcmlhbnRdOwo+ID4gPiArICAgICAgIHBpZF90
IHBpZDsKPiA+ID4gKyAgICAgICBpbnQgc3RhdHVzOwo+ID4gPiArCj4gPiA+ICsgICAgICAgcGlk
ID0gU0FGRV9GT1JLKCk7Cj4gPiA+ICsgICAgICAgaWYgKCFwaWQpIHsKPiA+ID4gKyAgICAgICAg
ICAgICAgIHZlcmlmeV9tcXRfc2VuZF9yZWNlaXZlKGksIHBpZCk7Cj4gPiA+ICsgICAgICAgICAg
ICAgICBfZXhpdCgwKTsKPiA+ID4gKyAgICAgICB9Cj4gPiA+ICsKPiA+ID4gKyAgICAgICBTQUZF
X1dBSVRQSUQocGlkLCAmc3RhdHVzLCAwKTsKPiA+ID4gKwo+ID4gPiArICAgICAgIGlmIChXSUZF
WElURUQoc3RhdHVzKSAmJiAhV0VYSVRTVEFUVVMoc3RhdHVzKSkKPiA+ID4gKyAgICAgICAgICAg
ICAgIHJldHVybjsKPiA+ID4gKwo+ID4gPiArICAgICAgIGlmICh0di0+dHNfdHlwZSA9PSBUU1Rf
TElCQ19USU1FU1BFQyAmJgo+ID4gPiArICAgICAgICAgICAgICAgV0lGU0lHTkFMRUQoc3RhdHVz
KSAmJiBXVEVSTVNJRyhzdGF0dXMpID09IFNJR1NFR1YpIHsKPiA+ID4gKyAgICAgICAgICAgICAg
IHRzdF9yZXMoVFBBU1MsICJDaGlsZCBraWxsZWQgYnkgZXhwZWN0ZWQgc2lnbmFsIik7Cj4gPiA+
ICsgICAgICAgICAgICAgICByZXR1cm47Cj4gPiA+ICsgICAgICAgfQo+ID4gPiArCj4gPiA+ICsg
ICAgICAgdHN0X3JlcyhURkFJTCwgIkNoaWxkICVzIiwgdHN0X3N0cnN0YXR1cyhzdGF0dXMpKTsK
PiA+ID4gK30KPiA+ID4gKwo+ID4gPiArc3RhdGljIHZvaWQgZG9fdGVzdCh1bnNpZ25lZCBpbnQg
aSkKPiA+ID4gK3sKPiA+ID4gKyAgICAgICBzdHJ1Y3QgdGltZTY0X3ZhcmlhbnRzICp0diA9ICZ2
YXJpYW50c1t0c3RfdmFyaWFudF07Cj4gPiA+ICsgICAgICAgY29uc3Qgc3RydWN0IHRlc3RfY2Fz
ZSAqdGMgPSAmdGNhc2VbaV07Cj4gPiA+ICsgICAgICAgdW5zaWduZWQgaW50IGo7Cj4gPiA+ICsg
ICAgICAgcGlkX3QgcGlkID0gLTE7Cj4gPiA+ICsKPiA+ID4gKyAgICAgICB0c3RfdHNfc2V0X3Nl
YygmdHMsIHRjLT50dl9zZWMpOwo+ID4gPiArICAgICAgIHRzdF90c19zZXRfbnNlYygmdHMsIHRj
LT50dl9uc2VjKTsKPiA+ID4gKwo+ID4gPiArICAgICAgIGlmICh0Yy0+YmFkX3RzX2FkZHIpIHsK
Pgo+ID4gV291bGQgaXQgbWFrZSBzZW5zZSB0byBydW4gYmFkX21zZ19hZGRyL0VGQVVMVCB0ZXN0
IGFsc28gaW4gY2hpbGQ/Cj4KPiBGaXJzdCwgdGhhbmtzIGEgbG90IGEgcmV2aWV3Lgo+IEknbSBu
b3Qgc3VyZSBteXNlbGYuIFNvIGZhciBpdCdzIG5vdCBuZWVkZWQgKHByb2JsZW0gaXMgb25seSB3
aXRoIHN0cnVjdAo+IHRpbWVzcGVjICphYnNfdGltZW91dCBub3Qgd2l0aCBjb25zdCBjaGFyIG1z
Z19wdHJbXSkuIEJ1dCBPVE9IIGl0IGRvZXMgbm90Cj4gaGFybS4gRG9pbmcgdGhpcyBtaWdodCBw
cmV2ZW50IHNvbWUgZmFpbHVyZSBpbiB0aGUgZnV0dXJlLgoKSXQgd2FzIG9ubHkgYXMgYSBwcmVj
YXV0aW9uLiBFaXRoZXIgd2F5LCBmZWVsIGZyZWUgdG8gYWRkIHRvIHNlcmllczoKQWNrZWQtYnk6
IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgoKPgo+IEtpbmQgcmVnYXJkcywKPiBQ
ZXRyCj4KPiA+ID4gKyAgICAgICAgICAgICAgIHRlc3RfYmFkX2FkZHIoaSk7Cj4gPiA+ICsgICAg
ICAgICAgICAgICByZXR1cm47Cj4gPiA+ICsgICAgICAgfQo+IC4uLgo+CgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
