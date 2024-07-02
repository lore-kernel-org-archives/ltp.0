Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7C7C30658
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 12:23:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 832083D3EC8
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 14:23:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 705FA3D3E89
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 14:23:09 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 53AA214044D1
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 14:23:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719922985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B1RZ0UxB1hla/r3fqOA1FLE0D7zLTLjcAAiogHByEaA=;
 b=gVM6Wr57Q/eLIaZgGtT8tD6pBySKYoPuWr0F1tR13mUPqg49daR3GWyok5fFC7+w78BhTG
 mhdygZppduHkcH14vjAqsi0xdQE9pAm5CL5WdRSSXuhPKU9ZefIQKGTJ92nbkL5zi+SaW6
 /f5vPdpz/xoWnrMO4NZYINZkRn/ik8s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-WeFxSrvIP6y1k1-QKsFESQ-1; Tue, 02 Jul 2024 08:23:03 -0400
X-MC-Unique: WeFxSrvIP6y1k1-QKsFESQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c924a5edaaso3775562a91.2
 for <ltp@lists.linux.it>; Tue, 02 Jul 2024 05:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719922981; x=1720527781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B1RZ0UxB1hla/r3fqOA1FLE0D7zLTLjcAAiogHByEaA=;
 b=py2x4JpZSPNLUI6k8I+IxESP9Z9pRkxGenallZCvFq4OQcN5jjJCs3/s3AI9VWbS2f
 UUoxYf6kdnCcPSnimiUdI6aDVd+X+G9Vlb7JW/uygrI5mwjl7MhZuYFjcWMvA1qCAz2r
 +OtejiGUoPnjfI5iI+LSZLQFTHGtYgCZcpczlJfzKZPcRqHOl/8NPLXumRES6yI+SBuo
 nqQLjLgHaYFYEN+CrY97L8xfMEe+fPJGMauuwS5mPfyCSGiWAnUggjiycdz7x57zcrQF
 UCGHvrf+Fs/+uGb8LmYtb7wjzCW/eOIqLZCPdifz0HihqgZ3YKEN7yl0maQq+Go7cItG
 XGDA==
X-Gm-Message-State: AOJu0YwY/qaAakF53guioBChuoHHaHKEWNlOL4MmgUevACsEG8fSVGyt
 iXweSgUPh3D+nHJKOuhmFSv2jR3djvo4nU+k0d6C0EAvcxT9Ag7XvrjX+Hh/Z8idoqArxbudgqm
 mGBKm+ZneuEi5SG87jnwpv0hGfTidRAGHjUTKCBGjSA0ajLe6BQwnH5FjJu6ujwluYMNAoL266H
 WBpsEiZjl+pX1i1HXs2FddNYPjjo/eONxVEqz0
X-Received: by 2002:a17:90a:c28d:b0:2c9:6278:27bd with SMTP id
 98e67ed59e1d1-2c962782978mr839175a91.3.1719922981342; 
 Tue, 02 Jul 2024 05:23:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWrIamqccCauKu0MCjaYuuyyVmOitEx8DoVOw7KL+aWfS5feNcdX/VnSsuG7ZbXS81bsPATWv893cRxEhKd7o=
X-Received: by 2002:a17:90a:c28d:b0:2c9:6278:27bd with SMTP id
 98e67ed59e1d1-2c962782978mr839165a91.3.1719922980989; Tue, 02 Jul 2024
 05:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
 <20240701-landlock-v1-8-58e9af649a72@suse.com>
 <CAEemH2f_Tq0W46x61FokVYwv4sK=8NhwfM5SY-gj1znbGnAmFg@mail.gmail.com>
In-Reply-To: <CAEemH2f_Tq0W46x61FokVYwv4sK=8NhwfM5SY-gj1znbGnAmFg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 2 Jul 2024 20:22:48 +0800
Message-ID: <CAEemH2cM6DMQZ-3j3sQ-0b1zD-rfeaCRTefO00wMnGqYeLn+Pw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 08/10] Add landlock04 test
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

T24gVHVlLCBKdWwgMiwgMjAyNCBhdCA0OjAw4oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgoKPgo+Cj4gT24gTW9uLCBKdWwgMSwgMjAyNCBhdCAxMTo0NOKAr1BNIEFuZHJl
YSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5kZT4KPiB3cm90ZToKPgo+PiBGcm9t
OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+Pgo+PiBUaGlz
IHRlc3QgdmVyaWZpZXMgdGhhdCBhbGwgbGFuZGxvY2sgcnVsZXMgYXJlIHdvcmtpbmcgcHJvcGVy
bHkuCj4+IFRoZSB3YXkgd2UgZG8gaXQgaXMgdG8gdmVyaWZ5IHRoYXQgYWxsIGRpc2FibGVkIHN5
c2NhbGxzIGFyZSBub3QKPj4gd29ya2luZyBidXQgdGhlIG9uZSB3ZSBlbmFibGVkIHZpYSBzcGVj
aWZjIGxhbmRsb2NrIHJ1bGVzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVzYXRv
IDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+PiAtLS0KPj4gIHJ1bnRlc3Qvc3lzY2FsbHMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsKPj4gIHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svLmdpdGlnbm9yZSAgICAgIHwgICAyICsKPj4gIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svTWFrZWZpbGUgICAgICAgIHwgICA1ICsKPj4g
IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svbGFuZGxvY2swNC5jICAgIHwgMTQz
ICsrKysrKysrKwo+PiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sYW5kbG9jay9sYW5kbG9j
a19leGVjLmMgfCAgIDkgKwo+PiAgLi4uL2tlcm5lbC9zeXNjYWxscy9sYW5kbG9jay9sYW5kbG9j
a190ZXN0ZXIuaCAgICAgfCAzNTAKPj4gKysrKysrKysrKysrKysrKysrKysrCj4+ICA2IGZpbGVz
IGNoYW5nZWQsIDUxMCBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9ydW50ZXN0L3N5
c2NhbGxzIGIvcnVudGVzdC9zeXNjYWxscwo+PiBpbmRleCAxZTJkNjgyZTMuLjlhY2RhZjc2MCAx
MDA2NDQKPj4gLS0tIGEvcnVudGVzdC9zeXNjYWxscwo+PiArKysgYi9ydW50ZXN0L3N5c2NhbGxz
Cj4+IEBAIC02ODcsNiArNjg3LDcgQEAga2lsbDEzIGtpbGwxMwo+PiAgbGFuZGxvY2swMSBsYW5k
bG9jazAxCj4+ICBsYW5kbG9jazAyIGxhbmRsb2NrMDIKPj4gIGxhbmRsb2NrMDMgbGFuZGxvY2sw
Mwo+PiArbGFuZGxvY2swNCBsYW5kbG9jazA0Cj4+Cj4+ICBsY2hvd24wMSBsY2hvd24wMQo+PiAg
bGNob3duMDFfMTYgbGNob3duMDFfMTYKPj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvbGFuZGxvY2svLmdpdGlnbm9yZQo+PiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvbGFuZGxvY2svLmdpdGlnbm9yZQo+PiBpbmRleCBmNzljZDA5MGIuLjRmZThkN2NiYSAxMDA2
NDQKPj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sYW5kbG9jay8uZ2l0aWdub3Jl
Cj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svLmdpdGlnbm9yZQo+
PiBAQCAtMSwzICsxLDUgQEAKPj4gK2xhbmRsb2NrX2V4ZWMKPj4gIGxhbmRsb2NrMDEKPj4gIGxh
bmRsb2NrMDIKPj4gIGxhbmRsb2NrMDMKPj4gK2xhbmRsb2NrMDQKPj4gZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svTWFrZWZpbGUKPj4gYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrL01ha2VmaWxlCj4+IGluZGV4IDRiM2UzZmQ4Zi4uYmRj
NmJkMmQ0IDEwMDY0NAo+PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xhbmRsb2Nr
L01ha2VmaWxlCj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svTWFr
ZWZpbGUKPj4gQEAgLTgsMyArOCw4IEBAIGluY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21r
L3Rlc3RjYXNlcy5tawo+PiAgTERMSUJTICs9IC1sYwo+Pgo+PiAgaW5jbHVkZSAkKHRvcF9zcmNk
aXIpL2luY2x1ZGUvbWsvZ2VuZXJpY19sZWFmX3RhcmdldC5tawo+PiArCj4+ICsjIHRoZSByZWFz
b24gd2h5IGxhbmRsb2NrX2V4ZWMgdGVzdCBiaW5hcnkgaXMgc3RhdGljYWxseSBsaW5rZWQsIGlz
IHRoYXQKPj4gKyMgd2UgY2FuJ3QgcmVhZCBsaWJjIG91dCBvZiB0aGUgc2FuZGJveGVkIGZvbGRl
ciBvbmNlCj4+IExBTkRMT0NLX0FDQ0VTU19GU19FWEVDVVRFCj4+ICsjIGhhcyBiZWVuIGFjdGl2
YXRlZAo+PiArbGFuZGxvY2tfZXhlYzogTERMSUJTICs9IC1zdGF0aWMgLWZQSUMKPj4KPgpBbmQs
IGlmIHdlIGRlY2lkZWQgdG8gYnVpbGQgdGhlIHByb2dyYW0gYXMgc3RhdGljLCB3ZSdkIGJldHRl
cgphZGRpbmcgZ2xpYmMtc3RhdGljIGludG8gdGhlIGRlcGVuZGVuY3kgbGlzdCwgb3RoZXJ3aXNl
IGl0IGFsd2F5cwpmYWlsZWQgdG8gbGluayB0aGUgYmluYXJ5IG9uIFJIRUwgZGlzdHJpYnV0aW9u
cy4KCi0tLSBhL2NpL2ZlZG9yYS5zaAorKysgYi9jaS9mZWRvcmEuc2gKQEAgLTE3LDYgKzE3LDcg
QEAgJHl1bSBcCiAgICAgICAgbnVtYWN0bC1kZXZlbCBcCiAgICAgICAgbGlidGlycGMgXAogICAg
ICAgIGxpYnRpcnBjLWRldmVsIFwKKyAgICAgICBsaWJjLXN0YXRpYyBcCiAgICAgICAgcGVybC1K
U09OIFwKICAgICAgICBwZXJsLWxpYnd3dy1wZXJsIFwKICAgICAgICBwa2ctY29uZmlnIFwKCgoK
LS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
