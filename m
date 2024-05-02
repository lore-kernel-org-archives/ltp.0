Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A65C4345F
	for <ltp@archiver.kernel.org>; Thu,  2 May 2024 09:13:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 970073CC0EA
	for <ltp@archiver.kernel.org>; Thu,  2 May 2024 11:13:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 885B03CB80F
 for <ltp@lists.linux.it>; Thu,  2 May 2024 11:13:03 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=fstornio@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B9A8A206C46
 for <ltp@lists.linux.it>; Thu,  2 May 2024 11:13:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714641180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RB+7gFrp/vmilQMUivFwehD9A3WVgP3RvMoIhpBzsak=;
 b=SPj/vbAniHwz8KieUYX730BgkHMsncmklqnXIJGKef+2jql5odt9RnAWpeylSLh3108NFb
 zuO3yNAt0piBKhl53/JBE56OKHJJZ/ACzFQoUJOe8kgGkqNzwVF2ofBsAsQfv6ACnhEqmW
 fzKc8w0ul+x6AMCp9wt8OXRK1lYT0Tk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-tqrejNerMtuS7Z1gmWyVyA-1; Thu, 02 May 2024 05:12:59 -0400
X-MC-Unique: tqrejNerMtuS7Z1gmWyVyA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-416e58bdc1eso39181835e9.3
 for <ltp@lists.linux.it>; Thu, 02 May 2024 02:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714641178; x=1715245978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RB+7gFrp/vmilQMUivFwehD9A3WVgP3RvMoIhpBzsak=;
 b=iopt2F0URmV2ySg1K6SR8bstv01gHY0Tb4uzgbQCw+9N8BzANswJxb3n3EBCLf91Es
 TLBCUqeB4EGQ9NDt2EINsjEP7JY8j5mrAQ63tnejp7ZAVwkJGFwGdCRztpaVVpWTcjMR
 SPbE47FoMGXIa0k4hfrKyC6q2vyULP07HOxVtaFZkSSHZ76HhzkAT/CgcWjBruhNA9Hy
 eWiLp7KcaeB3/iq251VH/2YVhW13e1/xT0MiCeQM+tJnowMRyrRVCUhdd4qPXHLXH3Gi
 VFa9rGwCOINFGKKXUi6VTyBS9DEdimowyUQjGyAqpwGoLDIMuLi5kO8Q6zceoyGV4hmQ
 B2KQ==
X-Gm-Message-State: AOJu0Yx99o5zPt+8bLuT5IKW1GHAkbgN28LTEcpSUr8tUdfhgR4Rf/0j
 PkV/cEGQOyZ0BXtHknFyd2l13uGAGmpvdBjML0Aki7qAHgPE6mRS0uhM+u2sZTRJAMNfJVe+o7o
 u8moDzPDQuC0rKPAOr6I6rkEMCRp5jT4gJDkvXMHCC+hKBGv6pDh0dnWlMJqL0CJNHvcuW2S8/i
 D3kZriNWpoe2b7uFbaDljv47A=
X-Received: by 2002:a05:600c:a09:b0:416:9b7f:7098 with SMTP id
 z9-20020a05600c0a0900b004169b7f7098mr1073868wmp.24.1714641178049; 
 Thu, 02 May 2024 02:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr0ifucPS6D6+dmwgIyZGxngg5XPUDb2NbtOoDkromytR0/aVDoB5hEmx2DFH9hWRVuP0riWRM09/tMBoi4hE=
X-Received: by 2002:a05:600c:a09:b0:416:9b7f:7098 with SMTP id
 z9-20020a05600c0a0900b004169b7f7098mr1073698wmp.24.1714641172924; Thu, 02 May
 2024 02:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240429133336.3166386-1-fstornio@redhat.com>
 <Zi-lJZW244sciuW9@yuki>
In-Reply-To: <Zi-lJZW244sciuW9@yuki>
From: Filippo Storniolo <fstornio@redhat.com>
Date: Thu, 2 May 2024 11:12:42 +0200
Message-ID: <CAHzY_-7DrwOOtawRziNo0CRS=VbEeNWF_sX_COpPaw_9s+J2nw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] syscalls/mlock05: add mlock test for locking
 and pre-faulting of memory
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

SGkgQ3lyaWwsIHRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcuCgpBZnRlciBzb21lIGludmVzdGln
YXRpb24sIEkgcmVhbGl6ZWQgdGhlIGlzc3VlIGlzIGNhdXNlZCBieSB0aGUKdW5yZWxpYWJpbGl0
eSBvZiB0aGUgVm1SU1MgZmllbGQgaW4gL3Byb2MvJHBpZC9zdGF0dXMuCkRvY3VtZW50YXRpb24g
c3VnZ2VzdHMgdG8gdXNlIC9wcm9jLyRwaWQvc21hcHMgZm9yIHJlbGlhYmxlIGluZm9ybWF0aW9u
LgoKVGhpcyBmaWxlIGNvbnRhaW5zIGluZm9ybWF0aW9uIGFib3V0IGVhY2ggbWVtb3J5IG1hcHBp
bmcsIHNvIGl0IGNvbnRhaW5zCm11bHRpcGxlIGluc3RhbmNlcyBvZiB0aGUgVm1Sc3MgZmllbGQg
KEluIHRoaXMgZmlsZSBpcyBzaW1wbHkgcmVmZXJyZWQgYXMKUnNzKS4KCkkgbWFuYWdlZCB0byBy
dW4gdGhlIHRlc3Qgd2l0aG91dCBhbnkgZmFpbHVyZXMgdXNpbmcgYSBjdXN0b20gZnVuY3Rpb24u
CldoYXQgd2UgbmVlZCB0byBkbyBpcyB0byBpdGVyYXRlIHRocm91Z2ggdGhlIG1lbW9yeSBtYXBw
aW5ncyB1bnRpbCB3ZSBmaW5kCnRoZSBvbmUgd2UgbmVlZC4gV2UgY2FuIHVzZSB0aGUgbWVtb3J5
IGFkZHJlc3MgcmV0cmlldmVkIGJ5IG1tYXAgdG8gbG9jYXRlCnRoZSBkZXNpcmVkIG9uZS4KCk9u
Y2Ugd2UgZmluZCB0aGUgbWFwcGluZywgd2UgY2FuIHRoZW4gc2VhcmNoIHRoZSBSc3MgZmllbGQu
CgpUaGlzIGlzIHRoZSBvdXRwdXQgSSBoYWQgdXNpbmcgdGhpcyBhcHByb2FjaDoKClRQQVNTOiBF
eHBlY3Q6IChWbVJTUz0xMDQ4NTc2KSA+PSAoTU1BUExFTj0xMDQ4NTc2KQpUUEFTUzogVm1MY2sg
PT0gTU1BUExFTiAoMTA0ODU3NikKClN1bW1hcnk6CnBhc3NlZCAgMjAwMDAKZmFpbGVkICAgMApi
cm9rZW4gICAwCnNraXBwZWQgIDAKd2FybmluZ3MgMAoKRG8geW91IHRoaW5rIHRoaXMgY2FuIHdv
cmsgYXMgYSBzb2x1dGlvbiBvciB5b3UgcHJlZmVyIGFub3RoZXIgd2F5IGFyb3VuZD8KCkYuIFN0
b3JuaW9sbwoKCgpPbiBNb24sIEFwciAyOSwgMjAyNCBhdCAzOjQ54oCvUE0gQ3lyaWwgSHJ1Ymlz
IDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IGNoZWNrIFZtUlNTIGFuZCBWbUxj
ayB2YXJpYWJsZXMgZnJvbSAvcHJvYy8kcGlkL3N0YXR1cy4KPiA+IFZtUlNTIHNpemUgc2hvdWxk
IGF0IGxlYXN0IGFzIGJpZyBhcyB0aGUgbWVtb3J5IGFsbG9jYXRpb24uCj4gPiBWbUxjayBzaXpl
IHNob3VsZCBiZSBlcXVhbCB0byB0aGUgc2l6ZSBvZiB0aGUgbWVtb3J5IGFsbG9jYXRpb24uCj4K
PiBOb3cgdGhlIHRlc3QgbG9va3MgZ29vZCwgaG93ZXZlciBJIG1hbmFnZWQgdG8gbWFrZSBpdCBm
YWlsLiBUaGUgdGVzdAo+IGZhaWxzIGlmIHlvdSBydW4gaXQgd2l0aCBsYXJnZSBlbm91Z2ggLWkg
cGFyYW1hdGVyLCBmb3IgbWUgcnVubmluZwo+ICcuL21sb2NrMDUgLWkgMTAwMDAnIHRlbmQgdG8g
cHJvZHVjZSBmYWlsdXJlcyBhdCB0aGUgZW5kIG9mIHRoZSB0ZXN0cnVuOgo+Cj4gdHN0X3Rlc3Qu
YzoxNzQxOiBUSU5GTzogTFRQIHZlcnNpb246IDIwMjQwMTI5LTE5Mi1nZWNhODAxMzIxCj4gdHN0
X3Rlc3QuYzoxNjI1OiBUSU5GTzogVGltZW91dCBwZXIgcnVuIGlzIDBoIDAwbSAzMHMKPiBtbG9j
azA1LmM6NDk6IFRQQVNTOiBFeHBlY3Q6IChWbVJTUz0xMDQ4NTc2KSA+PSAoTU1BUExFTj0xMDQ4
NTc2KQo+IG1sb2NrMDUuYzo1MjogVFBBU1M6IFZtTGNrID09IE1NQVBMRU4gKDEwNDg1NzYpCj4g
Li4uCj4gbWxvY2swNS5jOjUyOiBUUEFTUzogVm1MY2sgPT0gTU1BUExFTiAoMTA0ODU3NikKPiBt
bG9jazA1LmM6NDk6IFRGQUlMOiBFeHBlY3Q6IChWbVJTUz05ODMwNDApID49IChNTUFQTEVOPTEw
NDg1NzYpCj4gbWxvY2swNS5jOjUyOiBUUEFTUzogVm1MY2sgPT0gTU1BUExFTiAoMTA0ODU3NikK
PiBtbG9jazA1LmM6NDk6IFRGQUlMOiBFeHBlY3Q6IChWbVJTUz05ODMwNDApID49IChNTUFQTEVO
PTEwNDg1NzYpCj4gbWxvY2swNS5jOjUyOiBUUEFTUzogVm1MY2sgPT0gTU1BUExFTiAoMTA0ODU3
NikKPgo+IFN1bW1hcnk6Cj4gcGFzc2VkICAgMTgzMzIKPiBmYWlsZWQgICAxNjY4Cj4gYnJva2Vu
ICAgMAo+IHNraXBwZWQgIDAKPiB3YXJuaW5ncyAwCj4gLi4uCj4KPiAtLQo+IEN5cmlsIEhydWJp
cwo+IGNocnViaXNAc3VzZS5jego+Cj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
