Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3829EECE57A
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 11:47:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8253C3C1886
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 13:47:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3B2D3C0BC0
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 13:46:56 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EE3CB200741
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 13:46:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725882414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8YhXmLnRC0Cs/7wJsDl3F7cMT3Myic5W/zX1tocKAvU=;
 b=EUk6WlaGcrdTwt+gp3ED4b6qp7Xr5BMEJzpPy5DusfpbWQ5BtFRhU+XS+DxKE4nv7+KHAz
 /r/a+RWKSFwgYq29YRh4m/sn1O2AbfHuo3gdpYbHizYz1uekkedXPBdAtShyUPFQPymNMv
 tHmCPrMOp9/6ljx9Q48cBAIJhbdzzv8=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-A6PzVv2EP-G9eWbl7wNpCQ-1; Mon, 09 Sep 2024 07:46:53 -0400
X-MC-Unique: A6PzVv2EP-G9eWbl7wNpCQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-27795dffb33so3837473fac.3
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 04:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725882412; x=1726487212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8YhXmLnRC0Cs/7wJsDl3F7cMT3Myic5W/zX1tocKAvU=;
 b=w8sYSQst+W9PyGWTJpmPxTgwkwB/FijqjhiIomb6nGqPk+31I9kyMkT2Y6OoJFNF5k
 Ul7XT5LaQ3Ae/oi2aZLwIZbcef0rTzc9c+WyQDB6+bT0KuRXYft/Qwvze+ZDccMm30Rv
 rQB4wYFHnWCAxtjkFys6jXh7obVNDxV0UtBgajN+MNiz/DOne/p3Cv1xYdRRnHjN3XwW
 IEIMro/gXtOFHnpVjapFC8QNv4j/VQzbDWAh4rCQhY46+IkXmDdcSz1EnbrAb8fNuSHj
 nejofGXaAWj5Xfsd4Uycb5jG29WhukWt9Nab/jG2mLoIknH++zaDc7qK4ZDQFNKUQWsZ
 2Ifg==
X-Gm-Message-State: AOJu0Yz+N5UwHFoqfCqr0x1REYokrVXjJnObaiUCFlWaOrjG5rA2x6eA
 k45hohECvErPDmqyFyyQdny4IO4zT3KE6eeOXMayI13u8sLlToDZJxtDEUSQdPuH0vaV2QcE8Sk
 AnsRFq3Es7RtPSD+FSAtHlAlbD2p00M4lUCzRRsoVAUVcu7zd54ECkRXjqKsHl4pDSJ+LHOXjCj
 TJmlyPTU4HFeyJEyulGJTV1+YI+0fTceTSpA==
X-Received: by 2002:a05:6870:a10c:b0:261:1b66:5ab1 with SMTP id
 586e51a60fabf-27b82ea93dbmr11964339fac.21.1725882412631; 
 Mon, 09 Sep 2024 04:46:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKFxCTuCb+A9YTWVOomPZ8GM9HrZYNtuSCKiYleNo53+vAEQ8E4m/w6QCfkDrdPBq2HhWVwdiIdycPHNzcXuo=
X-Received: by 2002:a05:6870:a10c:b0:261:1b66:5ab1 with SMTP id
 586e51a60fabf-27b82ea93dbmr11964333fac.21.1725882412280; Mon, 09 Sep 2024
 04:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240903140326.773060-1-pvorel@suse.cz>
 <20240909025243.537071-1-liwang@redhat.com>
In-Reply-To: <20240909025243.537071-1-liwang@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 9 Sep 2024 13:46:35 +0200
Message-ID: <CAASaF6wC=SOnyX2rJ0EXqjoo95C4TAhURBYwLKAF8_oDOtRkBg@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] swapoff01/swapon01: Define max_runtime 1 mins
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

T24gTW9uLCBTZXAgOSwgMjAyNCBhdCA0OjUz4oCvQU0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4gRnJvbTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4KPiBUZXN0
IHJ1biBtb3N0bHkgYmVsb3cgMSBzZWMgcGVyIGZpbGVzeXN0ZW0sIG9ubHkgTlRGUyBpcyB2ZXJ5
IHNsb3cKPiB+IDEwLTE1IHNlYyBkZXBlbmRpbmcgb24gYXJjaGl0ZWN0dXJlLgo+Cj4gQWxzbyB0
aGlzIGlzIHRoZSBvbmx5IHRlc3RzIGluIHN5c2NhbGxzIHdoaWNoIGZhaWxzIG9uIGR1ZSB0aW1l
b3V0IG9uCj4gZW11bGF0ZWQgcmlzYy12IHdpdGggTFRQX1RJTUVPVVRfTVVMPTIsTFRQX1JVTlRJ
TUVfTVVMPTIgKHdpdGggdGhlCj4gZGVmYXVsdCAzMHMgcnVudGltZSA9PiAxIG1pbiBkdWUgTFRQ
X1JVTlRJTUVfTVVMPTIpLgo+Cj4gQmFzZWQgb24gdGhlIHRlc3QgY29uc3VtZWQgdGltZSBvbiBS
UGkwIGFuZCBSUGk0LCB3ZSBzZXQgcnVudGltZSB0byA2MHMsCj4gdGhhdCBzaG91bGQgYmUgZW5v
dWdoIGV2ZW4gZm9yIHNsb3cgcmlzYy12IGFuZCBub3QgdGhhdCBoaWdoIGZvciBvdGhlciBhcmNo
cy4KPgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IFNpZ25l
ZC1vZmYtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKQWNrZWQtYnk6IEphbiBTdGFu
Y2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgoKPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9zd2Fwb2ZmL3N3YXBvZmYwMS5jIHwgMSArCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvc3dhcG9uL3N3YXBvbjAxLmMgICB8IDEgKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9m
Zi9zd2Fwb2ZmMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9mZi9zd2Fwb2Zm
MDEuYwo+IGluZGV4IDMxNDYzMDI2Ny4uOTY1ZDE3Y2M4IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9mZi9zd2Fwb2ZmMDEuYwo+ICsrKyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvc3dhcG9mZi9zd2Fwb2ZmMDEuYwo+IEBAIC01Myw1ICs1Myw2IEBAIHN0
YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiAgICAgICAgIC5hbGxfZmlsZXN5c3RlbXMg
PSAxLAo+ICAgICAgICAgLm5lZWRzX3Jvb3QgPSAxLAo+ICAgICAgICAgLnRlc3RfYWxsID0gdmVy
aWZ5X3N3YXBvZmYsCj4gKyAgICAgICAubWF4X3J1bnRpbWUgPSA2MCwKPiAgICAgICAgIC5zZXR1
cCA9IHNldHVwCj4gIH07Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
c3dhcG9uL3N3YXBvbjAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fw
b24wMS5jCj4gaW5kZXggNDk5MTVjMzJkLi5lZGRjZDU3ODggMTAwNjQ0Cj4gLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+ICsrKyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAxLmMKPiBAQCAtNTEsNSArNTEsNiBAQCBzdGF0
aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gICAgICAgICAuYWxsX2ZpbGVzeXN0ZW1zID0g
MSwKPiAgICAgICAgIC5uZWVkc19jZ3JvdXBfY3RybHMgPSAoY29uc3QgY2hhciAqY29uc3QgW10p
eyAibWVtb3J5IiwgTlVMTCB9LAo+ICAgICAgICAgLnRlc3RfYWxsID0gdmVyaWZ5X3N3YXBvbiwK
PiArICAgICAgIC5tYXhfcnVudGltZSA9IDYwLAo+ICAgICAgICAgLnNldHVwID0gc2V0dXAKPiAg
fTsKPiAtLQo+IDIuNDYuMAo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
