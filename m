Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0944C35FFC
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742905749; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : content-type : content-transfer-encoding :
 sender : from; bh=1bsnCQE8wuiLkDRbRDnO5V0vN3+wLa+LPpg23Ca/NyE=;
 b=fa+nUZL/rrV713SCdyjrFXKR2ubT8zNiq9GwAqUXVFBAwLvZZa9AGbLrvpt6f3B4LNpV/
 RgUL5Eh24XLN/MojMFN13tTXF9JWj4OwPC0QCbbBr35CDTho/xfo86kNnv/OFW6+yfnYCJU
 gpmAmae3gYw5tCPG58tjcBhJ89UewTU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2271C3C99CC
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 13:29:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with UTF8SMTPS id B07983C19F4
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 13:28:46 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with UTF8SMTPS id B2A831000993
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 13:28:45 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so4384611f8f.1
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 05:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742905725; x=1743510525;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H5mYFbHqzvv2HLFxjjb3HpxwB+Va/dSEnoCKoAHHuM4=;
 b=P/Z2eSZY01i2Qb0Ewweuvjm4OMgTRvvZdPB3Wx5lTZ/ZMzAeTNIFneCh06+XiG/Ji9
 7zJ6SaDLJxb7OnnNdcCxQGP2ANXtNbEb86VZyI4ruu+RpTXCy5OJ5uMsmWdnH+UUudI5
 mX/GMj3G8cjzZqBLf91ynfLsmkNaN39mMnl79T+Bf3LqH0waYilRIvrkOAULgyuswUmS
 4nlw+H6X5jAxobYgiI38H6eIQzyBQQY/FDNtxskrTd2Skg0jVWVsBmpLkkdOOLerseNH
 V0tMQ38n16vr/waXOilLjZOC1WrJ3TQoXPBmCfP48fmc3J/iYocoHuDK14eGCUOdq0gq
 /nvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOo28L2oe0yto6kGd5hDApERsaborNr3oa5tVM5nTMP0V/w8VRev4rVEib0GgS7isJTts=@lists.linux.it
X-Gm-Message-State: AOJu0YxXRonLXXVnA7FFI1LFmzpXvdm1ur9CE3qZaeHRuNfIuVEXIOXF
 8XHPU6oIgRmqE5xRzGlD82TflgR2Y+5gp0O4dkJE2UfeAjGSSQ0A9GjMQpkH28zHdWVN7ZJ7biv
 3
X-Gm-Gg: ASbGnctyeciSZ5HVKbRzjIOiWeQVYtQOJz3PjuQdsy3wSJUVEQ+YNlIzdJ3CJG5oAKI
 lR/N7vgeMEPe/YKZNa6pi8ikM39g/8Rj/vzRZAxHDrNzvaM2S1Wmum9W0G1lNrzJFZfrM2Uqamb
 2I5dsweCQk19zh/vp/WK++5ZiLwX6GFxGto0tI7SpAQ2B9sfSw9BDR6Il+ayfMmgyzqAn1x44iM
 vD2ii4W8oxrriKRYxIPOF78RxVPFlvJvtXTpWyxvkkkwVwBSdWhc5dCMICALkKTK7QdRP43qcMA
 BuW2SA6w/amPR0y+4RzDD+/OsEITgbUuTw==
X-Google-Smtp-Source: AGHT+IELwMvbxuqWZHQp1fFVjjnIwAqU+dA776pvaJdHAVycD7bFP75f8+g7w2lRfGchINI81b6ejw==
X-Received: by 2002:a05:6000:2a88:b0:39a:c9fe:f069 with SMTP id
 ffacd0b85a97d-39ac9fef08dmr1263275f8f.30.1742905724989; 
 Tue, 25 Mar 2025 05:28:44 -0700 (PDT)
Received: from localhost ([179.228.213.210]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4bf1fsm88942705ad.94.2025.03.25.05.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 05:28:44 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 25 Mar 2025 09:28:39 -0300
Message-Id: <D8PCII25DLZQ.1K8JXES1P964F@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>, "Linux Test Project"
 <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250324-conversions-modify_ldt-v1-0-8d6d82f10768@suse.com>
 <20250324-conversions-modify_ldt-v1-4-8d6d82f10768@suse.com>
 <fac3d9dd-f960-4c63-be05-45f4d0fbe5e2@suse.com>
In-Reply-To: <fac3d9dd-f960-4c63-be05-45f4d0fbe5e2@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] syscalls/modify_ldt: Refactor modify_ldt01
 into new API
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
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsae+/ve+/vXJlIHZpYSBsdHA=?=
 <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marlière" <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKT24gVHVlIE1hciAyNSwgMjAyNSBhdCA3OjEwIEFNIC0wMywgQW5kcmVhIENl
cnZlc2F0byB3cm90ZToKPiBIaSEKPgo+IFNvIHRoaXMgaXMgYSB0ZXN0IHdoaWNoIGlzIHRlc3Rp
bmcgaWYgbW9kaWZ5X2xkdCBzeXNjYWxsIGlzIHByb2R1Y2luZyAKPiB0aGUgcmlnaHQgZXJyb3Jz
IGFjY29yZGluZyB0byBpbnZhbGlkIGlucHV0cy4gSXQncyBhIHByZXR0eSBjb21tb24gdHlwZSAK
PiBvZiB0ZXN0IGluIExUUCBhbmQgd2UgY2FuIGV4dGVuZCBpdCB0byBhbGwgdGhlIG90aGVyIGVy
cm9ycyBhcyB3ZWxsIAo+IEJhc2ljYWxseSwgd2UgbmVlZCB0byBtZXJnZSBzaW1wbGUgdGVzdHMg
Y2hlY2tpbmcgZm9yIGVycm9ycyBpbnRvIGEgCj4gc2luZ2xlIG9uZSB1c2luZyB0ZXN0IGNhc2Vz
LgoKU28sIGJhc2ljYWxseSBrZWVwIDAxIGFuZCBleHRlbmQgaXQgaW5zdGVhZCBvZiBzcGxpdHRp
bmcgaXQgaW50byBuZXcKdGVzdHMgc3VjaCBhcyAwNCBhbmQgMDU/Cgo+Cj4gU29tZSBjb21tZW50
cyBiZWxvdy4KPgo+IE9uIDMvMjQvMjUgMjE6NDUsIFJpY2FyZG8gQi4gTWFybGllcmUgdmlhIGx0
cCB3cm90ZToKPj4gRnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPj4K
Pj4gQWxzbyBzcGxpdCBpdHMgdGhyZWUgYmxvY2tzIGludG8gaW5kaXZpZHVhbCB0ZXN0cy4KPj4K
Pj4gU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPj4g
LS0tCj4+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0Ly5naXRpZ25vcmUg
ICAgfCAgIDggKy0KPj4gICAuLi4va2VybmVsL3N5c2NhbGxzL21vZGlmeV9sZHQvbW9kaWZ5X2xk
dDAxLmMgICAgICB8IDIzNCArKy0tLS0tLS0tLS0tLS0tLS0tLS0KPj4gICAuLi4va2VybmVsL3N5
c2NhbGxzL21vZGlmeV9sZHQvbW9kaWZ5X2xkdDA0LmMgICAgICB8ICAzMiArKysKPj4gICAuLi4v
a2VybmVsL3N5c2NhbGxzL21vZGlmeV9sZHQvbW9kaWZ5X2xkdDA1LmMgICAgICB8ICAzNyArKysr
Cj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCA5MiBpbnNlcnRpb25zKCspLCAyMTkgZGVsZXRpb25zKC0p
Cj4+Cj4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vZGlmeV9sZHQv
LmdpdGlnbm9yZSBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC8uZ2l0aWdu
b3JlCj4+IGluZGV4IGMwYjhiYmY1ODc1YWY0NTNiNDg4MGVmNGI3MTdmZGI0MGQxMDllZTcuLjc2
ZmUyZjNmMDU5MmY5MmZhODc5NjM1OTdkMGMwM2UyZmQ4MWUyZGEgMTAwNjQ0Cj4+IC0tLSBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC8uZ2l0aWdub3JlCj4+ICsrKyBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC8uZ2l0aWdub3JlCj4+IEBAIC0xLDMg
KzEsNSBAQAo+PiAtL21vZGlmeV9sZHQwMQo+PiAtL21vZGlmeV9sZHQwMgo+PiAtL21vZGlmeV9s
ZHQwMwo+PiArbW9kaWZ5X2xkdDAxCj4+ICttb2RpZnlfbGR0MDIKPj4gK21vZGlmeV9sZHQwMwo+
PiArbW9kaWZ5X2xkdDA0Cj4+ICttb2RpZnlfbGR0MDUKPj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9tb2RpZnlfbGR0MDEuYyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9tb2RpZnlfbGR0MDEuYwo+PiBpbmRleCA2ODRlNTM3
NzI0MTRhZTQ2OGI0ZjE2ODU3ODU5NmVhYmIyN2VmMThiLi40NWU5NjQ5ZjkxYjY4ZjI4YzhhZGMw
ODExODNjZmJkMWIxYzNjYTg4IDEwMDY0NAo+PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL21vZGlmeV9sZHQvbW9kaWZ5X2xkdDAxLmMKPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9tb2RpZnlfbGR0L21vZGlmeV9sZHQwMS5jCj4+IEBAIC0xLDIzMCArMSwzMiBAQAoK
PHNuaXA+Cgo+PiAtdm9pZCBjbGVhbnVwKHZvaWQpCj4+ICt2b2lkIHJ1bih2b2lkKQo+PiAgIHsK
Pj4gKwljaGFyIGJ1ZltzaXplb2Yoc3RydWN0IHVzZXJfZGVzYyldOwo+PiAgIAo+PiArCVRFU1Qo
bW9kaWZ5X2xkdCgxMDAsIGJ1Ziwgc2l6ZW9mKGJ1ZikpKTsKPj4gKwlUU1RfRVhQX0VRX0xJKFRT
VF9FUlIsIEVOT1NZUyk7Cj4KPiBXZSBjYW4gdXNlIFRTVF9FWFBfRkFJTCgpIHdoaWNoIGlzIGEg
c2hvcnRlciB2ZXJzaW9uLgo+Cj4gQWxzbywgd2hlbiB3ZSBhcmUgdGVzdGluZyBzeXNjYWxscywg
d2UgdXN1YWxseSAobm90IGFsd2F5cyBmb3IgCj4gaGlzdG9yaWNhbCByZWFzb25zKSB1c2UgZ3Vh
cmRlZCBidWZmZXJzIGZvciBtZW1vcnkgaW5wdXQuIFBsZWFzZSB0YWtlIGEgCj4gbG9vayBhdCB0
aGUgInRzdF90ZXN0OjpidWZzIiBhdHRyaWJ1dGUuIEFsc28gaW4gdGhpcyBjYXNlLCBMVFAgY29k
ZSBpcyAKPiB0aGUgd2F5IHRvIHVuZGVyc3RhbmQgaG93IHRvIHVzZSB0aGVtLgoKSSdsbCB0YWtl
IGEgbG9vayBhdCB0aGF0LCB0aGFua3MgZm9yIHRoZSBwb2ludGVycy4KCj4gS2luZCByZWdhcmRz
LAo+IEFuZHJlYSBDZXJ2ZXNhdG8KClRoYW5rcyBmb3IgcmV2aWV3aW5nLAotCVJpY2FyZG8uCgoK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
