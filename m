Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B69EC83F2C
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 03:10:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D2313CE34B
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 05:10:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1EE43C62DA
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 05:10:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A361620011A
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 05:10:07 +0200 (CEST)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-WGzONYhqPpOBiJXPOZD24A-1; Mon, 04 Sep 2023 23:10:04 -0400
X-MC-Unique: WGzONYhqPpOBiJXPOZD24A-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2bcc462506cso19628881fa.2
 for <ltp@lists.linux.it>; Mon, 04 Sep 2023 20:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693883402; x=1694488202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2xJjVSVPJdaPPCThvBuUJC1v8T3G8mVy/XRSJP/zZzY=;
 b=jZhnZksGX51GC3NH9WNftZ/dr16RepspqzMmXZT7YkLAkylFfmP620Vxcl8oDHMp/g
 90Nac3NFoCOkzdgyPl6/ts6yn5SFqfzWpzLovRqPp8B/tvbn1jcpFi9BxiPiw4ujShe0
 gkofIsrXDIki1ArNtyMQM4fPdXm4qFrC26b5bD6XzqGtNQr2SGqkiCbbWjFYPY9eGND/
 O+DjmikxynqB5WHbtC0uEzbUxkQeYHqUuJrHPVtreLDckoH6Ube/RKlEYyakWB8cLl5j
 7AbU6ZJT4bi2obXEJq7e0XFr0dgX+MzNQFmRSoCtHcehABm0c9AKIf/6cWZtjdWI1JwR
 ZfBg==
X-Gm-Message-State: AOJu0Yx37OPbFqI8kLO5/A2JsJc68EiH7+JSUVw+eQdi/Ro2Xv5YXKGm
 Kry74FfETpUwp1/ZiY8/F8ZBol/u7v4JQYrlBf09mV1LTq3af60BeHsMXJ7Yk/OtyaOVtVQqhL3
 Z7dtm1sGNTrMUiz4rztTHejM3Ib0=
X-Received: by 2002:a2e:721a:0:b0:2b9:e230:25ce with SMTP id
 n26-20020a2e721a000000b002b9e23025cemr8164066ljc.12.1693883402703; 
 Mon, 04 Sep 2023 20:10:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRbqRWUcFafk8J1ekYQosE5Bfxd0aTyS9ukO+zdKAB40EFf876QIkHvcFtQpahg7QNhuvsQcxAslonhmfRRtI=
X-Received: by 2002:a2e:721a:0:b0:2b9:e230:25ce with SMTP id
 n26-20020a2e721a000000b002b9e23025cemr8164060ljc.12.1693883402411; Mon, 04
 Sep 2023 20:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230904074443.24701-1-andrea.cervesato@suse.de>
In-Reply-To: <20230904074443.24701-1-andrea.cervesato@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 5 Sep 2023 11:09:49 +0800
Message-ID: <CAEemH2fF3GkbtCMzhhsdWy5fQ=JbTUSztrQP6NkgKwBWqqsMzA@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] lib: add .min_swap_avail in tst_test struct
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

SGkgQW5kcmVhLAoKT24gTW9uLCBTZXAgNCwgMjAyMyBhdCAzOjQ14oCvUE0gQW5kcmVhIENlcnZl
c2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmRlPgp3cm90ZToKCj4gRnJvbTogQW5kcmVhIENl
cnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPgo+IFRoaXMgbmV3IGZpZWxkIGlz
IG1haW5seSB0byBzZXQgdGhlIG1pbmltdW0gc2l6ZSBvZiBTd2FwRnJlZSBmb3IKPiBMVFAgdGVz
dGNhc2UuIElmIHN5c3RlbSBhdmFpbGFibGUgZnJlZSBzd2FwIG1lbW9yeSBpcyBsZXNzIHRoYW4K
PiAubWluX3N3YXBfYXZhaWwsIHRlc3Qgd2lsbCBiZSBleGl0IHdpdGggVENPTkYuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+
IC0tLQo+ICBpbmNsdWRlL3RzdF9tZW11dGlscy5oIHwgNSArKysrKwo+ICBpbmNsdWRlL3RzdF90
ZXN0LmggICAgIHwgMyArKysKPiAgbGliL3RzdF9tZW11dGlscy5jICAgICB8IDkgKysrKysrKysr
Cj4gIGxpYi90c3RfdGVzdC5jICAgICAgICAgfCAzICsrKwo+ICA0IGZpbGVzIGNoYW5nZWQsIDIw
IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3RzdF9tZW11dGlscy5oIGIv
aW5jbHVkZS90c3RfbWVtdXRpbHMuaAo+IGluZGV4IDQ1ZGVjNTViYy4uMTliNTkzNDMwIDEwMDY0
NAo+IC0tLSBhL2luY2x1ZGUvdHN0X21lbXV0aWxzLmgKPiArKysgYi9pbmNsdWRlL3RzdF9tZW11
dGlscy5oCj4gQEAgLTI1LDYgKzI1LDExIEBAIHZvaWQgdHN0X3BvbGx1dGVfbWVtb3J5KHNpemVf
dCBtYXhzaXplLCBpbnQgZmlsbGNoYXIpOwo+ICAgKi8KPiAgbG9uZyBsb25nIHRzdF9hdmFpbGFi
bGVfbWVtKHZvaWQpOwo+Cj4gKy8qCj4gKyAqIFJlYWQgdGhlIHZhbHVlIG9mIFN3YXBGcmVlIGZy
b20gL3Byb2MvbWVtaW5mby4KPiArICovCj4gK2xvbmcgbG9uZyB0c3RfYXZhaWxhYmxlX3N3YXAo
dm9pZCk7Cj4gKwo+ICAvKgo+ICAgKiBFbmFibGUgT09NIHByb3RlY3Rpb24gdG8gcHJldmVudCBw
cm9jZXNzKCRQSUQpIGJlaW5nIGtpbGxlZCBieSBPT00KPiBLaWxsZXIuCj4gICAqICAgZWNobyAt
MTAwMCA+L3Byb2MvJFBJRC9vb21fc2NvcmVfYWRqCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHN0
X3Rlc3QuaCBiL2luY2x1ZGUvdHN0X3Rlc3QuaAo+IGluZGV4IDBhYzQ5MmE4MC4uNzVjMjEwOWI5
IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdHN0X3Rlc3QuaAo+ICsrKyBiL2luY2x1ZGUvdHN0X3Rl
c3QuaAo+IEBAIC0yMTAsNiArMjEwLDkgQEAgc3RydWN0IHRzdF90ZXN0IHsKPiAgICAgICAgIC8q
IE1pbmltdW0gc2l6ZShNQikgb2YgTWVtQXZhaWxhYmxlIHJlcXVpcmVkIGJ5IHRoZSB0ZXN0ICov
Cj4gICAgICAgICB1bnNpZ25lZCBsb25nIG1pbl9tZW1fYXZhaWw7Cj4KPiArICAgICAgIC8qIE1p
bmltdW0gc2l6ZShNQikgb2YgU3dhcEZyZWUgcmVxdWlyZWQgYnkgdGhlIHRlc3QgKi8KPiArICAg
ICAgIHVuc2lnbmVkIGxvbmcgbWluX3N3YXBfYXZhaWw7Cj4KCkl0IHdvdWxkIGJlIGdyZWF0IHRv
IGhhdmUgYSBicmllZiBpbnRyb2R1Y3Rpb24gaW4gdGhlIGRvY3VtZW50LApsaWtlIHdoYXQgd2Ug
ZGlkIGZvciBtaW5fbWVtX2F2YWlsLgoKQW55d2F5LCB3ZSBjYW4gYWRkIGl0IGluIGEgc2VwYXJh
dGUgcGF0Y2guIFRoYW5rcyEKCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
