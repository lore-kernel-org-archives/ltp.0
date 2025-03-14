Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE6AC28B2F
	for <ltp@archiver.kernel.org>; Fri, 14 Mar 2025 06:48:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7CFC3CA621
	for <ltp@archiver.kernel.org>; Fri, 14 Mar 2025 07:48:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 314E53CA037
 for <ltp@lists.linux.it>; Fri, 14 Mar 2025 07:48:03 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 55FAC10009DD
 for <ltp@lists.linux.it>; Fri, 14 Mar 2025 07:48:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741934880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Q8nC+MQyRyCRt8+InXgiSgqdI+2EqpRwo64nTAhKhI=;
 b=Tqn1Y/KkDvvMm7ciuRteXZfe5/az/0E1+d0JL6UBX/ZF2IdABCiriHkmkK5DFK+PR2kukQ
 bF+ntXS4m+t408llpGdKvG5LWKALuTN2wDOpvJK2EQ3nQEek/9FoGM7Lzu5hzig43cu0H0
 YqLi0fMflQR+WgtDGdcRO5am5bXD/TM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-H3XCRByBOQKc4RwXDCNA5w-1; Fri, 14 Mar 2025 02:47:55 -0400
X-MC-Unique: H3XCRByBOQKc4RwXDCNA5w-1
X-Mimecast-MFC-AGG-ID: H3XCRByBOQKc4RwXDCNA5w_1741934875
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ff4b130bb2so3012359a91.0
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 23:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741934875; x=1742539675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Q8nC+MQyRyCRt8+InXgiSgqdI+2EqpRwo64nTAhKhI=;
 b=FvKWW3YoaqH+A+4RHJjdxyNI83a6qVYXIimvAtUY779/8fre1MvxHqPVq5ftxy7seb
 YD/pKb+kadXRmC1neFPOAee84//gC/1cWS6RQ889j/swVRhbdJ3z61sCKBh+8bRjc5c2
 QO7JdmLluYbY/xqwORZtkA0wEdYdiafp07co2KIAzCNbF8FswbjhdX5VYLtWdpTG3tPW
 N1dtHnR9zOGjT85YqKmbwIa3KMw4KYMcMdd6ML7WK2lOedERFaBIr8ihpAeOOFw7fBc9
 nqmDZhVJJ8by2cbK7YyDtK6UUHzLo0JVmLHSd5LPDhs7L1WOEURw+KY+RtnurZCznGN9
 S3bg==
X-Gm-Message-State: AOJu0Yye1O7oBduMV2KEqyijG5BVh2jJf4vJzLU3cG/4tFWcztRZ7Zc4
 28rhpe6zhab7XjFWw9PoY5UJK9TbbbBR2jzTjZ80Mp663c7Vu/g5QkXB6wtWPlcDPlP9O09SkOC
 qJVeotubEg3R/z24CHeQVPvH0R76sASkhETOZ9E6Gcyx8uBr6RSIy34BSwNCT90A3CBRrVOm8wa
 aD3u9oBkUQ4b0JlqQl2MCguNE=
X-Gm-Gg: ASbGncu6t6UAgpSER1iMJvzEMbxoBz62xXiMnFUV3zzo5ybdmQUX+XrTVIOvKgLoqLd
 sL+ofHmORU60/cFEc1rBYrwZTeOgK4pq/gdxHahxqxs5wITz1dgR1nxx3P07pz5a0Am8DHSnWEQ
 ==
X-Received: by 2002:a17:90b:51c7:b0:2ff:6e72:b8e9 with SMTP id
 98e67ed59e1d1-30151d54d05mr1927231a91.25.1741934874609; 
 Thu, 13 Mar 2025 23:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxuOKxJrk7L3ApE/zm7pV2zRbGPDIyFf4oAZoCW9kapHOuPpmqtcsZF6SOn92LyvdtPQ/74ZDMSj2W+l/g9iI=
X-Received: by 2002:a17:90b:51c7:b0:2ff:6e72:b8e9 with SMTP id
 98e67ed59e1d1-30151d54d05mr1927211a91.25.1741934874348; Thu, 13 Mar 2025
 23:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250313092445.164616-1-liwang@redhat.com>
 <Z9NjTtX3o15YDZ1w@bombadil.infradead.org>
 <CAEemH2cTkjGzYgvL3vw3+9MRPtxYfVTCmgexFWAVh5Q00J0oKg@mail.gmail.com>
 <Z9PEHuBTVFlWZ9dM@bombadil.infradead.org>
In-Reply-To: <Z9PEHuBTVFlWZ9dM@bombadil.infradead.org>
From: Li Wang <liwang@redhat.com>
Date: Fri, 14 Mar 2025 14:47:41 +0800
X-Gm-Features: AQ5f1Jo-lNwOntxf4tx6H444yvwmn_JuYq4Dd_ABCqUQAuizwhlLEyEJpapjymo
Message-ID: <CAEemH2cgixLgEHRNNEUA=YjqE6ApCHFT4Eq67z+nPA0crsN5uQ@mail.gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: duG_tVGmmFo36g6VWOA9LHP23FJWehJ0QU_ljF9is20_1741934875
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

T24gRnJpLCBNYXIgMTQsIDIwMjUgYXQgMTo1MuKAr1BNIEx1aXMgQ2hhbWJlcmxhaW4gPG1jZ3Jv
ZkBrZXJuZWwub3JnPiB3cm90ZToKCj4gT24gRnJpLCBNYXIgMTQsIDIwMjUgYXQgMTA6MjQ6NTJB
TSArMDgwMCwgTGkgV2FuZyB3cm90ZToKPiA+IEhpIEx1aXMsCj4gPgo+ID4gT24gRnJpLCBNYXIg
MTQsIDIwMjUgYXQgNjo1OeKAr0FNIEx1aXMgQ2hhbWJlcmxhaW4gPG1jZ3JvZkBrZXJuZWwub3Jn
Pgo+IHdyb3RlOgo+ID4KPiA+ID4gT24gVGh1LCBNYXIgMTMsIDIwMjUgYXQgMDU6MjQ6NDVQTSAr
MDgwMCwgTGkgV2FuZyB3cm90ZToKPiA+ID4gPiBUaGUga2VybmVsIGNvbW1pdCA0N2RkNjc1MyAo
ImJsb2NrL2JkZXY6IGxpZnQgYmxvY2sgc2l6ZQo+IHJlc3RyaWN0aW9ucyB0bwo+ID4gPiA2NGsi
KQo+ID4gPiA+IG5vdyBzdXBwb3J0cyBibG9jayBzaXplcyBsYXJnZXIgdGhhbiBQQUdFX1NJWkUs
IHdpdGggYSBuZXcgdXBwZXIKPiBsaW1pdCBvZgo+ID4gPiA+IEJMS19NQVhfQkxPQ0tfU0laRSAo
NjRLKS4gQnV0IGlvY3RsX2xvb3AwNiBzdGlsbCBhc3N1bWVzIHRoYXQKPiBQQUdFX1NJWkUKPiA+
ID4gaXMgdGhlCj4gPiA+ID4gbWF4aW11bSBhbGxvd2VkIGJsb2NrIHNpemUsIGNhdXNpbmcgZmFp
bHVyZXMgb24gbmV3ZXIga2VybmVscyg+PQo+IDYuMTQpOgo+ID4gPgo+ID4KPiA+IFdlbGwsIHRo
aXMgc291bmRzIGxpa2Ugd2UgbmVlZCB0byBnbyBiYWNrIHRvIHBhdGNoIHYxOgo+ID4gICBodHRw
czovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFpbC9sdHAvMjAyNS1NYXJjaC8wNDI1OTkuaHRtbAo+
ID4KPiA+IE5vdGU6IExUUCBoYXMgYSBmdW5jdGlvbiB0c3Rfa3ZlcmNtcCgpIGZvciBjb21wYXJp
bmcga2VybmVsIHZlcnNpb25zLgo+Cj4gQ2xvc2UuCj4KPiBCTEtfTUFYX0JMT0NLX1NJWkUgbWF5
IGNoYW5nZSBpbiB0aGUgZnV0dXJlIHNvIHRoZSBvbmx5IHJlYWwgd2F5IHRvCj4gdGVzdCBmb3Ig
YW4gaW52YWxpZCBibG9jayBzaXplIGlzIGhhdmluZyBhIGNoZWNrIGZvciBsaW51eC9ibGtkZXYu
aC4KPgoKR29vZCBwb2ludC4KCgo+IEkgc2VlIGNvbW1pdCA3Yzg0ZmE3MTBmNzUgKCJpb3ByaW86
IHVzZSBpb3ByaW8uaCBrZXJuZWwgaGVhZGVyIGlmIGl0Cj4gZXhpc3RzIikgaXMgYW4gZXhhbXBs
ZSBvZiB1c2luZyBhIGtlcm5lbCBoZWFkZXIgZmlsZS4gSSB0aGluayBzaW1pbGFyCj4gdGhpbmcg
Y2FuIGJlIGRvbmUgdG8gdXNlIGxpbnV4L2Jsa2Rldi5oIGFuZCBpZiB5b3UgZG9uJ3QgaGF2ZQo+
IEhBVkVfTElOVVhfQkxLREVWX0ggdGhlbiB5b3UgY2FuIGRlZmluZSBCTEtfTUFYX0JMT0NLX1NJ
WkUgdG8gNjRrIGZvcgo+IGZvciBvbGRlciBrZXJuZWxzLgo+CgpUbyBwcmVjaXNlLCBpZiBCTEtf
TUFYX0JMT0NLX1NJWkUgaXMgdW5kZWZpbmVkIChpbiBibGtkZXYuaCkgaW4gb2xkZXIKa2VybmVs
IChlLmcuIGtlcm5lbC02LjEyKSAgdGhlbiB3ZSBkZWZpbmUgaXQgdG8gNjRrLgoKCgo+Cj4gQSBt
b3JlIGFwcHJvcHJpYXRlIGludmFsaWQgdmFsdWUgd291bGQgYmUgQkxLX01BWF9CTE9DS19TSVpF
ICogMiBhcwo+IG5vbiBwb3dlciBvZiAyIHZhbHVlcyB3aWxsIGJlIG91dHJpZ2h0IGRpc2FsbG93
ZWQuCj4KCkFncmVlZC4gVGhhbmtzIGZvciByZXZpZXdpbmcuCgoKLS0gClJlZ2FyZHMsCkxpIFdh
bmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
