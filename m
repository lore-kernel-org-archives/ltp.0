Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B920EC35274
	for <ltp@archiver.kernel.org>; Thu, 21 Dec 2023 08:53:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 657803CEF45
	for <ltp@archiver.kernel.org>; Thu, 21 Dec 2023 09:53:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A5843CD749
 for <ltp@lists.linux.it>; Thu, 21 Dec 2023 09:52:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 81391600657
 for <ltp@lists.linux.it>; Thu, 21 Dec 2023 09:52:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703148774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lXwzfZ1QzfugzF9qPHVrxXMMF73Zh4P5XYHiMZawnhg=;
 b=VuRwXYBk1s1z3ri1VsVI1+PYBmspeDq+DvESDXv6zCE2HwL4X+4/zaLpUndZe+8d90Dn08
 SKx5YoSb5ofn9YMDpQ8N87e8Xnuy3fSUj3bhh8CPwGkwhr20o58ebxVMrRdRmnYvrNmYhi
 SRRvizuN6oyA9HvaypieEvzR4GTplfY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-VuoLTzqXP5KmunJdVKhkVA-1; Thu, 21 Dec 2023 03:52:51 -0500
X-MC-Unique: VuoLTzqXP5KmunJdVKhkVA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2cc6bc4cc87so3595721fa.2
 for <ltp@lists.linux.it>; Thu, 21 Dec 2023 00:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703148770; x=1703753570;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lXwzfZ1QzfugzF9qPHVrxXMMF73Zh4P5XYHiMZawnhg=;
 b=t5aFdUJqkG/XtbtyUJc9+1IYpQbZKbbh54XI0Qgp6GJ3w5af08aKj5zcynsPTZdZbO
 1r5CWvhQaw76kzD9accEW5qWbxoOAecCb9YiTmw3MosNo1jmiuoCal1/Vz2aRw0GPUtd
 E3PpLXwphHXrKgDmqlNYe9lDWtGjN3bsPjSlPM/rxevN6KX/KSf98MAebC83XvSwqQ4B
 KIui7d6HtfuF/AVpNC9LIJ0mAOqP/V7eOdV2Gq6M83pwUaESQgDmaakU4EX0ihmB9zNv
 gPRYxVpGWDeXPr5B9oZI5j/4ZPO+FYU9SUkVr1G6S2QEiAjXB5P45jJEfdvMfrVXW06P
 mHOQ==
X-Gm-Message-State: AOJu0YxXA/L/HA9n2LbIURQb2LLgi9oIC2u5l18ac99M3Ihi1xRHayBx
 so73TybClDeDjuaJx7ywqIORhYj4QkJvF7OvrAhoWHWweAMbNnFBZI1BjqsTLJ4tvx6iZc/GbNA
 ON4JE1qGMuFk/ZJ8hMBPsTk+IF7E=
X-Received: by 2002:a2e:870c:0:b0:2cc:7b1e:15e4 with SMTP id
 m12-20020a2e870c000000b002cc7b1e15e4mr2426952lji.30.1703148770114; 
 Thu, 21 Dec 2023 00:52:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb0Et0D7cEiWL/2lK9KIjiUlDuM1K+N+Gcda7cNxII/qZt3nfwgacc+8t6gctbMDfe0FIEaD2kQs1/HFdNMrk=
X-Received: by 2002:a2e:870c:0:b0:2cc:7b1e:15e4 with SMTP id
 m12-20020a2e870c000000b002cc7b1e15e4mr2426948lji.30.1703148769730; Thu, 21
 Dec 2023 00:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20231220145047.422491-1-pvorel@suse.cz>
In-Reply-To: <20231220145047.422491-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Dec 2023 16:52:37 +0800
Message-ID: <CAEemH2d2Yj0J1GYoRASCiDHAmOJMhqnM7PHo=gOTct1H4+-bJg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] oom*: Turn docs to docparse
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

SGkgUGV0ciwKCk9uIFdlZCwgRGVjIDIwLCAyMDIzIGF0IDEwOjUw4oCvUE0gUGV0ciBWb3JlbCA8
cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9y
ZWxAc3VzZS5jej4KPiAtLS0KPiBIaSwKPgo+IEkgcmVtb3ZlZCB0aGUgcGFyYWdyYXBoIHdoaWNo
IHdhcyB0aGUgc2FtZSBmb3IgYWxsIHRlc3RzLCB3aGljaCBpcwo+IGdlbmVyYWxseSBnb29kLCBi
dXQgSU1ITyBvdXRkYXRlZCAob3JpZ2luYXRlcyBmcm9tIDBkYjU1MDc3ZiBpbiAyMDExLAo+IGUu
Zy4gMyBHQiB3YXMgaW4gbGliL29vbS5oICNkZWZpbmUgTEVOR1RIICgzVUw8PDMwKSwgYnV0IHRo
ZSBmaWxlIHdhcwo+IHJlbW92ZWQgaW4gNGUyMTdhMzk4KS4gQWxzbyB0ZXN0cyBkaWZmZXJzLCBi
dXQgdGhlIHRleHQgaXMgdGhlIHNhbWUuCj4KPiBATGkgSWYgeW91IGhhdmUgdGltZSwgZmVlbCBm
cmVlIHRvIGFkZCBtb3JlIHRlc3QgZGVzY3JpcHRpb24gYW5kIHB1c2ggaXQKPiB3aXRoIHlvdXJz
ZWxmIGFzIHRoZSBhdXRob3IuCj4KClBhdGNoIG1lcmdlZC4KClRoZSBPT00gdGVzdCBjb2RlIGl0
c2VsZiBpcyBlYXN5IHRvIHJlYWQgYW5kIGRvZXMgbm90IHJlcXVpcmUgZXhjZXNzaXZlCmNvbW1l
bnRzLgoKVGhhbmsgeW91IGFuZCBNZXJyeSBDaHJpc3RtYXMhISEKCi0tIApSZWdhcmRzLApMaSBX
YW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
