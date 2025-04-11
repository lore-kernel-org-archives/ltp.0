Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5309FC369A8
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 10:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744366128; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=zULNSZPybDYZi0GsVpRoIsaoR+8jiOfBZdQitKqGPzQ=;
 b=aYFDVKGHwUVRqTyTRCqJMaJqKnTWYfp8q7MNXwYXx9Hy0XjegFEVW+lr4Cf5eyYQqDne3
 mRu+UyGXaLkZcioGX5mZTWxYbN/7cGUSzQnsn0mkjmD+XCpG7UByS+ANERdGMwdB8BqZXMB
 CaEkCe1fJ+d+aroNMlJT7P+u6sXeM90=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 396E53CB5B4
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 12:08:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3AB63CA320
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 12:08:26 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 63AE7600655
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 12:08:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744366103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=14gH8Je7/tW2GbplMKNfq/URtwknK26zDFSO2aTq/DE=;
 b=FqlbgvR0AFbSqj/LwkQXp+hM1/M6pxBy8rs+XYosWbpqDvqsyjj/2hwTl7X9zKmmbvewKe
 QzpEajyLw/Legynej7vYkylpCanPzS5/DZwZ5mK483zbJ6S21geRKWZoLB3ignHsgIqplp
 NAAN22FwMnghdp2QoTmXAwoEUnq8BZ4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-hj4M0jKrPJ-NS7-7y1ItYw-1; Fri, 11 Apr 2025 06:08:19 -0400
X-MC-Unique: hj4M0jKrPJ-NS7-7y1ItYw-1
X-Mimecast-MFC-AGG-ID: hj4M0jKrPJ-NS7-7y1ItYw_1744366098
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-af5156fbe79so2002333a12.1
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 03:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744366098; x=1744970898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=14gH8Je7/tW2GbplMKNfq/URtwknK26zDFSO2aTq/DE=;
 b=Xbb8St4nyZTBwkhnuTTvz4Vq6raw+dmrM7BBIc/wWuimLpckLsYbL9jy4Gr9LYnEot
 JR0f+QR4Gzll21s2oprSCJIOymbWit9Yq8+h3eBU1HBIN+oB9YAE7ycfwT9yCeel2w0b
 IS2FSjXmYnBi8m79d2hgVHv4fCAsQJyBSGM1vb7aBajM+C/03oYWCtAg77nGuv1Z8i8E
 2jjAZB/XvL0QZrO4t/zAJyXASL5+YOHNQklgdcGPVeGqYr54sYwoH02letY9U0txvGhR
 koIbfsIaGuE7E5sFbssGdRVx2K1x0vediPIeiJCDcvwGfAkzDDvKL+oWTNQPdECZgfLU
 IJfw==
X-Gm-Message-State: AOJu0Yy5UWrXKch0oX7OPm3GwJlzoJpJgOOFtf2aYtvmN4dmFhNCHPcK
 AN+9GJDUx7d9pSdB4rf/rqIkeR1oczb9k8F5APIHYC/c5N4xekBo6zGz8qAOURglWU5/Xf3RD8X
 AUHxSNc2WUUXE2D+RI3ubjI/0KYbLK4UCg6x7ek3U//PTNWtCkUqfyZWgaW4p5CR/gPquZrfYIB
 Ouf7Vb7jU6IyM8b8V7bUJijFk=
X-Gm-Gg: ASbGncsygWXKV+7vo/IjDvpTVxFvauH+4tjNYh15W2BiywZAco3AB326qrHMd8aUEUR
 qJeo2MKXaFeClli0bMidN/unnXNzNPkv3Yqlb6P2wY7pHzyoiQvJSxd/Y6iiDal2w5/dVzg==
X-Received: by 2002:a17:90b:3cc6:b0:301:1c11:aa83 with SMTP id
 98e67ed59e1d1-3082367df8dmr3437241a91.28.1744366098094; 
 Fri, 11 Apr 2025 03:08:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSsEAyA0Q3seBpLXvrQgY4Y9nMh1Jzz5j+FiO8t4YyYCa+OzusbxrWE4qwhnn9qwvPCwzu3XmDSHoYzCGtjB0=
X-Received: by 2002:a17:90b:3cc6:b0:301:1c11:aa83 with SMTP id
 98e67ed59e1d1-3082367df8dmr3437215a91.28.1744366097767; Fri, 11 Apr 2025
 03:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250314023120.169820-1-liwang@redhat.com>
 <20250314115848.173676-1-liwang@redhat.com>
 <5894423.DvuYhMxLoT@thinkpad>
In-Reply-To: <5894423.DvuYhMxLoT@thinkpad>
Date: Fri, 11 Apr 2025 18:08:05 +0800
X-Gm-Features: ATxdqUEQ3lytMtXGns2SvXXfOpKiMeTU6IYz_w85QwB_pDQCOqZRpLg5nFdatq0
Message-ID: <CAEemH2cUt-rWXOctyBxLvsQu6uBq3Q+6tWHp8NyOF3T4nk3=Xw@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ibuKbC-tPQ-QL91xARMbuXOkzl1ekHsimSydZFGv_o4_1744366098
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] ioctl_loop06: update loopback block size
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Christoph Hellwig <hch@lst.de>,
 ltp@lists.linux.it, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQXZpbmVzaCwgQWxsLAoKT24gRnJpLCBBcHIgMTEsIDIwMjUgYXQgNDozOOKAr1BNIEF2aW5l
c2ggS3VtYXIgPGFrdW1hckBzdXNlLmRlPiB3cm90ZToKCj4gT24gRnJpZGF5LCBNYXJjaCAxNCwg
MjAyNSAxMjo1ODo0OCBQTSBDRVNUIExpIFdhbmcgd3JvdGU6Cj4gPiBUaGUga2VybmVsIGNvbW1p
dCA0N2RkNjc1MyAoImJsb2NrL2JkZXY6IGxpZnQgYmxvY2sgc2l6ZSByZXN0cmljdGlvbnMgdG8K
PiA2NGsiKQo+ID4gbm93IHN1cHBvcnRzIGJsb2NrIHNpemVzIGxhcmdlciB0aGFuIFBBR0VfU0la
RSwgd2l0aCBhIG5ldyB1cHBlciBsaW1pdCBvZgo+ID4gQkxLX01BWF9CTE9DS19TSVpFICg2NEsp
LiBCdXQgaW9jdGxfbG9vcDA2IHN0aWxsIGFzc3VtZXMgdGhhdCBQQUdFX1NJWkUKPiBpcyB0aGUK
PiA+IG1heGltdW0gYWxsb3dlZCBibG9jayBzaXplLCBjYXVzaW5nIGZhaWx1cmVzIG9uIG5ld2Vy
IGtlcm5lbHMoPj0gNi4xNCk6Cj4gPgo+ID4gICBpb2N0bF9sb29wMDYuYzo3NDogVElORk86IFVz
aW5nIExPT1BfU0VUX0JMT0NLX1NJWkUgd2l0aCBhcmcgPgo+IFBBR0VfU0laRQo+ID4gICBpb2N0
bF9sb29wMDYuYzo1NzogVEZBSUw6IFNldCBibG9jayBzaXplIHN1Y2NlZWQgdW5leHBlY3RlZGx5
Cj4gPiAgIC4uLgo+ID4gICBpb2N0bF9sb29wMDYuYzo3NDogVElORk86IFVzaW5nIExPT1BfQ09O
RklHVVJFIHdpdGggYmxvY2tfc2l6ZSA+Cj4gUEFHRV9TSVpFCj4gPiAgIGlvY3RsX2xvb3AwNi5j
OjU3OiBURkFJTDogU2V0IGJsb2NrIHNpemUgc3VjY2VlZCB1bmV4cGVjdGVkbHkKPiA+Cj4gPiBU
aGlzIHBhdGNoIHVwZGF0ZXMgaW9jdGxfbG9vcDA2IHRvIHVzZSBCTEtfTUFYX0JMT0NLX1NJWkUg
aW5zdGVhZCBvZgo+IFBBR0VfU0laRQo+ID4gZm9yIGJsb2NrIHNpemUgdmFsaWRhdGlvbi4KPiA+
Cj4gPiBBbmQsIGR5bmFtaWNhbGx5IHNldHMgYnMgYmFzZWQgb24gQkxLX01BWF9CTE9DS19TSVpF
LCB1c2luZyAxMDI0IGJ5dGVzCj4gaWYgaXQncwo+ID4gYmVsb3cgMU1CIG9yIHNjYWxpbmcgaXQg
b3RoZXJ3aXNlLiBFbnN1cmVzIHRzdF9maWxsX2ZpbGUoKSB3cml0ZXMKPiBlZmZpY2llbnRseQo+
ID4gd2hpbGUgbWFpbnRhaW5pbmcgY29tcGF0aWJpbGl0eSBhY3Jvc3MgZGlmZmVyZW50IGtlcm5l
bCB2ZXJzaW9ucy4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4KPiA+IENjOiBMdWlzIENoYW1iZXJsYWluIDxtY2dyb2ZAa2VybmVsLm9yZz4KPiA+IENj
OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiA+IENjOiBIYW5uZXMgUmVpbmVja2Ug
PGhhcmVAc3VzZS5kZT4KPgo+IFRlc3RlZC1ieTogQXZpbmVzaCBLdW1hciA8YWt1bWFyQHN1c2Uu
ZGU+Cj4KClRoYW5rcyBmb3IgdGVzdGluZy4gSSB0aG91Z2h0IHRoaXMgb25lIHdhcyBtZXJnZWQs
IGJ1dCB3aGVuIEkgY2hlY2tlZCB0aGUKbG9nLCBpdCB3YXMgbm90LgpBbnl3YXksIEkgcHVzaGVk
IGl0IG5vdy4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
