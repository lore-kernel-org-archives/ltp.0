Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC5DC77B61
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 12:57:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 317C43CBA89
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 14:57:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6704A3CB2CD
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 14:56:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5E59C1A002EF
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 14:56:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682686612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2GBkZiCt94pkKhuZzcl4+/98UYEc4x8GjwGwH5KaY8g=;
 b=a2aelvtavYYx3alwpCO0mplIweX3Y9k10Pk2XXnVPiRq6g3rcXeU1m+4F6iHwrYvC/VUqe
 +vIge9KWmDNC6HLjyTXoQK6CFKGw+/+h3zva5PyZi5uwpmblg9+BrwvKTuD/gCtVP4kVAQ
 5D4P6OntU+Onl0/cNaXzEM6Zk7nu0GM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-LDIgXVCdPxW9lsYZsByFdg-1; Fri, 28 Apr 2023 08:56:50 -0400
X-MC-Unique: LDIgXVCdPxW9lsYZsByFdg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2a8bdcf87c4so39828711fa.1
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 05:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682686609; x=1685278609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2GBkZiCt94pkKhuZzcl4+/98UYEc4x8GjwGwH5KaY8g=;
 b=aLlJmHNJSVfgsRLeYcu72ei72WD5FZ9D5v6KHb8el8pOhBx8DQ4royUlmXfHHYdMPx
 Zl28g6xKeMEdwmaqSRcgCsf5+Cv8jYRIzzzVKtMcxGm48JFlRotBNP4R02CfIqkBh9Y6
 itai0P+asmvezyOJ870CyMjWYkuhfsd8ORlR2+/JLzV2PoF/zL/GhOfu2parl3clLKa2
 dZ2XEEje5eq6lD7fk9Yat6vTbtjMsgM1IhT0Y9XHbNpcy6GkxCcTZs2o5EnHP7nCG9/7
 Mn9DS7987alVwUacDK02HfGi+RMccd+c0il3dlyeaK5Ip1fuhiAuvQWS6QL2Q79OsY4B
 Ur3w==
X-Gm-Message-State: AC+VfDwxy8joAcZpb78Ea8m2vCgCNIdfomSwEtOgGyVpijDlG4cAjQgm
 ncqp2xEqLDXL/S2oHeFEwh5Me8MAebUOh6X3fnDUclOgEAGfRCu2P+HY4QW3JkX+UAzXRJYjlgE
 PusTxcFWTjxykhz01Jz0rdi2Soso=
X-Received: by 2002:a05:651c:82:b0:2a9:f589:1b0 with SMTP id
 2-20020a05651c008200b002a9f58901b0mr1559182ljq.15.1682686609423; 
 Fri, 28 Apr 2023 05:56:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TnwbI0raBn9ezu8jJECEMTd4vNjzODvXbQiLurCgeCp9wG55YhbPneh2vzrNlITUDe+k0MTmfXKVhWbV3s9w=
X-Received: by 2002:a05:651c:82:b0:2a9:f589:1b0 with SMTP id
 2-20020a05651c008200b002a9f58901b0mr1559175ljq.15.1682686609063; Fri, 28 Apr
 2023 05:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230428084922.9834-1-liwang@redhat.com> <ZEufJa+TyZdY9gsq@yuki>
In-Reply-To: <ZEufJa+TyZdY9gsq@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 28 Apr 2023 20:56:36 +0800
Message-ID: <CAEemH2fcvpRLS7-rdpiGt-fqEwXCiAb-jpRdisb33axhdP3CoA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH] tst_cgroup: Avoid mixing mounts V1 and V2
 simultaneously
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

T24gRnJpLCBBcHIgMjgsIDIwMjMgYXQgNjoyNOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBUaGVyZSBpcyBhIHRpbnkgcHJvYmxlbSB3aXRoIHRo
ZSB0ZXN0IGxvZ2ljIG9mIHRoaXMgdHN0X2Nncm91cCBsaWJyYXJ5LAo+ID4gdGhhdCBpdCBwb3Rl
bnRpYWxseSBtaXhlcyBDZ3JvdXAgVjEgYW5kIFYyIHRvZ2V0aGVyIHRvIGJlIG1vdW50ZWQgYXQK
PiA+IHRoZSBzYW1lIHRpbWUuIFRoZSBzY2VuYXJpbyBoYXBwZW5zIG9uY2UgcGVvcGxlIGp1c3Qg
cmVxdWVzdHMgQ1RSTF9CQVNFCj4gPiAob3IgYSBWMiBjb250cm9sbGVyIG5vdCBlbmFibGVkKSBv
biBhIG9ubHkgVjEtbW91bnRlZCBzeXN0ZW0uCj4gPgo+ID4gQ2dyb3VwIGNvbW11bml0eSBhbHdh
eXMgb2JqZWN0ZWQgdG8gZW5hYmxpbmcgQ2dyb3VwIGxpa2UgdGhhdCAoVjEmVjIpLAo+ID4gd2hp
Y2ggbWF5IGJyaW5nIHVuZXhwZWN0ZWQgaXNzdWVzIGFsb25nIHRoZSB3YXkuCj4gPgo+ID4gU28g
dGhpcyBwYXRjaCBjYW5jZWxzIExUUCBtb3VudCBWMSZWMiBzaW11bHRhbmVvdXNseSBldmVuIGlm
IHRoZXJlIGlzCj4gPiBubyBvdmVybGFwIGluIHNwZWNpZmljIGNvbnRyb2xsZXIgZmlsZXMuCj4K
PiBJc24ndCB0aGlzIHRoZSBwb2ludCBvZiB0aGUgbGlicmFyeSwgdG8gYmUgYWJsZSB0byB1c2Ug
bWl4ZWQgVjEgYW5kIFYyCj4gc2V0dXA/IEFzIGZhciBhcyBJIHVuZGVyc3RhbmQgaXQgdGhlIG9u
bHkgbGltaXRhdGlvbiBpcyB0aGF0IHdlIGNhbiBiaW5kCj4gYSBjb250cm9sbHRlciB0byBlaXRo
ZXIgVjEgb3IgVjIgYnV0IG5vdCBib3RoLgo+CgpUaGF0J3MgdGhlIG9yaWdpbmFsIGRlc2lnbi4g
V2UgdHJpZWQgdG8ga2VlcCBmbGV4aWJsZSBidXQgaWdub3JlZApvbmUgZXhjZXB0aW9uIFYxIG1v
dW50cyBhbGwgY29udHJvbGxlcnMgYW5kIFYyIG9ubHkgYmFzaWMgbW91bnQuCihObyBjb250cm9s
bGVycyBjb25mbGljdCBpbiB0aGlzIG1vdW50aW5nKS4KCkZyb20gbXkgb2JzZXJ2YXRpb24sIGlm
IGEgc3lzdGVtKGUuZy4gUkhFTDgpIG9ubHkgYW5ub3VuY2VzCkNncm91cCBWMSBzdXBwb3J0IGJ1
dCBkb2VzIG5vdCBndWFyYW50ZWUgVjIgdG8gYmUgdXNlZC4KQSB0ZXN0IHJlcXVpcmVkICdDVFJM
X0JBU0UnIGNvdWxkIG1vdW50IFYyIHN1Y2Nlc3MgYnV0CnRoYXQgVjIgaXMgb25seSBwYXJ0IHdv
cmsgYW5kIHRlc3Qgd2lsbCBnZXQgVEJST0suCldlIGFyZSB1bmFibGUgdG8gc2F5IHRoaXMgc2l0
dWF0aW9uIGlzIGEgYnVnLgoKU28gSSBzdXBwb3NlIGhlcmUgbWl4ZWQgVjEgYW5kIFYyIG1pZ2h0
IG5vdCBiZSBhIGdvb2QgZGVzaWduCnVubGVzcyB3ZSBmaW5kIGEgd2F5IHRvIGRldGVjdCBpZiB0
aGUgc3lzdGVtIGZ1bGx5IHN1cHBvcnRzIGJvdGgKdmVyc2lvbnMuIEJ1dCBJIGd1ZXNzIHRoaXMg
aXMgZGlmZmljdWx0IHRvIGNoZWNrLgoKCgo+Cj4gQWxzbyBhcyBmYXIgYXMgSSBjYW4gdGVsbCwg
dGhlcmUgaXMgcGxlbnkgb2YgZGlzdHJpYnV0aW9ucyBvdXQgdGhlcmUgYXQKPiB0aGUgbW9tZW50
IHdoZXJlIHRoZSBkZWZhdWx0IGlzIHNwbGl0IGJldHdlZW4gVjEgYW5kIFYyIGJvdGggbW91bnRl
ZCBhdAo+IHRoZSBzYW1lIHRpbWUuCj4KClllcywgYXMgbG9uZyBhcyBhIGRpc3RyaWJ1dGlvbiBh
bm5vdW5jZXMgc3VwcG9ydCBmb3IgYm90aCBDZ3JvdXAuClRoaXMgZGVzaWduIG1ha2VzIHNlbnNl
IGZvciBpdC4gQnV0IEknbSBhZnJhaWQgcmFyZSBwZW9wbGUgbWl4ZWQKdXNpbmcgYm90aCBhdCB0
aGUgc2FtZSB0aW1lKGFuZCB0aGF0IGlzIGFsc28gbm90IHJlY29tbWVuZGVkKS4KCi0tIApSZWdh
cmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
