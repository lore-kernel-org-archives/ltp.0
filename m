Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A02AE77188
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 07:53:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBF233EB5A9
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 08:53:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3133D3E4BE3
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 08:53:27 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3AA7F1BD353C
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 08:53:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735890805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U3uDG2WzGPzT9yNOJwxkX6Ropq1p308RdkLgjvclvbU=;
 b=OXlisSC9S5VmD633pq/1NDLqlbomjFgyRAzHpKBUiyIC9qsxhgBnZRX1avaQbJJn4685x7
 3tj22gpugExGhycnuIP6GZf7yDnOfXYlBoQmIDAyHQgimHTcDWWpu/3zOVKOScISbsA8Ay
 u95PtprAzubk6d92d0cOe+uTbkP+2Fg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-kUU83VUYPKCIb_Oi2o811Q-1; Fri, 03 Jan 2025 02:53:23 -0500
X-MC-Unique: kUU83VUYPKCIb_Oi2o811Q-1
X-Mimecast-MFC-AGG-ID: kUU83VUYPKCIb_Oi2o811Q
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ef9e4c5343so26673839a91.0
 for <ltp@lists.linux.it>; Thu, 02 Jan 2025 23:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735890802; x=1736495602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U3uDG2WzGPzT9yNOJwxkX6Ropq1p308RdkLgjvclvbU=;
 b=mKoD9v4F71WXcBDAlT2ol0HugL6hGLGpYRfMVHbhf+qDakheqKfowZALhBl03mh+2i
 oIbTnMSO+IuwM2Dt852iqbYuoKFZW3J3IBQxCA+AhJRrnrVRG2F1U0/jSy0nnuG3M/+S
 9qi+a4dWXJ9EDFfwuGwM0NGmCz3mBLbY2ZQEJ/CesH7UMYbS47aDAhcM0EZqb5z6OCEb
 xmvN5syfz91lZlh2oRWwAieQEgpr1bjCUdfeK1O5zV1basNhPfIm4G+6oQlZaJ/M5uXp
 cS6p7danEyGfxVRPQpeVXd7y5YArH+8bv6lDS7sDFKTWbMbQ2GoSGMqFCdhbsgiyRh7G
 2nvA==
X-Gm-Message-State: AOJu0Yym3hSPct2TGHYVNDI8wuEmNArXDJkEv1aG7bKy+RfzfEnU4lB/
 fKfbHMHbAdaLkjrm8N921G01r/qPVCkB3W5Iz3YJ2lOIwfpnOTUeY3/hSIEOikpmDMn2kWBdPPZ
 /efadgWElV24YMjGcTqRfyXiqjOagIyzB1fWPlLH5LQesj0lxRKdgZfSTHKJOIlD9xekhDZF46N
 ULSoAEOvHrFznffSCaI3fxmVs=
X-Gm-Gg: ASbGncvH4HlR13MjMKxu4+paSgUHP0OEIRtc1nzm5iOu7gQKw3ShbGXFiqPqFB+mVuC
 vbf0BKTQw1CvWpLMT70uyYkEO3y6B/yO3s5u7uoA=
X-Received: by 2002:a17:90b:51c2:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-2f452e1d3f9mr68977164a91.11.1735890801997; 
 Thu, 02 Jan 2025 23:53:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBZuNqEJhcTtBBgF4tC3S6kCNxf7bnS4OQi1jRTSPZrulNMpo9OieyfFQDzjlpgDUpQqePthm49obuFZrI3Dg=
X-Received: by 2002:a17:90b:51c2:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-2f452e1d3f9mr68977145a91.11.1735890801729; Thu, 02 Jan 2025
 23:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20241222072251.13150-1-liwang@redhat.com>
 <20241222072251.13150-2-liwang@redhat.com>
 <20250102125653.GB81987@pevik> <20250102143106.GA87474@pevik>
In-Reply-To: <20250102143106.GA87474@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 3 Jan 2025 15:53:09 +0800
Message-ID: <CAEemH2dt+JrGjCBVwM=8axSZt180xrBEYp=hKMfvvg-ubxYsRw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4fzugFcFNfpmTx71eRKt-QQwyX6wcuXnpK_rL8_2f_o_1735890802
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] starvation: skip test on slow kernel
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

T24gVGh1LCBKYW4gMiwgMjAyNSBhdCAxMDozMeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBIaSBMaSwKPgo+ID4gPiBTeXN0ZW1zIHdpdGggc2xvdyBrZXJuZWwg
Y29uZmlndXJhdGlvbnMgbWF5IG5vdCBtZWV0Cj4gPiA+IHRoZSBwZXJmb3JtYW5jZSByZXF1aXJl
bWVudHMgbmVjZXNzYXJ5IGZvciB0aGUgc3RhcnZhdGlvbgo+ID4gPiB0ZXN0IHRvIHByb2R1Y2Ug
dmFsaWQgcmVzdWx0cy4KPgo+ID4gPiBTa2lwcGluZyB0aGUgdGVzdCBlbnN1cmVzIHRoYXQgaXQg
cnVucyBvbmx5IG9uIHN5c3RlbXMKPiA+ID4gd2hlcmUgaXRzIHJlc3VsdHMgYXJlIG1lYW5pbmdm
dWwuCj4gPiAuLi4KPiA+ID4gKyAgIGlmICh0c3RfaGFzX3Nsb3dfa2NvbmZpZygpKQo+ID4gPiAr
ICAgICAgICAgICB0c3RfYnJrKFRDT05GLCAiU2tpcCB0ZXN0IGR1ZSB0byBzbG93IGtlcm5lbAo+
IGNvbmZpZ3VyYXRpb24iKTsKPiA+ID4gKwo+Cj4gPiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8
cHZvcmVsQHN1c2UuY3o+Cj4KPiA+IEkgc3VwcG9zZSB5b3UgaGF2ZSBzdHJvbmcgcmVhc29uIGZv
ciB0aGlzIChlLmcuIGl0J3MgZmFpbGluZyBvbiBzb21lIHNsb3cKPiA+IG1hY2hpbmUpLiBJJ20g
dGVzdGluZyBpdCBvbiBlbXVsYXRlZCByaXNjdjY0IHRvIHNlZSB3aGV0aGVyIGl0J3MgbmVlZGVk
Cj4gdG8gYmUKPiA+IHNraXBwZWQuIEJlY2F1c2UgZHVlIENPTkZJR19MQVRFTkNZVE9QIGl0IHdp
bGwgYWx3YXlzIGJlIHNraXBwZWQgb24KPiBUdW1ibGV3ZWVkLgo+Cj4gT0ssIEkgd2FzIGFibGUg
dG8gcmVwcm9kdWNlIFRGQUlMIG9uIGVtdWxhdGVkIHJpc2N2NjQsIHdoaWNoIHJ1bnMgfiA0bQo+
IDMwcywgd2l0aAo+IHRpbWVvdXQgaW5jcmVhc2VkIHRvIDBoIDA1bSA0NnM6Cj4KPiB0c3RfdG1w
ZGlyLmM6MzE2OiBUSU5GTzogVXNpbmcgL3RtcC9MVFBfc3RhM1VJQjZFIGFzIHRtcGRpciAodG1w
ZnMKPiBmaWxlc3lzdGVtKQo+IHRzdF90ZXN0LmM6MTg5MzogVElORk86IExUUCB2ZXJzaW9uOiAy
MDI0MDkzMAo+IHRzdF90ZXN0LmM6MTg5NzogVElORk86IFRlc3RlZCBrZXJuZWw6IDYuMTIuNi0x
LWRlZmF1bHQgIzEgU01QCj4gUFJFRU1QVF9EWU5BTUlDIFRodSBEZWMgMTkgMTc6MjM6MjUgVVRD
IDIwMjQgKGZiMDcyZGUpIHJpc2N2NjQKPiB0c3Rfa2NvbmZpZy5jOjg4OiBUSU5GTzogUGFyc2lu
ZyBrZXJuZWwgY29uZmlnICcvcHJvYy9jb25maWcuZ3onCj4gdHN0X2tjb25maWcuYzo2Njc6IFRJ
TkZPOiBDT05GSUdfTEFURU5DWVRPUCBrZXJuZWwgb3B0aW9uIGRldGVjdGVkIHdoaWNoCj4gbWln
aHQgc2xvdyB0aGUgZXhlY3V0aW9uCj4gdHN0X3Rlc3QuYzoxNzI4OiBUSU5GTzogVGltZW91dCBw
ZXIgcnVuIGlzIDBoIDAybSAwMHMKPiBzdGFydmF0aW9uLmM6OTg6IFRJTkZPOiBTZXR0aW5nIGFm
ZmluaXR5IHRvIENQVSAwCj4gc3RhcnZhdGlvbi5jOjUyOiBUSU5GTzogQ1BVIGRpZCAxMjAwMDAw
MDAgbG9vcHMgaW4gMjI2NTY2dXMKPiB0c3RfdGVzdC5jOjE3MzY6IFRJTkZPOiBVcGRhdGluZyBt
YXggcnVudGltZSB0byAwaCAwM20gNDZzCj4gdHN0X2tjb25maWcuYzo4ODogVElORk86IFBhcnNp
bmcga2VybmVsIGNvbmZpZyAnL3Byb2MvY29uZmlnLmd6Jwo+IHRzdF9rY29uZmlnLmM6NjY3OiBU
SU5GTzogQ09ORklHX0xBVEVOQ1lUT1Aga2VybmVsIG9wdGlvbiBkZXRlY3RlZCB3aGljaAo+IG1p
Z2h0IHNsb3cgdGhlIGV4ZWN1dGlvbgo+IHRzdF90ZXN0LmM6MTcyODogVElORk86IFRpbWVvdXQg
cGVyIHJ1biBpcyAwaCAwNW0gNDZzCj4gc3RhcnZhdGlvbi5jOjE0ODogVEZBSUw6IFNjaGVkdWxs
ZXIgc3RhcnZhdGlvbiByZXByb2R1Y2VkLgo+Cj4gQnV0IGl0IHdvcmtzIG9uIGVtdWxhdGVkIHg4
Nl82NC4KPgo+IHRzdF90bXBkaXIuYzozMTY6IFRJTkZPOiBVc2luZyAvdG1wL0xUUF9zdGFJdDBn
NzMgYXMgdG1wZGlyICh0bXBmcwo+IGZpbGVzeXN0ZW0pCj4gdHN0X3Rlc3QuYzoxODkzOiBUSU5G
TzogTFRQIHZlcnNpb246IDIwMjQwOTMwLTE0OC1nNDUzOWJmYmM3Cj4gdHN0X3Rlc3QuYzoxODk3
OiBUSU5GTzogVGVzdGVkIGtlcm5lbDogNi4xMy4wLXJjNC0xLmc0YTVjNmE2LWRlZmF1bHQgIzEK
PiBTTVAgUFJFRU1QVF9EWU5BTUlDIFN1biBEZWMgMjIgMjI6MTE6MzUgVVRDIDIwMjQgKDRhNWM2
YTYpIHg4Nl82NAo+IHRzdF9rY29uZmlnLmM6ODg6IFRJTkZPOiBQYXJzaW5nIGtlcm5lbCBjb25m
aWcgJy9wcm9jL2NvbmZpZy5neicKPiB0c3Rfa2NvbmZpZy5jOjY2NzogVElORk86IENPTkZJR19M
QVRFTkNZVE9QIGtlcm5lbCBvcHRpb24gZGV0ZWN0ZWQgd2hpY2gKPiBtaWdodCBzbG93IHRoZSBl
eGVjdXRpb24KPiB0c3RfdGVzdC5jOjE3Mjg6IFRJTkZPOiBUaW1lb3V0IHBlciBydW4gaXMgMGgg
MDJtIDAwcwo+IHN0YXJ2YXRpb24uYzo5ODogVElORk86IFNldHRpbmcgYWZmaW5pdHkgdG8gQ1BV
IDAKPiBzdGFydmF0aW9uLmM6NTI6IFRJTkZPOiBDUFUgZGlkIDEyMDAwMDAwMCBsb29wcyBpbiAz
NDE4OXVzCj4gdHN0X3Rlc3QuYzoxNzM2OiBUSU5GTzogVXBkYXRpbmcgbWF4IHJ1bnRpbWUgdG8g
MGggMDBtIDM0cwo+IHRzdF9rY29uZmlnLmM6ODg6IFRJTkZPOiBQYXJzaW5nIGtlcm5lbCBjb25m
aWcgJy9wcm9jL2NvbmZpZy5neicKPiB0c3Rfa2NvbmZpZy5jOjY2NzogVElORk86IENPTkZJR19M
QVRFTkNZVE9QIGtlcm5lbCBvcHRpb24gZGV0ZWN0ZWQgd2hpY2gKPiBtaWdodCBzbG93IHRoZSBl
eGVjdXRpb24KPiB0c3RfdGVzdC5jOjE3Mjg6IFRJTkZPOiBUaW1lb3V0IHBlciBydW4gaXMgMGgg
MDJtIDM0cwo+IHN0YXJ2YXRpb24uYzoxNTA6IFRQQVNTOiBIYXZlbid0IHJlcHJvZHVjZWQgc2No
ZWR1bGxlciBzdGFydmF0aW9uLgo+Cj4gSSB3b25kZXIgaWYgd2UgY2FuIHF1aXQgd2l0aCBUQ09O
RiBvbmx5IG9uIGNlcnRhaW4gcnVudGltZSBpbmNyZWFzZS4gV2UKPiB3b3VsZAo+IGFsc28gbmVl
ZCB0byB0YWtlIC1sIChudW1iZXIgb2YgbG9vcHMgaW50byBhbiBhY2NvdW50KS4KPgoKVGhlIHNp
bXBsZXN0IHdheSBpcyB0byBleHRlbmQgJ21heF9ydW50aW1lJyB3aGVuIGRldGVjdGluZyBzbG93
IGNvbmZpZ3MKZm9yIG9ubHkgc3RhcnZhdGlvbi5jIHRlc3QuCgpKdXN0IG11bHRpcGx5IHRoZSBh
cmd1bWVudCBvZiB0c3Rfc2V0X21heF9ydW50aW1lKHRpbWVvdXQpIGZvciBzdGFydmF0aW9uLmMu
CgpJIGRpZG4ndCBkbyB0aGF0IGJlY2F1c2UgUGhpbGlwIChvdXIgU2NoZWR1bGVyIGV4cGVydCkg
dG9sZCBtZSB0aGF0IG5vdCBtdWNoCnNlbnNlIHRvIHJ1biB0aGlzIG9uIGRlYnVnLWtlcm5lbC4K
KEkgZG9uJ3Qga25vdyB0aGF0IFR1bWJsZXdlZWQgZW5hYmxlcyBDT05GSUdfTEFURU5DWVRPUCBi
eSBkZWZhdWx0KQoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
