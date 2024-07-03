Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C5BC2BD09
	for <ltp@archiver.kernel.org>; Wed,  3 Jul 2024 07:40:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3C313D3DBF
	for <ltp@archiver.kernel.org>; Wed,  3 Jul 2024 09:40:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD0733CBED8
 for <ltp@lists.linux.it>; Wed,  3 Jul 2024 09:40:38 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 69819101BBA8
 for <ltp@lists.linux.it>; Wed,  3 Jul 2024 09:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719992435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x5uEMxwPSeQ3meAN0qaHu4i68wQTraYRcGG2vYcNiQg=;
 b=SAv4EPKPqB13GbeSJ8Il3OsXFIuxOlCgGP3nJUv2zI0y76d349+GmmIpsMVvRN+j0akv6q
 tTo0sTWVp9s+InLhnwsF7Pa1niAX6ho5CeezPONhllk3bhLT3biFISnDiVhQCcw1CW5x9n
 yBgUYQqPPgN+BB7h5n4GyeS05vQfOgI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-n8gnTZQ7NWq4dwUW2Xt4Mg-1; Wed, 03 Jul 2024 03:40:33 -0400
X-MC-Unique: n8gnTZQ7NWq4dwUW2Xt4Mg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-7276dd142b4so303815a12.1
 for <ltp@lists.linux.it>; Wed, 03 Jul 2024 00:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719992433; x=1720597233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x5uEMxwPSeQ3meAN0qaHu4i68wQTraYRcGG2vYcNiQg=;
 b=gQqbgCoc6DSluRgAFlCazurrvVrtr0tysRHl2vhCT/A8Rhd14VIjKyG9abZO5spyYO
 qnIEtKY1RX99IDwSYsKiewYl5cpCJAGBzGKOjm/KQamGDHnAtZLoRYUnfchXbCY+iWNe
 u0YwofjRKTuK8CglRxzWdrrEsm/fx6tTFlOqBvNjm3jxUOZ0LYGjOp7kw5T2w6eeC4NX
 NjQiK1sdEqXb262XVu/K2PN7Q8HHuyGdjMNGbI8p9gjSoRYJZZDdAYYvFuGyPOM+4ajD
 mBwy+B94GG2itC9Zp07c/kWg3UDlNz+cFtV4zZ8B9phZVjQQ0IbjfPVzSFpoBG9UbfMB
 bJ+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeo5L8ltKXMpEw2p2jnws8dNljuxvhten2xeYiCPhh8ft0jeS74tOOyyXuN76hYTaX1O6VEQOupAhkwg5V9VWzL3I=
X-Gm-Message-State: AOJu0Yw5u76d32pMwwvg6KpCOhc5bodGGCeKeERtduNM+XVzTGjeMWfY
 VsqJDVmVaHwyL85IjZf14vT/mIBoJz/ZASOBo1Pu1J/mqABWGpDg++CYC01l5FWgw3PYwZeECoz
 Tw6Y6vUqQKjmTlAZiRs6m7XZ72EyPHP+1EmuhRVyg9QXwCZRET4mEOTohDcY2LwAIJCVvQj7+LC
 YOr9jwgZwVLCw8Q9yKVlFItqE=
X-Received: by 2002:a17:90a:d78b:b0:2c8:7ef4:f502 with SMTP id
 98e67ed59e1d1-2c97ad30ba1mr1594903a91.19.1719992432361; 
 Wed, 03 Jul 2024 00:40:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9y0FOLP7IvrX/Q7yUWugpEfH7ygl6p8Fk7UeZhr5f1WmOSYSGr55o/kd26NMk0T1h+fQdDDjFTdUkNyP5oJY=
X-Received: by 2002:a17:90a:d78b:b0:2c8:7ef4:f502 with SMTP id
 98e67ed59e1d1-2c97ad30ba1mr1594880a91.19.1719992431976; Wed, 03 Jul 2024
 00:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
 <20240701-landlock-v1-9-58e9af649a72@suse.com>
 <CAEemH2dWxNg317Fx+pvRM=3v6Ddh2mHWLe-1_VKPO9DFpGcuoA@mail.gmail.com>
 <eb9fffd4-2cca-40d6-b0f3-bca0ee5cfdba@suse.com>
In-Reply-To: <eb9fffd4-2cca-40d6-b0f3-bca0ee5cfdba@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 3 Jul 2024 15:40:20 +0800
Message-ID: <CAEemH2eDySd7Vg9j0ntd96MR3xwLLNU1Dz54QJhHGWaUefkwLg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 09/10] Add landlock05 test
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

T24gV2VkLCBKdWwgMywgMjAyNCBhdCAzOjM34oCvUE0gQW5kcmVhIENlcnZlc2F0byA8YW5kcmVh
LmNlcnZlc2F0b0BzdXNlLmNvbT4Kd3JvdGU6Cgo+IE9uIDcvMy8yNCAwOTozMiwgTGkgV2FuZyB3
cm90ZToKPgo+Cj4KPiBPbiBNb24sIEp1bCAxLCAyMDI0IGF0IDExOjQ14oCvUE0gQW5kcmVhIENl
cnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmRlPgo+IHdyb3RlOgo+Cj4+IEZyb206IEFu
ZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4+Cj4+IFRoaXMgdGVz
dCB2ZXJpZmllcyBMQU5ETE9DS19BQ0NFU1NfRlNfUkVGRVIgYWNjZXNzIGluIHRoZQo+PiBsYW5k
bG9jayBzYW5kYm94LiBUaGUgZmVhdHVyZSBpcyBhdmFpbGFibGUgc2luY2Uga2VybmVsIDUuMTku
Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9A
c3VzZS5jb20+Cj4+Cj4KPiBSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+
Cj4KPiAtLS0KPj4gIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAxICsKPj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svLmdpdGln
bm9yZSAgIHwgICAxICsKPj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svbGFu
ZGxvY2swNS5jIHwgMTEzCj4+ICsrKysrKysrKysrKysrKysrKysrKysrKwo+PiAgMyBmaWxlcyBj
aGFuZ2VkLCAxMTUgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvcnVudGVzdC9zeXNj
YWxscyBiL3J1bnRlc3Qvc3lzY2FsbHMKPj4gaW5kZXggOWFjZGFmNzYwLi5hM2FkZTZkYzEgMTAw
NjQ0Cj4+IC0tLSBhL3J1bnRlc3Qvc3lzY2FsbHMKPj4gKysrIGIvcnVudGVzdC9zeXNjYWxscwo+
PiBAQCAtNjg4LDYgKzY4OCw3IEBAIGxhbmRsb2NrMDEgbGFuZGxvY2swMQo+PiAgbGFuZGxvY2sw
MiBsYW5kbG9jazAyCj4+ICBsYW5kbG9jazAzIGxhbmRsb2NrMDMKPj4gIGxhbmRsb2NrMDQgbGFu
ZGxvY2swNAo+PiArbGFuZGxvY2swNSBsYW5kbG9jazA1Cj4+Cj4+ICBsY2hvd24wMSBsY2hvd24w
MQo+PiAgbGNob3duMDFfMTYgbGNob3duMDFfMTYKPj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svLmdpdGlnbm9yZQo+PiBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvbGFuZGxvY2svLmdpdGlnbm9yZQo+PiBpbmRleCA0ZmU4ZDdjYmEuLmE3ZWE2YmUy
ZSAxMDA2NDQKPj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sYW5kbG9jay8uZ2l0
aWdub3JlCj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svLmdpdGln
bm9yZQo+PiBAQCAtMywzICszLDQgQEAgbGFuZGxvY2swMQo+PiAgbGFuZGxvY2swMgo+PiAgbGFu
ZGxvY2swMwo+PiAgbGFuZGxvY2swNAo+PiArbGFuZGxvY2swNQo+PiBkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sYW5kbG9jay9sYW5kbG9jazA1LmMKPj4gYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrL2xhbmRsb2NrMDUuYwo+PiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NAo+PiBpbmRleCAwMDAwMDAwMDAuLjU3ZWQ2N2U5Zgo+PiAtLS0gL2Rldi9udWxsCj4+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svbGFuZGxvY2swNS5jCj4+
IEBAIC0wLDAgKzEsMTEzIEBACj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MC1vci1sYXRlcgo+PiArLyoKPj4gKyAqIENvcHlyaWdodCAoQykgMjAyNCBTVVNFIExMQyBBbmRy
ZWEgQ2VydmVzYXRvIDwKPj4gYW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPj4gKyAqLwo+PiAr
Cj4+ICsvKlwKPj4gKyAqIFtEZXNjcmlwdGlvbl0KPj4gKyAqCj4+ICsgKiBUaGlzIHRlc3QgdmVy
aWZpZXMgTEFORExPQ0tfQUNDRVNTX0ZTX1JFRkVSIGFjY2VzcyBpbiB0aGUKPj4gKyAqIGxhbmRs
b2NrIHNhbmRib3guCj4+ICsgKgo+PiArICogW0FsZ29yaXRobV0KPj4gKyAqCj4+ICsgKiAtIGFw
cGx5IExBTkRMT0NLX0FDQ0VTU19GU19SRUZFUiBpbiB0aGUgZm9sZGVyMQo+PiArICogLSBhcHBs
eSBMQU5ETE9DS19BQ0NFU1NfRlNfUkVGRVIgaW4gdGhlIGZvbGRlcjIKPj4gKyAqIC0gY3JlYXRl
IGZvbGRlcjMKPj4gKyAqIC0gdmVyaWZ5IHRoYXQgZmlsZSBjYW4gYmUgbW92ZWQgZnJvbSBmb2xk
ZXIxIHRvIGZvbGRlcjIKPj4gKyAqIC0gdmVyaWZ5IHRoYXQgZmlsZSBjYW4ndCBiZSBtb3ZlZCBm
cm9tIGZvbGRlcjEgdG8gZm9sZGVyMwo+PiArICovCj4+ICsKPj4gKyNpbmNsdWRlICJsYW5kbG9j
a19jb21tb24uaCIKPj4gKwo+PiArI2RlZmluZSBNTlRQT0lOVCAic2FuZGJveCIKPj4gKyNkZWZp
bmUgRElSMSBNTlRQT0lOVCIvZm9sZGVyMSIKPj4gKyNkZWZpbmUgRElSMiBNTlRQT0lOVCIvZm9s
ZGVyMiIKPj4gKyNkZWZpbmUgRElSMyBNTlRQT0lOVCIvZm9sZGVyMyIKPj4gKyNkZWZpbmUgRklM
RU5BTUUxIERJUjEiL2ZpbGUiCj4+ICsjZGVmaW5lIEZJTEVOQU1FMiBESVIyIi9maWxlIgo+PiAr
I2RlZmluZSBGSUxFTkFNRTMgRElSMyIvZmlsZSIKPj4gKwo+PiArc3RhdGljIHN0cnVjdCBsYW5k
bG9ja19ydWxlc2V0X2F0dHIgKnJ1bGVzZXRfYXR0cjsKPj4gK3N0YXRpYyBzdHJ1Y3QgbGFuZGxv
Y2tfcGF0aF9iZW5lYXRoX2F0dHIgKnBhdGhfYmVuZWF0aF9hdHRyOwo+PiArCj4+ICtzdGF0aWMg
dm9pZCBydW4odm9pZCkKPj4gK3sKPj4gKyAgICAgICBpZiAoIVNBRkVfRk9SSygpKSB7Cj4+Cj4K
PiBEbyB3ZSByZWFsbHkgbmVlZCBhIGZvcmsgYW5kIHRlc3QgaW4gY2hpbGRyZW4gaGVyZT8KPgo+
IFllYWgsIHRoZSByZWFzb24gaXMgdGhhdCBzYW5kYm94IGlzIGFjdGl2YXRlZCBmb3IgdGhlIGVu
dGlyZSBwcm9jZXNzLiBUaGF0Cj4gbWVhbnMgdGVtcG9yYXJ5IGZvbGRlciBjbGVhbnVwIG1pZ2h0
IGJlIGFmZmVjdGVkIHdoZW4gd2UgZm9yY2UgcmVhZC1vbmx5Cj4gcnVsZS4KPgoKSSBzZWUsIHRo
YW5rcyEKCj4KPgo+Cj4+ICsgICAgICAgICAgICAgICBUU1RfRVhQX1BBU1MocmVuYW1lKEZJTEVO
QU1FMSwgRklMRU5BTUUyKSk7Cj4+ICsgICAgICAgICAgICAgICBpZiAoVFNUX1JFVCA9PSAtMSkK
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOwo+PiArCj4+ICsgICAgICAgICAgICAg
ICBUU1RfRVhQX0ZBSUwocmVuYW1lKEZJTEVOQU1FMiwgRklMRU5BTUUzKSwgRVhERVYpOwo+Pgo+
CkFuZCBoZXJlIEkgZ3Vlc3Mgd2UgY2FuIG1vdmUgdGhlIGZpbGUyIGJhY2sgdG8gZmlsZTEgdG8g
bWFrZSB0aGUgIi1pIDIiCnBhcmFtZXRlciB3b3JrIG5vcm1hbGx5LgoKICBUU1RfRVhQX1BBU1Mo
cmVuYW1lKEZJTEVOQU1FMiwgRklMRU5BTUUxKSk7CgorCj4+ICsgICAgICAgICAgICAgICBfZXhp
dCgwKTsKPj4gKyAgICAgICB9Cj4+ICt9Cj4+ICsKPj4gK3N0YXRpYyB2b2lkIHNldHVwKHZvaWQp
Cj4+ICt7Cj4+ICsgICAgICAgaW50IHJ1bGVzZXRfZmQ7Cj4+ICsKPj4gKyAgICAgICB2ZXJpZnlf
bGFuZGxvY2tfaXNfZW5hYmxlZCgpOwo+PiArCj4+ICsgICAgICAgU0FGRV9NS0RJUihESVIxLCAw
NjQwKTsKPj4gKyAgICAgICBTQUZFX01LRElSKERJUjIsIDA2NDApOwo+PiArICAgICAgIFNBRkVf
TUtESVIoRElSMywgMDY0MCk7Cj4+ICsgICAgICAgU0FGRV9UT1VDSChGSUxFTkFNRTEsIDA2NDAs
IE5VTEwpOwo+PiArCj4+ICsgICAgICAgdHN0X3JlcyhUSU5GTywgIkFwcGx5aW5nIExBTkRMT0NL
X0FDQ0VTU19GU19SRUZFUiIpOwo+PiArCj4+ICsgICAgICAgcnVsZXNldF9hdHRyLT5oYW5kbGVk
X2FjY2Vzc19mcyA9Cj4+ICsgICAgICAgICAgICAgICBMQU5ETE9DS19BQ0NFU1NfRlNfUkVBRF9G
SUxFIHwKPj4gKyAgICAgICAgICAgICAgIExBTkRMT0NLX0FDQ0VTU19GU19XUklURV9GSUxFIHwK
Pj4gKyAgICAgICAgICAgICAgIExBTkRMT0NLX0FDQ0VTU19GU19SRUZFUjsKPj4gKwo+PiArICAg
ICAgIHJ1bGVzZXRfZmQgPSBTQUZFX0xBTkRMT0NLX0NSRUFURV9SVUxFU0VUKAo+PiArICAgICAg
ICAgICAgICAgcnVsZXNldF9hdHRyLCBzaXplb2Yoc3RydWN0IGxhbmRsb2NrX3J1bGVzZXRfYXR0
ciksIDApOwo+PiArCj4+ICsgICAgICAgYXBwbHlfbGFuZGxvY2tfcnVsZSgKPj4gKyAgICAgICAg
ICAgICAgIHBhdGhfYmVuZWF0aF9hdHRyLAo+PiArICAgICAgICAgICAgICAgcnVsZXNldF9mZCwK
Pj4gKyAgICAgICAgICAgICAgIExBTkRMT0NLX0FDQ0VTU19GU19SRUZFUiwKPj4gKyAgICAgICAg
ICAgICAgIERJUjEpOwo+PiArCj4+ICsgICAgICAgYXBwbHlfbGFuZGxvY2tfcnVsZSgKPj4gKyAg
ICAgICAgICAgICAgIHBhdGhfYmVuZWF0aF9hdHRyLAo+PiArICAgICAgICAgICAgICAgcnVsZXNl
dF9mZCwKPj4gKyAgICAgICAgICAgICAgIExBTkRMT0NLX0FDQ0VTU19GU19SRUZFUiwKPj4gKyAg
ICAgICAgICAgICAgIERJUjIpOwo+PiArCj4+ICsgICAgICAgZW5mb3JjZV9ydWxlc2V0KHJ1bGVz
ZXRfZmQpOwo+PiArCj4+ICsgICAgICAgU0FGRV9DTE9TRShydWxlc2V0X2ZkKTsKPj4gK30KPj4g
Kwo+PiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+PiArICAgICAgIC50ZXN0X2Fs
bCA9IHJ1biwKPj4gKyAgICAgICAuc2V0dXAgPSBzZXR1cCwKPj4gKyAgICAgICAubWluX2t2ZXIg
PSAiNS4xOSIsCj4+ICsgICAgICAgLm5lZWRzX3RtcGRpciA9IDEsCj4+ICsgICAgICAgLm5lZWRz
X3Jvb3QgPSAxLAo+PiArICAgICAgIC5mb3Jrc19jaGlsZCA9IDEsCj4+ICsgICAgICAgLm5lZWRz
X2tjb25maWdzID0gKGNvbnN0IGNoYXIgKltdKSB7Cj4+ICsgICAgICAgICAgICAgICAiQ09ORklH
X1NFQ1VSSVRZX0xBTkRMT0NLPXkiLAo+PiArICAgICAgICAgICAgICAgTlVMTAo+PiArICAgICAg
IH0sCj4+ICsgICAgICAgLmJ1ZnMgPSAoc3RydWN0IHRzdF9idWZmZXJzIFtdKSB7Cj4+ICsgICAg
ICAgICAgICAgICB7JnJ1bGVzZXRfYXR0ciwgLnNpemUgPSBzaXplb2Yoc3RydWN0Cj4+IGxhbmRs
b2NrX3J1bGVzZXRfYXR0cil9LAo+PiArICAgICAgICAgICAgICAgeyZwYXRoX2JlbmVhdGhfYXR0
ciwgLnNpemUgPSBzaXplb2Yoc3RydWN0Cj4+IGxhbmRsb2NrX3BhdGhfYmVuZWF0aF9hdHRyKX0s
Cj4+ICsgICAgICAgICAgICAgICB7fSwKPj4gKyAgICAgICB9LAo+PiArICAgICAgIC5jYXBzID0g
KHN0cnVjdCB0c3RfY2FwIFtdKSB7Cj4+ICsgICAgICAgICAgICAgICBUU1RfQ0FQKFRTVF9DQVBf
UkVRLCBDQVBfU1lTX0FETUlOKSwKPj4gKyAgICAgICAgICAgICAgIHt9Cj4+ICsgICAgICAgfSwK
Pj4gKyAgICAgICAuZm9ybWF0X2RldmljZSA9IDEsCj4+ICsgICAgICAgLm1vdW50X2RldmljZSA9
IDEsCj4+ICsgICAgICAgLm1udHBvaW50ID0gTU5UUE9JTlQsCj4+ICsgICAgICAgLmFsbF9maWxl
c3lzdGVtcyA9IDEsCj4+ICsgICAgICAgLnNraXBfZmlsZXN5c3RlbXMgPSAoY29uc3QgY2hhciAq
W10pIHsKPj4gKyAgICAgICAgICAgICAgICJ2ZmF0IiwKPj4gKyAgICAgICAgICAgICAgIE5VTEwK
Pj4gKyAgICAgICB9LAo+PiArfTsKPj4KPj4gLS0KPj4gMi40My4wCj4+Cj4+Cj4+IC0tCj4+IE1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Pgo+
Pgo+Cj4gLS0KPiBSZWdhcmRzLAo+IExpIFdhbmcKPgo+IEFuZHJlYQo+CgoKLS0gClJlZ2FyZHMs
CkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
