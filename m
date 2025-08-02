Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F17C87FD2
	for <ltp@archiver.kernel.org>; Sat,  2 Aug 2025 04:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754107958; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GjJLh2PLaJ+Br3weZTGzYdibsIb+40Jraxu0cjBOpL4=;
 b=Lw1l9LsKdMfqEx+xCSfPPSTuQr7UMPVormb7aawmgTu7eqrM/YKzpvIjCO13Hbkm4PWAY
 JYQf4MYQp8Z6z5YdbSgbutOckJMYC2rSpQpMwNkwQsIZ3Dm35zwkRBBsQ2U8Wih1T7IHQm+
 CLMC6nDm6KZrau38Fcgg2NY0hPTaY5w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 344C23CCBA5
	for <ltp@archiver.kernel.org>; Sat,  2 Aug 2025 06:12:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0705B3C06E9
 for <ltp@lists.linux.it>; Sat,  2 Aug 2025 06:12:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1841E100035C
 for <ltp@lists.linux.it>; Sat,  2 Aug 2025 06:12:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754107933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6cDJMo/6oK7vgI4qF05xZLyZirszoNRA4RJYioXuXtM=;
 b=Z8IgDQKAtPZUfBo4Wbz7axAQ339P3ob96hUH3GJLI/SgtkPElN44iFiqvVdm+5IJ+UoLN8
 cD7wOlNmKn5WtWrDtTA5yKqqRFeKiBVMan6j6i/4YeFupfs5eTxe2NJD3NP03at76PVk+6
 V+wFR/TfJWzcejL4j01eVrkQt+C8hns=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-1Vwnrd-uM-6Db5rdQpalMg-1; Sat, 02 Aug 2025 00:12:11 -0400
X-MC-Unique: 1Vwnrd-uM-6Db5rdQpalMg-1
X-Mimecast-MFC-AGG-ID: 1Vwnrd-uM-6Db5rdQpalMg_1754107931
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31ea6231678so3384792a91.0
 for <ltp@lists.linux.it>; Fri, 01 Aug 2025 21:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754107930; x=1754712730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6cDJMo/6oK7vgI4qF05xZLyZirszoNRA4RJYioXuXtM=;
 b=Hp6815NXbuGsOqCONM+0eEdjRlyYtezFPdwTkA7SJnUgEDFaJ6TQPwXexyILfou32C
 y6Q7xsXBBcbhLoQMnvtO+4GNDhlgFKdj2glSebMRP2dYaYcZ/gcvxiti2RTlCNJ/F9mO
 L8PF9FeIBRjUcaNzz+ywpAbixJiHvvZwEAO2QE3N7mETny2ZhCPK4U/3PtONIqW/dtKk
 /L+UI7+IAOx7iZM9JaQB2uUaBhudBGn2qs7adFYaFqlbDgybJmZys+8ii8rl0n3aHcsl
 H0FowmZbU/UdjGy6T8KATu/xhXR/ydpT4xwqBOY92WAKRNuW74p2rrOKqG4ILTHbnFhC
 LhKg==
X-Gm-Message-State: AOJu0Yxn43HeOQXnwqdv9WWGy26yn/onUxiNtWr/+eXAXYi0L0nHtNKi
 eOZPMTwrVXqEooDUPOr0pjUpR+NwnXkBR7qfVs2oeRfZWb3ujLmzc9rtLLXDIG3V7IwpL/dnlt1
 UCksFWVtrhlR/5Gc2q/4Cxa/k4zhDroDvS4Ekb9liehIuxs9DqaTeMO2/yfU2fjqp2JjiKk62zq
 HD1q0PiEX6PNSlNGvq+10OhzTG15WR3nQ7kGPbcg==
X-Gm-Gg: ASbGnctmxjP+kMdrTcE7KMf/sHGNKfLJx/AKn2mRqo3+g8emrN3uRSRGSJb2xOtJLPM
 49d9jLByX9S/tVhf8/srByB0Qn1Zl7EvL8VIS6T88FQMz+K6mw1bIe/EdaqW6JgjeLwO9GevXIS
 bdODS6oYqd6Xr3UqnXsZf1qw==
X-Received: by 2002:a17:90b:58e4:b0:320:e145:26f3 with SMTP id
 98e67ed59e1d1-320e1452b4amr11946333a91.8.1754107930152; 
 Fri, 01 Aug 2025 21:12:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZYsCKan4bFBwt7EPI/70QD7suI+b35Y3EH+zS6KUwFtskbrTkpHGW1oKpQafUkx+yQhnhWTtoir98inP3Spc=
X-Received: by 2002:a17:90b:58e4:b0:320:e145:26f3 with SMTP id
 98e67ed59e1d1-320e1452b4amr11946305a91.8.1754107929672; Fri, 01 Aug 2025
 21:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250801100935.974351-1-pvorel@suse.cz>
 <CAEemH2cvLsgVYkLOuVFZ4FrhqoUBFF54xRW0CF-0JN-tOCO8KQ@mail.gmail.com>
In-Reply-To: <CAEemH2cvLsgVYkLOuVFZ4FrhqoUBFF54xRW0CF-0JN-tOCO8KQ@mail.gmail.com>
Date: Sat, 2 Aug 2025 12:11:57 +0800
X-Gm-Features: Ac12FXz8_HEnS2A8uzCF8C7acoxLpzKUm-0GDmAyoteEA0TM5TgWFrkNk1pVLgs
Message-ID: <CAEemH2c9h97nC6sj323oG2kDvkcEqxspA5DPRrgK=zGSpEFr6w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QZmGSj_VVCNhoOZxDpyYc4_aNvuKKFLhk9J7v-x4ARQ_1754107931
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/1] Makefile: Add kernel modules related make
 targets
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

T24gU2F0LCBBdWcgMiwgMjAyNSBhdCAxMToyNeKAr0FNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4KPgo+IE9uIEZyaSwgQXVnIDEsIDIwMjUgYXQgNjowOeKAr1BNIFBldHIg
Vm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKPgo+PiBMVFAgY29udGFpbnMgZmV3IGtlcm5l
bCBtb2R1bGVzIGFuZCB0ZXN0cyB3aGljaCBhcmUgdXNpbmcgdGhlbS4gIFRoZXNlCj4+IHJlcXVp
cmUgdG8gYmUgYnVpbHQgd2l0aCB0aGUgc2FtZSBrZXJuZWwgaGVhZGVycyBhcyB0aGUgcnVubmlu
ZyBrZXJuZWwKPj4gKFNVVCkuIFNvbWV0aW1lcyB0aGUgYmVzdCB3YXkgdG8gYWNoaWV2ZSB0aGlz
IGlzIHRvIGNvbXBpbGUgdGhlbSBvbiB0aGUKPj4gU1VULgo+Pgo+PiBBZGQgJ21vZHVsZXMnLCAn
bW9kdWxlcy1jbGVhbicgYW5kICdtb2R1bGVzLWluc3RhbGwnIG1ha2UgdGFyZ2V0cyB0bwo+PiBt
YWtlIGl0IGVhc2llciB0byBidWlsZCB0aGVtLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4KPj4gLS0tCj4+IEhpLAo+Pgo+PiBJJ20gc29ycnkgZm9yIHRo
ZSBub2lzZS4KPj4KPj4gTW9zdCBvZiB0aGUgcGVvcGxlIHdpbGwgbmVlZCBqdXN0IG1vZHVsZXMt
aW5zdGFsbCwgYnV0IGxldCdzIGJlCj4+IGNvbnNpc3RlbnQgd2l0aCBvdGhlciBMVFAgbWFrZSB0
YXJnZXRzLgo+Pgo+PiBLaW5kIHJlZ2FyZHMsCj4+IFBldHIKPj4KPj4gQ2hhbmdlcyB2MS0+djI6
Cj4+ICogQWRkIGFsc28gbW9kdWxlcy1jbGVhbiBhbmQgbW9kdWxlcy1pbnN0YWxsCj4+IFRoaXMg
aXMgbmVlZGVkIGFzICdtYWtlIG1vZHVsZXMgY2xlYW4nIG9yICdtYWtlIG1vZHVsZXMgaW5zdGFs
bCcKPj4gd291bGQgYmUgcnVubmluZyAyIHNlcGFyYXRlIHRhcmdldHMuCj4+Cj4+IHYxOgo+PiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAyNTA4MDEwOTQyMDUuOTY1NjQ1LTEtcHZvcmVs
QHN1c2UuY3ovCj4+Cj4+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9sdHAv
cGF0Y2gvMjAyNTA4MDEwOTQyMDUuOTY1NjQ1LTEtcHZvcmVsQHN1c2UuY3ovCj4+Cj4+ICBJTlNU
QUxMICB8IDEwICsrKysrKysrKysKPj4gIE1ha2VmaWxlIHwgMjQgKysrKysrKysrKysrKysrKysr
KysrKysrCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAt
LWdpdCBhL0lOU1RBTEwgYi9JTlNUQUxMCj4+IGluZGV4IGNiZTI3ZjMyZWEuLjEwYzE5ZDQxMDUg
MTAwNjQ0Cj4+IC0tLSBhL0lOU1RBTEwKPj4gKysrIGIvSU5TVEFMTAo+PiBAQCAtMTY1LDYgKzE2
NSwxNiBAQCBQS0dfQ09ORklHX0xJQkRJUj0vdXNyL2xpYi9pMzg2LWxpbnV4LWdudS9wa2djb25m
aWcKPj4gQ0ZMQUdTPS1tMzIgTERGTEFHUz0tbTMyIC4vYwo+PiAgKiBBcmNoIExpbnV4Cj4+ICBQ
S0dfQ09ORklHX0xJQkRJUj0vdXNyL2xpYjMyL3BrZ2NvbmZpZyBDRkxBR1M9LW0zMiBMREZMQUdT
PS1tMzIKPj4gLi9jb25maWd1cmUKPj4KPj4gK0tlcm5lbCBtb2R1bGVzCj4+ICstLS0tLS0tLS0t
LS0tLQo+PiArCj4+ICtMVFAgY29udGFpbnMgZmV3IGtlcm5lbCBtb2R1bGVzIGFuZCB0ZXN0cyB3
aGljaCBhcmUgdXNpbmcgdGhlbS4KPj4gK1RoZXNlIHJlcXVpcmUgdG8gYmUgYnVpbHQgd2l0aCB0
aGUgc2FtZSBrZXJuZWwgaGVhZGVycyBhcyB0aGUgcnVubmluZwo+PiBrZXJuZWwgKFNVVCkuCj4+
ICtTb21ldGltZXMgdGhlIGJlc3Qgd2F5IHRvIGFjaGlldmUgdGhpcyBpcyB0byBjb21waWxlIHRo
ZW0gb24gdGhlIFNVVC4KPj4gKwo+PiArJ21vZHVsZXMnLCAnbW9kdWxlcy1jbGVhbicgYW5kICdt
b2R1bGVzLWluc3RhbGwnIG1ha2UgdGFyZ2V0cyBhcmUKPj4gc2hvcnRjdXRzCj4+ICt0byBidWls
ZCBqdXN0IHRoZXNlIG1vZHVsZXMgYW5kIHRlc3RzLgo+PiArCj4+ICBBbmRyb2lkIFVzZXJzCj4+
ICAtLS0tLS0tLS0tLS0tCj4+Cj4+IGRpZmYgLS1naXQgYS9NYWtlZmlsZSBiL01ha2VmaWxlCj4+
IGluZGV4IGVhYjQwZGE4YTYuLjkzM2UzM2NhNzUgMTAwNjQ0Cj4+IC0tLSBhL01ha2VmaWxlCj4+
ICsrKyBiL01ha2VmaWxlCj4+IEBAIC0yMTIsNiArMjEyLDMwIEBAIGVuZGlmCj4+ICB0ZXN0LW1l
dGFkYXRhOiBtZXRhZGF0YS1hbGwKPj4gICAgICAgICAkKE1BS0UpIC1DICQoYWJzX3NyY2Rpcikv
bWV0YWRhdGEgdGVzdAo+Pgo+PiArTU9EVUxFX0RJUlMgOj0gY29tbWFuZHMvaW5zbW9kIFwKPj4K
Pgo+IEhlcmUgc2hvdWxkIGJlOgo+Cj4gLU1PRFVMRV9ESVJTIDo9IGNvbW1hbmRzL2luc21vZCBc
Cj4gK01PRFVMRV9ESVJTIDo9IHRlc3RjYXNlcy9jb21tYW5kcy9pbnNtb2QgXAo+CgpPciwgaWYg
d2UgYXZvaWQgaGFyZC1jb2RpbmcgdGhlIG1vZHVsZSBkaXJzLCB0aGVuIHdlIGRvbid0IG5lZWQK
dG8gYW1lbmQgaXQgd2hlbiBhZGRpbmcgbmV3IHRlc3RzIGxhdGVyLgoKU29tZXRoaW5nIG1heWJl
IGxpa2U6CgotTU9EVUxFX0RJUlMgOj0gY29tbWFuZHMvaW5zbW9kIFwKLSAgICAgICB0ZXN0Y2Fz
ZXMva2VybmVsL2Zpcm13YXJlIFwKLSAgICAgICB0ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2
ZXJzIFwKLSAgICAgICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2RlbGV0ZV9tb2R1bGUgXAot
ICAgICAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmluaXRfbW9kdWxlIFwKLSAgICAgICB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2luaXRfbW9kdWxlCitNT0RVTEVfRElSUyA6PSAkKHNo
ZWxsIFwKKyAgZmluZCB0ZXN0Y2FzZXMvIC10eXBlIGYgLW5hbWUgJ01ha2VmaWxlJyB8IFwKKyAg
eGFyZ3MgZ3JlcCAtbCAnaW5jbHVkZS4qbW9kdWxlXC5taycgfCBcCisgIHhhcmdzIC1uMSBkaXJu
YW1lIHwgXAorICBzb3J0IC11IFwKKykKCgo+Cj4KPj4gKyAgICAgICB0ZXN0Y2FzZXMva2VybmVs
L2Zpcm13YXJlIFwKPj4gKyAgICAgICB0ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzIFwK
Pj4gKyAgICAgICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2RlbGV0ZV9tb2R1bGUgXAo+PiAr
ICAgICAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmluaXRfbW9kdWxlIFwKPj4gKyAgICAg
ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2luaXRfbW9kdWxlCj4+ICsKPj4gKy5QSE9OWTog
bW9kdWxlcyBtb2R1bGVzLWNsZWFuIG1vZHVsZXMtaW5zdGFsbAo+PiArbW9kdWxlczoKPj4gKyAg
ICAgICBAJChmb3JlYWNoIGRpciwkKE1PRFVMRV9ESVJTKSxcCj4+ICsgICAgICAgICAgICAgICBl
Y2hvICJCdWlsZCAkKGRpcikiO1wKPj4gKyAgICAgICAgICAgICAgICQoTUFLRSkgLUMgJChhYnNf
c3JjZGlyKS8kKGRpcik7IFwKPj4gKykKPj4gK21vZHVsZXMtY2xlYW46Cj4+ICsgICAgICAgQCQo
Zm9yZWFjaCBkaXIsJChNT0RVTEVfRElSUyksXAo+PiArICAgICAgICAgICAgICAgZWNobyAiQnVp
bGQgJChkaXIpIjtcCj4+ICsgICAgICAgICAgICAgICAkKE1BS0UpIC1DICQoYWJzX3NyY2Rpcikv
JChkaXIpIGNsZWFuOyBcCj4+ICspCj4+ICttb2R1bGVzLWluc3RhbGw6IG1vZHVsZXMKPj4gKyAg
ICAgICBAJChmb3JlYWNoIGRpciwkKE1PRFVMRV9ESVJTKSxcCj4+ICsgICAgICAgICAgICAgICBl
Y2hvICJCdWlsZCAkKGRpcikiO1wKPj4gKyAgICAgICAgICAgICAgICQoTUFLRSkgLUMgJChhYnNf
c3JjZGlyKS8kKGRpcikgaW5zdGFsbDsgXAo+PiArKQo+PiArCj4+ICAjIyBIZWxwCj4+ICAuUEhP
Tlk6IGhlbHAKPj4gIGhlbHA6Cj4+IC0tCj4+IDIuNTAuMQo+Pgo+Pgo+Cj4gLS0KPiBSZWdhcmRz
LAo+IExpIFdhbmcKPgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
