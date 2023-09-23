Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB9BCE7A89
	for <ltp@archiver.kernel.org>; Sat, 23 Sep 2023 12:28:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17C2C3CDE17
	for <ltp@archiver.kernel.org>; Sat, 23 Sep 2023 14:28:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 784653C9D2C
 for <ltp@lists.linux.it>; Sat, 23 Sep 2023 14:28:18 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 691641A00985
 for <ltp@lists.linux.it>; Sat, 23 Sep 2023 14:28:17 +0200 (CEST)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ae18567f42so301689b6e.1
 for <ltp@lists.linux.it>; Sat, 23 Sep 2023 05:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695472096; x=1696076896; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zwa6XoVK1ziuvDONBXKiRRHRuiPSZixDgSWLEksRRiU=;
 b=GTxTMhOyGSq6RHQRLp/9ughn/shmeo3QLG3SMUisnM6hxOath8xBliICIXGYNXaXl9
 pCmcBFp4nWC96M9K37ApwinN9U5qFxCaKLoo1Q7fCu7GftLmWlMY46IdbjDBcSLQW6fx
 IJrZGXZ7afWxrH9yxybUvihJHRLEFlsNKOjUyMgfyfc/FCovphDKL7Hf69dOifSbi5TQ
 N/DIfhkQK2ODQOH5V967iEpG/xATQngSBP1oe8r9fYEKYEK61QKM593HzooVKWmUy2/W
 rvyEGuDrsGk86XJh9zO/W6g3zhMw4+mRd8v3L2XENF5Ss0CcxmJYgh8IZMm0W+jaZygn
 oJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695472096; x=1696076896;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zwa6XoVK1ziuvDONBXKiRRHRuiPSZixDgSWLEksRRiU=;
 b=HDY9V2vUvsN2eIO+EzOH4swCcqw4SFPN3G8gHPKDWGqZtVMTTXrLpb54VFavH/UA6A
 w1QRLraaeVpoTcv7kmEAxbZ0GAxB20HU39kqms8xRfSbO89KTTjCLx+nUDMGJVqAruKC
 WAVkt+2xHKV8UOD0SQ9I3XNaTFXpAitF7UdzNxQyILvxmOt3/K7+977wnV+ICxCxNEBV
 Na2vngICewaigmdGk2EZ/piWNoS8RE5+1z2gQl5fDiqgvYGtxAaglC1lzOVSD/+NHheS
 R+WsFg5a5JaHqQiOc1pZXaoc/aVDGt4plEcwVMKnTpvWY1rSm7I06buaWtxVcIfEiPc4
 4+Hg==
X-Gm-Message-State: AOJu0YwMdq8+YkY2X9BzjDEUnO0DXAKA/J9ouFtKtaNyWqrvBM8Dgk3V
 g/2+WwolQqlXjhbyPYVMIIoGJlq/KtFwVGomufg=
X-Google-Smtp-Source: AGHT+IGRsVwUlFjXnCpLJv36iRn1OjKzC6b004++SMEaSjGVkHauYmLsW+N7rSV3hJxnb7ZO8tzNKBVmKnuWvfDlumc=
X-Received: by 2002:a05:6359:59e:b0:143:4e76:7e5b with SMTP id
 ee30-20020a056359059e00b001434e767e5bmr1405042rwb.3.1695472095863; Sat, 23
 Sep 2023 05:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com>
 <202309191018.68ec87d7-oliver.sang@intel.com>
 <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
 <ZQ1Z_JHMPE3hrzv5@yuki>
 <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <CAD_8n+SDoqUhR1+Gx15vOB5OvUL3eT5-UJb7JXOuRxVdrid5qA@mail.gmail.com>
In-Reply-To: <CAD_8n+SDoqUhR1+Gx15vOB5OvUL3eT5-UJb7JXOuRxVdrid5qA@mail.gmail.com>
From: Reuben Hawkins <reubenhwk@gmail.com>
Date: Sat, 23 Sep 2023 07:28:04 -0500
Message-ID: <CAD_8n+TOeQaU=ujeSfmNv53wwd158cN=1yVr8xdbASYZ1fEcMw@mail.gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, brauner@kernel.org, lkp@intel.com, willy@infradead.org,
 oe-lkp@lists.linux.dev, kernel test robot <oliver.sang@intel.com>,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU2F0LCBTZXAgMjMsIDIwMjMgYXQgNzoyMOKAr0FNIFJldWJlbiBIYXdraW5zIDxyZXViZW5o
d2tAZ21haWwuY29tPiB3cm90ZToKCj4KPgo+IE9uIFNhdCwgU2VwIDIzLCAyMDIzIGF0IDEyOjU2
4oCvQU0gQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KPiB3cm90ZToKPgo+PiBP
biBGcmksIFNlcCAyMiwgMjAyMyBhdCAxMToyOeKAr1BNIFJldWJlbiBIYXdraW5zIDxyZXViZW5o
d2tAZ21haWwuY29tPgo+PiB3cm90ZToKPj4gPgo+PiA+Cj4+ID4KPj4gPiBPbiBGcmksIFNlcCAy
MiwgMjAyMyBhdCA0OjA54oCvQU0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3Rl
Ogo+PiA+Pgo+PiA+PiBIaSEKPj4gPj4gPiBhY2suICBXaWxsIHRyeSB0byB0ZXN0LiAgTXkgVWJ1
bnR1IDIyLjA0IHN5c3RlbSB3YXNuJ3QgYWJsZSB0byBmaW5kCj4+ID4+ID4gcGFja2FnZXMgY2Fs
bGVkCj4+ID4+ID4gZm9yIGJ5IHRoZSB0ZXN0IGNhc2UsIHNvIGl0J2xsIHRha2UgbWUgYSBsaXR0
bGUgd2hpbGUgdG8gZmlndXJlIG91dAo+PiBob3cgdG8KPj4gPj4gPiBnZXQgdGhlCj4+ID4+ID4g
dGVzdCBjYXNlIHdvcmtpbmcuLi4KPj4gPj4KPj4gPj4gSHVoPyBUaGUgdGVzdCBpcyBhIHNpbXBs
ZSBDIGJpbmFyeSB5b3Ugc2hvdWxkbid0IG5lZWQgYW55dGhpbmcgbW9yZQo+PiA+PiB0aGFuOgo+
PiA+Pgo+PiA+PiAkIGdpdCBjbG9uZSBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9q
ZWN0L2x0cC5naXQKPj4gPj4gJCBjZCBsdHAKPj4gPj4gJCBtYWtlIGF1dG90b29scwo+PiA+PiAk
IC4vY29uZmlndXJlCj4+ID4+Cj4+ID4+ICQgY2QgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9y
ZWFkYWhlYWQKPj4gPj4gJCBtYWtlCj4+ID4+ICQgLi9yZWFkYWhlYWQwMQo+PiA+Pgo+PiA+PiBB
bmQgdGhpcyBpcyB3ZWxsIGRlc2NyaWJlZCBpbiB0aGUgcmVhZG1lIGF0Ogo+PiA+Pgo+PiA+PiBo
dHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC8KPj4gPj4KPj4gPj4gQW5k
IHRoZSBwYWNrYWdlcyByZXF1aXJlZCBmb3IgdGhlIGNvbXBpbGF0aW9uIGFyZSBtYWtlLCBDIGNv
bXBpbGVyIGFuZAo+PiA+PiBhdXRvdG9vbHMgbm90aGluZyBleHRyYW9yZGluYXJ5Lgo+PiA+Pgo+
PiA+IEF3ZXNvbWUuICBUaGF0IHdhcyBzaW1wbGVyIHRoYW4gd2hhdGV2ZXIgaXQgd2FzIEkgd2Fz
IHRyeWluZy4gIEkndmUKPj4gPiByZXByb2R1Y2VkIHRoZSBmYWlsZWQgdGVzdCBhbmQgd2lsbCB0
cnkgYSBmZXcgdmFyaWF0aW9ucyBvbiB0aGUgcGF0Y2guCj4+Cj4+IENvb2wuCj4+Cj4+IEZvciBw
ZW9wbGUgdGhhdCB3ZXJlIG5vdCBmb2xsb3dpbmcgdGhlIHBhdGNoIHJldmlldywKPj4gdGhlIGdv
YWwgaXMgbm90IHRvIHBhc3MgdGhlIGV4aXN0aW5nIHRlc3QuCj4+Cj4+IFdlIGRlY2lkZWQgdG8g
ZGVsaWJlcmF0ZWx5IHRyeSB0aGUgY2hhbmdlIG9mIGJlaGF2aW9yCj4+IGZyb20gRUlOVkFMIHRv
IEVTUElQRSwgdG8gYWxpZ24gd2l0aCBmYWR2aXNlIGJlaGF2aW9yLAo+PiBzbyBldmVudHVhbGx5
IHRoZSBMVFAgdGVzdCBzaG91bGQgYmUgY2hhbmdlZCB0byBhbGxvdyBib3RoLgo+Pgo+PiBJdCB3
YXMgdGhlIHRlc3QgZmFpbHVyZSBvbiB0aGUgc29ja2V0IHRoYXQgYWxhcm1lZCBtZS4KPj4gSG93
ZXZlciwgaWYgd2Ugd2lsbCBoYXZlIHRvIHNwZWNpYWwgY2FzZSBzb2NrZXQgaW4KPj4gcmVhZGFo
ZWFkKCkgYWZ0ZXIgYWxsLCB3ZSBtYXkgYXMgd2VsbCBhbHNvIHNwZWNpYWwgY2FzZQo+PiBwaXBl
IHdpdGggaXQgYW5kIHJldGFpbiB0aGUgRUlOVkFMIGJlaGF2aW9yIC0gbGV0J3Mgc2VlCj4+IHdo
YXQgeW91ciBmaW5kaW5ncyBhcmUgYW5kIGRlY2lkZS4KPj4KPj4gVGhhbmtzLAo+PiBBbWlyLgo+
Pgo+Cj4gSSBkb24ndCB3YW50IHRvIGNoYW5nZSB0aGUgYmVoYXZpb3Igb3RoZXIgdGhhbiB0byBm
aXggcmVhZGFoZWFkIG9uIGJsb2NrCj4gZGV2aWNlcy4gIElmIHdlIGNoYW5nZSB0aGUgdGVzdCBu
b3cgd2UncmUgbGlrZWx5IHRvIGZpbmQgb3V0IHRoYXQgd2UgYnJva2UKPiBzb21lYm9keSdzIGFw
cGxpY2F0aW9uIHdobyBoYXJkY29kZWQgdGhlIHJldHVybiB2YWx1ZSBoYW5kbGluZyBvZiByZWFk
YWhlYWQKPiB0byBsb29rIHNwZWNpZmljYWxseSBmb3IgcmMgIT0gRUlOVkFMLgo+Cj4gSSB0aGlu
ayBteSB2MSBwYXRjaCwgaW4gdGhpcyByZWdhcmQsIGlzIGJldHRlciB0aGFuIHRoZSB2MiBwYXRj
aC4gIEl0Cj4gZG9lc24ndAo+IGJyZWFrIHRoZSB0ZXN0LiAgSXQgZG9lc24ndCBtYWtlIHRoZSBy
ZWFkYWhlYWQgbWFuIHBhZ2Ugd3JvbmcuICAgQW5kIGl0Cj4gZml4ZXMKPiByZWFkYWhlYWQgb24g
YmxvY2sgZGV2aWNlcy4gICAuLi5ob3dldmVyIEkgdGhpbmsgSSBoYWQgYSB0eXBvIGluIHRoZSB2
MQo+IHBhdGNoLAo+IHNvIEkgdGhpbmsgd2hhdCBJJ2xsIGRvIGlzIHJlc3VibWl0IHRoZSB2MSBw
YXRjaCBhcyB2MyB3aXRoIHRoZSB0eXBvZXMKPiBmaXhlZC4KPiBJIHRoaW5rIEkgaGFkIEZfSVNS
RUcgdnMgU19JU1JFRyBpbiBhIGNvdXBsZSBwbGFjZXMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLgo+
Cj4gLVJldWJlbgo+CgpJIG1heSBoYXZlIHRvIHJldHJhY3QgbXkgbGFzdCBtZXNzYWdlIGJlY2F1
c2UgaXQgYXBwZWFycyB0byBtZSB0aGUgdjIgcGF0Y2gKanVzdCBwYXNzZWQgdGhlIHRlc3QgaW4g
dGhlIGxhdGVzdCBrZXJuZWwgSSBidWlsdCBsYXN0IG5pZ2h0LiAgV2lsbCBoYXZlIHRvCmRvdWJs
ZSBjaGVjayBleGFjdGx5IHdoYXQgaGFwcGVuZWQgYWZ0ZXIgY29mZmVlLgoKLVJldWJlbgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
