Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856F5C28B2F
	for <ltp@archiver.kernel.org>; Fri, 14 Mar 2025 06:50:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD25A3CA608
	for <ltp@archiver.kernel.org>; Fri, 14 Mar 2025 07:50:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C9F43CA12E
 for <ltp@lists.linux.it>; Fri, 14 Mar 2025 07:49:57 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 374101000742
 for <ltp@lists.linux.it>; Fri, 14 Mar 2025 07:49:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741934993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FB+jRBlpS/Y7d1qmR3o6UoscVtcAlCSKGSvsb8186os=;
 b=BaTmd7naPAF8RrgDqDE7ti5DOEBxyFwfom64jfoN7es4URYi16ktsOTq1CYAMwLMYVJ7/b
 6p2lXiUYGiKNN26ZxvJ8/kClZ1scC+m4Aekhag8Jx54JAPj+1uvJpc5Hglnjv6AFEYFKso
 zFDMwRiT25RGZKmQJ4Bkvk5VQjzeDhg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-EaggGy3NOKKO33J-cZ7GlQ-1; Fri, 14 Mar 2025 02:49:50 -0400
X-MC-Unique: EaggGy3NOKKO33J-cZ7GlQ-1
X-Mimecast-MFC-AGG-ID: EaggGy3NOKKO33J-cZ7GlQ_1741934990
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff8119b436so3203080a91.0
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 23:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741934990; x=1742539790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FB+jRBlpS/Y7d1qmR3o6UoscVtcAlCSKGSvsb8186os=;
 b=cA7Eo2DYToHLlU0/HRbXHJbj33w5z5crANFd0DzNEWxgIZ7ByUbylZuU/z9ulzzYhT
 XnkQrSzcnRl+7k0Kfz/Ei6+Os7ElcUXy8u+QCTf+Ru1GurQzZOei9TfxmzIigv7yFiw4
 mVM5tRUpRn0A01x8BNWrzc/Pde5C3e9AcDRInF9YEC/UPPwAfYG8D4mpDFEm68DfGs2a
 mtw1ikjPsLW4fLEtVXQ1H8oBSDCe6tK9PBOdYLtPKCCXB3OgcID2EhrPvYNCDPGvKZCc
 OPTivK1c72Qx7iHK8ZlGZdkyJyTEmWXkoP9b2Mf5Yg5p3GVUUC+KZ+AfhH6A0eZVXaoL
 ROqA==
X-Gm-Message-State: AOJu0YxTGjv7FdNKaFbby6Uj9c3ORc4Ad9CrKpKHqsGBcPWef5uSKzxt
 ZmidkijY+NYgAxsS7H33KqEQrzDc4k7A3mItqtde0OjRU9xPRcr4JMx5dGIwfqhfOxdrEZ7avCH
 OJ02A34IoSDWRECqTexEk65BJigvRGSsjB/oWO0QXWY2DEP1ECTX4UAUvS5AIuzE705FUlmuALy
 +7KCBy1nrfwCmyYNRG+Db2z9k=
X-Gm-Gg: ASbGncsDXeSXM9yhJnyy2Veru2CdAy5vy3A+GyepqJ/kQSO1qwxwuOUtkvKCpM23UDM
 tjjeP+gV05wbWfqDUDpJWJnjiczn77YV90EZhNuQbBXSobsBnlpMli5910PW7bkM5lEEzp8HGfw
 ==
X-Received: by 2002:a17:90a:d004:b0:2ff:4bac:6fba with SMTP id
 98e67ed59e1d1-30151d3cacbmr2126076a91.24.1741934989873; 
 Thu, 13 Mar 2025 23:49:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4DBY+fkjb4OSjSC+VlmuzfAralKDMCh5ThUuK/dpLURMIewodysGGwOCLQFc03qO/8yuZ2bueBtfqkrVIwU0=
X-Received: by 2002:a17:90a:d004:b0:2ff:4bac:6fba with SMTP id
 98e67ed59e1d1-30151d3cacbmr2126056a91.24.1741934989491; Thu, 13 Mar 2025
 23:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250313092445.164616-1-liwang@redhat.com>
 <Z9NjTtX3o15YDZ1w@bombadil.infradead.org>
 <CAEemH2cTkjGzYgvL3vw3+9MRPtxYfVTCmgexFWAVh5Q00J0oKg@mail.gmail.com>
 <Z9PEHuBTVFlWZ9dM@bombadil.infradead.org>
 <Z9PFQR51mFwIEj0m@bombadil.infradead.org>
In-Reply-To: <Z9PFQR51mFwIEj0m@bombadil.infradead.org>
From: Li Wang <liwang@redhat.com>
Date: Fri, 14 Mar 2025 14:49:37 +0800
X-Gm-Features: AQ5f1JqJg_e4rbowXtxyF4rWBYJ4oSvfItK5AjpfEZAao1-gu0ebil6q3Dkgdss
Message-ID: <CAEemH2c3pwvSjPYR4DAV4xpx-OjBcBC81n0msteHQw1yV6x=wQ@mail.gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4zQ0t8c-nSfEpxYLUOdQ-rlh6IuYl7zHzFV_67U3iww_1741934990
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] ioctl_loop06: update loopback block size
 validation
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
Cc: Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBNYXIgMTQsIDIwMjUgYXQgMTo1N+KAr1BNIEx1aXMgQ2hhbWJlcmxhaW4gPG1jZ3Jv
ZkBrZXJuZWwub3JnPiB3cm90ZToKCj4gT24gVGh1LCBNYXIgMTMsIDIwMjUgYXQgMTA6NTI6MzFQ
TSAtMDcwMCwgTHVpcyBDaGFtYmVybGFpbiB3cm90ZToKPiA+IE9uIEZyaSwgTWFyIDE0LCAyMDI1
IGF0IDEwOjI0OjUyQU0gKzA4MDAsIExpIFdhbmcgd3JvdGU6Cj4gPiA+IEhpIEx1aXMsCj4gPiA+
Cj4gPiA+IE9uIEZyaSwgTWFyIDE0LCAyMDI1IGF0IDY6NTnigK9BTSBMdWlzIENoYW1iZXJsYWlu
IDxtY2dyb2ZAa2VybmVsLm9yZz4KPiB3cm90ZToKPiA+ID4KPiA+ID4gPiBPbiBUaHUsIE1hciAx
MywgMjAyNSBhdCAwNToyNDo0NVBNICswODAwLCBMaSBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gVGhl
IGtlcm5lbCBjb21taXQgNDdkZDY3NTMgKCJibG9jay9iZGV2OiBsaWZ0IGJsb2NrIHNpemUKPiBy
ZXN0cmljdGlvbnMgdG8KPiA+ID4gPiA2NGsiKQo+ID4gPiA+ID4gbm93IHN1cHBvcnRzIGJsb2Nr
IHNpemVzIGxhcmdlciB0aGFuIFBBR0VfU0laRSwgd2l0aCBhIG5ldyB1cHBlcgo+IGxpbWl0IG9m
Cj4gPiA+ID4gPiBCTEtfTUFYX0JMT0NLX1NJWkUgKDY0SykuIEJ1dCBpb2N0bF9sb29wMDYgc3Rp
bGwgYXNzdW1lcyB0aGF0Cj4gUEFHRV9TSVpFCj4gPiA+ID4gaXMgdGhlCj4gPiA+ID4gPiBtYXhp
bXVtIGFsbG93ZWQgYmxvY2sgc2l6ZSwgY2F1c2luZyBmYWlsdXJlcyBvbiBuZXdlciBrZXJuZWxz
KD49Cj4gNi4xNCk6Cj4gPiA+ID4KPiA+ID4KPiA+ID4gV2VsbCwgdGhpcyBzb3VuZHMgbGlrZSB3
ZSBuZWVkIHRvIGdvIGJhY2sgdG8gcGF0Y2ggdjE6Cj4gPiA+ICAgaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9waXBlcm1haWwvbHRwLzIwMjUtTWFyY2gvMDQyNTk5Lmh0bWwKPiA+ID4KPiA+ID4gTm90
ZTogTFRQIGhhcyBhIGZ1bmN0aW9uIHRzdF9rdmVyY21wKCkgZm9yIGNvbXBhcmluZyBrZXJuZWwg
dmVyc2lvbnMuCj4gPgo+ID4gQ2xvc2UuCj4gPgo+ID4gQkxLX01BWF9CTE9DS19TSVpFIG1heSBj
aGFuZ2UgaW4gdGhlIGZ1dHVyZSBzbyB0aGUgb25seSByZWFsIHdheSB0bwo+ID4gdGVzdCBmb3Ig
YW4gaW52YWxpZCBibG9jayBzaXplIGlzIGhhdmluZyBhIGNoZWNrIGZvciBsaW51eC9ibGtkZXYu
aC4KPiA+Cj4gPiBJIHNlZSBjb21taXQgN2M4NGZhNzEwZjc1ICgiaW9wcmlvOiB1c2UgaW9wcmlv
Lmgga2VybmVsIGhlYWRlciBpZiBpdAo+ID4gZXhpc3RzIikgaXMgYW4gZXhhbXBsZSBvZiB1c2lu
ZyBhIGtlcm5lbCBoZWFkZXIgZmlsZS4gSSB0aGluayBzaW1pbGFyCj4gPiB0aGluZyBjYW4gYmUg
ZG9uZSB0byB1c2UgbGludXgvYmxrZGV2LmggYW5kIGlmIHlvdSBkb24ndCBoYXZlCj4gPiBIQVZF
X0xJTlVYX0JMS0RFVl9IIHRoZW4geW91IGNhbiBkZWZpbmUgQkxLX01BWF9CTE9DS19TSVpFIHRv
IDY0ayBmb3IKPiA+IGZvciBvbGRlciBrZXJuZWxzLgo+ID4KPiA+IEEgbW9yZSBhcHByb3ByaWF0
ZSBpbnZhbGlkIHZhbHVlIHdvdWxkIGJlIEJMS19NQVhfQkxPQ0tfU0laRSAqIDIgYXMKPiA+IG5v
biBwb3dlciBvZiAyIHZhbHVlcyB3aWxsIGJlIG91dHJpZ2h0IGRpc2FsbG93ZWQuCj4KPiBXaGls
ZSBhdCBpdCwgYmUgc3VyZSB0byBzY2FsZSB0c3RfZmlsbF9maWxlKCJ0ZXN0LmltZyIsIDAsIDEw
MjQsIDEwMjQpCj4gKEkgdGhpbmsgdGhhdCBpcyBicz0xMDI0LCBjb3VudD0xMDI0LCBzbyAxIE1p
QiBmaWxlIHNpemUpIHNvIHRoYXQgeW91Cj4gdGFrZSBpbnRvIGNvbnNpZGVyYXRpb24gdGhlIEJM
S19NQVhfQkxPQ0tfU0laRSBzbyB0aGF0IHRoZSBmaWxlIHNpemUKPiB3aWxsIGJlIGF0IGxlYXN0
IG1heWJlIDEwICogQkxLX01BWF9CTE9DS19TSVpFIG9yIHNvbWV0aGluZyBzZW5zaWJsZS4KPgo+
IEJlY2F1c2UgYXMgc29vbiBhcyB3ZSBjYW4gc3VwcG9ydCBhIEJMS19NQVhfQkxPQ0tfU0laRSBv
ZiAyIE1pQiB0aGlzCj4gdGVzdCB3aWxsIGFsc28gZmFpbCBhZ2Fpbi4KPgoKTWFrZSBzZW5zZSEh
IEkgd2lsbCBpbXByb3ZlIHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbiwgdG9vLgoKCi0tIApSZWdh
cmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
