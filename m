Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39E9C5B552
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 08:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749026404; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=yXfGclKZcUSRvbIxeMQsu3/vztlgFn7iQVrykhsMSDA=;
 b=P+hwGEZQ/R21IxJomyCOf93AoUCtL8s5zyucbMF40acdBffQBw4HtuRHo3YdmvInjVH8O
 lSQtRvKfezIS9A9CrLyN+fKIZFCe4AUgJfWLwpNMPxDvlKq/A6wpW9FpEN72yYSElp7AbUA
 qzWsOVkZPHPj8Wwm9L96ObpSrbaMR7k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1789D3CA10D
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 10:40:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E5613CA0F2
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 10:39:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4ECF7600832
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 10:39:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749026379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVLh0AtbeNb1sYLQH4WZAl5X45KFnir2/IaugMFHk8E=;
 b=AS2NTTutMzfmGx+5/G+hGRqLmoCgMns8yXmvE689uiRf/A6rQNDT9YMbN6kVri/1TxQghW
 q+0nImbQMOb8x55Pl8wzby6m/NSaYfwrcIdU/VfcDSYLDZQYKeCfhR8w9WIIKKRYOa5Aw3
 iqHLm6ekn+zxheSth7IdYD1ndi1M4vQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-VA_3mv8pPIOhERHR40uG3w-1; Wed, 04 Jun 2025 04:39:38 -0400
X-MC-Unique: VA_3mv8pPIOhERHR40uG3w-1
X-Mimecast-MFC-AGG-ID: VA_3mv8pPIOhERHR40uG3w_1749026377
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b26e0fee459so544977a12.1
 for <ltp@lists.linux.it>; Wed, 04 Jun 2025 01:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749026377; x=1749631177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EVLh0AtbeNb1sYLQH4WZAl5X45KFnir2/IaugMFHk8E=;
 b=fG9WIT9yOmJzCXfnVDsCw22cmH1DYLu1unVnL1cHretrcMrlZgU3R9/vIR7R/68Li8
 BOOVX8RMj5lVX/KuJZcIqxQkzaTFQSolokkzFLDsCEluMmlrAsx7yqOC4tQ5chUcUUdb
 5z9mYMy6JNWxmJafL+KIICLFr5vI5whkr/O5QzGmKkFloFuNR+0gNuejbjpVur2RZol/
 KdIpkEF3EER7lhkSpxCOU1AqW+kXbujpmpwn7dHi49pMJIATEMm3sNSPXNh53rHO1v6n
 o6e/VYEm3bEworNUUa3nw30YYoCR6aoXlOFHsmeFaoEmZ83V6isESANBFkyBLhGanuZf
 6mXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaUQwvwB7x5NFPUwX+sL6VOS65YCg5uzb931da8cf/CNAzmTZ1QXcG8Kx6Lgq2sbSTJgU=@lists.linux.it
X-Gm-Message-State: AOJu0YxdEyhR4zXOLGsh++6ZCRcKCGDZHe6eC/4DV/9ZnnmlLvpIOBar
 ZVoLhgHigG5OnNRNkyhQ1SUlMKWafRx3fzVDQb/s53b6YRlSHnIV89FwA7e8GkYJAxFhdnXKZis
 DVCgoK6rhnS35Evk0Zw0sSY5/d7WZs31vt61RPL1GnzP57rAk8orpP7lVnuHMm5kLD9E27guiBK
 Z0iEIC60QjswDgIKzOO5rwkzFsI3Y=
X-Gm-Gg: ASbGncs+sWiixnAdRTWCOW4qXM5+WsBBM8bhCd/S10yz8sZex90azm4IxyiRKASSSW1
 pTtlBYAiEB2FWtwhh22YSPvydVQf7pHZzlQeDISfZvFc9wU0U7Jm8+g8+cWOw6SOSfdFQNg==
X-Received: by 2002:a17:903:19cc:b0:234:9dce:74e3 with SMTP id
 d9443c01a7336-235c9ac27b2mr81241605ad.2.1749026376998; 
 Wed, 04 Jun 2025 01:39:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMetzrTN/mzDZd8crJsScneMVrc7+wvCfWFsWOyRYuT1p4IlpydZb7pA9Rqu0qcpnGQVh5zENDSOZZ1DNYbx8=
X-Received: by 2002:a17:903:19cc:b0:234:9dce:74e3 with SMTP id
 d9443c01a7336-235c9ac27b2mr81241355ad.2.1749026376598; Wed, 04 Jun 2025
 01:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250602170831.404641-1-pvorel@suse.cz>
 <aD7P6mPoJbe_CAgP@yuki.lan> <20250603161148.GA1080027@pevik>
In-Reply-To: <20250603161148.GA1080027@pevik>
Date: Wed, 4 Jun 2025 16:39:24 +0800
X-Gm-Features: AX0GCFujSyJTsZliu-eBlYsPAmv3ud8buZNjhaF7VhzAe9ml5h8Y0Qkgr7JiDzU
Message-ID: <CAEemH2f6GqpLcuoPYA-3WjWidOmgpQ8CrJ4Pw_fdEA7Bx7B7hA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I1Cs84UOOVMBToxVxLl2C6Z3QzZcVm8G_aUuXGGnmEw_1749026377
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] configure: Fix build on kernel 6.14 headers
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

T24gV2VkLCBKdW4gNCwgMjAyNSBhdCAxMjoxMuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgYWxsLAo+Cj4gPiBIaSEKPiA+IExldCdzIHB1c2ggdGhpcyBub3cs
IGl0J3Mgc2ltcGxlIGVub3VnaCBhbmQgZml4ZXMgdGhlIENJLgo+Cj4gSSdtIHNvcnJ5LCBpdCBk
aWQgbm90IGZpeCB0aGUgcHJvYmxlbSBkdWUgdGhlIG9sZCBwcm9ibGVtIG9mIGluZGlyZWN0Cj4g
aW5jbHVkZQo+IDxsaW51eC9tb3VudC5oPiBieSA8bGludXgvZnMuaD4gb24gQWxwaW5lIHYzLjIy
ICh0aGUgZGVmYXVsdCBBbHBpbmUKPiB2ZXJzaW9uIGluCj4gR2l0SHViIGFjdGlvbiksIHdoaWNo
IHVzZXMgNi4xNC4yIGtlcm5lbCBoZWFkZXJzOgo+Cj4gICAgIEluIGZpbGUgaW5jbHVkZWQgZnJv
bSAvdXNyL2luY2x1ZGUvbGludXgvZnMuaDoxOSwKPiAgICAgICAgICAgICAgICAgICAgICBmcm9t
IC91c3IvaW5jbHVkZS9saW51eC9idHJmcy5oOjI5LAo+ICAgICAgICAgICAgICAgICAgICAgIGZy
b20gc3RhdG1vdW50MDIuYzoyMzoKPiAgICAgL3Vzci9pbmNsdWRlL2xpbnV4L21vdW50Lmg6MTU1
Ojg6IGVycm9yOiByZWRlZmluaXRpb24gb2YgJ3N0cnVjdAo+IHN0YXRtb3VudCcKPiAgICAgICAx
NTUgfCBzdHJ1Y3Qgc3RhdG1vdW50IHsKPiAgICAgICAgICAgfCAgICAgICAgXn5+fn5+fn5+Cj4g
ICAgIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBzdGF0bW91bnQuaDoxMiwKPiAgICAgICAgICAgICAg
ICAgICAgICBmcm9tIHN0YXRtb3VudDAyLmM6MjA6Cj4gICAgIC4uLy4uLy4uLy4uL2luY2x1ZGUv
bGFwaS9tb3VudC5oOjU4Ojg6IG5vdGU6IG9yaWdpbmFsbHkgZGVmaW5lZCBoZXJlCj4gICAgICAg
IDU4IHwgc3RydWN0IHN0YXRtb3VudCB7Cj4gICAgICAgICAgIHwgICAgICAgIF5+fn5+fn5+fgo+
ICAgICAvdXNyL2luY2x1ZGUvbGludXgvbW91bnQuaDoxOTM6ODogZXJyb3I6IHJlZGVmaW5pdGlv
biBvZiAnc3RydWN0Cj4gbW50X2lkX3JlcScKPiAgICAgICAxOTMgfCBzdHJ1Y3QgbW50X2lkX3Jl
cSB7Cj4gICAgICAgICAgIHwgICAgICAgIF5+fn5+fn5+fn4KPiAgICAgLi4vLi4vLi4vLi4vaW5j
bHVkZS9sYXBpL21vdW50Lmg6NDk6ODogbm90ZTogb3JpZ2luYWxseSBkZWZpbmVkIGhlcmUKPiAg
ICAgICAgNDkgfCBzdHJ1Y3QgbW50X2lkX3JlcSB7Cj4gICAgICAgICAgIHwgICAgICAgIF5+fn5+
fn5+fn4KPgo+IEJ1dCB3ZSBzdGlsbCBzdXBwb3J0IG9sZCBMZWFwIDQyIChnbGliYyAyLjIyIGJh
c2VkKSwgd2hpY2ggcmVxdWlyZXMgZm9yCj4gc3RhdG1vdW50MDQuYyBvbGQgZmFsbGJhY2tzIGZv
ciA8c3lzL21vdW50Lmg+IGJ1dCBhbHNvIG5ldyBtb3VudCBBUEkKPiBkZWZpbmVkIGluIDxsaW51
eC9tb3VudC5oPiwgb3RoZXJ3aXNlIGl0IGZhaWxzOgo+Cj4gICAgIHN0YXRtb3VudDAzLmM6NjI6
NDogZXJyb3I6ICdNU19QUklWQVRFJyB1bmRlY2xhcmVkIGhlcmUgKG5vdCBpbiBhCj4gZnVuY3Rp
b24pCj4gICAgICAgeyBNU19QUklWQVRFLCBUU1RfVE9fU1RSXyhNU19QUklWQVRFKSB9LAo+ICAg
ICAgICAgXgo+ICAgICBzdGF0bW91bnQwMy5jOjYzOjQ6IGVycm9yOiAnTVNfU0hBUkVEJyB1bmRl
Y2xhcmVkIGhlcmUgKG5vdCBpbiBhCj4gZnVuY3Rpb24pCj4gICAgICAgeyBNU19TSEFSRUQsIFRT
VF9UT19TVFJfKE1TX1NIQVJFRCkgfSwKPiAgICAgICAgIF4KPiAgICAgc3RhdG1vdW50MDMuYzo2
NDo0OiBlcnJvcjogJ01TX1NMQVZFJyB1bmRlY2xhcmVkIGhlcmUgKG5vdCBpbiBhCj4gZnVuY3Rp
b24pCj4gICAgICAgeyBNU19TTEFWRSwgVFNUX1RPX1NUUl8oTVNfU0xBVkUpIH0sCj4gICAgICAg
ICBeCj4gICAgIEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuLi8uLi8uLi8uLi9pbmNsdWRlL3RzdF90
ZXN0Lmg6MTg1OjAsCj4gICAgICAgICAgICAgICAgICAgICAgZnJvbSBzdGF0bW91bnQuaDoxMSwK
PiAgICAgICAgICAgICAgICAgICAgICBmcm9tIHN0YXRtb3VudDA0LmM6MjE6Cj4gICAgIHN0YXRt
b3VudDA0LmM6IEluIGZ1bmN0aW9uICdzZXR1cCc6Cj4gICAgIHN0YXRtb3VudDAzLmM6NjU6NDog
ZXJyb3I6ICdNU19VTkJJTkRBQkxFJyB1bmRlY2xhcmVkIGhlcmUgKG5vdCBpbiBhCj4gZnVuY3Rp
b24pCj4gICAgICAgeyBNU19VTkJJTkRBQkxFLCBUU1RfVE9fU1RSXyhNU19VTkJJTkRBQkxFKSB9
LAo+ICAgICAgICAgXgo+ICAgICBzdGF0bW91bnQwNC5jOjU3OjM1OiBlcnJvcjogJ01TX0JJTkQn
IHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzCj4gZnVuY3Rpb24pCj4gICAgICAgU0FGRV9N
T1VOVChESVJfQSwgRElSX0EsICJub25lIiwgTVNfQklORCwgTlVMTCk7Cj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXgo+ICAgICAuLi8uLi8uLi8uLi9pbmNsdWRlL3Rz
dF9zYWZlX21hY3Jvcy5oOjI0NDoyNTogbm90ZTogaW4gZGVmaW5pdGlvbiBvZgo+IG1hY3JvICdT
QUZFX01PVU5UJwo+ICAgICAgICAgICAoZmlsZXN5c3RlbXR5cGUpLCAobW91bnRmbGFncyksIChk
YXRhKSkKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KPiAgICAgSW4gZmlsZSBpbmNs
dWRlZCBmcm9tIC4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0X3Rlc3QuaDoxODU6MCwKPiAgICAgICAg
ICAgICAgICAgICAgICBmcm9tIHN0YXRtb3VudC5oOjExLAo+ICAgICAgICAgICAgICAgICAgICAg
IGZyb20gc3RhdG1vdW50MDMuYzoyMToKPiAgICAgc3RhdG1vdW50MDMuYzogSW4gZnVuY3Rpb24g
J3J1bic6Cj4gICAgIHN0YXRtb3VudDA0LmM6NTc6MzU6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBp
ZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkKPiBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFw
cGVhcnMgaW4KPiAgICAgICBTQUZFX01PVU5UKERJUl9BLCBESVJfQSwgIm5vbmUiLCBNU19CSU5E
LCBOVUxMKTsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCj4gICAg
IC4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmg6MjQ0OjI1OiBub3RlOiBpbiBk
ZWZpbml0aW9uIG9mCj4gbWFjcm8gJ1NBRkVfTU9VTlQnCj4gICAgICAgICAgIChmaWxlc3lzdGVt
dHlwZSksIChtb3VudGZsYWdzKSwgKGRhdGEpKQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXgo+ICAgICBzdGF0bW91bnQwMy5jOjc0OjM1OiBlcnJvcjogJ01TX0JJTkQnIHVuZGVjbGFy
ZWQgKGZpcnN0IHVzZSBpbiB0aGlzCj4gZnVuY3Rpb24pCj4gICAgICAgU0FGRV9NT1VOVChESVJf
QiwgRElSX0EsICJub25lIiwgTVNfQklORCwgTlVMTCk7Cj4KPiBJIHN1cHBvc2Ugd2Ugc2hvdWxk
IGhhdmUgMiBvciAzIGxhcGkgZmlsZXM6Cj4KPiAxKSBsYXBpL21vdW50LmgKPiBtb3VudCBkZWZp
bml0aW9ucyAoZ3VhcmRlZCBieSAjaWZuZGVmKSAtIHRoZSBvbGQgb25lcyBmcm9tIDxzeXMvbW91
bnQuaD4KPiBlLmcuCj4gTVNfUkVDLCBNU19QUklWQVRFIGFuZCBwcm9iYWJseSB0aGUgbmV3IG9u
ZXMgZnJvbSA8bGludXgvbW91bnQuaD4sIGUuZy4KPiBNTlRfSURfUkVRX1NJWkVfVkVSMC4gTm9u
ZSBvZiA8c3lzL21vdW50Lmg+IDxsaW51eC9tb3VudC5oPiBzaG91bGQgYmUKPiBpbmNsdWRlZAo+
IGluIGl0Lgo+Cj4gMikgbGFwaS9saW51eF9tb3VudC5oCj4gbW91bnQgc3RydWN0cyAobm93YWRh
eXMgdmFzdCBtYWpvcml0eSBpZiBub3QgYWxsIGZyb20gPGxpbnV4L21vdW50Lmg+Cj4gb25seSku
Cj4gVGhpcyBoZWFkZXIgY2FuIGluY2x1ZGUgPGxpbnV4L21vdW50Lmg+IGFuZCBsYXBpL21vdW50
LmguCj4gVGhhdCBhbGxvd3MgdG8gaGF2ZSBjb25maWd1cmUuYWMgdG8gc2FmZWx5IHVzZSA8bGlu
dXgvbW91bnQuaD4gZm9yCj4gZGV0ZWN0aW9uLgo+Cj4gMykgbGFwaS9zeXNfbW91bnQuaAo+IE9w
dGlvbmFsIGhlbHBlciBoZWFkZXIgd2hpY2ggd291bGQgaW5jbHVkZSBsYXBpL21vdW50LmggYW5k
IDxzeXMvbW91bnQuaD4KPiAodG8ga2VlcCB0aGUgY3VycmVudCBhcHByb2FjaCB0aGF0IGxhcGkg
aGVhZGVycyBpbmNsdWRlIHN5c3RlbSBoZWFkZXJzIHNvCj4gdGhhdAo+IHRlc3RzIGRvZXMgbm90
IG5lZWQgdG8gZG8gaXQuCj4KPiBXRFlUPwo+CgpTb3VuZHMgcmVhc29uYWJsZSB0byBtZSwgd2Ug
Y291bGQgaGF2ZSBhIHRyeS4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
