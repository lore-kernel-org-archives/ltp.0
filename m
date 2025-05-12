Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DBDC3ABBC
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 08:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747039482; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=H144Pt3FSRFXySaTJZHHvO7yFnU2dlC4Hkg+gJGjOQ8=;
 b=lMYGMu1IBMkHWeUoABi4YuijQeRRgOEhgyr5jp60/P/A83KLpzMJtgsd/dVLgtKbgBok1
 a9IGsEl13obIjSCHRbxiQuy3URhx8Ae4woqrU+kbXGLif3C57JsrZuOtAC+DcnwQ3AbwOkl
 2sYtHAVH+zWCo1Oqn7UX/21j+cg2iM0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B64B73CC28E
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 10:44:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74A9E3C9B4A
 for <ltp@lists.linux.it>; Mon, 12 May 2025 10:44:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8909B1400428
 for <ltp@lists.linux.it>; Mon, 12 May 2025 10:44:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747039457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xyz2NQ8GGnNJBWmUULJ+e17szx1pBupAj1pRmiLu3Ss=;
 b=AFPYPpjj1amUgC4tScVq/qT1YIQfYSTWQypAP+iCIG2nmrRSEhLbtWATqjucLf+SczZ924
 H971kAl6iUrCmw3ED45Qa51XAeAra7AchIZV/jZSir35tNEljTaxAmUKOtKeAJft3O0UFj
 0rO/QDzBUfxduAdmDrNjxEb8fJ+7cvI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-oYAsU4nyOymzUqTKwCcL-Q-1; Mon, 12 May 2025 04:44:15 -0400
X-MC-Unique: oYAsU4nyOymzUqTKwCcL-Q-1
X-Mimecast-MFC-AGG-ID: oYAsU4nyOymzUqTKwCcL-Q_1747039454
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a1f6c5f4f2so952833f8f.2
 for <ltp@lists.linux.it>; Mon, 12 May 2025 01:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039454; x=1747644254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xyz2NQ8GGnNJBWmUULJ+e17szx1pBupAj1pRmiLu3Ss=;
 b=e5p8xfL9K50QOKlku5Vl5SvBYd5MV5QV0mo4a6Fpnu/ljotLZyxSyenQXkCHqfeuVF
 LUQURDUEVEq5lNzvgoKsKsNYiY+QXChnKRXkQpLYsulwJCQ2hHWwzDTfDuKrXVrTrnNb
 Ue2Ckx0JqI0a86Sg8sWt/vpN4rsEKLpolSH3SXUimUKCRTNYt0CiKn4Z5SMEmqhI2tQf
 Cns0DlZDDPQ7215DHTVvFgCtFp1Oj4/J/qGm1KTMxxK1iNKiyPUuqsfhGg/RFo5xNOb0
 Je85qkwpzb/TUm5dlWarV2FSH70P+wCY+vRP2yCM+mNDGsLK9IiYTcek2FTgbr8VXAOJ
 EdaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7Ni/3UKO9fclNIJ6xXpkdft/WdfYb24hqDu1jPQvz1hBNgG0RSyXg817uxDZZdOwSVWY=@lists.linux.it
X-Gm-Message-State: AOJu0Ywn4uDflVtY3GQ79BR/I/yrYKvvac2cGPqt+oirrxTfsuKNKkuf
 dldbq6ksVD4XF5Q4jdJnqPQ6GEwL+cDAQn3CRmtZG68SehUFkMlt3+CODmRFcapmI/tuy6zXHUd
 3sGvdtpNjgrpPCemdCRaJvFGqbrLFtGDbmYqYZ4SLwWBJbL33utAxEldNwup12Tqfepa8NZQDbb
 arId/jUu/eZe7T8AiJ+mrZEys=
X-Gm-Gg: ASbGncuZrp6gIwqsGO1092GjIRYMwkFchnexhKJt2gK88WwGXj5co7Z9QfCuaG+Kd4v
 1yy6CSMA7XxjaFVRSjw/B16G94+CNmArTq8mmz3t0RNSXT0xcGRcoYvvMzrZozK2NB1ZV
X-Received: by 2002:a05:6000:2283:b0:3a2:12a:e631 with SMTP id
 ffacd0b85a97d-3a2012ae77emr4848647f8f.22.1747039453951; 
 Mon, 12 May 2025 01:44:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8WMbEiRG6RJ9MQjeh4VDh5N0Sw7YA92gR62kw8bEqnKdNb4zGr3m7GTUbs3lTrNdg5HcvxKS60ev3ordhKcU=
X-Received: by 2002:a05:6000:2283:b0:3a2:12a:e631 with SMTP id
 ffacd0b85a97d-3a2012ae77emr4848627f8f.22.1747039453590; Mon, 12 May 2025
 01:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250416191645.355088-1-wegao@suse.com>
 <20250428160421.3457215-1-wegao@suse.com>
 <aBt7ck35Dq8GIKHc@yuki.lan>
In-Reply-To: <aBt7ck35Dq8GIKHc@yuki.lan>
Date: Mon, 12 May 2025 10:43:55 +0200
X-Gm-Features: AX0GCFsJWFzfjl5IREXtdnruLNbWuwRQZXNswFRW-kVdZov1LBYrMPpSgLkIG8I
Message-ID: <CAASaF6y+e6eKMONT2FdgsLJyhGzZPswQNqthQpneEqpte+-6pQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: su0Q6KCH4fxTCSAz02-Y6uxOZ2HLwluEi7M7YcfU-9M_1747039454
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mmap22.c: Test for new MAP_DROPPABLE flag for
 mmap
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

SXMgYW55b25lIGVsc2Ugc2VlaW5nIHRoaXMgdGVzdCBmYWlsaW5nIG9uIHJlY2VudCA2LjE1LXJj
NSBrZXJuZWxzPwoKPT09PSBtbWFwMjIgPT09PQpjb21tYW5kOiBtbWFwMjIKdHN0X3RtcGRpci5j
OjMxNjogVElORk86IFVzaW5nIC90bXAvTFRQX21tYXpDVUxOTiBhcyB0bXBkaXIgKHRtcGZzIGZp
bGVzeXN0ZW0pCnRzdF90ZXN0LmM6MTkzODogVElORk86IExUUCB2ZXJzaW9uOiAyMDI1MDEzMC0y
NTMtZzRhMGUzYThmYQp0c3RfdGVzdC5jOjE5NDI6IFRJTkZPOiBUZXN0ZWQga2VybmVsOgo2LjE1
LjAtMC5yYzUuMjUwNTA5ZzljNjlmODg4NDkwNC40Ny5lbG4xNDgueDg2XzY0ICMxIFNNUApQUkVF
TVBUX0RZTkFNSUMgRnJpIE1heSAgOSAxNToxNzozMSBVVEMgMjAyNSB4ODZfNjQKdHN0X2tjb25m
aWcuYzo4ODogVElORk86IFBhcnNpbmcga2VybmVsIGNvbmZpZwonL2xpYi9tb2R1bGVzLzYuMTUu
MC0wLnJjNS4yNTA1MDlnOWM2OWY4ODg0OTA0LjQ3LmVsbjE0OC54ODZfNjQvYnVpbGQvLmNvbmZp
ZycKdHN0X3Rlc3QuYzoxNzU4OiBUSU5GTzogT3ZlcmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGgg
MDVtIDU0cwptbWFwMjIuYzo1NTogVEZBSUw6IE1BUF9EUk9QUEFCTEUgZGlkIG5vdCBkcm9wIG1l
bW9yeSB3aXRoaW4gdGhlIHRpbWVvdXQgcGVyaW9kLgoKCgpPbiBXZWQsIE1heSA3LCAyMDI1IGF0
IDU6MjXigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4gd3JvdGU6Cj4KPiBIaSEK
PiBQdXNoZWQgd2l0aCBhIG1pbm9yIGNoYW5nZSwgdGhhbmtzLgo+Cj4gV2Ugc2hvdWxkIGNoZWNr
IGlmIHRoZSBhZGRyIGlzIHZhbGlkIGJlZm9yZSB3ZSBhdHRlbXAgdG8gdW5tYXAgaXQgaW4gdGhl
Cj4gc2V0dXAoKSBzbyBJJ3ZlIGFkZGVkOgo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvbW1hcC9tbWFwMjIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1h
cC9tbWFwMjIuYwo+IGluZGV4IGJmZWY1NTllNC4uMGU1ODlkZmFiIDEwMDY0NAo+IC0tLSBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMjIuYwo+ICsrKyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMjIuYwo+IEBAIC03Miw4ICs3MiwxMyBAQCBzdGF0aWMg
dm9pZCBzZXR1cCh2b2lkKQo+ICB7Cj4gICAgICAgICB2b2lkICphZGRyID0gbW1hcCgwLCAxLCBQ
Uk9UX1JFQUQgfCBQUk9UX1dSSVRFLAo+ICAgICAgICAgICAgICAgICAgICAgICAgIE1BUF9BTk9O
WU1PVVMgfCBNQVBfRFJPUFBBQkxFLCAtMSwgMCk7Cj4gKwo+ICAgICAgICAgaWYgKGFkZHIgPT0g
TUFQX0ZBSUxFRCAmJiBlcnJubyA9PSBFSU5WQUwpCj4gLSAgICAgICAgICAgICAgIHRzdF9icmso
VENPTkYsICJNQVBfRFJPUFBBQkxFIG5vdCBzdXBwb3J0Iik7Cj4gKyAgICAgICAgICAgICAgIHRz
dF9icmsoVENPTkYsICJNQVBfRFJPUFBBQkxFIG5vdCBzdXBwb3J0ZWQiKTsKPiArCj4gKyAgICAg
ICBpZiAoYWRkciA9PSBNQVBfRkFJTEVEKQo+ICsgICAgICAgICAgICAgICB0c3RfYnJrKFRCUk9L
IHwgVEVSUk5PLCAibW1hcCgpIE1BUF9EUk9QUEFCTEUgZmFpbGVkIik7Cj4gKwo+ICAgICAgICAg
U0FGRV9NVU5NQVAoYWRkciwgMSk7Cj4gIH0KPgo+Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1
YmlzQHN1c2UuY3oKPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
