Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A21C35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 08:48:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FF203CB08B
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 09:48:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 710A23C83BA
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 09:48:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.145.221.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6EE852064EF
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 09:48:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702889278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MRFoP4exmEnhSQEqtXDXHgLTvjMaC7CYjjAWoQs3Z/U=;
 b=AeYtkJwEc5BqnMR8dGz2lbKl8cUZEOQs6cMtilMUqrD114oK47/lMB6DpIL7SNkXLz8/H5
 M/C2/hJrMPQuHa8v1NFvzBWetQbumOwMWNuSNy/kxksOp4OK22dKxeoL2VhH/hdYwexJiW
 YYM7vbPoA1pQpYDSN6GCHVgkHMaCNTw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-lbImvdRzPR2mB9w6I5Q1yw-1; Mon, 18 Dec 2023 03:47:56 -0500
X-MC-Unique: lbImvdRzPR2mB9w6I5Q1yw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2cc61c96e08so13586841fa.0
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 00:47:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702889272; x=1703494072;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MRFoP4exmEnhSQEqtXDXHgLTvjMaC7CYjjAWoQs3Z/U=;
 b=WjxL+vrpSfKNFROVjL+bXocelwm8ZnWHi3xtYSbC+HE4Xf+Xtb9Oo6T89dXNNLDa8A
 SNVU39/2g5SGEvuh4VFAUu4ctBQXcoGNT15uM55uG4o6N1yUhFoFXcoW8U+D/HvPhN3P
 yZTLHDI4iP/GdkNmtF+t8U8e89c4ABjDnlnX47CBKl/J+uCTaAn8P/ICbf0hJLaSln5y
 SScZBi7wShaLQeFWhXNXYC3A0xF7c32rmQCqFP2ekEmSkTPhXNmeBICt3WfnT67hJeSN
 mCWJwkkM7SD5JO+YoweLB2aJgnNNL2WF0+YIFqe6l1a+8kW9ABpspy47J/2MeyqO7TrY
 PoSA==
X-Gm-Message-State: AOJu0Yx112YS3nrUi2Mi8N8qYZy567MHLu5rpJqFR4CFZ3lPEbC94jEA
 kfW3SnM14eWLXXpEIBI6ToDqZqjGIhMhDcIA/GVv0/1Z4lZ1X6OKt8YaOi6rgq9PQE+uy+k+cUa
 zWXhimWqWDJZHOIDb4TVBbNt52V3j+N8S9aDuyvvTubw=
X-Received: by 2002:a05:651c:50c:b0:2cc:4210:57b9 with SMTP id
 o12-20020a05651c050c00b002cc421057b9mr3847131ljp.80.1702889272560; 
 Mon, 18 Dec 2023 00:47:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI/NDe26nYQhcX3akXK3wGzn3fgTwGIKht6paWks3Atk++g/INx6bnCpTtI3FQgNtuG1pwiUHR2fpoRyajZ+8=
X-Received: by 2002:a05:651c:50c:b0:2cc:4210:57b9 with SMTP id
 o12-20020a05651c050c00b002cc421057b9mr3847126ljp.80.1702889272242; Mon, 18
 Dec 2023 00:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20231218062129.130236-1-xuyang2018.jy@fujitsu.com>
In-Reply-To: <20231218062129.130236-1-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 18 Dec 2023 16:47:39 +0800
Message-ID: <CAEemH2e-QNst=HVf3C-mEmdRiNh-Rrq-WzAc8bAcOLEAW9jjOA@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] gettimeofday01: Convert to new API
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

T24gTW9uLCBEZWMgMTgsIDIwMjMgYXQgNDoxNuKAr1BNIFlhbmcgWHUgPHh1eWFuZzIwMTguanlA
ZnVqaXRzdS5jb20+IHdyb3RlOgoKPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1IDx4dXlhbmcyMDE4
Lmp5QGZ1aml0c3UuY29tPgo+CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+CgpCdXQgSSB3b3VsZCBzdWdnZXN0IGFkZGluZyBtb3JlIGNvdmVyYWdlIG9uIEVSUk9SUyBp
biB0aGlzIHRlc3QuCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
