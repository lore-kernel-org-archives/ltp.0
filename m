Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95315C5B549
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 13:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749042853; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=lGIgziSgKULHyyectxDX6+clTtUpIYaloGXoQHcLCBo=;
 b=mJ8NMqzwO3W4tWa7BuzBCkEqTk3iyVq3hyi9hkpM6BRezAmVnUOnuR538n7rg/LtPKw9D
 0ylswKvR118bPTrq6zCjqkgSzCnuGIe7AipFM7NQdGhp9OQf42ORqme6oBPtax+3mrEctB3
 BbHmY1mxm52fX8VQm54c2aCcHAOiSS4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6AEF3CA119
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 15:14:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3A743CA0F2
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 15:13:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 087321000A57
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 15:13:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749042831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9auusvDgdxJgzfVUqp0fp85gnsy8Z2RvMSr7ktT8lE=;
 b=LuaGe8ShBN2cLrR/teiOBQrKeQKWEOd6ZKn7J46lQ0UV/5E2vqWhE8hGnSnLX2mU2pFjil
 pIGno7Lrh0Egk6klyQ3jRGeWZyycycTtu73YzJ/PP18Cw/ZOeDIRpptxtkbCU5tJQHiZsF
 aesM1rgVQgMRN6PLtrvoAc8P8cXEkgQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-woX4Q8OQMfCJvi2PqKBVng-1; Wed, 04 Jun 2025 09:13:49 -0400
X-MC-Unique: woX4Q8OQMfCJvi2PqKBVng-1
X-Mimecast-MFC-AGG-ID: woX4Q8OQMfCJvi2PqKBVng_1749042828
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39ee4b91d1cso495069f8f.0
 for <ltp@lists.linux.it>; Wed, 04 Jun 2025 06:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749042827; x=1749647627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9auusvDgdxJgzfVUqp0fp85gnsy8Z2RvMSr7ktT8lE=;
 b=OBkiJnZ9enUyVGk/gi9/gytdqCet8abopDxVu3+WVOviwFX8uu3rWaX8CLUXQCV7+s
 VypT+99kri5UkuljSa/DTZv/c9rzgq2Sgf1GXNvZfrr1IMQzRi6fBrE6rFiZx3Fqg/HN
 nKIbpL/URjljGlyv9ZO+c3e2fiAlaKrG1Vkmq+VLC7ClZAdMu/jaUytqhmDt3VY+VxQW
 BdmAIDi3UJEpN+SrY1QAsAhLvCqlo5WoIzuzH5SlcTUG3pPu6R7cm7BN5d33EuAepr0f
 WN2IYRzNhFnF9N7QZF4rKskoqaP6DQt/fEDKZkrmJlcM2pZKn//O6fLovY5OvPFWmAYM
 idDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIpu45edopi0LxHTAy3CHjjCDC4y4FhrL13sDnvWaukjcbIbaMhJnpxD4MJAzer2AekXg=@lists.linux.it
X-Gm-Message-State: AOJu0Yyr4+0+eg3dC40vECjDhoKICkQtRlR8MvTFZwTuE2B4Fb+ABFoU
 eLgQr/hr4G6hqF2CmH4XlNlJM5KlFu/JHFticxNzhKrx8LiktoCbEF9DyIZyy8uJIYyeXQmBbNc
 mx4ABHfekvdn5aqRkZj9SjXo8ITnvklKvZXpUQf1C20NxDHWdld+Qxt2LGxWYo0z2d1G+X/Xxsc
 LK7DcSAhTuaIn4MEviF72W0b3eonk=
X-Gm-Gg: ASbGncvloUEVl6k7FofJyBSvDMO+ZP7SyjDA9W71HyJkOCWrwI+fNTY4NBRZPji+Mgg
 kXKp3voa2q09MjQd4dQQXvyZ0Vt80eNkMFpCeVXiOZo/xoS3gb+ix/fIDpquQobuBJ6Dt
X-Received: by 2002:a05:6000:420f:b0:3a4:d915:d652 with SMTP id
 ffacd0b85a97d-3a5141d0a12mr4928952f8f.29.1749042827592; 
 Wed, 04 Jun 2025 06:13:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsKLseQ0doTiHFJ2d98uIL8hZX/TAVVSg/qupFF0g7UmoXzUxVJ/hAkGXOvmeHPxhSLYKqHjHZ2PH9uZyPBkw=
X-Received: by 2002:a05:6000:420f:b0:3a4:d915:d652 with SMTP id
 ffacd0b85a97d-3a5141d0a12mr4928932f8f.29.1749042827220; Wed, 04 Jun 2025
 06:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250602170831.404641-1-pvorel@suse.cz>
 <aD7P6mPoJbe_CAgP@yuki.lan> <20250603161148.GA1080027@pevik>
In-Reply-To: <20250603161148.GA1080027@pevik>
Date: Wed, 4 Jun 2025 15:13:30 +0200
X-Gm-Features: AX0GCFvd11EB4BLZZ0cscuvAalZ6lKBt6Kd9WQIettwOL-TgkoRXXb_bk9kUcQ8
Message-ID: <CAASaF6yU+s4ZHgSU5mvb+R4cZiamqqM0eN6sHQVTHH0TEP6uug@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VN7VIjeXmW8AOkSimvvYYAmKZjxpozqWgxKJt3MVx4w_1749042828
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdW4gMywgMjAyNSBhdCA2OjEy4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgo+Cj4gSGkgYWxsLAo+Cj4gPiBIaSEKPiA+IExldCdzIHB1c2ggdGhpcyBub3cs
IGl0J3Mgc2ltcGxlIGVub3VnaCBhbmQgZml4ZXMgdGhlIENJLgo+Cj4gSSdtIHNvcnJ5LCBpdCBk
aWQgbm90IGZpeCB0aGUgcHJvYmxlbSBkdWUgdGhlIG9sZCBwcm9ibGVtIG9mIGluZGlyZWN0IGlu
Y2x1ZGUKPiA8bGludXgvbW91bnQuaD4gYnkgPGxpbnV4L2ZzLmg+IG9uIEFscGluZSB2My4yMiAo
dGhlIGRlZmF1bHQgQWxwaW5lIHZlcnNpb24gaW4KPiBHaXRIdWIgYWN0aW9uKSwgd2hpY2ggdXNl
cyA2LjE0LjIga2VybmVsIGhlYWRlcnM6Cj4KPiAgICAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91
c3IvaW5jbHVkZS9saW51eC9mcy5oOjE5LAo+ICAgICAgICAgICAgICAgICAgICAgIGZyb20gL3Vz
ci9pbmNsdWRlL2xpbnV4L2J0cmZzLmg6MjksCj4gICAgICAgICAgICAgICAgICAgICAgZnJvbSBz
dGF0bW91bnQwMi5jOjIzOgoKZnJvbSBzdGF0bW91bnQwMi5jOgoKVGhlIGJ0cmZzIHZhbGlkYXRp
b24gaXMgY3VycmVudGx5IHNraXBwZWQgZHVlIHRvIHRoZSBsYWNrIG9mIHN1cHBvcnQgZm9yIFZG
UwouLi4KI2luY2x1ZGUgPGxpbnV4L2J0cmZzLmg+CgpEb2VzIHRoZSB0ZXN0IGFjdHVhbGx5IG5l
ZWQgbGludXgvYnRyZnMuaCA/Cgo+ICAgICAvdXNyL2luY2x1ZGUvbGludXgvbW91bnQuaDoxNTU6
ODogZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiAnc3RydWN0IHN0YXRtb3VudCcKPiAgICAgICAxNTUg
fCBzdHJ1Y3Qgc3RhdG1vdW50IHsKPiAgICAgICAgICAgfCAgICAgICAgXn5+fn5+fn5+Cj4gICAg
IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBzdGF0bW91bnQuaDoxMiwKPiAgICAgICAgICAgICAgICAg
ICAgICBmcm9tIHN0YXRtb3VudDAyLmM6MjA6Cj4gICAgIC4uLy4uLy4uLy4uL2luY2x1ZGUvbGFw
aS9tb3VudC5oOjU4Ojg6IG5vdGU6IG9yaWdpbmFsbHkgZGVmaW5lZCBoZXJlCj4gICAgICAgIDU4
IHwgc3RydWN0IHN0YXRtb3VudCB7Cj4gICAgICAgICAgIHwgICAgICAgIF5+fn5+fn5+fgo+ICAg
ICAvdXNyL2luY2x1ZGUvbGludXgvbW91bnQuaDoxOTM6ODogZXJyb3I6IHJlZGVmaW5pdGlvbiBv
ZiAnc3RydWN0IG1udF9pZF9yZXEnCj4gICAgICAgMTkzIHwgc3RydWN0IG1udF9pZF9yZXEgewo+
ICAgICAgICAgICB8ICAgICAgICBefn5+fn5+fn5+Cj4gICAgIC4uLy4uLy4uLy4uL2luY2x1ZGUv
bGFwaS9tb3VudC5oOjQ5Ojg6IG5vdGU6IG9yaWdpbmFsbHkgZGVmaW5lZCBoZXJlCj4gICAgICAg
IDQ5IHwgc3RydWN0IG1udF9pZF9yZXEgewo+ICAgICAgICAgICB8ICAgICAgICBefn5+fn5+fn5+
Cj4KPiBCdXQgd2Ugc3RpbGwgc3VwcG9ydCBvbGQgTGVhcCA0MiAoZ2xpYmMgMi4yMiBiYXNlZCks
IHdoaWNoIHJlcXVpcmVzIGZvcgo+IHN0YXRtb3VudDA0LmMgb2xkIGZhbGxiYWNrcyBmb3IgPHN5
cy9tb3VudC5oPiBidXQgYWxzbyBuZXcgbW91bnQgQVBJCj4gZGVmaW5lZCBpbiA8bGludXgvbW91
bnQuaD4sIG90aGVyd2lzZSBpdCBmYWlsczoKPgo+ICAgICBzdGF0bW91bnQwMy5jOjYyOjQ6IGVy
cm9yOiAnTVNfUFJJVkFURScgdW5kZWNsYXJlZCBoZXJlIChub3QgaW4gYSBmdW5jdGlvbikKPiAg
ICAgICB7IE1TX1BSSVZBVEUsIFRTVF9UT19TVFJfKE1TX1BSSVZBVEUpIH0sCj4gICAgICAgICBe
Cj4gICAgIHN0YXRtb3VudDAzLmM6NjM6NDogZXJyb3I6ICdNU19TSEFSRUQnIHVuZGVjbGFyZWQg
aGVyZSAobm90IGluIGEgZnVuY3Rpb24pCj4gICAgICAgeyBNU19TSEFSRUQsIFRTVF9UT19TVFJf
KE1TX1NIQVJFRCkgfSwKPiAgICAgICAgIF4KPiAgICAgc3RhdG1vdW50MDMuYzo2NDo0OiBlcnJv
cjogJ01TX1NMQVZFJyB1bmRlY2xhcmVkIGhlcmUgKG5vdCBpbiBhIGZ1bmN0aW9uKQo+ICAgICAg
IHsgTVNfU0xBVkUsIFRTVF9UT19TVFJfKE1TX1NMQVZFKSB9LAo+ICAgICAgICAgXgo+ICAgICBJ
biBmaWxlIGluY2x1ZGVkIGZyb20gLi4vLi4vLi4vLi4vaW5jbHVkZS90c3RfdGVzdC5oOjE4NTow
LAo+ICAgICAgICAgICAgICAgICAgICAgIGZyb20gc3RhdG1vdW50Lmg6MTEsCj4gICAgICAgICAg
ICAgICAgICAgICAgZnJvbSBzdGF0bW91bnQwNC5jOjIxOgo+ICAgICBzdGF0bW91bnQwNC5jOiBJ
biBmdW5jdGlvbiAnc2V0dXAnOgo+ICAgICBzdGF0bW91bnQwMy5jOjY1OjQ6IGVycm9yOiAnTVNf
VU5CSU5EQUJMRScgdW5kZWNsYXJlZCBoZXJlIChub3QgaW4gYSBmdW5jdGlvbikKPiAgICAgICB7
IE1TX1VOQklOREFCTEUsIFRTVF9UT19TVFJfKE1TX1VOQklOREFCTEUpIH0sCj4gICAgICAgICBe
Cj4gICAgIHN0YXRtb3VudDA0LmM6NTc6MzU6IGVycm9yOiAnTVNfQklORCcgdW5kZWNsYXJlZCAo
Zmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCj4gICAgICAgU0FGRV9NT1VOVChESVJfQSwgRElS
X0EsICJub25lIiwgTVNfQklORCwgTlVMTCk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXgo+ICAgICAuLi8uLi8uLi8uLi9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5o
OjI0NDoyNTogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyAnU0FGRV9NT1VOVCcKPiAgICAg
ICAgICAgKGZpbGVzeXN0ZW10eXBlKSwgKG1vdW50ZmxhZ3MpLCAoZGF0YSkpCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBeCj4gICAgIEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuLi8uLi8u
Li8uLi9pbmNsdWRlL3RzdF90ZXN0Lmg6MTg1OjAsCj4gICAgICAgICAgICAgICAgICAgICAgZnJv
bSBzdGF0bW91bnQuaDoxMSwKPiAgICAgICAgICAgICAgICAgICAgICBmcm9tIHN0YXRtb3VudDAz
LmM6MjE6Cj4gICAgIHN0YXRtb3VudDAzLmM6IEluIGZ1bmN0aW9uICdydW4nOgo+ICAgICBzdGF0
bW91bnQwNC5jOjU3OjM1OiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBv
cnRlZCBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgo+ICAgICAgIFNB
RkVfTU9VTlQoRElSX0EsIERJUl9BLCAibm9uZSIsIE1TX0JJTkQsIE5VTEwpOwo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KPiAgICAgLi4vLi4vLi4vLi4vaW5jbHVk
ZS90c3Rfc2FmZV9tYWNyb3MuaDoyNDQ6MjU6IG5vdGU6IGluIGRlZmluaXRpb24gb2YgbWFjcm8g
J1NBRkVfTU9VTlQnCj4gICAgICAgICAgIChmaWxlc3lzdGVtdHlwZSksIChtb3VudGZsYWdzKSwg
KGRhdGEpKQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgo+ICAgICBzdGF0bW91bnQw
My5jOjc0OjM1OiBlcnJvcjogJ01TX0JJTkQnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlz
IGZ1bmN0aW9uKQo+ICAgICAgIFNBRkVfTU9VTlQoRElSX0IsIERJUl9BLCAibm9uZSIsIE1TX0JJ
TkQsIE5VTEwpOwo+Cj4gSSBzdXBwb3NlIHdlIHNob3VsZCBoYXZlIDIgb3IgMyBsYXBpIGZpbGVz
Ogo+Cj4gMSkgbGFwaS9tb3VudC5oCj4gbW91bnQgZGVmaW5pdGlvbnMgKGd1YXJkZWQgYnkgI2lm
bmRlZikgLSB0aGUgb2xkIG9uZXMgZnJvbSA8c3lzL21vdW50Lmg+IGUuZy4KPiBNU19SRUMsIE1T
X1BSSVZBVEUgYW5kIHByb2JhYmx5IHRoZSBuZXcgb25lcyBmcm9tIDxsaW51eC9tb3VudC5oPiwg
ZS5nLgo+IE1OVF9JRF9SRVFfU0laRV9WRVIwLiBOb25lIG9mIDxzeXMvbW91bnQuaD4gPGxpbnV4
L21vdW50Lmg+IHNob3VsZCBiZSBpbmNsdWRlZAo+IGluIGl0Lgo+Cj4gMikgbGFwaS9saW51eF9t
b3VudC5oCj4gbW91bnQgc3RydWN0cyAobm93YWRheXMgdmFzdCBtYWpvcml0eSBpZiBub3QgYWxs
IGZyb20gPGxpbnV4L21vdW50Lmg+IG9ubHkpLgo+IFRoaXMgaGVhZGVyIGNhbiBpbmNsdWRlIDxs
aW51eC9tb3VudC5oPiBhbmQgbGFwaS9tb3VudC5oLgo+IFRoYXQgYWxsb3dzIHRvIGhhdmUgY29u
ZmlndXJlLmFjIHRvIHNhZmVseSB1c2UgPGxpbnV4L21vdW50Lmg+IGZvciBkZXRlY3Rpb24uCj4K
PiAzKSBsYXBpL3N5c19tb3VudC5oCj4gT3B0aW9uYWwgaGVscGVyIGhlYWRlciB3aGljaCB3b3Vs
ZCBpbmNsdWRlIGxhcGkvbW91bnQuaCBhbmQgPHN5cy9tb3VudC5oPgo+ICh0byBrZWVwIHRoZSBj
dXJyZW50IGFwcHJvYWNoIHRoYXQgbGFwaSBoZWFkZXJzIGluY2x1ZGUgc3lzdGVtIGhlYWRlcnMg
c28gdGhhdAo+IHRlc3RzIGRvZXMgbm90IG5lZWQgdG8gZG8gaXQuCj4KPiBXRFlUPwo+Cj4gS2lu
ZCByZWdhcmRzLAo+IFBldHIKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
