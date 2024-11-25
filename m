Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20538D3B7CA
	for <ltp@archiver.kernel.org>; Mon, 25 Nov 2024 03:44:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADF243DA888
	for <ltp@archiver.kernel.org>; Mon, 25 Nov 2024 04:44:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BA6C3DA826
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 04:44:07 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B07E065063C
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 04:44:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732506244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0RAUl4zMJr1IbzDs9YePrakoHuyybSg6/Oyqd6aQNzQ=;
 b=J183q4L+vHQY0qnYG1oK2bbXfp+rW319/u2ydKM9l79GfDzL2HDQ+ixHBSW2PYC2IP+R60
 4wGUNz6XwHFv2r2URQSUqwN1guJaaH6R5h36hFhOTgrjPt6LD/qWrgInEjeGnvgIY9RLdH
 ixGC0hPs6q7/bhnliQ4j2yghpEF6HOw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-oBqfs4RDNN2WMZx3ipAjcw-1; Sun, 24 Nov 2024 22:44:02 -0500
X-MC-Unique: oBqfs4RDNN2WMZx3ipAjcw-1
X-Mimecast-MFC-AGG-ID: oBqfs4RDNN2WMZx3ipAjcw
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2edba08c89bso817103a91.1
 for <ltp@lists.linux.it>; Sun, 24 Nov 2024 19:44:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732506241; x=1733111041;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0RAUl4zMJr1IbzDs9YePrakoHuyybSg6/Oyqd6aQNzQ=;
 b=U5qDesm6G9ZDeO4QJ4BT9ujG8zbGENKt5xMU2kHJT3Zcndq5hFUoEsiaxd6XAva2Jw
 I4yx3DQMpYn943lmV84uM7YuULPa55zhI5+xCom1mFjlx3WAYWKP0Qb/B4hRyJ3ngPbx
 VaBArx8UKYwoPxI7K0dASlp5lI9MbdLmfclo8fjNgorjJOIomAfAQ1+G74WxO6yeq4t6
 WlIaQPb3kGulLMds6gs0F+LSvyF4F8LRFDtQhWdGOKV3NsuZ3ZJrTBM2KDoByYIZrW3N
 dEoOtecX5nvsM2/X9B+3xw5AwUMbj5dfBKz4piD4Xw8dJ9HqdlbbbuVxNZIuzpihBmUG
 rpVQ==
X-Gm-Message-State: AOJu0YwMTMI6ACwzrJAk/l+j7W2x+AnX1ZD0+wJ9dXeECcJ6/N/7IZMD
 XhyWRDdYaM19/c+FpXMT89WWoGKZBIW8+PoLjCol6I7RfXAcH+mLo7Ra7R1y+aY1C1CgB/+HSIG
 ByzOaYT5JBP9vQbA5CdP+CIqV4ZCNwnnEIgmBsUCczznUOd1mnchJShecjC3sto7uY0lgN0GIiN
 p5EKXRYQyx6z6zXfr6ffySWWE=
X-Gm-Gg: ASbGncv2heWxlrxr8zbbMaJHp3I4x5kizB8SWXgMZ0pc/CvaotT/YT3AOEdXYrT9gTS
 z3Sf8k819G+v0Fhclj5ailkshbuedDnca
X-Received: by 2002:a17:90b:1a8e:b0:2ea:77a2:e47b with SMTP id
 98e67ed59e1d1-2eb0e22bfe8mr17968595a91.12.1732506241679; 
 Sun, 24 Nov 2024 19:44:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmxv3zNYXrLtQAOsQ7Oh+GZ5DDuM0fuqscGvLGkgsQWDa/GKWse1b8+pqqI+GNtSIPcCYIXEjXhHmZ46AYwrw=
X-Received: by 2002:a17:90b:1a8e:b0:2ea:77a2:e47b with SMTP id
 98e67ed59e1d1-2eb0e22bfe8mr17968579a91.12.1732506241261; Sun, 24 Nov 2024
 19:44:01 -0800 (PST)
MIME-Version: 1.0
References: <CAASaF6yd+FHWf8urwFbk6U6oTNnXhdR+CbGhWqq6DT+eKjeVfQ@mail.gmail.com>
 <7cdc48ed109ee67af12d0bc74eb32c0b7f862430.1732031092.git.jstancek@redhat.com>
In-Reply-To: <7cdc48ed109ee67af12d0bc74eb32c0b7f862430.1732031092.git.jstancek@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 25 Nov 2024 11:43:49 +0800
Message-ID: <CAEemH2dHY4UWEmoTQFg2Qt_bi0He2WFv=CmAR6RAa6A4se5E_Q@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OFrVl5XqdmIQYEybbQNey-tcsfyqTOim02c23g5FqeU_1732506242
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] syscalls/pkeys01: use a dummy function instead of
 function_size
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

T24gVHVlLCBOb3YgMTksIDIwMjQgYXQgMTE6NDjigK9QTSBKYW4gU3RhbmNlayA8anN0YW5jZWtA
cmVkaGF0LmNvbT4gd3JvdGU6Cgo+IEFzIE1hcnRpbiBmb3VuZDoKPiAgIFRoZSBmdW5jdGlvbl9z
aXplKCkgY29kZQo+ICAgaXMgYnJva2VuIGluIGEgd2F5IHRoYXQgSSBjYW5ub3QgZWFzaWx5IGZp
eC4gVGhlIGZ1bmN0aW9uIHRyaWVzCj4gICB0byBjYWxjdWxhdGUgdGhlIHNpemUgb2YgYSBmdW5j
dGlvbiBieSBmaW5kaW5nIHRoZSBmaXJzdCBSRVQKPiAgIGluc3RydWN0aW9uLiBIb3dldmVyLCBp
biAzMmJpdCBMVFAgYnVpbGRzLCB0aGUgY29kZSBnZXRzIGNvbXBpbGVkCj4gICB0byB0aGlzOgo+
Cj4gICAwODA0YjY5MCA8ZnVuY3Rpb25fc2l6ZT46Cj4gICAgODA0YjY5MDogICAgICAgOGIgNGMg
MjQgMDQgICAgICAgICAgICAgbW92ICAgIDB4NCglZXNwKSwlZWN4Cj4gICAgODA0YjY5NDogICAg
ICAgMGYgYjYgMDEgICAgICAgICAgICAgICAgbW92emJsICglZWN4KSwlZWF4Cj4gICAgODA0YjY5
NzogICAgICAgODMgYzAgM2UgICAgICAgICAgICAgICAgYWRkICAgICQweDNlLCVlYXgKPiAgICA4
MDRiNjlhOiAgICAgICAzYyAwMSAgICAgICAgICAgICAgICAgICBjbXAgICAgJDB4MSwlYWwKPiAg
ICA4MDRiNjljOiAgICAgICA3NiAxYSAgICAgICAgICAgICAgICAgICBqYmUgICAgODA0YjZiOAo+
IDxmdW5jdGlvbl9zaXplKzB4Mjg+Cj4gICAgODA0YjY5ZTogICAgICAgODkgYzggICAgICAgICAg
ICAgICAgICAgbW92ICAgICVlY3gsJWVheAo+ICAgIDgwNGI2YTA6ICAgICAgIDgzIGMwIDAxICAg
ICAgICAgICAgICAgIGFkZCAgICAkMHgxLCVlYXgKPiAgICA4MDRiNmEzOiAgICAgICAwZiBiNiAx
MCAgICAgICAgICAgICAgICBtb3Z6YmwgKCVlYXgpLCVlZHgKPiAgICA4MDRiNmE2OiAgICAgICA4
MyBjMiAzZSAgICAgICAgICAgICAgICBhZGQgICAgJDB4M2UsJWVkeAo+ICAgIDgwNGI2YTk6ICAg
ICAgIDgwIGZhIDAxICAgICAgICAgICAgICAgIGNtcCAgICAkMHgxLCVkbAo+ICAgIDgwNGI2YWM6
ICAgICAgIDc3IGYyICAgICAgICAgICAgICAgICAgIGphICAgICA4MDRiNmEwCj4gPGZ1bmN0aW9u
X3NpemUrMHgxMD4KPiAgICA4MDRiNmFlOiAgICAgICAyOSBjOCAgICAgICAgICAgICAgICAgICBz
dWIgICAgJWVjeCwlZWF4Cj4gICAgODA0YjZiMDogICAgICAgODMgYzAgMTAgICAgICAgICAgICAg
ICAgYWRkICAgICQweDEwLCVlYXgKPiAgICA4MDRiNmIzOiAgICAgICBjMyAgICAgICAgICAgICAg
ICAgICAgICByZXQKPiAgICA4MDRiNmI0OiAgICAgICA4ZCA3NCAyNiAwMCAgICAgICAgICAgICBs
ZWEgICAgMHgwKCVlc2ksJWVpeiwxKSwlZXNpCj4gICAgODA0YjZiODogICAgICAgYjggMTAgMDAg
MDAgMDAgICAgICAgICAgbW92ICAgICQweDEwLCVlYXgKPiAgICA4MDRiNmJkOiAgICAgICBjMyAg
ICAgICAgICAgICAgICAgICAgICByZXQKPiAgICA4MDRiNmJlOiAgICAgICA2NiA5MCAgICAgICAg
ICAgICAgICAgICB4Y2hnICAgJWF4LCVheAo+Cj4gICBJZiB5b3UgbG9vayBjbG9zZWx5IGVub3Vn
aCwgeW91J2xsIG5vdGljZSBhIEMyIGJ5dGUgaW4gYWRkICQweDNlLCVlZHgKPiAgIGluc3RydWN0
aW9uIG9uIGFkZHJlc3MgODA0YjZhNi4gVGhlIGZ1bmN0aW9uIHdpbGwgYXNzdW1lIHRoaXMgYnl0
ZSBpcwo+ICAgYSBSRVQgaW5zdHJ1Y3Rpb24sIHJldHVybiBhIHNpemUgdGhhdCdzIDIyIGJ5dGVz
IHRvbyBzaG9ydCBhbmQgdGhlbgo+ICAgdGhlIGNvZGUgZXhlY3V0aW9uIGluc2lkZSB0aGUgZXhl
Y3V0YWJsZSBidWZmZXIgd2lsbCBydW4gcGFzdCB0aGUgZW5kCj4gICBvZiBidWZmZXIsIHJlc3Vs
dGluZyBpbiBhIHNlZ2ZhdWx0Lgo+Cj4gVXNlIGEgZHVtbXkgZnVuY3Rpb24gYW5kIGNvcHkgZW50
aXJlIHBhZ2UsIHNpbWlsYXIgdG8gd2hhdCB3ZSBkbwo+IGluIG1wcm90ZWN0MDQuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KPgoKClRoaXMgd2F5
IGlzIGJldHRlciB0aGFuIHJldmVydGluZywgdGhhbmtzIQoKUmV2aWV3ZWQtYnk6IExpIFdhbmcg
PGxpd2FuZ0ByZWRoYXQuY29tPgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
