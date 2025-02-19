Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE95C021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 02:36:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5E903C280D
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 03:36:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76F773C1AFC
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 03:36:08 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=chwen@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5073E1427612
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 03:36:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739932566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=48sHArHPsFz8DR7dLRVIjm1roscGc3lEFJbgtu5nA2g=;
 b=Ga3xRrua7yRKFRsD51nzQg6k937vrnLW+Z9Qh2pbY+CqaBUQX/DdCHnP5GrMQ2d8Z5Wno1
 lYmU+tf7AwjJlcANy/mMmXhyULIXy/5ZB/quHiDwJpf9MAdSiM5DlVogAfPn2DAWF5vG7u
 UYjUM0qIxIxEbhHbwqDH/DEjknB4mYE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-Jq2DD8V7O3WM_iZGKwfJYQ-1; Tue, 18 Feb 2025 21:36:04 -0500
X-MC-Unique: Jq2DD8V7O3WM_iZGKwfJYQ-1
X-Mimecast-MFC-AGG-ID: Jq2DD8V7O3WM_iZGKwfJYQ_1739932564
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6f28863ff05so89837147b3.1
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 18:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739932564; x=1740537364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=48sHArHPsFz8DR7dLRVIjm1roscGc3lEFJbgtu5nA2g=;
 b=W3VmpBsY3S6by7AcFYTYTITRqzZnBgLpu0sP5KGDtdurHLztvf+hNQurzWJmQE1mlL
 k+fLxf97GEmMrnuCrGZ2ZwGB7UerAMjUiEz4vfQRNsmthyu9hG9i8H5rgXOQm8E6Rb2b
 QuBesyLpuIXi2n+FxAxVkqN0IJBia8uyLQ2+yCPAI1ANgQYt8oHySl63yNoajxxafqFZ
 LbL502QvNsSU3pH7ZwLHfeWk+MSbesv9iHLtd27ytUjOIGC89Yr2liICy61L4sHUygo/
 XxFwh2umB6+68nFoEANlSE+BOKzZDOgNPrsNn1hfhi+3RCaKdaULkKFND1PhzL1wzUWO
 uiSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMEyDXpilHjMEQXEPC6O+xM9vIq3pjpl6x8QWWMLcImeEKmFCI9Tf9DS7Xa62LfVGnHM8=@lists.linux.it
X-Gm-Message-State: AOJu0YwaAfdY/lm4tUw/cXHKYQTzPbpdH5hEbgzjfDq2SPTF/468hztt
 Gmb2M3IKP6MlDugJFmqjIIfSayp5phShWi45T6ZsRhsHAHID0BaFpj1sk2xEpJ8QVB9AuxWr0b+
 x5njueIjD7tEOrOXv2kjJooq1lxOg/0RDLCRVcvivA8/ArUwAqKtMEpDM8EdF1ZMV1JcCucgPsG
 8izLuNffyxssOWAt1x0pKEzVw=
X-Gm-Gg: ASbGncue1NXSiS+5/cz8KERvo1ea4P5Ke7itYLx8/uaRuoUMlStK0xvc2CCqV5jKtkM
 /8XqnPT62W6iBcO9GGklsDnNKqacSStgc0sAjX+U32qQKQfWwd61z7uifX4mhEtA=
X-Received: by 2002:a05:690c:ed2:b0:6fb:9822:bbb8 with SMTP id
 00721157ae682-6fba57a1b24mr20956377b3.35.1739932564203; 
 Tue, 18 Feb 2025 18:36:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgjseEMcUNDclkoVPOaw3jr79HpVvYKwBjfySeQ3O7j0mFaJam2tZMXhwz6VTGUmMiavMY46OmNbvbKKzHDR0=
X-Received: by 2002:a05:690c:ed2:b0:6fb:9822:bbb8 with SMTP id
 00721157ae682-6fba57a1b24mr20956267b3.35.1739932563854; Tue, 18 Feb 2025
 18:36:03 -0800 (PST)
MIME-Version: 1.0
References: <20250218023107.1208990-1-chwen@redhat.com>
 <D7VJNTFZM1Z5.1WXQYU2HD3T0P@marliere.net>
 <bc3276b8-8383-4ef8-a4d7-a2a786662cbd@suse.com>
In-Reply-To: <bc3276b8-8383-4ef8-a4d7-a2a786662cbd@suse.com>
From: Chunfu Wen <chwen@redhat.com>
Date: Wed, 19 Feb 2025 10:35:52 +0800
X-Gm-Features: AWEUYZn5pe6najvNsQZuGCk7EmEFSglWxI-5jwnjk28tWG1s2OiHFs2aAenf3Aw
Message-ID: <CAAA2g-1G6q_+049zVD8=ZwuighYa6YHiXwzyXKUG8Uy3RAqaUw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5-rqis7p2mWObZ9qUkIP4ubiVftsDc-Q6phhEjpPngs_1739932564
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] Add test case to cover the setting resource
 limit64 for process
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
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sClNlZSBpbmxpbmUgY29tbWVudHMuCkJlc3QgUmVnYXJkcywKQ2h1bmZ1IFdlbgoKT24g
VHVlLCBGZWIgMTgsIDIwMjUgYXQgOToyOeKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5j
ZXJ2ZXNhdG9Ac3VzZS5jb20+Cndyb3RlOgoKPiBIaSEKPgo+IFRoZSB3aG9sZSB0ZXN0IGlzIGEg
ZHVwbGljYXRpb24gb2YgdGhlIHNldHJsaW1pdDA2LCBzbyBpdCdzIGJldHRlciB0bwo+IHdvcmsg
b24gdGhhdCBvbmUgYW5kIHRvIGludHJvZHVjZSB0aGUgNjRiaXRzIHN1cHBvcnQgdXNpbmcgNjRi
aXQgdGVzdAo+IHZhcmlhbnQuCj4gW2Nod2VuXU1heWJlIGl0IGlzIGEgZ29vZCBpZGVhIHRvIHVz
ZSBzZXBhcmF0ZSBzZXRybGltaXQwNy5jIGZpbGUgdG8KPiBzdXBwb3J0IHVzaW5nIDY0Yml0IHRl
c3RpbmcsIHNpbmNlIGl0IGNhbiBicmluZyBpbnRvIHR3byBiZW5lZml0cy4gMSlhbGlnbgo+IHdp
dGggZ2V0dHJsaW1pdCwgaXQgaGFzIHNlcGFyYXRlIGZpbGUgZ2V0cmxpbWl0MDMuYyBmb3IgNjRi
aXRzLCBhbmQgaXQgaGVscAo+IGVhc2lseSBleHRlbmQgbW9yZSBzY2VybmFvIGNhc2VzIGZvciA2
NGJpdHMgMikgUHV0dGluZyB0aGVtIGluIHNlcGFyYXRlCj4gZmlsZSBpcyBtb3JlIGNvbnZlbmll
bnQgZm9yIHVzZXJzIHRvIHNlbGVjdCB0ZXN0IGNhc2Ugc3BlY2ZpYyA2NGJpdHMKPiB0ZXN0aW5n
IG9uY2UgdXNlcnMgbmVlZCB0aGF0LgoKCgo+IEEgY291cGxlIG9mIGNvbW1lbnRzIGFib3V0IHRo
ZSBpbXBsZW1lbnRhdGlvbjoKPgo+IC0gd2UgYXJlIGFscmVhZHkgZGVmaW5pbmcgdGhlICJzdHJ1
Y3QgcmxpbWl0NjQiIGluc2lkZSBnZXRybGltaXQwMywgc28KPiB3ZSBuZWVkIHRvIGNyZWF0ZSBh
IG5ldyBmaWxlIGxhcGkvcmVzb3VyY2UuaCB3aGVyZSB3ZSBtb3ZlIHRoYXQgc3RydWN0LAo+IGNo
ZWNraW5nIGlmIEhBVkVfU1RSVUNUX1JMSU1JVDY0IGlzIG5vdCBkZWZpbmVkLiBJIGd1ZXNzIHRo
ZSBzYW1lIHNob3VsZAo+IGJlIGRvbmUgZm9yIGdldHJsaW1pdF91NjQoKS9zZXRybGltaXRfdTY0
KCkgc3lzY2FsbHMgZGVmaW5pdGlvbnMuIEJldHRlcgo+IHRvIG1vdmUgdGhlbSBpbiB0aGVyZSBp
biBjYXNlIHdlIHdpbGwgbmVlZCBpdCBpbiB0aGUgZnV0dXJlIC4gV2UgY2FuCj4gc2tpcCBTQUZF
XyogdmFyaWFudHMgYXQgdGhlIG1vbWVudCwgc2luY2Ugd2UgYXJlIG5vdCB1c2luZyB0aGVtIGFy
b3VuZAo+IExUUCB0ZXN0IGZvciBub3cuCj4KPiAtIGluIGJvdGggc2V0cmxpbWl0MDYgYW5kIHNl
dHJsaW1pdDA3IHdlIHNob3VsZCBwcm9iYWJseSB1c2UgdHN0X2J1ZmZlcnMKPiBmb3Igc2FmZXR5
IHJlYXNvbnMgd2hlbiBwYXNzaW5nIHRoZSBwb2ludGVyIHRvIHRoZSBybGltaXQvcmxpbWl0NjQK
PiBzdHJ1Y3Qgd2UgYXJlIGdvbm5hIHVzZQo+Cj4gLSBpdCdzIHdvcnRoIHRvIGNoZWNrIGlmIHRo
ZSBvdGhlciB0ZXN0cyBtaWdodCBpbnRyb2R1Y2UgdGhlIHNhbWUgNjRiaXQKPiB2YXJpYW50cwo+
Cj4gRllJIGkgbm90aWNlZCB0aGF0IHNldHJsaW1pdDA2IGRlc2NyaXB0aW9uIGNhbid0IGJlIGZl
dGNoZWQgaW4gdGhlCj4gbWV0YWRhdGEgYmVjYXVzZSBpdCdzIG5vdCBpbml0aWFsaXplZCB3aXRo
IC8qXCAuIEl0IGFsc28gbmVlZHMgdG8gYmUKPiBjaGFuZ2VkIGludG8gdGhlIFJTVCBmb3JtYXQg
aW5zdGVhZCBvZiBhc2NpaWRvYy4KPgo+IEtpbmcgcmVnYXJkcywKPiBBbmRyZWEgQ2VydmVzYXRv
Cj4KPgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
