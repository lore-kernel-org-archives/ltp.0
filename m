Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CD6C36008
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 08:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742977646; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=kyWODbLi/IVIOdQpgMZtr+s8nvjdmYwnf2IqJvJXrBc=;
 b=lg6m9EyEdodznuQBSFSEJ7tCd/MXZm83pbgqg2A1XIjXbAP6N0tQHfKTHmegP7KkkFTeK
 NEf7Wuu2EvrCg9ebMdRAcjMeBiEQ/dGMZXrJAezKFnSQCQjlzxldl6GAswoSsbkRAYU9IWe
 +5Pcz+P7dDqfj3meorj5TXWAcocgJN0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68E743C9991
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 09:27:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4AA53C19F4
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 09:27:04 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 850C01000776
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 09:27:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742977621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nOtURhL/tC/qBGNPQ25K2nPTbkIHW+w3ZtFL1zD1wPY=;
 b=Oc3gciXUBq/FGjHRy+rvchuK8RuGpz7/hG9Aj31hAjMElXApSDUljEVFe9TcJL5P18bFPw
 Vcelv7TnI8myDuPLjn0IWrWh0P8t9fRFetPHngt90gIjTq3z06Gs64SwTLaZn243qlEVfM
 8LkP//Mqt1LoMp1ub87pntvbxC9AdWc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-8n_knLWpOdqCNuOqSa9VSg-1; Wed, 26 Mar 2025 04:27:00 -0400
X-MC-Unique: 8n_knLWpOdqCNuOqSa9VSg-1
X-Mimecast-MFC-AGG-ID: 8n_knLWpOdqCNuOqSa9VSg_1742977619
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5e6a340f8c7so5924189a12.2
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 01:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742977617; x=1743582417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nOtURhL/tC/qBGNPQ25K2nPTbkIHW+w3ZtFL1zD1wPY=;
 b=tptnCfuhx7s6JJMFMKo9HX+/diHsi8MJ5GZJLrOcxY6bUfEbGv5ZqW/1N2UD6vKGr5
 4RumTO3AnMOOJdcXqLy2z1aKHJX4SEVQuXh5KNbA+W2eDDeS82fmXkxKBw4cDDv+JA/B
 S1r8G7V/X+Oiugyc5x/+j2b6nmvzrSJDszyAAgnYhBRfweNfvtXhurt8asQcnXbBeLgv
 Gd/8KCYawQjKCTxh3hiH00sw1rDm/PpKo+E0yVhZiakHSM7v8oT1/rXUiYLZrK34Dgif
 xPOuaSwwdP5UWOJnFRhJtrHQcJIFpiYdJV3J1f3SQRoP2AUCk+xdKZpz+L49R4/uWz3Q
 fsmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjqi+bjO7HC9eyKjr+5bBy+6p3VbGSSno+d4oqQ51mGlIVvjoA2pu0JKUbWcfTvkIkSWs=@lists.linux.it
X-Gm-Message-State: AOJu0YwLMf5VNcflzrFoiS4kKjwCNrWXYB44i2bKlAepufJ9hW2O+/Bz
 1kpuOrIqRIKjFAj4NnQPxYBrMnVruIfOzBla3bRotpD/d+KbmCTRL2dB8Dfged/++5psfOMRRTc
 O4ZvZOgxL8xrmR7oFFZ7rkX5I6CHDZmLkgusKvVRuiatnuqJvIO6j9TXUN7L9yVgRxG6Xv9P2HS
 4W5tJzjbdFzzlmlEBRsq2CJagn5o9AXiiNAYAv
X-Gm-Gg: ASbGncvekmfiiQapDYI18fsD8Sos2JUjIWfCBk2DhgwskswFk0Vp/fU5Lf0MC+DarEv
 CfCmvmUMivKFuco+WFEmXBYAhxfD8vysQhHRlqTXrEaDg9Ep7JcCbFz3Go2DQnpQOff7FjO+b1w
 ==
X-Received: by 2002:a17:907:7e5e:b0:ab7:fbb2:b465 with SMTP id
 a640c23a62f3a-ac3f27fd5e2mr2179489266b.49.1742977617236; 
 Wed, 26 Mar 2025 01:26:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6wRT1TSidZjowsuDEkQTv5lJUvpDu8Mt6ODLS48cLbivXzJ2NEknB9+ueF1jfu4XfGygTm8Y/qng9NWcGYiY=
X-Received: by 2002:a17:907:7e5e:b0:ab7:fbb2:b465 with SMTP id
 a640c23a62f3a-ac3f27fd5e2mr2179482566b.49.1742977615279; Wed, 26 Mar 2025
 01:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250305050805.7905-1-wegao@suse.com>
 <20250324120049.29270-1-wegao@suse.com>
 <20250324120049.29270-2-wegao@suse.com> <20250325140018.GA448693@pevik>
 <Z+N/LjYbZJKq3qsS@wegao>
 <CAEemH2dNduMxZZzvC-ENpCMLcrD7CXYuV8iLsRJXisRu6LLSLA@mail.gmail.com>
In-Reply-To: <CAEemH2dNduMxZZzvC-ENpCMLcrD7CXYuV8iLsRJXisRu6LLSLA@mail.gmail.com>
Date: Wed, 26 Mar 2025 16:26:41 +0800
X-Gm-Features: AQ5f1JrTBfowzSm6rTtRUO4JI1GBE-rhXvy-Ef1x1dkwrXktvXADMIZ51lme9B0
Message-ID: <CAEemH2cOLLxrfzFmq1OZPxmOtKY_x3dL0Jags9uYeJ5xo1F6Vg@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 15WtxDYwzGxBaZiNcZKrPfKbbliIqQ7EZXQHtHpc2Tk_1742977619
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v7 1/2] cpuset02: Convert the test6 from
 cpuset_memory_testset.sh to C code
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

SGkgV2VpLAoKT24gV2VkLCBNYXIgMjYsIDIwMjUgYXQgMzozOOKAr1BNIExpIFdhbmcgPGxpd2Fu
Z0ByZWRoYXQuY29tPiB3cm90ZToKCj4KPgo+IE9uIFdlZCwgTWFyIDI2LCAyMDI1IGF0IDEyOjE1
4oCvUE0gV2VpIEdhbyB2aWEgbHRwIDxsdHBAbGlzdHMubGludXguaXQ+Cj4gd3JvdGU6Cj4KPj4g
T24gVHVlLCBNYXIgMjUsIDIwMjUgYXQgMDM6MDA6MThQTSArMDEwMCwgUGV0ciBWb3JlbCB3cm90
ZToKPj4gPiBIaSBXZWksCj4+ID4KPj4gPiAuLi4KPj4gPiA+ICtzdGF0aWMgdm9pZCBydW5fdGVz
dCh2b2lkKQo+PiA+ID4gK3sKPj4gPiA+ICsgICBpbnQgcGlkOwo+PiA+ID4gKyAgIGNoYXIgbm9k
ZV9pZF9zdHJbMjU2XTsKPj4gPiA+ICsKPj4gPiA+ICsgICBjZ19jcHVzZXRfMCA9IHRzdF9jZ19n
cm91cF9tayh0c3RfY2csICIwIik7Cj4+ID4gPiArCj4+ID4gPiArICAgc3ByaW50Zihub2RlX2lk
X3N0ciwgIiV1IiwgY2hlY2tfbm9kZV9pZCk7Cj4+ID4gPiArICAgU0FGRV9DR19QUklOVChjZ19j
cHVzZXRfMCwgImNwdXNldC5tZW1zIiwgbm9kZV9pZF9zdHIpOwo+PiA+ID4gKyAgIFNBRkVfRklM
RV9QUklOVEYoIi9wcm9jL3N5cy92bS9ucl9odWdlcGFnZXMiLCAiJWQiLCAxKTsKPj4gPgo+PiA+
IFlvdSBjaGFuZ2VkIHRoZSAvcHJvYy9zeXMvdm0vbnJfaHVnZXBhZ2VzIHRvIDEsIGJlY2F1c2Ug
Q3lyaWwgb2JqZWN0ZWQKPj4gdGhlIGNvZGUKPj4gPiBpbiB2NjoKPj4gPgo+PiA+IFNBRkVfRklM
RV9QUklOVEYoIi9wcm9jL3N5cy92bS9ucl9odWdlcGFnZXMiLCAiJWQiLCAyICogbm9kZS0+Y250
KTsKPj4gPgo+PiA+IEJ1dCBhcyBJIG5vdGUgdGhlcmUgWzFdLCB0aGUgb3JpZ2luYWwgc2hlbGwg
dGVzdCBkaWQgaXQgdGhpcyB3YXkgYW5kCj4+IGtlcm5lbCBkb2NzCj4+ID4gYWxsb3dzIG1vcmUg
dGhhbiAxIHRvIGFsbG9jYXRlLiBJJ20gb2J2aW91c2x5IG1pc3Npbmcgc29tZXRoaW5nLgo+PiA+
Cj4+ID4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yMDI1MDMyNTEzMzYxMS5HQjM3
MjQxN0BwZXZpay8KPj4gPgo+PiBNeSB1bmRlcnN0YW5kaW5nIGZyb20gQ3lyaWwncyBjb21tZW50
cyBpcyBubyBuZWVkIHJlc2VydmUgbW9yZSBodWdlcGFnZXMsCj4+IHNpbmNlCj4+IHRoaXMgdGVz
dCBjYXNlIE9OTFkgYWxsb2NhdGUgMSBwYWdlIHRocm91Z2ggbW1hcC4KPgo+Cj4gSXQgZGVwZW5k
cyBvbiB3aGF0IHlvdSB3YW50ZWQgdGhlcmUsIGlmIG9ubHkgMSBnZW5lcmFsIGh1Z2UgcGFnZSwK
PiAgYGVjaG8gMSA+IC9wcm9jL3N5cy92bS9ucl9odWdlcGFnZXNgIHdpbGwgdHJ5IHRvIHJlc2Vy
dmUgMQo+IGZyb20gYSBOVU1BIG5vZGUgcmFuZG9tbHkuCj4KPiBCdXQgaWYgeW91IHByZWZlciB0
byBnZXQgMSBodWdlcGFnZSBmcm9tIGEgc3BlY2lmaWVkIG5vZGUsIHdlIG5lZWQ6Cj4gIGBlY2hv
IDEgPgo+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlJXUvaHVnZXBhZ2VzL2h1Z2VwYWdl
cy0lZGtCL25yX2h1Z2VwYWdlc2AKPgo+IEhvd2V2ZXIsIGJvdGggd2F5cyB3b24ndCBndWFyYW50
ZWUgdGhlIHJlc2VydmF0aW9uIHdpbGwgYmUgMTAwJSBzdWNjZXNzZnVsLAo+IHdoaWNoIGlzIGJh
c2VkIG9uIHRoZSBtZW1vcnkgZnJhZ21lbnRhdGlvbiBzaXR1YXRpb25zLgo+Cj4gVG8gYmUgb24g
dGhlIHNhZmUgc2lkZSwgSSB3b3VsZCBzdWdnZXN0IHVzaW5nIExUUCB1bmlmaWVkIEFQSSB0byBy
ZXNlcnZlOgo+Cj4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvYmxv
Yi9tYXN0ZXIvZG9jL29sZC9DLVRlc3QtQVBJLmFzY2lpZG9jIzEzNC1yZXNlcnZpbmctaHVnZXBh
Z2VzCj4KPiBZb3UgY291bGQgcmVmZXJlbmNlIHVzYWdlIGZyb206Cj4gICBtZW0vaHVnZXRsYi9o
dWdlbW1hcC9odWdlbW1hcDE2LmMsCj4gICBzeXNjYWxscy9tb3ZlX3BhZ2VzL21vdmVfcGFnZXMx
Mi5jCj4KCgpJIGxvb2tlZCB0aHJvdWdoIGFsbCB0aGUgY29kZSBhbmQgZ290IHlvdXIgcmVxdWly
ZW1lbnRzIGhlcmUuClRoZSBvcmlnaW5hbCB0ZXN0NiBpcyBlY2hvaW5nICcyKiRucl9tZW1zJyB0
byB0aGUgd2hvbGUgc3lzdGVtCnRvIG1ha2UgZWFjaCBub2RlIHJlc2VydmUgc29tZSBwYWdlcywg
dGhlbiBkb2luZyBodWdldGxiZnNmaWxlCm1hcHBpbmcgdG8gdmVyaWZ5IHRoYXQgdGhlIHJlYWwg
YWxsb2NhdGVkIFBBR0Ugd2FzIGhhcHBlbmluZwpvbiB0aGUgQ2dyb3VwIHNldCBub2RlLgoKKEJ1
dCB0aGUgZGVmZWN0IGlzIHRoYXQgICcyKiRucl9tZW1zJyBwcm9iYWJseSBkb2VzIG5vdCBkaXN0
cmlidXRlIHRvIGVhY2gKbm9kZSBpZGVhbGx5Lgp3ZSBzaG91bGQgcmVzb2x2ZSB0aGlzIGluIHRo
ZSBuZXcgdGVzdCkKCkFuZCB0aGF0IGNvdWxkIGJlIGVhc3kgdG8gY29udmVydCBpbnRvIHlvdXIg
QyBjcHVzZXQwMiB0ZXN0LCBqdXN0CmVjaG8gYXQgbGVhc3QgMSBucl9odWdlcGFnZXMgaW4gZWFj
aCBOVU1BIG5vZGUsIGFuZCBiaW5kaW5nIHRoZQpjaGlsZCBhbGxvY2F0aW5nIHByb2Nlc3MgdG8g
dGhlIGV4cGVjdGVkIENHcm91cCBzZXQsIHRoZW4gdmVyaWZ5CnRoYXQgb25seSAxIGh1cGFnZSBp
cyByZWFsbHkgYWxsb2NhdGVkIGluIHRoZSBjb3JyZWN0IG5vZGUuCgpUbyBzaG93IHRoZSBpZGVh
IG9uIGEgdHdvLW5vZGUgc3lzdGVtIGlzOgoKMS4gUmVzZXJ2ZSBhdCBsZWFzdCAxIGhwYWdlIG9u
IGVhY2ggbm9kZSBhbmQgY2hlY2sgdGhlIHZhbHVlIGlzIGNvcnJlY3QuCiAgZWNobyAxID4KL3N5
cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUwL2h1Z2VwYWdlcy9odWdlcGFnZXMtJWRrQi9ucl9o
dWdlcGFnZXMKICBlY2hvIDEgPgovc3lzL2RldmljZXMvc3lzdGVtL25vZGUvbm9kZTEvaHVnZXBh
Z2VzL2h1Z2VwYWdlcy0lZGtCL25yX2h1Z2VwYWdlcwoKMi4gQWZ0ZXIgZm9sa2luZywgYmluZCB0
aGUgY2hpbGQgdG8gdGhlIGNncm91cC5wcm9jcy4KCjMuIERvIG1tYXAgaW4gdGhlIGNoaWxkIHdp
dGggaHVnZXRsYmZzIGZpbGUgbWFwcGluZyAoZm9yIGFsbG9jYXRpbmcgdGhlIDEKaHVhZ2UgcGFn
ZSkuCgo0LiBUb3VjaCB0aGUgbWVtb3J5IGFuZCB2ZXJpZnkgdGhhdCBvbmx5IDEgaHVnZSBwYWdl
IGlzIGFsbG9jYXRlZCBpbiB0aGUKZXhwZWN0ZWQgbm9kZS4KCgoKCj4KPgo+Cj4+Cj4+IEBDeXJp
bCBjb3VsZCB5b3UgaGVscCBjb25maXJtIHRoaXM/Cj4+Cj4+ID4KPj4gPiBLaW5kIHJlZ2FyZHMs
Cj4+ID4gUGV0cgo+Pgo+PiAtLQo+PiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAKPj4KPj4KPgo+IC0tCj4gUmVnYXJkcywKPiBMaSBXYW5nCj4K
CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
