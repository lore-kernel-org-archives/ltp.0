Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4403C7619A
	for <ltp@archiver.kernel.org>; Tue, 11 Apr 2023 10:36:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 162F63CC83C
	for <ltp@archiver.kernel.org>; Tue, 11 Apr 2023 12:36:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86D0C3CC552
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 12:36:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 212DB10005B9
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 12:35:59 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AC28D75;
 Tue, 11 Apr 2023 03:36:42 -0700 (PDT)
Received: from [10.1.27.14] (e126380.cambridge.arm.com [10.1.27.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 205A03F73F;
 Tue, 11 Apr 2023 03:35:56 -0700 (PDT)
Message-ID: <bef924f6-9b29-cf36-a15a-7edfe5a92e4d@arm.com>
Date: Tue, 11 Apr 2023 11:35:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: Edward Liaw <edliaw@google.com>
References: <20230331000747.2294390-1-edliaw@google.com>
 <c766ddbe-f991-9304-0dec-ecf795a788db@arm.com>
 <CAG4es9VrznF_X=3msWZQfcKOjn-tu8s_rV4Kq_tVWde=JUWxtg@mail.gmail.com>
Content-Language: en-US
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <CAG4es9VrznF_X=3msWZQfcKOjn-tu8s_rV4Kq_tVWde=JUWxtg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] setpgid02: use 1 instead of getpgid(1)
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMTEvMDQvMjAyMyAwMDo1MSwgRWR3YXJkIExpYXcgd3JvdGU6Cgo+IE9uIEZyaSwgQXByIDcs
IDIwMjMgYXQgMzoxOOKAr0FNIFRlbyBDb3VwcmllIERpYXogPHRlby5jb3VwcmllZGlhekBhcm0u
Y29tPiB3cm90ZToKPj4gSG93ZXZlciwgSSBoYXZlIGVuY291bnRlcmVkIGFuIGlzc3VlIG9uIHRo
ZSBzYW1lIGNoZWNrIG9mIHRoaXMgdGVzdCwKPj4gdW5yZWxhdGVkIHRvIEVkd2FyZCdzIGlzc3Vl
Lgo+Pgo+PiBJbmRlZWQsIG9uIHN5c3RlbXMgdGhhdCBydW4gdGhlIHNoZWxsIGFzIFBJRCAxIChm
b3IgZXhhbXBsZSBhIGJhc2ljCj4+IGJ1c3lib3ggcm9vdGZzKSB0aGUgRVBFUk0gY2hlY2sgd291
bGRuJ3Qgd29yay4KPj4gVGhpcyBpcyBiZWNhdXNlIExUUCB3b3VsZCBydW4gd2l0aGluIHRoZSBz
YW1lIHNlc3Npb24gSUQgYXMgaW5pdCwgd2hpY2gKPj4gd291bGQgYWxsb3cgdGhlIHRlc3QgdG8g
Y2hhbmdlIHRoZSBQR0lEIGFuZCBub3QgdHJpZ2dlciB0aGUgRVBFUk0uCj4+Cj4+IEkgYW0gd29y
a2luZyBvbiBhIHBhdGNoIGFuZCB3YW50ZWQgdG8gZ2V0IHNvbWUgaW5wdXQuIE15IGN1cnJlbnQg
aWRlYQo+PiB3b3VsZCBiZSB0byBmb3JrIGEgY2hpbGQgdGhhdCB3b3VsZCBjcmVhdGUgYSBuZXcg
c2Vzc2lvbiBhbmQgdHJ5IHRvCj4+IHNldHBnaWQoKSB0aGUgY2hpbGQuCj4+IFRoaXMgd291bGQg
YWxzbyBhbGxvdyB0byB1c2UgdGhlIG1haW4gcHJvY2VzcycgUEdJRCwgYXMgaXQgd291bGQgYmUg
aW4KPj4gYW5vdGhlciBzZXNzaW9uIGZyb20gdGhlIGNoaWxkIGFueXdheS4gVGhpcyB3b3VsZCBy
ZW1vdmUgdGhlIG5lZWQgdG8KPj4gZ2V0cGdpZCgpIGluaXQsIHdoaWNoIGhvcGVmdWxseSBzaG91
bGQgZml4IHlvdXIgaXNzdWUgb24gQW5kcm9pZCBhcyB3ZWxsLgo+Pgo+IFRoYXQgbWFrZXMgc2Vu
c2UgdG8gbWUsIGJ1dCBpdCBzZWVtcyB0byBtZSB0aGF0IHNldHBnaWQwMyBpcyBhbHJlYWR5Cj4g
dGVzdGluZyBpdCB0aGF0IHdheS4KQWgsIHllcyBpbmRlZWQgaXQgaXMgdGVzdGluZyBpdCBleGFj
dGx5IGxpa2UgdGhhdC4KPgo+PiBIb3dldmVyLCB0aGlzIGFkZHMgYSBsb3QgbW9yZSBjb21wbGV4
aXR5IGluIHRoZSB0ZXN0OiBuZWVkaW5nIHRvIGZvcmsKPj4gYW5kIHN5bmNocm9uaXplIHdpdGgg
dGhlIGNoaWxkIGFzIHRoZSBtYWluIHByb2Nlc3MgbmVlZHMgdG8gd2FpdCBmb3IgdGhlCj4+IGNo
aWxkIHRvIGNoYW5nZSBpdHMgc2Vzc2lvbiBJRCwgb3RoZXJ3aXNlIHRoZSB0ZXN0IHdvdWxkIGZh
aWwuCj4+Cj4+IERvIHlvdSB0aGluayB0aGlzIGlkZWEgbWFrZXMgc2Vuc2UgPyBJIHdvdWxkIHNl
bmQgaXQgZm9yIHJldmlldyBvbmNlIEkKPj4gaXJvbmVkIG91dCB0aGUgcGF0Y2guCj4+IEFub3Ro
ZXIgc29sdXRpb24gd291bGQgYmUgZm9yIExUUCB0byBjaGFuZ2UgaXRzIHNlc3Npb24gSUQgYnkg
ZGVmYXVsdCwKPj4gd2hpY2ggd291bGQgcHJldmVudCB0aGUgbmVlZCBmb3IgYSBjaGFuZ2UgdG8g
c2V0cGdpZDAyIG9uIHRvcCBvZiBFZHdhcmQncy4KPj4gSG93ZXZlciwgSSBkb24ndCBmdWxseSB1
bmRlcnN0YW5kIHRoZSBwb3NzaWJsZSBjb25zZXF1ZW5jZXMgb2YgaGF2aW5nCj4+IExUUCBjaGFu
Z2UgaXRzIFNJRCBmb3IgYWxsIHRlc3RzLgo+Pgo+IEFsdGVybmF0aXZlbHksIG1heWJlIGl0IGNv
dWxkIGJlIHJldmVydGVkIHRvIHVzaW5nIHRoZSBoYXJkY29kZWQgOTk5OTkKPiBhcyBhbiBpbnZh
bGlkIFBHSUQgYXMgaXQgd2FzIGJlZm9yZSBBdmluZXNoJ3MgcGF0Y2ggb3IgdGhlIHRlc3QgY2Fz
ZQo+IHJlbW92ZWQgYmVjYXVzZSBpdCBpcyBoYW5kbGVkIGluIHNldHBnaWQwMz8KSSBmZWVsIHRo
YXQgaXQgd291bGQgbWFrZSBzZW5zZSB0byByZW1vdmUgdGhlIHRlc3QgY2FzZSBhcyBpdCdzIHRl
c3RlZCBhcyBpcwppbiBzZXRwZ2lkMDMuIEV2ZW4gdGhlIGNvbW1lbnRzIGZvciB0aGUgRVBFUk0g
Y2FzZXMgYXJlIGlkZW50aWNhbCBpbiAKbWVhbmluZy4KCklmIGl0IGlzIHRvIGJlIGtlcHQsIEkg
dGhpbmsgaXQgY291bGQgYmUgYmV0dGVyIHRvIHVzZSB0aGUga2VybmVsIApwaWRfbWF4IHJhdGhl
ciB0aGFuCmFuIGhhcmRjb2RlZCB2YWx1ZSAoZm9yIGV4YW1wbGUgOTk5OTkgd291bGQgYmUgcG9z
c2libGUgb24gbXkgbWFjaGluZSksIGJ1dApJIGFncmVlIGl0IHdvdWxkIGJlIGZpbmUuCgpBZGRp
bmcgUGV0ciBWb3JlbCB0byBDQ3MgYXMgaGUgcmV2aWV3ZWQgQXZpbmVzaCdzIHBhdGNoLgo+Cj4g
VGhhbmtzLAo+IEVkd2FyZApUaGFua3MgZm9yIGNvbWluZyBiYWNrIHRvIG1lLApCZXN0IHJlZ2Fy
ZHMKVMOpbwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
