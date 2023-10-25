Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EF3C0032E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 05:36:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C57173CEC37
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 07:36:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78F373CC50D
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 07:36:07 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 972C920097A
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 07:36:06 +0200 (CEST)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53f647c84d4so8225a12.0
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 22:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698212166; x=1698816966; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkMdHbGKoi+M4rU2IMyxyZb0CvDoRMKeCkZR2A62cOM=;
 b=LuxYMcAVi1TiOKHWhSXWT2c8FBcuyXccAL5i9K1X73CZscyV1qZS+9piOoZmKTWlIa
 D/ViymzEkt+MxtFgH4G0L5Ka2ThacexpeWtE806id/8hYpi7GA9KlD6QucaLBVOyzPpj
 /DoGVpy5or+1mypFChag5TkOXXbCvrdFOeWyVLt3AoCmTNW3CDzbDoOemoLtPM24czPX
 DJ3vYf7oQthrN7YWlOg0bHt0afJk2yMw7y//NkY8nfeYnc/Isnu7koJYbg1pLAen/dYu
 C2grVEEB/edCMOq15dBSXFvrVhrbzXNl7HU0iegedHOilmNax9nHwQX+Xc7qhOeU7cHT
 crXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698212166; x=1698816966;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkMdHbGKoi+M4rU2IMyxyZb0CvDoRMKeCkZR2A62cOM=;
 b=OTd/QkG14s0eia0yu4wXSKh8v/Q+WqqWL/XToLSunn4gkH2pSzDdgVeMgFeVam2M/E
 tJ49Jviw2VS2kkcKVm7COU3PB12wraUNY1MD54l0WvFU/whZZCKH8A9Wq+ovICAsizDC
 wFCAXov4kqRPnkeIv9JaU9tXLdCux1nw/bFxcmobWH1CzMKiXtYZG5QZn8VJc459H3na
 9uL4I/GqkVs7+aF3fbjtvb7JsblcEO8/kp3uXhrKubFa5euKWv7uyt0FkNsBlM2ReDCJ
 0+dRMHoRq/t2NLypRj+YNznC4bSCyRGGVyFVAEawMgK/dJtJWc5k1pcpxt0vJqGwPKpC
 O6Jg==
X-Gm-Message-State: AOJu0Yz7nAGB/kb9wifkeZb/anzVvPk21MyfTGb6plo1nyPr3w3QYbGW
 22d9yscLaRxUsZZdQWHzV6o85pMVtdUkHPnYwKn/Wg==
X-Google-Smtp-Source: AGHT+IGXQvHPo288PWh2PGZ4aeaH2ku6TEzq7ANjTx4vGJqGK7aUzTaKZhIdVwnWWUN6KH6X4Ve4CIBap9Fp7Hr/4J4=
X-Received: by 2002:aa7:da95:0:b0:540:e46d:1ee8 with SMTP id
 q21-20020aa7da95000000b00540e46d1ee8mr30010eds.4.1698212165865; Tue, 24 Oct
 2023 22:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231018015016.1897021-1-edliaw@google.com>
 <20231024231429.GA282313@pevik>
 <CAG4es9XP8UWtR6Z4jx+Oe1H4FoL=Rb1PFkShctBsC2Jkp7kg0g@mail.gmail.com>
In-Reply-To: <CAG4es9XP8UWtR6Z4jx+Oe1H4FoL=Rb1PFkShctBsC2Jkp7kg0g@mail.gmail.com>
Date: Tue, 24 Oct 2023 22:35:38 -0700
Message-ID: <CAG4es9WSzgHp3iLmzf1zfWTE5-8+6BnvhZ08SFZaT_Y8550gJA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_kvercmp: Handle larger kernel version numbers
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIFR1ZSwgT2N0IDI0LCAyMDIzIGF0IDU6NDbigK9QTSBFZHdhcmQgTGlhdyA8
ZWRsaWF3QGdvb2dsZS5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBPY3QgMjQsIDIwMjMsIDQ6MTTi
gK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4+Cj4+IEhpIEVkd2FyZCwK
Pj4KPj4gPiBDdXJyZW50IGltcGxlbWVudGF0aW9uIGNhbiBvbmx5IGhhbmRsZSByZXZpc2lvbiBu
dW1iZXJzIHVwIHRvIDI1Ni4gIEJ1bXAKPj4gPiB0aGlzIHVwIHRvIDEwMjQgYXMgc29tZSByZXZp
c2lvbiBudW1iZXJzIGFyZSBpbiB0aGUgMzAwcy4KPj4KPj4gPiBTaWduZWQtb2ZmLWJ5OiBFZHdh
cmQgTGlhdyA8ZWRsaWF3QGdvb2dsZS5jb20+Cj4+ID4gLS0tCj4+ID4gIGxpYi90c3Rfa3ZlcmNt
cC5jIHwgNCArKy0tCj4+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCj4+Cj4+ID4gZGlmZiAtLWdpdCBhL2xpYi90c3Rfa3ZlcmNtcC5jIGIvbGliL3Rz
dF9rdmVyY21wLmMKPj4gPiBpbmRleCA1NTI5MjBmYWMuLjllMWE1MTFhZiAxMDA2NDQKPj4gPiAt
LS0gYS9saWIvdHN0X2t2ZXJjbXAuYwo+PiA+ICsrKyBiL2xpYi90c3Rfa3ZlcmNtcC5jCj4+ID4g
QEAgLTkyLDggKzkyLDggQEAgaW50IHRzdF9rdmNtcChjb25zdCBjaGFyICpjdXJfa3ZlciwgaW50
IHIxLCBpbnQgcjIsIGludCByMykKPj4gPiAgICAgICAgICAgICAgICAgICAgICAgIGN1cl9rdmVy
KTsKPj4gPiAgICAgICB9Cj4+Cj4+ID4gLSAgICAgdGVzdHZlciA9IChyMSA8PCAxNikgKyAocjIg
PDwgOCkgKyByMzsKPj4gPiAtICAgICBjdXJydmVyID0gKGExIDw8IDE2KSArIChhMiA8PCA4KSAr
IGEzOwo+PiA+ICsgICAgIHRlc3R2ZXIgPSAocjEgPDwgMjApICsgKHIyIDw8IDEwKSArIHIzOwo+
PiA+ICsgICAgIGN1cnJ2ZXIgPSAoYTEgPDwgMjApICsgKGEyIDw8IDEwKSArIGEzOwo+Pgo+PiBJ
IHdvbmRlciB3aHkgeW91IG5lZWQgdGhpcyBjaGFuZ2UuIE51bWJlciA+IDI1NiBpcyBhY3R1YWxs
eSBvbmx5IHRoZSB0aGlyZAo+PiBudW1iZXIsIGJ1dCB3ZSBoYXZlbid0IGNoZWNrZWQgdGhhdCBz
byBmYXIuIERvIHlvdSBwbGFuIHRvIHVzZSBpdCBhY3R1YWxseT8KPgo+Cj4gSXQgd2FzIGNhdXNp
bmcgdGhlIG1pbm9yIHJldiBvZiB0aGUga2VybmVsIEkgd2FzIHJ1bm5pbmcgdG8gb3ZlcmZsb3cg
aW50byB0aGUgbWFqb3IgcmV2LCBzbyBhIHRlc3QgdGhhdCBoYWQgYSBtaW4ga3ZlciBvZiA0LjE5
IHdhcyBydW5uaW5nIGFuZCBmYWlsaW5nIG9uIGEgNC4xNC4zMjcga2VybmVsLgoKSSByZW1lbWJl
cmVkIGl0IGluY29ycmVjdGx5LiAgSXQgd2FzIHRoZSBtbWFwMjAgdGVzdCB3aXRoIG1pbl9rdmVy
CjQuMTUgdGhhdCB3YXMgZmFpbGluZyBvbiBhIDQuMTQuMzI3IGtlcm5lbC4KCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
