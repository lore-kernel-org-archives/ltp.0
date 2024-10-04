Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572E7CFA775
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 12:51:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8D643C62BB
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 14:51:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 203333C61AE
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 14:51:00 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E48D8206C37
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 14:50:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728046258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZVF8DgPOYH31LJm3NWs4Ti1Tq8gTaEHw5QsDrHnfb/s=;
 b=Z3QJrdpS7iQuZ/ih39BYvwOwtkoy2KyLtqdERxDBSasUtMmj9TzkyH2xtDOuRs+ztb/sX1
 xSjo/YMuB0VgBhhX80/Ti2384uNAny/TsMRC6glPJVO38c9rdeH8iQ84eRY6SHALbv/Sr0
 72H4zBG3euJJ8qy92MbVe3StXqg1nzY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-tYJUq-t_PSql7ZnUSdse1Q-1; Fri, 04 Oct 2024 08:50:57 -0400
X-MC-Unique: tYJUq-t_PSql7ZnUSdse1Q-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3e27a10ae79so1973877b6e.0
 for <ltp@lists.linux.it>; Fri, 04 Oct 2024 05:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728046256; x=1728651056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZVF8DgPOYH31LJm3NWs4Ti1Tq8gTaEHw5QsDrHnfb/s=;
 b=IDGe/o5vA1G4rp+a+xFFned3O2nF/FGK0F7LcLp0opMu9pmn1L3XFXP29Qjcd98gJ8
 /Dk6TqoB1ZyztZNCspO+4WOXJVVuI9b7Pd/FcZHCreg+FNhXZSj9hko6X/DqldDUXQp1
 NWt6X9jttW67XT3cF6uWFPGlWoFzwdHN4EfEdR9AjKDkDKY4+rTr/Xksj0V0i+m3mdV+
 rLHTkCXOXD3x9vgPBl8KNj8L/4ifQLnMGNdBRFN6rxsHQqYyc8MZATPoCZxqnIEgHV6R
 fxxLvn7fZ0UlCgiYNMA9O8J9q9Lf+U/EvGYDfj6KTJfHNMllvA2Y6KZAnw7O8umvv1zj
 Ml+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVURhS97qlAAC6DqPngG7EWIboBfyv2qO2xX9AwRz3K9V9uR9NAqtYScjlFPtDw2v8yrvk=@lists.linux.it
X-Gm-Message-State: AOJu0YzAOlEL4KneOhFIICeGOZkYfwK4hfh2XxW6NB7SfpB0MDUbb0Mk
 cn/Ipzq48/tVv6iWGxB2h1S74/3a5332oE7eX1vk4ZMb4U52dFv8c3epf4Z0fciGk6caX7LF3qf
 Pbyl9xomi7GPh6KCF4BiDRwkPtolCjILjeWiqrwn/vk+QiOXioKTS9v2hCAZuAm+wQAnYE5/PJw
 /Gj/1XzBcz7yu7Yojo+53egWc=
X-Received: by 2002:a05:6808:448c:b0:3e3:c411:5e86 with SMTP id
 5614622812f47-3e3c411848dmr812695b6e.35.1728046256533; 
 Fri, 04 Oct 2024 05:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpqfAKYzgpxhx1Y0BybucSFPMqmPot5eRKUtb/w2XIi6XfDKI/xhyBng1Hj827T1HCrAcFDKKTHQWLD2IflRU=
X-Received: by 2002:a05:6808:448c:b0:3e3:c411:5e86 with SMTP id
 5614622812f47-3e3c411848dmr812677b6e.35.1728046256097; Fri, 04 Oct 2024
 05:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201241.27286-1-jack@suse.cz> <Zvp6L+oFnfASaoHl@t14s>
 <20240930113434.hhkro4bofhvapwm7@quack3>
 <CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 4 Oct 2024 14:50:40 +0200
Message-ID: <CAASaF6yASRgEKfhAVktFit31Yw5e9gwMD0jupchD0gWK9EppTw@mail.gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ext4: don't set SB_RDONLY after filesystem errors
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
Cc: Christian Brauner <brauner@kernel.org>, Ted Tso <tytso@mit.edu>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBPY3QgNCwgMjAyNCBhdCAyOjMy4oCvUE0gQW1pciBHb2xkc3RlaW4gPGFtaXI3M2ls
QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIFNlcCAzMCwgMjAyNCBhdCAxOjM04oCvUE0g
SmFuIEthcmEgPGphY2tAc3VzZS5jej4gd3JvdGU6Cj4gPgo+ID4gT24gTW9uIDMwLTA5LTI0IDEy
OjE1OjExLCBKYW4gU3RhbmNlayB3cm90ZToKPiA+ID4gT24gTW9uLCBBdWcgMDUsIDIwMjQgYXQg
MTA6MTI6NDFQTSArMDIwMCwgSmFuIEthcmEgd3JvdGU6Cj4gPiA+ID4gV2hlbiB0aGUgZmlsZXN5
c3RlbSBpcyBtb3VudGVkIHdpdGggZXJyb3JzPXJlbW91bnQtcm8sIHdlIHdlcmUgc2V0dGluZwo+
ID4gPiA+IFNCX1JET05MWSBmbGFnIHRvIHN0b3AgYWxsIGZpbGVzeXN0ZW0gbW9kaWZpY2F0aW9u
cy4gV2Uga25ldyB0aGlzIG1pc3Nlcwo+ID4gPiA+IHByb3BlciBsb2NraW5nIChzYi0+c191bW91
bnQpIGFuZCBkb2VzIG5vdCBnbyB0aHJvdWdoIHByb3BlciBmaWxlc3lzdGVtCj4gPiA+ID4gcmVt
b3VudCBwcm9jZWR1cmUgYnV0IGl0IGhhcyBiZWVuIHRoZSB3YXkgdGhpcyB3b3JrZWQgc2luY2Ug
ZWFybHkgZXh0Mgo+ID4gPiA+IGRheXMgYW5kIGl0IHdhcyBnb29kIGVub3VnaCBmb3IgY2F0YXN0
cm9waGljIHNpdHVhdGlvbiBkYW1hZ2UKPiA+ID4gPiBtaXRpZ2F0aW9uLiBSZWNlbnRseSwgc3l6
Ym90IGhhcyBmb3VuZCBhIHdheSAoc2VlIGxpbmspIHRvIHRyaWdnZXIKPiA+ID4gPiB3YXJuaW5n
cyBpbiBmaWxlc3lzdGVtIGZyZWV6aW5nIGJlY2F1c2UgdGhlIGNvZGUgZ290IGNvbmZ1c2VkIGJ5
Cj4gPiA+ID4gU0JfUkRPTkxZIGNoYW5naW5nIHVuZGVyIGl0cyBoYW5kcy4gU2luY2UgdGhlc2Ug
ZGF5cyB3ZSBzZXQKPiA+ID4gPiBFWFQ0X0ZMQUdTX1NIVVRET1dOIG9uIHRoZSBzdXBlcmJsb2Nr
IHdoaWNoIGlzIGVub3VnaCB0byBzdG9wIGFsbAo+ID4gPiA+IGZpbGVzeXN0ZW0gbW9kaWZpY2F0
aW9ucywgbW9kaWZ5aW5nIFNCX1JET05MWSBzaG91bGRuJ3QgYmUgbmVlZGVkLiBTbwo+ID4gPiA+
IHN0b3AgZG9pbmcgdGhhdC4KPiA+ID4gPgo+ID4gPiA+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8wMDAwMDAwMDAwMDBiOTBhOGUwNjFlMjFkMTJmQGdvb2dsZS5jb20KPiA+ID4g
PiBSZXBvcnRlZC1ieTogQ2hyaXN0aWFuIEJyYXVuZXIgPGJyYXVuZXJAa2VybmVsLm9yZz4KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYW4gS2FyYSA8amFja0BzdXNlLmN6Pgo+ID4gPiA+IC0tLQo+
ID4gPiA+IGZzL2V4dDQvc3VwZXIuYyB8IDkgKysrKystLS0tCj4gPiA+ID4gMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+ID4gPgo+ID4gPiA+IE5vdGUg
dGhhdCB0aGlzIHBhdGNoIGludHJvZHVjZXMgZnN0ZXN0cyBmYWlsdXJlIHdpdGggZ2VuZXJpYy80
NTkgdGVzdCBiZWNhdXNlCj4gPiA+ID4gaXQgYXNzdW1lcyB0aGF0IGVpdGhlciBmcmVlemluZyBz
dWNjZWVkcyBvciAncm8nIGlzIGFtb25nIG1vdW50IG9wdGlvbnMuIEJ1dAo+ID4gPiA+IHdlIGZh
aWwgdGhlIGZyZWV6ZSB3aXRoIEVGU0NPUlJVUFRFRC4gVGhpcyBuZWVkcyBmaXhpbmcgaW4gdGhl
IHRlc3QgYnV0IGF0IHRoaXMKPiA+ID4gPiBwb2ludCBJJ20gbm90IHN1cmUgaG93IGV4YWN0bHku
Cj4gPiA+ID4KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvZXh0NC9zdXBlci5jIGIvZnMvZXh0NC9z
dXBlci5jCj4gPiA+ID4gaW5kZXggZTcyMTQ1YzRhZTVhLi45M2MwMTZiMTg2YzAgMTAwNjQ0Cj4g
PiA+ID4gLS0tIGEvZnMvZXh0NC9zdXBlci5jCj4gPiA+ID4gKysrIGIvZnMvZXh0NC9zdXBlci5j
Cj4gPiA+ID4gQEAgLTczNSwxMSArNzM1LDEyIEBAIHN0YXRpYyB2b2lkIGV4dDRfaGFuZGxlX2Vy
cm9yKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIGJvb2wgZm9yY2Vfcm8sIGludCBlcnJvciwKPiA+
ID4gPgo+ID4gPiA+ICAgICBleHQ0X21zZyhzYiwgS0VSTl9DUklULCAiUmVtb3VudGluZyBmaWxl
c3lzdGVtIHJlYWQtb25seSIpOwo+ID4gPiA+ICAgICAvKgo+ID4gPiA+IC0gICAgKiBNYWtlIHN1
cmUgdXBkYXRlZCB2YWx1ZSBvZiAtPnNfbW91bnRfZmxhZ3Mgd2lsbCBiZSB2aXNpYmxlIGJlZm9y
ZQo+ID4gPiA+IC0gICAgKiAtPnNfZmxhZ3MgdXBkYXRlCj4gPiA+ID4gKyAgICAqIEVYVDRfRkxB
R1NfU0hVVERPV04gd2FzIHNldCB3aGljaCBzdG9wcyBhbGwgZmlsZXN5c3RlbQo+ID4gPiA+ICsg
ICAgKiBtb2RpZmljYXRpb25zLiBXZSBkb24ndCBzZXQgU0JfUkRPTkxZIGJlY2F1c2UgdGhhdCBy
ZXF1aXJlcwo+ID4gPiA+ICsgICAgKiBzYi0+c191bW91bnQgc2VtYXBob3JlIGFuZCBzZXR0aW5n
IGl0IHdpdGhvdXQgcHJvcGVyIHJlbW91bnQKPiA+ID4gPiArICAgICogcHJvY2VkdXJlIGlzIGNv
bmZ1c2luZyBjb2RlIHN1Y2ggYXMgZnJlZXplX3N1cGVyKCkgbGVhZGluZyB0bwo+ID4gPiA+ICsg
ICAgKiBkZWFkbG9ja3MgYW5kIG90aGVyIHByb2JsZW1zLgo+ID4gPiA+ICAgICAgKi8KPiA+ID4g
PiAtICAgc21wX3dtYigpOwo+ID4gPiA+IC0gICBzYi0+c19mbGFncyB8PSBTQl9SRE9OTFk7Cj4g
PiA+Cj4gPiA+IEhpLAo+ID4gPgo+ID4gPiBzaG91bGRuJ3QgdGhlIFNCX1JET05MWSBzdGlsbCBi
ZSBzZXQgKGluIF9fZXh0NF9yZW1vdW50KCkpIGZvciB0aGUgY2FzZQo+ID4gPiB3aGVuIHVzZXIg
dHJpZ2dlcnMgdGhlIGFib3J0IHdpdGggbW91bnQoLi4sICJhYm9ydCIpPyBCZWNhdXNlIG5vdyB3
ZSBzZWVtCj4gPiA+IHRvIGFsd2F5cyBoaXQgdGhlIGNvbmRpdGlvbiB0aGF0IHJldHVybnMgRVJP
RlMgdG8gdXNlci1zcGFjZS4KPiA+Cj4gPiBUaGFua3MgZm9yIHJlcG9ydCEgSSBhZ3JlZSByZXR1
cm5pbmcgRVJPRlMgZnJvbSB0aGUgbW91bnQgYWx0aG91Z2gKPiA+ICdhYm9ydGluZycgc3VjY2Vl
ZGVkIGlzIGNvbmZ1c2luZyBhbmQgaXMgbW9zdGx5IGFuIHVuaW50ZW5kZWQgc2lkZSBlZmZlY3QK
PiA+IHRoYXQgYWZ0ZXIgYWJvcnRpbmcgdGhlIGZzIGZ1cnRoZXIgY2hhbmdlcyB0byBtb3VudCBz
dGF0ZSBhcmUgZm9yYmlkZGVuIGJ1dAo+ID4gdGhlIHRlc3RjYXNlIGFkZGl0aW9uYWxseSB3YW50
cyB0byByZW1vdW50IHRoZSBmcyByZWFkLW9ubHkuCj4KPiBSZWdhcmRsZXNzIG9mIHdoYXQgaXMg
cmlnaHQgb3Igd3JvbmcgdG8gZG8gaW4gZXh0NCwgSSBkb24ndCB0aGluayB0aGF0IHRoZSB0ZXN0
Cj4gcmVhbGx5IGNhcmVzIGFib3V0IHJlbW91bnQgcmVhZC1vbmx5Lgo+IEkgZG9uJ3Qgc2VlIGFu
eXRoaW5nIGluIHRoZSB0ZXN0IHRoYXQgcmVxdWlyZXMgaXQuIEdhYnJpZWw/Cj4gSWYgSSByZW1v
dmUgTVNfUkRPTkxZIGZyb20gdGhlIHRlc3QgaXQgd29ya3MganVzdCBmaW5lLgo+Cj4gQW55IG9i
amVjdGlvbiBmb3IgTFRQIG1haW50YWluZXJzIHRvIGFwcGx5IHRoaXMgc2ltcGxlIHRlc3QgZml4
PwoKRG9lcyB0aGF0IGNoYW5nZSB3b3JrIGZvciB5b3Ugb24gb2xkZXIga2VybmVscz8gT24gNi4x
MSBJIGdldCBFUk9GUzoKCmZhbm90aWZ5MjIuYzo1OTogVElORk86IE1vdW50aW5nIC9kZXYvbG9v
cDAgdG8KL3RtcC9MVFBfZmFuZ2I1d3VPL3Rlc3RfbW50IGZzdHlwPWV4dDQgZmxhZ3M9MjAKZmFu
b3RpZnkyMi5jOjU5OiBUQlJPSzogbW91bnQoL2Rldi9sb29wMCwgdGVzdF9tbnQsIGV4dDQsIDMy
LAoweDQyMTFlZCkgZmFpbGVkOiBFUk9GUyAoMzApCgo+Cj4gVGhhbmtzLAo+IEFtaXIuCj4KPiAt
LS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjIuYwo+ICsr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMi5jCj4gQEAg
LTU3LDcgKzU3LDcgQEAgc3RhdGljIHN0cnVjdCBmYW5vdGlmeV9maWRfdCBiYWRfbGlua19maWQ7
Cj4gIHN0YXRpYyB2b2lkIHRyaWdnZXJfZnNfYWJvcnQodm9pZCkKPiAgewo+ICAgICAgICAgU0FG
RV9NT1VOVCh0c3RfZGV2aWNlLT5kZXYsIE1PVU5UX1BBVEgsIHRzdF9kZXZpY2UtPmZzX3R5cGUs
Cj4gLSAgICAgICAgICAgICAgICAgIE1TX1JFTU9VTlR8TVNfUkRPTkxZLCAiYWJvcnQiKTsKPiAr
ICAgICAgICAgICAgICAgICAgTVNfUkVNT1VOVCwgImFib3J0Iik7Cj4gIH0KPgoKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
