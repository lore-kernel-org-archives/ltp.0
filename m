Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76A9C77B6E
	for <ltp@archiver.kernel.org>; Wed, 12 Apr 2023 11:46:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E74443CC63C
	for <ltp@archiver.kernel.org>; Wed, 12 Apr 2023 13:46:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C634A3CA84C
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 13:46:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id CB9171A0088A
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 13:46:14 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9409FD75;
 Wed, 12 Apr 2023 04:46:56 -0700 (PDT)
Received: from [10.1.197.61] (unknown [10.1.197.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 956373F73F;
 Wed, 12 Apr 2023 04:46:11 -0700 (PDT)
Message-ID: <a35f8c15-e599-2366-82ff-3025158d14c9@arm.com>
Date: Wed, 12 Apr 2023 12:45:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20230331000747.2294390-1-edliaw@google.com>
 <c766ddbe-f991-9304-0dec-ecf795a788db@arm.com>
 <CAG4es9VrznF_X=3msWZQfcKOjn-tu8s_rV4Kq_tVWde=JUWxtg@mail.gmail.com>
 <bef924f6-9b29-cf36-a15a-7edfe5a92e4d@arm.com>
 <20230411230548.GB1798729@pevik>
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <20230411230548.GB1798729@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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

SGkgUGV0ciwKCk9uIDEyLzA0LzIwMjMgMDA6MDUsIFBldHIgVm9yZWwgd3JvdGU6Cj4gSGkgYWxs
LAo+Cj4gWyBDYyBBdmluZXNoLCB3aG8gYWxzbyBwb3N0ZWQgcmV2aWV3IF0KPgo+PiBPbiAxMS8w
NC8yMDIzIDAwOjUxLCBFZHdhcmQgTGlhdyB3cm90ZToKPj4+IE9uIEZyaSwgQXByIDcsIDIwMjMg
YXQgMzoxOOKAr0FNIFRlbyBDb3VwcmllIERpYXogPHRlby5jb3VwcmllZGlhekBhcm0uY29tPiB3
cm90ZToKPj4+PiBIb3dldmVyLCBJIGhhdmUgZW5jb3VudGVyZWQgYW4gaXNzdWUgb24gdGhlIHNh
bWUgY2hlY2sgb2YgdGhpcyB0ZXN0LAo+Pj4+IHVucmVsYXRlZCB0byBFZHdhcmQncyBpc3N1ZS4K
Pj4+PiBJbmRlZWQsIG9uIHN5c3RlbXMgdGhhdCBydW4gdGhlIHNoZWxsIGFzIFBJRCAxIChmb3Ig
ZXhhbXBsZSBhIGJhc2ljCj4+Pj4gYnVzeWJveCByb290ZnMpIHRoZSBFUEVSTSBjaGVjayB3b3Vs
ZG4ndCB3b3JrLgo+Pj4+IFRoaXMgaXMgYmVjYXVzZSBMVFAgd291bGQgcnVuIHdpdGhpbiB0aGUg
c2FtZSBzZXNzaW9uIElEIGFzIGluaXQsIHdoaWNoCj4+Pj4gd291bGQgYWxsb3cgdGhlIHRlc3Qg
dG8gY2hhbmdlIHRoZSBQR0lEIGFuZCBub3QgdHJpZ2dlciB0aGUgRVBFUk0uCj4+Pj4gSSBhbSB3
b3JraW5nIG9uIGEgcGF0Y2ggYW5kIHdhbnRlZCB0byBnZXQgc29tZSBpbnB1dC4gTXkgY3VycmVu
dCBpZGVhCj4+Pj4gd291bGQgYmUgdG8gZm9yayBhIGNoaWxkIHRoYXQgd291bGQgY3JlYXRlIGEg
bmV3IHNlc3Npb24gYW5kIHRyeSB0bwo+Pj4+IHNldHBnaWQoKSB0aGUgY2hpbGQuCj4+Pj4gVGhp
cyB3b3VsZCBhbHNvIGFsbG93IHRvIHVzZSB0aGUgbWFpbiBwcm9jZXNzJyBQR0lELCBhcyBpdCB3
b3VsZCBiZSBpbgo+Pj4+IGFub3RoZXIgc2Vzc2lvbiBmcm9tIHRoZSBjaGlsZCBhbnl3YXkuIFRo
aXMgd291bGQgcmVtb3ZlIHRoZSBuZWVkIHRvCj4+Pj4gZ2V0cGdpZCgpIGluaXQsIHdoaWNoIGhv
cGVmdWxseSBzaG91bGQgZml4IHlvdXIgaXNzdWUgb24gQW5kcm9pZCBhcyB3ZWxsLgo+Pj4gVGhh
dCBtYWtlcyBzZW5zZSB0byBtZSwgYnV0IGl0IHNlZW1zIHRvIG1lIHRoYXQgc2V0cGdpZDAzIGlz
IGFscmVhZHkKPj4+IHRlc3RpbmcgaXQgdGhhdCB3YXkuCj4+IEFoLCB5ZXMgaW5kZWVkIGl0IGlz
IHRlc3RpbmcgaXQgZXhhY3RseSBsaWtlIHRoYXQuCj4gR29vZCBjYXRjaCEKPgo+Pj4+IEhvd2V2
ZXIsIHRoaXMgYWRkcyBhIGxvdCBtb3JlIGNvbXBsZXhpdHkgaW4gdGhlIHRlc3Q6IG5lZWRpbmcg
dG8gZm9yawo+Pj4+IGFuZCBzeW5jaHJvbml6ZSB3aXRoIHRoZSBjaGlsZCBhcyB0aGUgbWFpbiBw
cm9jZXNzIG5lZWRzIHRvIHdhaXQgZm9yIHRoZQo+Pj4+IGNoaWxkIHRvIGNoYW5nZSBpdHMgc2Vz
c2lvbiBJRCwgb3RoZXJ3aXNlIHRoZSB0ZXN0IHdvdWxkIGZhaWwuCj4+Pj4gRG8geW91IHRoaW5r
IHRoaXMgaWRlYSBtYWtlcyBzZW5zZSA/IEkgd291bGQgc2VuZCBpdCBmb3IgcmV2aWV3IG9uY2Ug
SQo+Pj4+IGlyb25lZCBvdXQgdGhlIHBhdGNoLgo+Pj4+IEFub3RoZXIgc29sdXRpb24gd291bGQg
YmUgZm9yIExUUCB0byBjaGFuZ2UgaXRzIHNlc3Npb24gSUQgYnkgZGVmYXVsdCwKPj4+PiB3aGlj
aCB3b3VsZCBwcmV2ZW50IHRoZSBuZWVkIGZvciBhIGNoYW5nZSB0byBzZXRwZ2lkMDIgb24gdG9w
IG9mIEVkd2FyZCdzLgo+Pj4+IEhvd2V2ZXIsIEkgZG9uJ3QgZnVsbHkgdW5kZXJzdGFuZCB0aGUg
cG9zc2libGUgY29uc2VxdWVuY2VzIG9mIGhhdmluZwo+Pj4+IExUUCBjaGFuZ2UgaXRzIFNJRCBm
b3IgYWxsIHRlc3RzLgo+Pj4gQWx0ZXJuYXRpdmVseSwgbWF5YmUgaXQgY291bGQgYmUgcmV2ZXJ0
ZWQgdG8gdXNpbmcgdGhlIGhhcmRjb2RlZCA5OTk5OQo+Pj4gYXMgYW4gaW52YWxpZCBQR0lEIGFz
IGl0IHdhcyBiZWZvcmUgQXZpbmVzaCdzIHBhdGNoIG9yIHRoZSB0ZXN0IGNhc2UKPj4+IHJlbW92
ZWQgYmVjYXVzZSBpdCBpcyBoYW5kbGVkIGluIHNldHBnaWQwMz8KPj4gSSBmZWVsIHRoYXQgaXQg
d291bGQgbWFrZSBzZW5zZSB0byByZW1vdmUgdGhlIHRlc3QgY2FzZSBhcyBpdCdzIHRlc3RlZCBh
cyBpcwo+PiBpbiBzZXRwZ2lkMDMuIEV2ZW4gdGhlIGNvbW1lbnRzIGZvciB0aGUgRVBFUk0gY2Fz
ZXMgYXJlIGlkZW50aWNhbCBpbgo+PiBtZWFuaW5nLgo+IEkgZG9uJ3Qgd2FudCB0byBhZGQgYW4g
dWx0aW1hdGUgYW5zd2VyIChub3Qgc3VyZSBteXNlbGYpLCBidXQgSU1ITyB0aGVzZQo+IHNldHBn
aWQwMy5jIGFuZCBzZXRwZ2lkMDIuYyBhcmVuJ3QgdGhlIHNhbWUsIGJlY2F1c2Ugc2V0cGdpZDAz
LmMgY2FsbHM6Cj4gMSkgdGhlIGZvcmsoKSB5b3UgbWVudGlvbmVkCj4gMikgc2V0c2lkKCkgKHZp
YSBTQUZFX1NFVFNJRCgpKQo+Cj4gVGhlcmVmb3JlIHRoZSBFUEVSTSBtZWFuaW5nIGlzIHRoZSBz
YW1lLCBJTUhPIHRoZSBjb2RlIHBhdGggaW4ga2VybmVsIGFuZCBsaWJjCj4gaXMgbm90IHRoZSBz
YW1lLgpJIHNlZSwgdGhhdCdzIGZhaXIuIEkgd291bGQgdGVuZCB0byBhZ3JlZSB0aGVuIGFuZCBs
ZWF2ZSBpdCBqdXN0IGZvciB0aGUgCnBvdGVudGlhbApkaWZmZXJlbmNlIGluIGNvdmVyYWdlLgo+
PiBJZiBpdCBpcyB0byBiZSBrZXB0LCBJIHRoaW5rIGl0IGNvdWxkIGJlIGJldHRlciB0byB1c2Ug
dGhlIGtlcm5lbCBwaWRfbWF4Cj4+IHJhdGhlciB0aGFuCj4+IGFuIGhhcmRjb2RlZCB2YWx1ZSAo
Zm9yIGV4YW1wbGUgOTk5OTkgd291bGQgYmUgcG9zc2libGUgb24gbXkgbWFjaGluZSksIGJ1dAo+
PiBJIGFncmVlIGl0IHdvdWxkIGJlIGZpbmUuCj4gQmFzZWQgdG8gZjI3OTdmYTQ0IGNvbW1pdCBt
ZXNzYWdlIGFuZCBteSBtZW1vcnkgSSBndWVzcyBBdmluZXNoIHVzZWQgUElEIDEgYXMKPiB0aGF0
J3MgMTAwJSBzdXJlIGl0J3MgZGlmZmVyZW50IGZyb20gd2hhdGV2ZXIgcHJvY2VzcyBncm91cCBj
b3VsZCBMVFAgdGVzdCBoYXZlLgo+IEJ1dCBJTUhPIHRoYXQncyBub3QgbmVjZXNzYXJ5LCBiZWNh
dXNlIFBHSUQgb2YgYm90aCBzZXRwZ2lkMDIgcHJvY2Vzc2VzIGlzCj4gYWx3YXlzIHRoZSBzYW1l
IGFzIFBJRDoKPgo+ICQgcHMgeGFvIHVzZXIscGlkLHBwaWQscGdpZCxzaWQsY29tbSB8IGdyZXAg
LWUgXlVTRVIgLWUgc2V0cGdpZDAyCj4gVVNFUiAgICAgICAgIFBJRCAgICBQUElEICAgIFBHSUQg
ICAgIFNJRCBDT01NQU5ECj4gcGV2aWsgICAgMTgyMjA2MyAxODIwOTAwIDE4MjIwNjMgMTgyMDkw
MCBzZXRwZ2lkMDIKPiBwZXZpayAgICAxODIyMDY0IDE4MjIwNjMgMTgyMjA2NCAxODIwOTAwIHNl
dHBnaWQwMgo+Cj4gVGhlcmVmb3JlIGFueSBQSUQgd291bGQgd29yayA9PiBzdXJlLCBzY2Fubmlu
ZyAvcHJvYy9zeXMva2VybmVsL3BpZF9tYXggTEdUTToKPiBTQUZFX0ZJTEVfU0NBTkYoIi9wcm9j
L3N5cy9rZXJuZWwvcGlkX21heCIsICIlbHUiLCAmcGlkX21heCk7CklmIHRoZXJlIGFyZSBubyBv
YmplY3Rpb25zIEkgd2lsbCBzZW5kIGEgcGF0Y2ggaW4gdGhlIGNvbWluZyBkYXlzIHRoZW4sIAp0
aGFua3MuCj4KPj4gQWRkaW5nIFBldHIgVm9yZWwgdG8gQ0NzIGFzIGhlIHJldmlld2VkIEF2aW5l
c2gncyBwYXRjaC4KPiBUaGFua3MhIEkgYWxyZWFkeSBwb3N0ZWQgbXkgcmV2aWV3LCBidXQgbWlz
c2VkIGZvbGxvd2luZyBkaXNjdXNzaW9uLgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKTm8gd29y
cmllcywgdGhhbmtzIGZvciBjaGltaW5nIGluLgpCZXN0IHJlZ2FyZHMKVMOpbwo+Cj4+PiBUaGFu
a3MsCj4+PiBFZHdhcmQKPj4gVGhhbmtzIGZvciBjb21pbmcgYmFjayB0byBtZSwKPj4gQmVzdCBy
ZWdhcmRzCj4+IFTDqW8KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
