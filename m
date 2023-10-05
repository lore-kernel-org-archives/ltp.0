Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3D8E81DFB
	for <ltp@archiver.kernel.org>; Fri,  6 Oct 2023 13:30:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B9073C911B
	for <ltp@archiver.kernel.org>; Fri,  6 Oct 2023 15:30:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF71C3C8B94
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 21:21:08 +0200 (CEST)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EDB6F1A0091E
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 21:21:07 +0200 (CEST)
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-49d55b90a5aso920265e0c.0
 for <ltp@lists.linux.it>; Thu, 05 Oct 2023 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696533667; x=1697138467; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3YAwa7B2OJPRUP59nwxn3A11jwk1jGLcSNDbqpCUEs=;
 b=davImytqsic732oOgoDS5ghStLgyHGlfNslzcFz1xIYSL3p7lGjwRkIOh/vA0TW/Mq
 0hQ0nyo54o2tQL2mCSojPwHzLfSawhH9J2JwhGPpKry5e+f+I6obGPhRpcuEFk6Jsh8Q
 n6df0HVdbj56lHz4ofwpHPuC4rlbMide+frkd81VHlENBNYBEkiDeqeNcJWnG9b0tfpi
 VvJN5j4Ve/x/WfA4SYv46qn5nexZC7odNsTf0U/k/ltTySUUcPUvoHMNce/gdblHFsVl
 GygTU5lC/an7Bft2zy/uu9y3aT4BX3acAD6IvwqZCW/SMROXlCyW+f/YZzdpwT/l6vVj
 YUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696533667; x=1697138467;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3YAwa7B2OJPRUP59nwxn3A11jwk1jGLcSNDbqpCUEs=;
 b=s0c1gWHGnCfeKuaQLimOQnpdV4zC4GNQghl7TP+h8URAeAvXv6YhQ6h1HOLJ5tTqVo
 gIhqUXE7glki6SQ7Szi8AMHUgDhPuC2QUPpAT888bkiqN8FmUtYa6HSikC1n5JlavMQT
 9iuKPJoyI6ipz8xEJNG28L7KUd26m2whcsrzfvL9wOwMkUyLx3xhWygKsBUlvOcoquNv
 lIgbNLBKRwI6+YhZZs+e1wA9U3lXWGuXl5EPs6ksABTPgcHf735TjZFfBVVrux+ev3Od
 ytfD11/qL6j8EVfpk5qGoFO57d2BEgbRUTaDfEYJS27ef8QaCehY3SQNK9hh2v3F+12k
 FOuQ==
X-Gm-Message-State: AOJu0Yy5YZp+2h6cLFldKgl6Wousw2NCVyf2gYSBREYVyqwJO0i104AY
 ROOjV1eX1mwVi+k2w3y/on9yvJYNhxAxQXGKpTwiSQ==
X-Google-Smtp-Source: AGHT+IFhEXUCf6hg0p0VkgiUHPuy9O4n5JiWEsbvC4N0pJ6GZCevj6BKaE5f4ZMr3qR2O1q/atILq+7gURY5Qemu1P4=
X-Received: by 2002:a05:6122:4201:b0:49a:b587:ab79 with SMTP id
 cm1-20020a056122420100b0049ab587ab79mr1292189vkb.8.1696533666626; Thu, 05 Oct
 2023 12:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231004175217.404851126@linuxfoundation.org>
 <CA+G9fYsqbZhSQnEi-qSc7n+4d7nPap8HWcdbZGWLfo3mTH-L7A@mail.gmail.com>
 <20231005172448.GA161140@pevik>
In-Reply-To: <20231005172448.GA161140@pevik>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 6 Oct 2023 00:50:55 +0530
Message-ID: <CA+G9fYuyXgWvsRhznP2x2VE5CvSyCCgcvxPz2J=dbvg6YW2iUA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 06 Oct 2023 15:30:10 +0200
Subject: Re: [LTP] [PATCH 6.1 000/259] 6.1.56-rc1 review
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
Cc: lkft-triage@lists.linaro.org, linux-kernel@vger.kernel.org,
 Olga Kornievskaia <kolga@netapp.com>, stable@vger.kernel.org, shuah@kernel.org,
 f.fainelli@gmail.com, jonathanh@nvidia.com, patches@kernelci.org,
 linux@roeck-us.net, srw@sladewatkins.net,
 Richard Palethorpe <rpalethorpe@suse.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 LTP List <ltp@lists.linux.it>, linux-nfs@vger.kernel.org,
 Eryu Guan <eguan@redhat.com>, rwarsow@gmx.de, pavel@denx.de,
 patches@lists.linux.dev, conor@kernel.org, sudipm.mukherjee@gmail.com,
 Benjamin Coddington <bcodding@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, Anna Schumaker <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCA1IE9jdCAyMDIzIGF0IDIyOjU0LCBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4g
d3JvdGU6Cj4KPiBIaSBOYXJlc2gsCj4KPiA+IE9uIFdlZCwgNCBPY3QgMjAyMyBhdCAyMzo0MSwg
R3JlZyBLcm9haC1IYXJ0bWFuCj4gPiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3Rl
Ogo+Cj4gPiA+IFRoaXMgaXMgdGhlIHN0YXJ0IG9mIHRoZSBzdGFibGUgcmV2aWV3IGN5Y2xlIGZv
ciB0aGUgNi4xLjU2IHJlbGVhc2UuCj4gPiA+IFRoZXJlIGFyZSAyNTkgcGF0Y2hlcyBpbiB0aGlz
IHNlcmllcywgYWxsIHdpbGwgYmUgcG9zdGVkIGFzIGEgcmVzcG9uc2UKPiA+ID4gdG8gdGhpcyBv
bmUuICBJZiBhbnlvbmUgaGFzIGFueSBpc3N1ZXMgd2l0aCB0aGVzZSBiZWluZyBhcHBsaWVkLCBw
bGVhc2UKPiA+ID4gbGV0IG1lIGtub3cuCj4KPiA+ID4gUmVzcG9uc2VzIHNob3VsZCBiZSBtYWRl
IGJ5IEZyaSwgMDYgT2N0IDIwMjMgMTc6NTE6MTIgKzAwMDAuCj4gPiA+IEFueXRoaW5nIHJlY2Vp
dmVkIGFmdGVyIHRoYXQgdGltZSBtaWdodCBiZSB0b28gbGF0ZS4KPgo+ID4gPiBUaGUgd2hvbGUg
cGF0Y2ggc2VyaWVzIGNhbiBiZSBmb3VuZCBpbiBvbmUgcGF0Y2ggYXQ6Cj4gPiA+ICAgICAgICAg
aHR0cHM6Ly93d3cua2VybmVsLm9yZy9wdWIvbGludXgva2VybmVsL3Y2Lngvc3RhYmxlLXJldmll
dy9wYXRjaC02LjEuNTYtcmMxLmd6Cj4gPiA+IG9yIGluIHRoZSBnaXQgdHJlZSBhbmQgYnJhbmNo
IGF0Ogo+ID4gPiAgICAgICAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9zdGFibGUvbGludXgtc3RhYmxlLXJjLmdpdCBsaW51eC02LjEueQo+ID4gPiBhbmQg
dGhlIGRpZmZzdGF0IGNhbiBiZSBmb3VuZCBiZWxvdy4KPgo+ID4gPiB0aGFua3MsCj4KPiA+ID4g
Z3JlZyBrLWgKPgo+ID4gUmVzdWx0cyBmcm9tIExpbmFyb+KAmXMgdGVzdCBmYXJtLgo+ID4gUmVn
cmVzc2lvbnMgb24gYXJtNjQgYmNtMjcxMS1ycGktNC1iIGRldmljZSBydW5uaW5nIExUUCBkaW8g
dGVzdHMgb24KPiBDb3VsZCB5b3UgcGxlYXNlIG5vdGUgaW4geW91ciByZXBvcnRzIGFsc28gTFRQ
IHZlcnNpb24/CgpTdXJlLgpXZSBhcmUgcnVubmluZyBMVFAgVmVyc2lvbjogMjAyMzA1MTYgZm9y
IG91ciB0ZXN0aW5nLgoKV2Ugd2lsbCB1cGRhdGUgdGhlIGxhdGVzdCBMVFAgcmVsZWFzZSAoMjAy
MzA5MjkpIG5leHQgd2Vlay4KCj4gRllJIHRoZSBiZXN0IExUUCByZWxlYXNlIGlzIGFsd2F5cyB0
aGUgbGF0ZXN0IHJlbGVhc2Ugb3IgZ2l0IG1hc3RlciBicmFuY2guCgpXZSBoYXZlIHR3byB0aHJl
YWRzIGhlcmUuCjEpIExUUCByZWxlYXNlIHRhZyB0ZXN0aW5nIG9uIGFsbCBzdGFibGUtcmMgYnJh
bmNoZXMKMikgTFRQIG1hc3RlciB0ZXN0aW5nIG9uIGEgZ2l2ZW4gc3BlY2lmaWMga2VybmVsIHZl
cnNpb24gW2FdCgpbYV0gaHR0cHM6Ly9xYS1yZXBvcnRzLmxpbmFyby5vcmcvbGtmdC9sdHAtbWFz
dGVyLwoKLSBOYXJlc2gKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
