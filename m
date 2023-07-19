Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11497EB64DA
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 09:11:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E348D3CDD16
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 11:11:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BCE13C02C7
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 11:11:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0B0C6201100
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 11:11:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689757872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iHdj44wErqX10vgMEwC7HPTsaPmLrlakyJVTsxvp0DY=;
 b=QjRKZraGdCCgMSQ/Uat71VlXyM4uivbtpqIFTv69abs8C/uXDNvz2oMmCRZqSEW7P4+BXs
 Ca5vdqLo2iKT/whSUmxHYOClNh0O99esJTorOzKMe57Lr7eCKL4QUz0hx4Ot8i7Ts3v1sI
 QsaR0B70uZ+A0g7plHdq20GTX+A6OTk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-dJprHXvGPF2GHLOQ3j12-A-1; Wed, 19 Jul 2023 05:11:10 -0400
X-MC-Unique: dJprHXvGPF2GHLOQ3j12-A-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b701c82e83so61166271fa.1
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 02:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689757869; x=1692349869;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iHdj44wErqX10vgMEwC7HPTsaPmLrlakyJVTsxvp0DY=;
 b=A9mKrxovAl7zxslu5cZI8TJf3tpw3XbhP6rggES1PXTGefuEB87a9fKDSg/br/Mss0
 b2FvqyeERXINPct6Nh0UfuG088hKL+JPH4Z1jlilaI3w9LnxgZqnzpIYF42ngnJTXBFz
 NIu0zu5sIN52oOa7eZa3vpO2camox0CVQ41+IU1F6JsF1ovYnKFVyWYbXzSYD8Eh8L5o
 67F9/tvhxrlHbCxZgVDVA8yuOOOXDbvawxBRwREODYcmWq9SRLbkQXZaIRaXgjsfKk4Q
 CyWJN02jgWzmY3AUY2+FvSpI25argfd+oIaVYNAwKQS5hCSpmYpqhB092QSQVX+cZq43
 W5iw==
X-Gm-Message-State: ABy/qLaRsYWn8xo6uP72InUj+oU0zRX16lRU9BMV04tL0LboTspyhedD
 p6hK+Sq/lEdwUOhASqqHQkBk9KdTIR3CExN5shlzfQAKxYFhjtWwSyZrq/MRoB6CAUVC8uABvZd
 qoIv8tDX/+1QxUzNPvbkB/irLZBM=
X-Received: by 2002:a2e:9059:0:b0:2b6:9ed0:46f4 with SMTP id
 n25-20020a2e9059000000b002b69ed046f4mr2227678ljg.23.1689757868859; 
 Wed, 19 Jul 2023 02:11:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFFsPaSOB/IA3k8rMSO6vo8unwzGICoprogMwAXCHX4doEETt/6eE0sw3SoiV8j88V2FLN77YAzY8+WgFJ94T4=
X-Received: by 2002:a2e:9059:0:b0:2b6:9ed0:46f4 with SMTP id
 n25-20020a2e9059000000b002b69ed046f4mr2227663ljg.23.1689757868537; Wed, 19
 Jul 2023 02:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230719085529.8886-1-mdoucha@suse.cz>
In-Reply-To: <20230719085529.8886-1-mdoucha@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Jul 2023 17:10:56 +0800
Message-ID: <CAEemH2ee36=NQCvNZ+fwj2=mkG+Bx7doSudsJw_qqnRijMXyWw@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] cpuset_memory_testset.sh: Fix syntax error when
 hugepages not supported
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

T24gV2VkLCBKdWwgMTksIDIwMjMgYXQgNDo1NeKAr1BNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFA
c3VzZS5jej4gd3JvdGU6Cgo+IFRoZSBpbml0aWFsIGh1Z2VwYWdlIHNpemUgY2FsY3VsYXRpb24g
Y2FuIHJlc3VsdCBpbiBtdWx0aXBsaWNhdGlvbgo+IG9mIGVtcHR5IHN0cmluZyBvbiBtYWNoaW5l
cyB3aGljaCBkb24ndCBzdXBwb3J0IGh1Z2VwYWdlcy4gTWFrZQo+IHN1cmUgdGhhdCBlbXB0eSBz
dHJpbmcgaXMgY29udmVydGVkIHRvIHplcm8uCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gRG91
Y2hhIDxtZG91Y2hhQHN1c2UuY3o+Cj4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVk
aGF0LmNvbT4KCj4gLS0tCj4gIC4uLi9jcHVzZXQvY3B1c2V0X21lbW9yeV90ZXN0L2NwdXNldF9t
ZW1vcnlfdGVzdHNldC5zaCAgICAgICAgICB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0Cj4gYS90ZXN0Y2FzZXMva2Vy
bmVsL2NvbnRyb2xsZXJzL2NwdXNldC9jcHVzZXRfbWVtb3J5X3Rlc3QvY3B1c2V0X21lbW9yeV90
ZXN0c2V0LnNoCj4gYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2NwdXNldC9jcHVzZXRf
bWVtb3J5X3Rlc3QvY3B1c2V0X21lbW9yeV90ZXN0c2V0LnNoCj4gaW5kZXggY2I3ZGJkODY3Li5j
MWU3Y2VhOGYgMTAwNzU1Cj4gLS0tCj4gYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2Nw
dXNldC9jcHVzZXRfbWVtb3J5X3Rlc3QvY3B1c2V0X21lbW9yeV90ZXN0c2V0LnNoCj4gKysrCj4g
Yi90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2NwdXNldC9jcHVzZXRfbWVtb3J5X3Rlc3Qv
Y3B1c2V0X21lbW9yeV90ZXN0c2V0LnNoCj4gQEAgLTQxLDcgKzQxLDcgQEAgbWVtc19hbGw9IiQo
c2VxIC1zLCAwICQoKG5yX21lbXMtMSkpKSIKPiAgY3B1X29mX25vZGUwPTAKPgo+ICBIVUdFUEFH
RVNJWkU9JChhd2sgJy9IdWdlcGFnZXNpemUveyBwcmludCAkMiB9JyAvcHJvYy9tZW1pbmZvKQo+
IC1IVUdFUEFHRVNJWkU9JCgoJEhVR0VQQUdFU0laRSAqIDEwMjQpKQo+ICtIVUdFUEFHRVNJWkU9
JCgoJHtIVUdFUEFHRVNJWkU6LTB9ICogMTAyNCkpCj4KPiAgTUVNT1JZX1JFU1VMVD0iJENQVVNF
VF9UTVAvbWVtb3J5X3Jlc3VsdCIKPgo+IC0tCj4gMi40MS4wCj4KPgo+IC0tCj4gTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJl
Z2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
