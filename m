Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953B0C55822
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785852162; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=oHim6aB76T7cS47ODoWaAgVIOYSwOgDhf+ZyMapsqDg=;
 b=Z+OI5Yu77KICCbWt7wEhp/0pXLHdTD6Z9m55+ldnRoMSaOHqFlMJW27w9Gu9o9WSAv+ZF
 0ZlcG0rMOgV3dRykqpnAnmTIIWfKZyBA9lSIzzxe/DpolZNaEXappUxXeFvM7aFUDIEaibN
 /nzIc8JQ2lXVD4E0zIHg48mnPRNi2ds=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E52763E7184
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 16:02:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFA663E716C
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 16:02:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 02C8C1400992
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 16:02:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785852141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5xS6iw4gGeBpLE6XWGrgv4wMHaPy+D77ovdOH7JXxI=;
 b=BNEjitsZVQutpZMbg+91hHge+bXWV3wmoJhe4U3lDzef57TKdAxXz89iWXAOUl8kZ7FKPj
 0WBzaOm3drQfh2pmZ06Jew6roy5wBnXDRPHTV+Y6IU6MWuTFE3uifNH4UflBLQnWdRBSFl
 z89izikgiACyEQrEUVPqJslnTXbSZbg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-gFf4lVu5MiiGKAnYoeA9ww-1; Tue, 04 Aug 2026 10:02:17 -0400
X-MC-Unique: gFf4lVu5MiiGKAnYoeA9ww-1
X-Mimecast-MFC-AGG-ID: gFf4lVu5MiiGKAnYoeA9ww_1785852136
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-473ac08a6a4so3642921f8f.0
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 07:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785852136; x=1786456936;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o5xS6iw4gGeBpLE6XWGrgv4wMHaPy+D77ovdOH7JXxI=;
 b=SPw5RS/gZy6dNqAO7A4cQhRuQeDmv+RuLkyUpHSkqv904LPZhB60KiwLeApNlUddZn
 32e7efxFAmzbD5SpMeJJWkVf0tWi66iv8N5YkZ9P2BfvO+aZTkwaOsGxnXdOItOrs+Qd
 MO8ow3zyAXbpVqE1hwHxTL+8Ucx3KMP4MErr6XRBcgm2DgDjRhe+kettjoVKNTYBJUog
 bN9Kp8nsRml4Z12gqllLHkzzB+T2ohPtCsIX9fWmV8lgOEnxNa9bZJgeM+Sypze+vcZv
 +JNPX34yzcQWJF1Ty+TcRwmeOOOuPUsJC0MX1CNZlFaB2NnygAG/RHK4AP2MJl3xIOqN
 tVtQ==
X-Gm-Message-State: AOJu0Yx5XRm6co2bFgYWgx4Umb+a6FnU0FXzZtcIbrC84HAZc5kqhFpa
 2tjpHUmQpwjJL8hBiV9wt37+enIoV0+J6nmDt0YLMbsEmCUdgF3G/1E+yvUh65s5h5xhivMsmph
 lfEMuyp4jbQXUrsLvl7p+9+WrJAfZgerDNXPzP5ZQgYAYyobWzjWinon87gc+zY4V40s8gsZvOG
 SPP+RPSW7GKfEVIVZsvRF3/we1lWM=
X-Gm-Gg: AR+sD12+9RaYXqFBgyAdSZ9YOM2k47QFgPtdpLuG3XDUiHRRgro7UfXJtabUMFFAgzg
 EEuU5dHz8SAQxBU/mHrbW+CH5VKksYEEGfo5BkyiXRsj9qGHh0DLgx2VFrNoqcSmaT+0nzbnIYo
 EWfmWuOg2pcPV43XWsBkfkgLvB9VrCVM3K219pO/TiqS3bO3jhZJBJ3/E=
X-Received: by 2002:a05:6000:615:b0:47f:81af:1a3b with SMTP id
 ffacd0b85a97d-47fd72c4be9mr37930133f8f.22.1785852136190; 
 Tue, 04 Aug 2026 07:02:16 -0700 (PDT)
X-Received: by 2002:a05:6000:615:b0:47f:81af:1a3b with SMTP id
 ffacd0b85a97d-47fd72c4be9mr37930033f8f.22.1785852135511; Tue, 04 Aug 2026
 07:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260804132857.552304-1-chrubis@suse.cz>
In-Reply-To: <20260804132857.552304-1-chrubis@suse.cz>
Date: Tue, 4 Aug 2026 16:01:58 +0200
X-Gm-Features: AUfX_mwKy_eBxTWS5ZGcPrk03bkRClFovRLxrIFRwrgSVtZpDGS86XxVi8Q4bMA
Message-ID: <CAASaF6zS3gX8YMcx+nXv2xTfx+NfSRnf-_s3fCC_F8CppCC6_Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p1PzXqBqa4N9xu3XzXpluqcUE8D37l9K1V44UMWtvPA_1785852136
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_res(): Fix TDEBUG | TERRNO
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBBdWcgNCwgMjAyNiBhdCAzOjI54oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgo+Cj4gUHJvcGVybHkgbWFzayB0aGUgdHR5cGUgd2l0aCBUVFlQRV9NQVNL
KCkgd2hlbiBkZWNpZGluZyBpZiBUREVCVUcKPiBtZXNzYWdlcyBzaG91bGQgYmUgcHJpbnRlZCwg
b3RoZXJ3aXNlIGFueSBjb21iaW5hdGlvbiBvZiBURVJSTk8gZXRjLgo+IGZsYWdzIGlzIHByaW50
ZWQgcmVnYXJkbGVzcyB0aGUgLUQgZmxhZy4KPgo+IFNpZ25lZC1vZmYtYnk6IEN5cmlsIEhydWJp
cyA8Y2hydWJpc0BzdXNlLmN6PgoKQWNrZWQtYnk6IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRo
YXQuY29tPgoKPiAtLS0KPiAgbGliL25ld2xpYl90ZXN0cy90c3RfcmVzX2ZsYWdzLmMgfCAxICsK
PiAgbGliL3RzdF90ZXN0LmMgICAgICAgICAgICAgICAgICAgfCAyICstCj4gIDIgZmlsZXMgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvbGli
L25ld2xpYl90ZXN0cy90c3RfcmVzX2ZsYWdzLmMgYi9saWIvbmV3bGliX3Rlc3RzL3RzdF9yZXNf
ZmxhZ3MuYwo+IGluZGV4IGNkYTA5NzA3MC4uZjRhYWEwNDM5IDEwMDY0NAo+IC0tLSBhL2xpYi9u
ZXdsaWJfdGVzdHMvdHN0X3Jlc19mbGFncy5jCj4gKysrIGIvbGliL25ld2xpYl90ZXN0cy90c3Rf
cmVzX2ZsYWdzLmMKPiBAQCAtMjIsNiArMjIsNyBAQCBzdGF0aWMgc3RydWN0IHRjYXNlIHsKPiAg
ICAgICAgIHtGTEFHKFRXQVJOKX0sCj4gICAgICAgICB7RkxBRyhUSU5GTyl9LAo+ICAgICAgICAg
e0ZMQUcoVERFQlVHKSwgIiAocHJpbnRlZCBvbmx5IHdpdGggLURbMSwyXSBvciBMVFBfREVCVUc9
MSh5KSwyKSJ9LAo+ICsgICAgICAge0ZMQUcoVERFQlVHIHwgVEVSUk5PKSwgIiAocHJpbnRlZCBv
bmx5IHdpdGggLURbMSwyXSBvciBMVFBfREVCVUc9MSh5KSwyKSJ9LAo+ICB9Owo+Cj4gIHN0YXRp
YyB2b2lkIGRvX2NsZWFudXAodm9pZCkKPiBkaWZmIC0tZ2l0IGEvbGliL3RzdF90ZXN0LmMgYi9s
aWIvdHN0X3Rlc3QuYwo+IGluZGV4IDVjMzYwNzAxNi4uOWM1ZjI2MTdmIDEwMDY0NAo+IC0tLSBh
L2xpYi90c3RfdGVzdC5jCj4gKysrIGIvbGliL3RzdF90ZXN0LmMKPiBAQCAtNDk1LDcgKzQ5NSw3
IEBAIHZvaWQgdHN0X3Jlc18oY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgaW50
IHR0eXBlLAo+ICAgICAgICAgICogMy4gRGVidWcgb3V0cHV0IGlzIG9ubHkgZm9yIHRlc3QgcHJv
Y2VzcyAoY29udGV4dC0+dGRlYnVnID09IDEpLgo+ICAgICAgICAgICogNC4gRGVidWcgb3V0cHV0
IGlzIGVuYWJsZWQgZm9yIGJvdGggdGVzdCBhbmQgbGliIHByb2Nlc3NlcyAoY29udGV4dC0+dGRl
YnVnID09IDIpLgo+ICAgICAgICAgICovCj4gLSAgICAgICBpZiAodHR5cGUgPT0gVERFQlVHKSB7
Cj4gKyAgICAgICBpZiAoVFRZUEVfUkVTVUxUKHR0eXBlKSA9PSBUREVCVUcpIHsKPiAgICAgICAg
ICAgICAgICAgaWYgKCFjb250ZXh0KQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybjsK
Pgo+IC0tCj4gMi41NC4wCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
