Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED572C54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 07:32:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 632BD3CF23E
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 08:32:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEBC73CD808
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 08:31:51 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A71651405170
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 08:31:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710919908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VAZxmdQBcDnHCO8IzOX3WDg3WUiV76pcgL1y9HYaerM=;
 b=Yh+bZ6vBTzik1boaUlssgfY1RMzIVUB98ybPBHfst2MJ7l8s6/n15ekhT8I4RDhiWwNfhe
 OoZYoG9W1h6dpM8RQyTCx5gQBZAXkednCXnNhxQ7hkyH4j1X+rFZFyc1vtkPKIGBPRIfOk
 l6Yob3GlB8aN+il6b2ih0rztpf4vJnA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-iGhiR8AUPCaoWXM1I-Fq-Q-1; Wed, 20 Mar 2024 03:31:47 -0400
X-MC-Unique: iGhiR8AUPCaoWXM1I-Fq-Q-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29de8002b0bso4410569a91.3
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 00:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710919904; x=1711524704;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VAZxmdQBcDnHCO8IzOX3WDg3WUiV76pcgL1y9HYaerM=;
 b=pbk8NNu7LuwCTl+1EEPoHRzjQQ2hhPnO9+Yf4UQNeCZYdOxXhl+2dZwoElIAVOeVB1
 VO45AbljUEJifamZ+loPCfbrhxJMhEKfLL/WM/p7/vQ8sgX37pZfcH62WmAsY7GpUjid
 N7vhZ+3aBqyZNFIXOvnDLPcXVyPEWe/lGCRcX3saJQmeA1a6HiwTU7K+oZtdoL6IkoqF
 VvWYCeVXLymaxQ9rPVXTEWVCseE11APasJMzkVFGlpxPBBXeSbX2Paw9xDL8exeEUVMQ
 XZVI49UlnJleUeavRlVbPi6P4YVLw+pOZ4/Yn2k2e8vsrkEfeV88tZmLLeq3DlgNU5r/
 rs3w==
X-Gm-Message-State: AOJu0YwnfBmv3tsv3hr6RYL6wosku3tp5CJn16klV0mBiEf9xlTbT8Vy
 cz5xUU45t0Z4AbGre1WOvOXDjIZi7dxKkfEnLR/22O7UsPNczcuactZspc6NK0GUlM1nM4ukrHP
 wKPx9ZJbkLc8kj+3xrUEv7OtlaBAAIeffJvLXIME5vWPSqDT5rf9Igl/L1Vho4I3VSYKgBxIQe4
 WSm35BLg1ZLT3tnSDnvrxGY3Bn47uq/6uoZJYf
X-Received: by 2002:a17:90a:928e:b0:299:3f5d:b5e8 with SMTP id
 n14-20020a17090a928e00b002993f5db5e8mr14390016pjo.20.1710919904643; 
 Wed, 20 Mar 2024 00:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE23bVAug5ujnnTwkCMlcNx/Dy9KAnpY9Yc5FJnJkdg9+Dxqu5HJPFl8YyGE7qc2JNaNisTU9FCssX20k1ey+o=
X-Received: by 2002:a17:90a:928e:b0:299:3f5d:b5e8 with SMTP id
 n14-20020a17090a928e00b002993f5db5e8mr14390010pjo.20.1710919904350; Wed, 20
 Mar 2024 00:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240320063218.449072-1-pvorel@suse.cz>
In-Reply-To: <20240320063218.449072-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 20 Mar 2024 15:31:32 +0800
Message-ID: <CAEemH2eRspxMmD4LEQ-ospJES2BWAHLqhviX_1uSM=-eefnQug@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] lib: Add tst_selinux_enforcing()
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
Cc: Mete Durlu <meted@linux.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIFdlZCwgTWFyIDIwLCAyMDI0IGF0IDI6MzLigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IENvLWRldmVsb3BlZC1ieTogTWV0ZSBEdXJsdSA8bWV0
ZWRAbGludXguaWJtLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4KPgoKVGhpcyBwYXRjaCBpcyBkb2luZyB0aGUgc2FtZSB3b3JrIGFzIHNlY3VyaXR5X2dl
dGVuZm9yY2UoKSB3aGljaCBwcm92aWRlcwpieSAnc2VsaW51eC9zZWxpbnV4LmgnLCBidXQgaXQg
aXMgc3RpbGwgd29ydGggaGF2aW5nIGl0IGJlY2F1c2Ugd2UgZG8gbm90CndhbnQgbHRwCmhhcyBt
YW55IGV4dHJhIGRlcGVuZGVuY2llcyAoZS5nLiBsaWJzZWxpbnV4LWRldmVsKS4KClJldmlld2Vk
LWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCgoKPiAtLS0KPiBIaSwKPgo+IEBMaSwg
Q3lyaWw6Cj4gMSkgSSBndWVzcyB3ZSB3YW50IHRvIGRpc3Rpbmd1aXNoIEVBQ0NFUyBmb3IgU0VM
aW51eCBlbmZvcmNpbmcsIHJpZ2h0Pwo+IElmIG5vdCwgdGhpcyBjb21taXQgd291bGQgYmUgZHJv
cHBlZCBhbmQgc2Vjb25kIGNvbW1pdCB3b3VsZCBqdXN0IHVzZQo+Cj4gICAgICAgICBjb25zdCBp
bnQgZXhwX2VycnNbXSA9IHt0Yy0+ZXhwZWN0ZWRfZXJybm8sIEVBQ0NFU307Cj4KPiAgICAgICAg
IFRTVF9FWFBfRkFJTF9BUlIoZmFub3RpZnlfbWFyayhmYW5vdGlmeV9mZCwgRkFOX01BUktfQURE
IHwKPiB0Yy0+bWFyay5mbGFncywKPiAgICAgICAgICAgICAgICAgICAgICAgICAgdGMtPm1hc2su
ZmxhZ3MsIGRpcmZkLCBwYXRoKSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgZXhwX2VycnMp
Owo+Cj4gMikgU29tZSB0aW1lIGFnbyBJIHByb3Bvc2VkIHRvIG1lcmdlIHNvbWUgbGliLyouYyBm
aWxlcywgbm90Cj4ganVzdCBoYXZlIHNvIG1hbnkgZmlsZXMgd2l0aCBzaW5nbGUgZnVuY3Rpb25z
IGluIHRoZSBsaWJyYXJ5LiBFLmcuCj4gbGliL3RzdF9maXBzLmMsIGxpYi90c3Rfc2VsaW51eC5j
LCBsaWIvdHN0X2xvY2tkb3duLmMgY291bGQgYmUgbWVyZ2VkCj4gaW50byBsaWIvdHN0X3NlY3Vy
aXR5LmMuIE9yIGRvIHdlIHdhbnQgdG8gaGF2ZSB0aGVzZSBzZXBhcmF0ZT8KPgoKSSB0aGluayB0
aGUgYW5zd2VyIGlzIFllcy4gVGhlcmUgYXJlIG1vcmUgYW5kIG1vcmUgbGliLyouYyBmaWxlcyB3
aXRoCnNvbWUgdHJpdmlhbCBmZWF0dXJlcywgd2hpY2ggYnJpbmcgdHJvdWJsZXMgZm9yIHJlYWRp
bmcvbWFuYWdpbmcgdGhlCmxpYnJhcnkuIEl0IGlzIG5lY2Vzc2FyeSB0byBhcmNoaXZlIGFuZCBt
ZXJnZSB0aGUgc2FtZSB0aGluZy4KCgoKPgo+IFdoZW4gSSBwcm9wb3NlZCB0aGlzLCBJIHdhbnRl
ZCB0byBtZXJnZSBmaWxlcywgd2hpY2ggaGF2ZSB0aGUgc2FtZSBuYW1lCj4gYXMgdGhlIHNpbmds
ZSBmdW5jdGlvbiBpbiB0aGUgZmlsZSAoZS5nLiB0c3RfZGlyX2lzX2VtcHR5LmMsCj4gdHN0X3Bh
dGhfaGFzX21udF9mbGFncy5jKSwgaGF2aW5nIHRoZW0gYXMgc2luZ2xlIGZpbGUgZG9lcyBub3Qg
aGVscCBtdWNoCj4gd2l0aCBzZWFyY2hpbmcgZm9yIHRoZSBjb250ZW50Lgo+CgorMQoKQW5kIHRo
ZSBtb3N0IGltcG9ydGFudCBpcyB3ZSBuZWVkIHRvIGdpdmUgYSBnb29kIG5hbWUgZm9yIHRoZQph
Y2hpZXZlZCBoZWFkZXIgZmlsZS4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
