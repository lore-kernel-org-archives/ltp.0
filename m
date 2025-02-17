Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D45C021A9
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 12:53:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2371D3C9C70
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 13:53:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 574843C0722
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 13:52:48 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dbassey@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 138E21203F73
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 13:52:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739796766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OEv9+BxumBa+YdnDulG1/HDuoADF+aFE11zPSEzWOYI=;
 b=JoQM95fRqqIj0sxQ2aIL7R8rYyv/ZUc2QqCINRKc7szxyvgQ8832q7cGXIk9ZHeZiLLsHL
 s54hLkCfPX5p+gInNSyyhnaI1Yhr/YCZTCSUq/GUJKnm3wIi9kcny6mru2tUWmN87QKnV+
 DaxI8cnEF/qXIJkEOHlEi1TaExr+TpY=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-7TuQZo6ePiutBgmazGlVIA-1; Mon, 17 Feb 2025 07:52:45 -0500
X-MC-Unique: 7TuQZo6ePiutBgmazGlVIA-1
X-Mimecast-MFC-AGG-ID: 7TuQZo6ePiutBgmazGlVIA_1739796764
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3cf64584097so32977085ab.2
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 04:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739796764; x=1740401564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OEv9+BxumBa+YdnDulG1/HDuoADF+aFE11zPSEzWOYI=;
 b=Ny46yP06iGRNux1AvCn5AOFUa8zcv/p4Mau6LOBVNlUDbnz6AxyWF2G1duNGdr9X87
 VZBaufdodTYq3RIllGfHi69+x4J6Y2YYNeP1jLcSTTBdR6OGi6hyF5oDq+JhYbyTU32N
 DRoIr5Lsc3Rqk23+mW3leneTks1HWvYDA3ZvVNCNW8eTT5AEh0UFDsaH8DI4cEUh1MoW
 8KIBeKFVDBkq35WoKhO3Tv5KhuMu++k8wIuVg8QgwMTSgQnwTb2o1XMHPNuolZ+iK0Lb
 Ss1pJHLa2KJkZ3fzkrg+w/zuieXP3jHKUt6QAOrY0LD/yQb6wZjSEeiFquQ51Al8u+ga
 4pEw==
X-Gm-Message-State: AOJu0YzIiWmXUiGEYvNGkXTOe9GLhm/iUxvIzSK61zQaDyhLsRcDktMy
 LGr9bdmGgko2+JwtYbzyCXI3kRlhKGsvlm1AOh2a6NDyLoRn9P2Q2T0bhb4r2GYORbFtmajM1uz
 R2BBEEpj+JCOUBGLqjHTjxHUygIj5a3IomV8hS56IVUJhzPL/hvIkGg7CwYi7/k0c1K/9681SHR
 3DnglJPCjGuA3P2HFqGdBEjwA=
X-Gm-Gg: ASbGncuCHWBMXZpY/ws9tInJOUgZHeoxkwC9kAqbbJTz+NcuwYRnWAy2gAMgwDQ7deH
 zEfhvcbSkBhScIQkz5Vu8qYasCBEaM0AuulcjWunxGiIp41/KBw6UOrWFM15VvDo=
X-Received: by 2002:a05:6e02:3109:b0:3d0:10a6:99b9 with SMTP id
 e9e14a558f8ab-3d2807b0fa5mr92972375ab.3.1739796764377; 
 Mon, 17 Feb 2025 04:52:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5ywc1H6uHGq5t00eM0udBtzmv6PdbkVXlfLQ7Uka0EL6gNSklEBkhq8YuvrecmsmTPjeVhgPFsxxPikq++Lk=
X-Received: by 2002:a05:6e02:3109:b0:3d0:10a6:99b9 with SMTP id
 e9e14a558f8ab-3d2807b0fa5mr92972175ab.3.1739796764076; Mon, 17 Feb 2025
 04:52:44 -0800 (PST)
MIME-Version: 1.0
References: <20250214153158.96460-1-dbassey@redhat.com>
 <Z7MLfpxzQtcdhNzu@yuki.lan>
In-Reply-To: <Z7MLfpxzQtcdhNzu@yuki.lan>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Mon, 17 Feb 2025 13:52:33 +0100
X-Gm-Features: AWEUYZmMMwKunQcWO-Kr89HcHY0pnSe6I0ykVE3SqKDw5KAlqpSR34ZBfUpmePs
Message-ID: <CACzuRyyX-NJmB5Sm+y-ovEYh9jxaThh4+_Be1B1FS4YKmrfQbQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -X78DIxoIAeBwHO_Y-BNR7XXfbe34w3d1ye8dlcdHI4_1739796764
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] kcmp03: Add check for KCMP_SYSVSEM before running
 test
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
Cc: sbertram@redhat.com, javierm@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsCgpUaGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjaywgSSBqdXN0IHNlbnQgYSB2MiBv
ZiB0aGUgcGF0Y2guCgpCUiwKRG9yaW5kYSBCYXNzZXkuCgpPbiBNb24sIEZlYiAxNywgMjAyNSBh
dCAxMToxMuKAr0FNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKCj4gSGkh
Cj4gPiBUaGlzIGNvbW1pdCBpbnRyb2R1Y2VzIGEgbmV3IGZ1bmN0aW9uCj4gPiBgaXNfa2NtcF9z
dXBwb3J0ZWQoKWAgdG8gY2hlY2sgaWYgdGhlIGtlcm5lbCBzdXBwb3J0cyB0aGUKPiA+IGBLQ01Q
X1NZU1ZTRU1gIG9wZXJhdGlvbi4gSW4gdGhlIGB2ZXJpZnlfa2NtcCgpYCBmdW5jdGlvbiwKPiA+
IHdlIGFkZCBsb2dpYyB0byBkZXRlY3Qgd2hlbiB0aGUga2VybmVsIGRvZXMgbm90IHN1cHBvcnQK
PiA+IGBLQ01QX1NZU1ZTRU1gIGFuZCBza2lwIHRoZSB0ZXN0IGZvciB0aGF0IGNhc2Ugd2l0aCBh
IFRDT05GCj4gPiByZXN1bHQuIFRoaXMgZW5zdXJlcyB0aGF0IHRoZSB0ZXN0IGRvZXMgbm90IGZh
aWwgd2hlbiB0aGUKPiA+IEtjb25maWcgdGhhdCBzdXBwb3J0cyBgS0NNUF9TWVNWU0VNYCBpcyB1
bmF2YWlsYWJsZS4KPgo+IEZpcnN0IG9mIGFsbCB0aGUgY29kaW5nIHN0eWxlIGlzIGluY29uc2lz
dGVudCwgaGF2ZSB5b3UgcnVuICdtYWtlIGNoZWNrJwo+IGluIHRoZSB0ZXN0IGRpcmVjdG9yeSBh
bmQgZml4ZWQgYWxsIHRoZSBwcm9ibGVtcz8KPgo+ID4gU2lnbmVkLW9mZi1ieTogRG9yaW5kYSBC
YXNzZXkgPGRiYXNzZXlAcmVkaGF0LmNvbT4KPiA+IC0tLQo+ID4gIHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMva2NtcC9rY21wMDMuYyB8IDEzICsrKysrKysrKysrKysKPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMTMgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2tjbXAva2NtcDAzLmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
a2NtcC9rY21wMDMuYwo+ID4gaW5kZXggMzdkNTExOGQ1Li4yNTUxNzFkOTggMTAwNjQ0Cj4gPiAt
LS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tjbXAva2NtcDAzLmMKPiA+ICsrKyBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2NtcC9rY21wMDMuYwo+ID4gQEAgLTUyLDYgKzUyLDEy
IEBAIHN0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKPiA+ICAgICAgIGZyZWUoc3RhY2spOwo+ID4g
IH0KPiA+Cj4gPiArc3RhdGljIGludCBpc19rY21wX3N1cHBvcnRlZCh2b2lkKQo+ID4gK3sKPiA+
ICsgICAgIGludCByZXN1bHQgPSBzeXNjYWxsKF9fTlJfa2NtcCwgZ2V0cGlkKCksIGdldHBpZCgp
LCBLQ01QX1NZU1ZTRU0sCj4gMCwgMCk7Cj4KPiBXaHkgc3lzY2FsbCgpIGluc3RlYWQgb2Yga2Nt
cCgpIHRoYXQgaXMgdXNlZCBpbiB0aGUgcmVzdCBvZiB0aGUgdGVzdD8KPgo+ID4gKyAgICAgcmV0
dXJuIHJlc3VsdCA9PSAwIHx8IGVycm5vICE9IEVPUE5PVFNVUFA7Cj4gPiArfQo+ID4gKwo+ID4g
IHN0YXRpYyBpbnQgZG9fY2hpbGQodm9pZCAqYXJnKQo+ID4gIHsKPiA+ICAgICAgIHBpZDIgPSBn
ZXRwaWQoKTsKPiA+IEBAIC02NCw2ICs3MCwxMyBAQCBzdGF0aWMgdm9pZCB2ZXJpZnlfa2NtcCh1
bnNpZ25lZCBpbnQgbikKPiA+ICAgICAgIGludCByZXM7Cj4gPiAgICAgICBzdHJ1Y3QgdGNhc2Ug
KnRjID0gJnRjYXNlc1tuXTsKPiA+Cj4gPiArICAgIC8vIEhhbmRsZSB0aGUgY2FzZSBmb3IgS0NN
UF9TWVNWU0VNIHNwZWNpZmljYWxseQo+ID4gKyAgICBpZiAodGMtPmtjbXBfdHlwZSA9PSBLQ01Q
X1NZU1ZTRU0pIHsKPiA+ICsgICAgICAgIGlmICghaXNfa2NtcF9zdXBwb3J0ZWQoKSkgewo+Cj4g
VGhpcyBmdW5jdGlvbiBzaG91bGQgYmUgY2FsbGVkIG9uY2UgZnJvbSB0aGUgdGVzdCBzZXR1cCBh
bmQgdGhlIHJlc3VsdHMKPiBzaG91bGQgYmUgY2FjaGVkLgo+Cj4gPiArICAgICAgICAgICAgdHN0
X2JyayhUQ09ORiwgIktlcm5lbCBkb2VzIG5vdCBzdXBwb3J0IEtDTVBfU1lTVlNFTSwKPiBza2lw
cGluZyB0ZXN0LiIpOwo+Cj4gVGhpcyBzaG91bGQgYmUganVzdCB0c3RfcmVzKFRDT05GLCAiLi4u
Iik7IGZvbGxvd2VkIGJ5IHJldHVybiAwOwo+Cj4gV2UgZG8gbm90IHdhbnQgdG8gYWJvcnQgc3Vi
c2VxZW50IHRlc3QgaXRlcmF0aW9ucyAoZS5nLiAtaSAyIG9uIGNvbW1hbmQKPiBsaW5lKSBqdXN0
IGJlY2F1c2Ugb25lIG9wZXJhdGlvbiBpcyBub3Qgc3VwcG9ydGVkLgo+Cj4gPiArICAgICAgICAg
fQo+ID4gKyAgICAgfQo+Cj4KPiA+ICAgICAgIHBpZDEgPSBnZXRwaWQoKTsKPiA+ICAgICAgIHRz
dF9yZXMoVElORk8sICJUZXN0aW5nICVzIiwgdGMtPmRlc2MpOwo+ID4KPiA+IC0tCj4gPiAyLjQ4
LjEKPiA+Cj4KPiAtLQo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNAc3VzZS5jego+Cj4KCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
