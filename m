Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6670DC4706C
	for <ltp@archiver.kernel.org>; Fri, 12 Jan 2024 07:18:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 508803CE05F
	for <ltp@archiver.kernel.org>; Fri, 12 Jan 2024 08:18:37 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B64E63C8874
 for <ltp@lists.linux.it>; Fri, 12 Jan 2024 08:18:22 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B723F140170E
 for <ltp@lists.linux.it>; Fri, 12 Jan 2024 08:18:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705043899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bm7CqYB6fIueeqzF8AuJWUdd3+oaiBhLzfy0/68aggU=;
 b=bslSh2UJAHf05IyVSRrBhQwEBF6SrzAx7zSEvUWY+Je7m9b3T76j48xrz/Kivpmr82ztrF
 9YLI1wXXx5ZC76CePP21pYt8T+s1Wyqs/a0NIpabeLcePmbPkRHmb0dvNWbNRoAtYANlvs
 GSrFlEf/szY3gjxuizEqJ7fHP6CxOM0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-IiHSnW-cM1qmcrf4VMPx8Q-1; Fri, 12 Jan 2024 02:18:17 -0500
X-MC-Unique: IiHSnW-cM1qmcrf4VMPx8Q-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ccea28e95aso54457501fa.3
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 23:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705043896; x=1705648696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bm7CqYB6fIueeqzF8AuJWUdd3+oaiBhLzfy0/68aggU=;
 b=Pj7br0BRavtuexQ1PZ1VLzpYqEaEufFwo5DerJz1WkeCor7ICu36bvE+2cNWO4+v2a
 ClBoCZzdQFlDepjAjCJy3aSZ8OwWNjtvcRr9x+6iJN6rA7rPn2Sx4aUfNiz6h/Qn/0KA
 Ni/kwlXyqCrEnsQCEAvr55Icd6xBGyb6SjnGeZtdgBcO+OtzfPS6iadvBxYTLSx5+qT4
 6uk8g4vITDXDfqCvaxw+Egp/SIl9kT32lpteZltxB+9V9lyZgmA+iuznRMpdvGGBECv1
 yyqmBGgNn6ZdPULa4cv8x2Myo9rmcAftBg5NZaR2yNgkC+MZXB7QEGveWLv/R6aFT+9o
 rDPQ==
X-Gm-Message-State: AOJu0YzQucfUJYdHUsrJ5WjOf6uvqFtFcpc7OswHTaoFDCBSaVTG9itK
 Xq/smAQSv9uLyXyXy5u4XwOK4reCalPVD312S0DsIoFx/XMlSsOII5OhtR1g0xgBHnvJYj9DUfv
 EcaCc595PIlpXn8NpN74UFq83tqOshS3tZ2E=
X-Received: by 2002:a2e:80cb:0:b0:2cc:7b7b:8804 with SMTP id
 r11-20020a2e80cb000000b002cc7b7b8804mr398087ljg.96.1705043895787; 
 Thu, 11 Jan 2024 23:18:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG29fzHENXPJalvT+a6QDi6yx+D0uVhmEm9bjJ7VDUz9RwV/zaM4BCpGLO+fVWgAAgZwuglvAgDyp0dCbfBJCI=
X-Received: by 2002:a2e:80cb:0:b0:2cc:7b7b:8804 with SMTP id
 r11-20020a2e80cb000000b002cc7b7b8804mr398078ljg.96.1705043895394; Thu, 11 Jan
 2024 23:18:15 -0800 (PST)
MIME-Version: 1.0
References: <20231011162428.583911-1-pvorel@suse.cz>
 <4867816.31r3eYUQgx@linux-9lzf>
In-Reply-To: <4867816.31r3eYUQgx@linux-9lzf>
From: Li Wang <liwang@redhat.com>
Date: Fri, 12 Jan 2024 15:18:03 +0800
Message-ID: <CAEemH2efad9xYK1Q75EGyPM=7diLLGMzauO4fQ9gNxjOrnYhEQ@mail.gmail.com>
To: Marius Kittler <mkittler@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 0/2] swapon01: Test on all filesystems, cleanup
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

SGkgTWFyaXVzLCBQZXRyLAoKT24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgNToyOeKAr1BNIE1hcml1
cyBLaXR0bGVyIDxta2l0dGxlckBzdXNlLmRlPiB3cm90ZToKCj4gSSBndWVzcyB0aGUgY29kZSB3
b3VsZCB3b3JrIGFuZCBsb29rcyBnZW5lcmFsbHkgZ29vZCB0byBtZXJnZS4gSW4gZmFjdCwgSQo+
IHRlc3RlZCBgLmFsbF9maWxlc3lzdGVtcyA9IDFgICBteXNlbGYgeWVzdGVyZGF5LiBJdCBpcyBq
dXN0IHRoZSBxdWVzdGlvbgo+IHdoZXRoZXIgd2UgYWN0dWFsbHkgd2FudCBpdC4gSXMgdGhlcmUg
cmVhbGx5IGNvdmVyYWdlIHRvIGJlIGdhaW5lZCAob3IKPiBkb2VzCj4gdGhlIGtlcm5lbCBqdXN0
IHRoZSBzYW1lIHVuZGVyIHRoZSBob29kIGFueXdheSByZWdhcmRsZXNzIG9mIHRoZQo+IGZpbGVz
eXN0ZW0pPwo+CgpBZnRlciBhIHJvdWdoIGxvb2tpbmcgYXQgdGhlIHN3YXBvbigpIHJlbGF0ZWQg
Y29kZSBhY2hpZXZlZCBpbiB0aGUga2VybmVsCnNvdXJjZS4KSSB0aGluayB0aGUgc3dhcG9uIGNv
dmVyYWdlIGFyZSBzYW1lIG9uIHdoYXRldmVyIHRoZSBzd2FwZmlsZSBmaWxlc3lzdGVtIGlzLAp0
aGUgb25seSBkaWZmZXJlbmNlIG1heSBiZSBhYm91dCB0aGUgYG1ha2Vfc3dhcGZpbGVgIHBhcnQg
d2hpY2gKaGlnaGx5IGRlcGVuZHMKb24gdGhlIGZpbGVzeXN0ZW0gdHlwZSwgYW5kIHRoZSBmaWxl
c3lzdGVtJ3MgY2hhcmFjdGVyaXN0aWNzIGNhbiBpbXBhY3QgdGhlCnBlcmZvcm1hbmNlIGFuZCBl
ZmZlY3RpdmVuZXNzIG9mIHN3YXBwaW5nIG9wZXJhdGlvbnMuCgpTbyBpbiBhIHdvcmQsIGlmIHdl
IGp1c3QgY2hlY2sgdGhlIHN3YXBvbigpIHN1Y2NlZWQgd2l0aCBzd2FwZmlsZSwgdGhlCicuYWxs
X2ZpbGVzeXN0ZW1zID0gMScgaXMgdXNlbGVzcyBpbiBwYXRjaDEvMiwgYnV0IGlmIHdlIGRvIG1v
cmUgYWN0aW9uIGluCndyaXRpbmcvdXNpbmcgc3dhcGZpbGUgdGhhdCBwcm9iYWJseSByYWlzZXMg
dGhlIGNvdmVyYWdlLgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoK
Cgo+Cj4gPiBUZXN0IG9uIGFsbCBmaWxlc3lzdGVtcyB0byBpbmNyZWFzZSBjb3ZlcmFnZS4gIGJ0
cmZzIGFuZCB0bXBmcwo+ID4gY3VycmVudGx5IGRvZXMgbm90IHN1cHBvcnQgc3dhcCBmaWxlLCBi
dXQga2VlcCBpdCBpbiBjYXNlIHRoaXMgZ2V0Cj4gPiBjaGFuZ2VkIGluIHRoZSBmdXR1cmUuCj4K
PiBDb25zaWRlcmluZyBidHJmcyBkb2VzIG5vdCBzdXBwb3J0IGl0IEkgZ3Vlc3MgdGhhdCBtZWFu
cyB0aGUga2VybmVsIGRvZXMKPiBpbmRlZWQgZGlmZmVyZW50IHRoaW5ncyB1bmRlciB0aGUgaG9v
ZCBzbyB0aGUgY292ZXJhZ2UgbWlnaHQgYmUKPiBiZW5lZmljaWFsLiAoSWYKPiBpdCB3YXMganVz
dCBhYm91dCB0bXBmcyB0aGVuIEknZCBzYXkgaXQgbWFrZXMgbm8gc2Vuc2UgdG8gcHV0IGEgc3dh
cGZpbGUKPiB0aGVyZQo+IGluIGFueSBjYXNlIGFuZCBpdCB3aWxsIHRoZXJlZm9yZSBsaWtlbHkg
bmV2ZXIgYmUgc3VwcG9ydGVkLikKPgo+IFJldmlld2VkLWJ5OiBNYXJpdXMgS2l0dGxlciA8bWtp
dHRsZXJAc3VzZS5kZT4KPgo+Cj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
