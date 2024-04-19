Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F873C4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 02:04:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD4AF3CFC21
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 04:04:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45A653CF435
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 04:04:26 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8429B1000C2C
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 04:04:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713492263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lU97DMhqafSd9IDZqmjTCne3OrKWdepMrnENkYsysng=;
 b=N0p14NgwO9ITT6lE5Py46gHMwj5Y7clRav8Ty9XCo0iEJX2s5fXE3xtGK+nAM2BZGakp7/
 tEqURfV0k0mAGEkWr+cUBrgLLpot+F0VMx1QujpNyw8p6176x4fLlnAsTIVFTnWqMK7MbP
 eGMSKyCJsCXN0+0nBmPkjUHuG/0UyWE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-b9eYCLbNPzyJR-kN4i3eQQ-1; Thu, 18 Apr 2024 22:04:21 -0400
X-MC-Unique: b9eYCLbNPzyJR-kN4i3eQQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5ca4ee5b97aso1388767a12.1
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 19:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713492260; x=1714097060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lU97DMhqafSd9IDZqmjTCne3OrKWdepMrnENkYsysng=;
 b=GN+U7nOedeeH6EeOsRbMoWWVvzNvNPxF1GR0oWoyiABBQsj0LJfsF25+e90dadVzn2
 1dbJcgoD2LebTINDJgZWPiJ4Vl6VivbtkfUaWX2x5btD+5OC5kzpSmtRB4VIRIP5Y+eU
 gbzz9gu4zC4UZm26jsP7FsyaElVlf4LGaYgRcYUf1aJs7YjZrtNeRBOD7SWZ3uXwPuRe
 8eLJsGgWtmCch57NgnfMDECpeNmKu9KdQdtOR16g5hyzPwwwGnLecOvnMdp5qJahsPJj
 yyAflp19OCv7chbmNTAoNwDg4stqvHQZkIpgCW4K2YqaMFzCazv0N+c5W718yyzKlPYu
 tHLg==
X-Gm-Message-State: AOJu0Yw2cScEjf3T7Dcpt9GPljivNd7sW4UmXGSfHITtMw2sreP8ByYu
 VxyYAOVwXzAzx0hCn15a3GMt/Wr9N6Qn3GtIrYDftfDQqoA4zxN787t5AbU+JXbfiiZCNl8/zFf
 vq/+EjALglBukLGFQux1QwA9GWF6T7HnM8wOzL/4HQ6OOpVuomOxO/2PHcivE3EBVAgt/6YJwpI
 Lom9QArQwnEndNUo77Bmvr/KU=
X-Received: by 2002:a05:6a20:d707:b0:1ab:b369:7bd3 with SMTP id
 iz7-20020a056a20d70700b001abb3697bd3mr1170303pzb.38.1713492260439; 
 Thu, 18 Apr 2024 19:04:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXb33Yg07ht1shJwXxIMUfXgfsXZwtm0UfIo8zK1+0W4kr0lZrwcGanEOzxZ2ugfXJibmYJLa+HpYSNLu5RJY=
X-Received: by 2002:a05:6a20:d707:b0:1ab:b369:7bd3 with SMTP id
 iz7-20020a056a20d70700b001abb3697bd3mr1170294pzb.38.1713492260107; Thu, 18
 Apr 2024 19:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240418185210.132137-1-pvorel@suse.cz>
 <20240418185210.132137-2-pvorel@suse.cz>
 <CAEemH2dw83UCUg7tXnVuKqwDZtFfc8zEWq=SvLuRtzcA_4AV=w@mail.gmail.com>
In-Reply-To: <CAEemH2dw83UCUg7tXnVuKqwDZtFfc8zEWq=SvLuRtzcA_4AV=w@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Apr 2024 10:04:07 +0800
Message-ID: <CAEemH2fr5+L0UK4McWf7Aos9TciME7wHMQmVujNX8xQtZYUsqQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/2] libswap: Add {SAFE_,
 }MAKE_MINIMAL_SWAPFILE() macros
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

T24gRnJpLCBBcHIgMTksIDIwMjQgYXQgOTo1MOKAr0FNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4gSGkgUGV0ciwgQ3lyaWwsCj4KPiBUaGUgcGF0Y2hzZXQgZ2VuZXJhbGx5
IGxvb2tzIGdvb2QuCj4KPiBCdXQgSSBoYXZlIGEgY29uY2VybiBhYm91dCB0aGUgbWFjcm8gbmFt
ZSAiTUlOSU1BTCIgd29yZCwKPiB3aGljaCBtaXNsZWQgcGVvcGxlIHRvIHRoaW5rIHRoYXQgaXMg
dGhlIG1pbmltYWwgc3dhcGZpbGUgc2l6ZSB3ZQo+IGNhbiBtYWtlIG9uIHRoZSBzeXN0ZW0sIGJ1
dCBvYnZpb3VzbHkgaXQgaXMgbm90LCB3ZSBjb3VsZCBldmVuCj4gY3JlYXRlIGEgc21hbGxlciBv
bmUsIHJpZ2h0Pwo+Cj4gQ2FuIHdlIHJlbmFtZSBpdCB3aXRoIGEgYmV0dGVyIG9uZT8KPgoKV2hh
dCBhYm91dCBNQUtFX0RFRkFVTFRfU1dBUEZJTEUsIG9yIE1BS0VfVEVTVF9TV0FQRklMRT8KCi0t
IApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
