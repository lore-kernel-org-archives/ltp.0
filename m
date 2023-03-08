Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CB4C6FA99
	for <ltp@archiver.kernel.org>; Wed,  8 Mar 2023 00:18:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFC4B3CD9A5
	for <ltp@archiver.kernel.org>; Wed,  8 Mar 2023 01:18:47 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D9763C1047
 for <ltp@lists.linux.it>; Wed,  8 Mar 2023 01:18:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 308001000464
 for <ltp@lists.linux.it>; Wed,  8 Mar 2023 01:18:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678234713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PB/fVX04RSK/FgIRUl1Jm92NLI+Oq+Ub1GZ5pcBZhJ4=;
 b=YrgtZemY4UTFoQ8FCCHXST+iSz5JVZ2oVkJEaQoiMnNcKUp/oXa2PtEo0jK6mgoSn/hkV8
 uL1tf46A9oB40wVAnww6MMpcT8bIMPoMvkEZ+QUYGE86L/TmUltDguap1+/Ab/IcHj/JjL
 GTw2cW3a0MvHyOZ25Me4/nvdwJuTC2U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-_P0-LaRFMlKmiQpOqsaSFw-1; Tue, 07 Mar 2023 19:18:29 -0500
X-MC-Unique: _P0-LaRFMlKmiQpOqsaSFw-1
Received: by mail-wr1-f69.google.com with SMTP id
 a7-20020a056000188700b002cdd0562b11so2566605wri.11
 for <ltp@lists.linux.it>; Tue, 07 Mar 2023 16:18:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678234708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PB/fVX04RSK/FgIRUl1Jm92NLI+Oq+Ub1GZ5pcBZhJ4=;
 b=GQGMiJlJT0Oe0BP3+Q5gsTtjNtpO/2V9pHiYenWpM9B6yoysWKBkcndTwuYrapl6hg
 J/FRiVl1FgEj1bf9ThPASR0FqX6Y06R/BR8Ke86tQNE8U69SAN3URvc1fmJcVoBytrbK
 iXLTtkuJmunALfScLtn4xp6w3Weke45UV+knX53VSiWHWE06ebVF5IXQCTmFKdtdkZIj
 S5p3dwz/RQNbFjiIfyIcjKmwDBlOxTqTx9/qKHH6awWO1ds0Oo8h+Drku7K7ZBGnyNET
 KSJMqZq0qxtzzvPeNWh0LG5kpGopX7z8NWN83hWCxayOAXO3eZfavlXuItH+mm0Og5Lz
 BhLg==
X-Gm-Message-State: AO0yUKUAB5BI0KeOrZ7SGpSlOo7/fsgpeZfUA7D/UZE6sdF7Wis7ZRw5
 JkLjsIR9Zl+pKKS2XzHWZgRpxkkxcC/+Gg5SZZlYJEutEeYSjWjzpgVY2Vvc3e+ioIaGSwG9Znq
 nuZDTUvPqBmDN/ZZuxYRSfQw8jyo=
X-Received: by 2002:a05:600c:a695:b0:3e2:1a3f:4ea2 with SMTP id
 ip21-20020a05600ca69500b003e21a3f4ea2mr3473637wmb.7.1678234708215; 
 Tue, 07 Mar 2023 16:18:28 -0800 (PST)
X-Google-Smtp-Source: AK7set+ukRh4BlH3RfGp6IrzmtP8J5NIc87xHd+MINLnzx0Wk3S6aisNXKQv5xs8nUAgfjF4VytRFIxnYI+o1ZJfnCg=
X-Received: by 2002:a05:600c:a695:b0:3e2:1a3f:4ea2 with SMTP id
 ip21-20020a05600ca69500b003e21a3f4ea2mr3473634wmb.7.1678234707995; Tue, 07
 Mar 2023 16:18:27 -0800 (PST)
MIME-Version: 1.0
References: <CAEemH2esqAP+kfEgwXkSkw6V7ubFn+uq2_QdF_Nx1gF2t-WXzA@mail.gmail.com>
 <20230302074123.567654-1-liwang@redhat.com> <20230303083822.GB4255@pevik>
In-Reply-To: <20230303083822.GB4255@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Mar 2023 08:18:16 +0800
Message-ID: <CAEemH2ffqNxiOMyGx1m+7RmAcj2OHk2vdCyA2ZVDEnU0PGOytw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, Richard Palethorpe <rpalethorpe@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCh v2] madvise06: stop throwing failure when
 MADV_WILLNEED is ignored
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
Cc: Yongqiang Liu <liuyongqiang13@huawei.com>, Paul Bunyan <pbunyan@redhat.com>,
 Eirik Fuller <efuller@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpPbiBGcmksIE1hciAzLCAyMDIzIGF0IDM6NDTigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4gd3JvdGU6Cgo+IEhpIExpLAo+Cj4gTEdUTS4KPiBBY2tlZC1ieTogUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+Cj4KClRoYW5rIHlvdSBmb3IgeW91ciBhY2ssIFBldHIuCgpJIHN0
aWxsIHdhbnQgUmljaGFyZCBnaXZlcyBtZSBhIGZpbmFsIGNoZWNrLgoKQFJpY2hhcmQsIGRvIHlv
dSBhZ3JlZSB3aXRoIHB1c2hpbmcgaXQsIG9yIG90aGVyIHRob3VnaHRzPwoKCi0tIApSZWdhcmRz
LApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
