Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD298C19776
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 12:18:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8C413C9E30
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 13:18:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED12C3C9DF2
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 13:18:08 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 165D363DAB9
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 13:18:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740745086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m2g5iQ+ogGo4bQ8NQkKzpLQdwqHnXqqjwbrObIw0/+8=;
 b=fdUIbXNmGMylv99vuU1RFT2RVsqTnGNU6dMmvHUevfJq3cGE+RZgNwVv6wRnzdArqavRCg
 WgxiQ3myFBdsf3QCkckv5Gb86kuTF3dhFnUg1TOKNaX2KXCqwAW+cXXkieumCfmxkOb1Pe
 bDD/5eHbPXpxzuXvP5oFw5SxwPDlZwI=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-R3fiBgYDMZmT-dzCC89u_A-1; Fri, 28 Feb 2025 07:18:03 -0500
X-MC-Unique: R3fiBgYDMZmT-dzCC89u_A-1
X-Mimecast-MFC-AGG-ID: R3fiBgYDMZmT-dzCC89u_A_1740745083
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-86b3a04051dso678038241.2
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 04:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740745083; x=1741349883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m2g5iQ+ogGo4bQ8NQkKzpLQdwqHnXqqjwbrObIw0/+8=;
 b=Ap4EJwC3IHv08c1o39+DOQz1kAeGRe9azHg0Wg//9Z1BlX6PFIZ+JvI5CPNd2WXfd6
 SGH/nuwV1Jcvf/qgcGEsRJV5U69/Rom4y3uwRDSHXYwMko1gZVbmykKTMw0QEtYaGSX/
 PswwtC7oCtP9o7zRF4lcsx8AP574/9Eq7Kt0Jo7XD0+yAShIGFncfu2SIa4lqFO4t4PT
 m7yUh4alPFaOIFJKS+OJK6QCMDajBXvt9uu9nx69IJgaTaimHq7YhwvRlXJMYnpTx1b3
 WoePmRGFrWM8Jzy3+bfBhFwQEZ5V2Ui0ZmNN+3xapt0a1sYZHHG3QaF34O9Vvv/Khi87
 E7Mw==
X-Gm-Message-State: AOJu0YxqyhPl17BNdi28E7+q9oFY3XhccuPFv/6TfoesR6siFjyFovJL
 5jN5s+hSBS4dgclURZ5DMkuKYz+eFo7SxQox0rUATjBtaGJi4eevM1fXrupor3crKemyqTJtIe8
 GvYu2LuZqa2OOGaqH/fEoirfmhuhQvzChgJ60ONFiuTXd6BIx3vd7ZomiHN4Oef5/yeE1RENKKz
 sqEsTnePWKC8GM0RPxDdHEGFs=
X-Gm-Gg: ASbGnct9eAEY0bdpIioquN4E2TLNBOhe4apRKStbQUXDqXrXqRvhhQJrmOcRyIyyIiP
 v5SqOu/Eh99wSq9DmsHd8XkM4tRASShZqvdM6HKiXIcZSICHG3Q98BMcLUC44dg9yC8eO1ieN
X-Received: by 2002:a05:6102:2922:b0:4bb:ecb9:b34f with SMTP id
 ada2fe7eead31-4c04499a50fmr1693185137.14.1740745083066; 
 Fri, 28 Feb 2025 04:18:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3UgX3nDabCYop5ulYYY+17QljlOM96tIXh29VxeObDZmz839iWGkWe31OsWqAJhp3UCGQNMAPiOjocC9r1aE=
X-Received: by 2002:a05:6102:2922:b0:4bb:ecb9:b34f with SMTP id
 ada2fe7eead31-4c04499a50fmr1693175137.14.1740745082805; Fri, 28 Feb 2025
 04:18:02 -0800 (PST)
MIME-Version: 1.0
References: <59baf41928c498349f41f468e4efdb4908bccc28.1739886583.git.jstancek@redhat.com>
 <309b1ba7-9a22-4173-92a8-96ee12219f5b@suse.com>
In-Reply-To: <309b1ba7-9a22-4173-92a8-96ee12219f5b@suse.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 28 Feb 2025 13:17:47 +0100
X-Gm-Features: AQ5f1JrEB9zc0RffFJX61gLnRUtDPSKXjE8SwwCOSObLB29iXpA02yGTto_Mta0
Message-ID: <CAASaF6ynx7yOGhzA4GaJgWAj2HJ78N4LVWE0u_uG+VdJXZgBJQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0xpmy_jK_OWa3c6CAEeQQMlzoQHF7MnoDKwaLGSD2qg_1740745083
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] aio-stress: fix memory leak
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
Cc: liwan@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBGZWIgMjgsIDIwMjUgYXQgMTowNOKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8KPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5jb20+IHdyb3RlOgo+Cj4gSGkhCj4KPiBUaGlzIHRlc3QgaXMgYSB0
aGluZyA6LSkgVGhhbmtzIGZvciBmaXhpbmcgaXQuCj4KPiBBY2tlZC1ieTogQW5kcmVhIENlcnZl
c2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KClB1c2hlZC4KClRoYW5rcyBhbGwgZm9y
IHJldmlld3MuCgo+Cj4gT24gMi8xOC8yNSAxNDo1NCwgSmFuIFN0YW5jZWsgd3JvdGU6Cj4gPiBz
ZXR1cF9zaGFyZWRfbWVtKCkgY3VycmVudGx5IHJ1bnMgYXMgcGFydCBvZiBydW4oKSBmdW5jdGlv
biwKPiA+IGFuZCBpZiBpdCBydW5zIGZvciB0b28gbWFueSBpdGVyYXRpb25zIGl0IGNhbiBjb25z
dW1lIHNvIG11Y2gKPiA+IG1lbW9yeSB0aGF0IE9PTSBraWxscyBpdC4KPiA+Cj4gPiBNb3ZlIHNl
dHVwX3NoYXJlZF9tZW0oKSBhbG9uZyB3aXRoIHRoZSAyIGNoZWNrcyBmb3IgaW9faXRlciBhbmQK
PiA+IG51bV90aHJlYWRzIHRvIHNldHVwKCkuIFRoaXMgd2F5IGl0IHJ1bnMgb25seSBvbmNlIGFu
ZCBnZXRzCj4gPiBmcmVlZCBvbiB0ZXN0IGV4aXQuCj4gPgo+ID4gQXMgY29uc2VxdWVuY2Ugc2V0
dXBfaW91cygpIGFsc28gbmVlZHMgdG8gYmUgbW9kaWZpZWQgdG8gbm8gbG9uZ2VyCj4gPiBtb2Rp
ZnkgZ2xvYmFsIHZhcmlhYmxlICdhbGlnbmVkX2J1ZmZlcicsIGJlY2F1c2Ugd2UgZG9uJ3QgcmUt
aW5pdGlhbGl6ZQo+ID4gaXQgb24gZXZlcnkgaXRlcmF0aW9uLgo+ID4KPiA+IEFuZCBmaW5hbGx5
LCBhdCB0aGUgZW5kIG9mIHJ1bigpIGZ1bmN0aW9uIGZyZWUgYWxzbyBtZW1vcnkgYWxsb2NhdGVk
Cj4gPiBieSBzZXR1cF9pb3VzKCkuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogSmFuIFN0YW5jZWsg
PGpzdGFuY2VrQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICAgdGVzdGNhc2VzL2tlcm5lbC9pby9s
dHAtYWlvZGlvL2Fpby1zdHJlc3MuYyB8IDQ1ICsrKysrKysrKysrKy0tLS0tLS0tLQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4gPgo+ID4g
ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9haW8tc3RyZXNzLmMg
Yi90ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vYWlvLXN0cmVzcy5jCj4gPiBpbmRleCA0
Njk3NjlkNWExZjQuLjVjY2U5MmRmYTQ0YyAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJu
ZWwvaW8vbHRwLWFpb2Rpby9haW8tc3RyZXNzLmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwv
aW8vbHRwLWFpb2Rpby9haW8tc3RyZXNzLmMKPiA+IEBAIC05MTQsMTQgKzkxNCwxNSBAQCBzdGF0
aWMgdm9pZCBzZXR1cF9pb3VzKHN0cnVjdCB0aHJlYWRfaW5mbyAqdCwgaW50IG51bV9maWxlcywg
aW50IGRlcHRoLCBpbnQgcmVjbAo+ID4gICB7Cj4gPiAgICAgICBpbnQgaTsKPiA+ICAgICAgIHNp
emVfdCBieXRlcyA9IG51bV9maWxlcyAqIGRlcHRoICogc2l6ZW9mKCp0LT5pb3MpOwo+ID4gKyAg
ICAgY2hhciAqYnVmZmVyID0gYWxpZ25lZF9idWZmZXI7Cj4gPgo+ID4gICAgICAgdC0+aW9zID0g
U0FGRV9NQUxMT0MoYnl0ZXMpOwo+ID4KPiA+ICAgICAgIG1lbXNldCh0LT5pb3MsIDAsIGJ5dGVz
KTsKPiA+Cj4gPiAgICAgICBmb3IgKGkgPSAwOyBpIDwgZGVwdGggKiBudW1fZmlsZXM7IGkrKykg
ewo+ID4gLSAgICAgICAgICAgICB0LT5pb3NbaV0uYnVmID0gYWxpZ25lZF9idWZmZXI7Cj4gPiAt
ICAgICAgICAgICAgIGFsaWduZWRfYnVmZmVyICs9IHBhZGRlZF9yZWNsZW47Cj4gPiArICAgICAg
ICAgICAgIHQtPmlvc1tpXS5idWYgPSBidWZmZXI7Cj4gPiArICAgICAgICAgICAgIGJ1ZmZlciAr
PSBwYWRkZWRfcmVjbGVuOwo+ID4gICAgICAgICAgICAgICB0LT5pb3NbaV0uYnVmX3NpemUgPSBy
ZWNsZW47Cj4gPiAgICAgICAgICAgICAgIGlmICh2ZXJpZnkpCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgbWVtc2V0KHQtPmlvc1tpXS5idWYsICdiJywgcmVjbGVuKTsKPiA+IEBAIC05MzIsNyAr
OTMzLDcgQEAgc3RhdGljIHZvaWQgc2V0dXBfaW91cyhzdHJ1Y3QgdGhyZWFkX2luZm8gKnQsIGlu
dCBudW1fZmlsZXMsIGludCBkZXB0aCwgaW50IHJlY2wKPiA+ICAgICAgIH0KPiA+Cj4gPiAgICAg
ICBpZiAodmVyaWZ5KSB7Cj4gPiAtICAgICAgICAgICAgIHZlcmlmeV9idWYgPSBhbGlnbmVkX2J1
ZmZlcjsKPiA+ICsgICAgICAgICAgICAgdmVyaWZ5X2J1ZiA9IGJ1ZmZlcjsKPiA+ICAgICAgICAg
ICAgICAgbWVtc2V0KHZlcmlmeV9idWYsICdiJywgcmVjbGVuKTsKPiA+ICAgICAgIH0KPiA+Cj4g
PiBAQCAtMTIyOCwxOSArMTIyOSw2IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgdHN0X2JyayhUQlJPSywgIkludmFsaWQgc2htIG9wdGlvbiAnJXMn
Iiwgc3RyX3VzZV9zaG0pOwo+ID4gICAgICAgICAgICAgICB9Cj4gPiAgICAgICB9Cj4gPiAtfQo+
ID4gLQo+ID4gLXN0YXRpYyB2b2lkIHJ1bih2b2lkKQo+ID4gLXsKPiA+IC0gICAgIGNoYXIgZmls
ZXNbbnVtX2ZpbGVzXVsyNjVdOwo+ID4gLSAgICAgaW50IGZpcnN0X3N0YWdlID0gV1JJVEU7Cj4g
PiAtICAgICBzdHJ1Y3QgaW9fb3BlciAqb3BlcjsKPiA+IC0gICAgIGludCBzdGF0dXMgPSAwOwo+
ID4gLSAgICAgaW50IG9wZW5fZmRzID0gMDsKPiA+IC0gICAgIHN0cnVjdCB0aHJlYWRfaW5mbyAq
dDsKPiA+IC0gICAgIGludCByd2ZkOwo+ID4gLSAgICAgaW50IGk7Cj4gPiAtICAgICBpbnQgajsK
PiA+Cj4gPiAgICAgICAvKgo+ID4gICAgICAgICogbWFrZSBzdXJlIHdlIGRvbid0IHRyeSB0byBz
dWJtaXQgbW9yZSBJL08gdGhhbiB3ZSBoYXZlIGFsbG9jYXRlZAo+ID4gQEAgLTEyNTYsNiArMTI0
NCwyMiBAQCBzdGF0aWMgdm9pZCBydW4odm9pZCkKPiA+ICAgICAgICAgICAgICAgdHN0X3JlcyhU
SU5GTywgIkRyb3BwaW5nIHRocmVhZCBjb3VudCB0byB0aGUgbnVtYmVyIG9mIGNvbnRleHRzICVk
IiwgbnVtX3RocmVhZHMpOwo+ID4gICAgICAgfQo+ID4KPiA+ICsgICAgIGlmIChzZXR1cF9zaGFy
ZWRfbWVtKG51bV90aHJlYWRzLCBudW1fZmlsZXMgKiBudW1fY29udGV4dHMsIGRlcHRoLCByZWNf
bGVuKSkKPiA+ICsgICAgICAgICAgICAgdHN0X2JyayhUQlJPSywgImVycm9yIGluIHNldHVwX3No
YXJlZF9tZW0iKTsKPiA+ICt9Cj4gPiArCj4gPiArc3RhdGljIHZvaWQgcnVuKHZvaWQpCj4gPiAr
ewo+ID4gKyAgICAgY2hhciBmaWxlc1tudW1fZmlsZXNdWzI2NV07Cj4gPiArICAgICBpbnQgZmly
c3Rfc3RhZ2UgPSBXUklURTsKPiA+ICsgICAgIHN0cnVjdCBpb19vcGVyICpvcGVyOwo+ID4gKyAg
ICAgaW50IHN0YXR1cyA9IDA7Cj4gPiArICAgICBpbnQgb3Blbl9mZHMgPSAwOwo+ID4gKyAgICAg
c3RydWN0IHRocmVhZF9pbmZvICp0Owo+ID4gKyAgICAgaW50IHJ3ZmQ7Cj4gPiArICAgICBpbnQg
aTsKPiA+ICsgICAgIGludCBqOwo+ID4gKwo+ID4gICAgICAgdCA9IFNBRkVfTUFMTE9DKG51bV90
aHJlYWRzICogc2l6ZW9mKCp0KSk7Cj4gPiAgICAgICBtZW1zZXQodCwgMCwgbnVtX3RocmVhZHMg
KiBzaXplb2YoKnQpKTsKPiA+ICAgICAgIGdsb2JhbF90aHJlYWRfaW5mbyA9IHQ7Cj4gPiBAQCAt
MTMyMiw4ICsxMzI2LDYgQEAgc3RhdGljIHZvaWQgcnVuKHZvaWQpCj4gPiAgICAgICAgICAgICAg
IH0KPiA+ICAgICAgIH0KPiA+Cj4gPiAtICAgICBpZiAoc2V0dXBfc2hhcmVkX21lbShudW1fdGhy
ZWFkcywgbnVtX2ZpbGVzICogbnVtX2NvbnRleHRzLCBkZXB0aCwgcmVjX2xlbikpCj4gPiAtICAg
ICAgICAgICAgIHRzdF9icmsoVEJST0ssICJlcnJvciBpbiBzZXR1cF9zaGFyZWRfbWVtIik7Cj4g
Pgo+ID4gICAgICAgZm9yIChpID0gMDsgaSA8IG51bV90aHJlYWRzOyBpKyspCj4gPiAgICAgICAg
ICAgICAgIHNldHVwX2lvdXMoJnRbaV0sIHRbaV0ubnVtX2ZpbGVzLCBkZXB0aCwgcmVjX2xlbiwg
bWF4X2lvX3N1Ym1pdCk7Cj4gPiBAQCAtMTMzOSw2ICsxMzQxLDEzIEBAIHN0YXRpYyB2b2lkIHJ1
bih2b2lkKQo+ID4gICAgICAgZm9yIChpID0gMDsgaSA8IG51bV9maWxlczsgaSsrKQo+ID4gICAg
ICAgICAgICAgICBTQUZFX1VOTElOSyhmaWxlc1tpXSk7Cj4gPgo+ID4gKyAgICAgZm9yIChpID0g
MDsgaSA8IG51bV90aHJlYWRzOyBpKyspIHsKPiA+ICsgICAgICAgICAgICAgZnJlZSh0W2ldLmlv
cyk7Cj4gPiArICAgICAgICAgICAgIGZyZWUodFtpXS5pb2Nicyk7Cj4gPiArICAgICAgICAgICAg
IGZyZWUodFtpXS5ldmVudHMpOwo+ID4gKyAgICAgfQo+ID4gKyAgICAgZnJlZSh0KTsKPiA+ICsK
PiA+ICAgICAgIGlmIChzdGF0dXMpCj4gPiAgICAgICAgICAgICAgIHRzdF9yZXMoVEZBSUwsICJU
ZXN0IGRpZCBub3QgcGFzcyIpOwo+ID4gICAgICAgZWxzZQo+CgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
