Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403F2C4332F
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 09:28:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E8503CC8DB
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 10:28:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C5C03CC822
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 10:28:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 49C8D1B601C9
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 10:28:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698917279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YLLmAaMUQbUBssM1m3M4XddqCHT5Ld4Vq+Q1BwH/ZNY=;
 b=LssFoMp+RpQQZPJlQXLs5BVRbsHrz/atnFc/T1v0jJQ+heOL4JvRFJPPer5anQuHYOW2wT
 DE9WPT7S5xeGFmNjrODrU5MZstu6Vw6F1r+QUTt3sR1AkIxrQm+0rv7DLlPy7jRaz5CTSM
 GSv6c2+gdEr6s0LbRoBu/iDYtZBzyEk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-ESikKCi2MgqY-Z3FEh1OWw-1; Thu, 02 Nov 2023 05:27:58 -0400
X-MC-Unique: ESikKCi2MgqY-Z3FEh1OWw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50798a259c7so643377e87.1
 for <ltp@lists.linux.it>; Thu, 02 Nov 2023 02:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698917275; x=1699522075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YLLmAaMUQbUBssM1m3M4XddqCHT5Ld4Vq+Q1BwH/ZNY=;
 b=eW7vVEAwLhJVtOpXC7Z3398/u5e9zXSmNKA8jBG8RVU2aNkleb9W+w96qRBUEXQpFx
 6LnLGEW/hWfoBUdZJPjiRqlkhLxfYfgfurHHeXRIHiFo8QMgsLR3kAbkuvyuIH47BLgq
 TvyrUAiQwJAOhz4No8v/eFnv95KWbWmtEAik9v3DythTx4ERWHBa21AT3YJ+jzeSJqES
 hJiaZs+wF6mP7u2u2MT7p9SX0J1DUk9vWTZNyE1eRyWPTYEkv+AkdD6YUNc5ung8m3pD
 7kFsrUt0pYFRic9xqnklQprX6qUHLrZBGWbNY2CRZwVSAErlhSkccrI9IxfmRRIl4J2b
 P1Ig==
X-Gm-Message-State: AOJu0YxtmUcnZWhsSRx1PP6J53mc82TGRn+DErnT9pylaXI1q8/FpCSR
 rH3/aJaFCMmC2GUNfrg/bGkKUNXtfk+n74BVuFgwTe+u0zsaA9N9MYrrvK+XyX6U5+7jmW8JbK2
 vTNwb4CCxz+JEISEbAC+neb/3+CY=
X-Received: by 2002:a05:6512:1598:b0:509:4b04:6331 with SMTP id
 bp24-20020a056512159800b005094b046331mr1079751lfb.55.1698917275407; 
 Thu, 02 Nov 2023 02:27:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6YSCuBjlUmCTtxVHvmApdcc2aUSosY4Jgw1D5B/U/7r/c+DrwJfTGyVYFbICbYrBBlPjzALAXk8rIk7gxLPI=
X-Received: by 2002:a05:6512:1598:b0:509:4b04:6331 with SMTP id
 bp24-20020a056512159800b005094b046331mr1079737lfb.55.1698917275025; Thu, 02
 Nov 2023 02:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231102072030.1800796-1-liwang@redhat.com>
 <20231102092135.GA921952@pevik>
In-Reply-To: <20231102092135.GA921952@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 2 Nov 2023 17:27:43 +0800
Message-ID: <CAEemH2fWDQgPv+9TR9nb4rw5CsJx3uGKS+Yvb3YqgNEOUSVYmg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] ci: add centos stream support
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
Cc: Chao Ye <cye@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIFRodSwgTm92IDIsIDIwMjMgYXQgNToyMeKAr1BNIFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiA+IFRoaXMgaXMgYmFzZSBvbiBQZXRl
cidzIHBhdGNoOgo+ID4gICBDSTogUmVBcGxhY2UgQ2VudE9TIDcgd2l0aCBvcGVuU1VTRSBMZWFw
IDQyLjIsIFVidW50dSB4ZW5pYWwKPgo+ID4gQ2k6IGh0dHBzOi8vZ2l0aHViLmNvbS93YW5nbGk1
NjY1L2x0cC9hY3Rpb25zL3J1bnMvNjcyOTM3OTU2NQo+Cj4gUmV2aWV3ZWQtYnk6IFBldHIgVm9y
ZWwgPHB2b3JlbEBzdXNlLmN6Pgo+CgpUaGFua3MhCgoKPiBBVE0gd2UgaGF2ZSAxOCBqb2JzLCBJ
TUhPIHdlIHNob3VsZCBub3QgYWRkIG1vcmUgd2l0aG91dCByZW1vdmluZyBvdGhlcnMKPiBqdXN0
IHRvCj4gaGF2ZSByZWFzb25hYmxlIENJIHJ1bnRpbWUuCj4KCllvdXIgY29uY2VybiBtYWtlcyBz
ZW5zZSwgYnV0IEkgaGF2ZSBubyBpZGVhIHdoaWNoIG9uZSBjb3VsZCBiZSByZW1vdmVkLgoKCi0t
IApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
