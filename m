Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087DFC30653
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 11:28:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34EF53D3CF6
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 13:28:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B53DE3CF754
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 13:28:03 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 930F6201752
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 13:28:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720092481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sdV3Iy7SXdHdVTJ2L1VHYKZznxhqNKyOqmc2l5zwc3I=;
 b=bik847tK09WUwanmYPjC6k+kZLakS4l3/UuQU6fwAhzVRg2Vaimf3AwOOdDEeAykV4Z3FT
 HuK17TUnYO7ykzqoEyKCSXSkE7HtwgUJ42idtGTwyZ0gYkPwjB1/egvqICCXzfh/2uT38S
 fA5CzqVzpXuJSjkmnFgUBtern4bngds=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-SXgPBuajMKSI49zq8v9h4Q-1; Thu, 04 Jul 2024 07:27:58 -0400
X-MC-Unique: SXgPBuajMKSI49zq8v9h4Q-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-75ea23782f5so331933a12.2
 for <ltp@lists.linux.it>; Thu, 04 Jul 2024 04:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720092478; x=1720697278;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sdV3Iy7SXdHdVTJ2L1VHYKZznxhqNKyOqmc2l5zwc3I=;
 b=et4k9gVcRutPCyxlJYJJC74LwWMghT0V0rJBf7WkWh5TrLuCYpFjbbYcmm97p0PI+R
 5LcRsXyq5K/N/2f1szebHZcrGq6EgUjVQJyieTb7ZKAz2wuq2WhAcloaZSlzCNIJ+G2i
 k3luvC++JduV2DpP8VXJoqvQssbO0ZeFKN4IUxnlCRNefQm9e2MiB9Q0r5BFt7jDqGqW
 LPpvuiURi+chXP6/1fY5m1TNp0cITvhCT5n0K6fCCXOh5wOpoiuDxIkEWiLHsrB9cNmr
 GtKmCPo454Gs5KREyqHysObOvA56Ar6+nkocyP0XkFGWQuIN9jRyQltbI01T3mCnctqu
 EBsA==
X-Gm-Message-State: AOJu0Yz3dmxQ94AxHxdKcd/fKCkXbBd+iaEl4ymlpnmlvCQyprtXq0au
 MfuNl6iKJ4MNQGbSH/jZUcuIRSzgDPqFmNGM7jolYPi0Lfp+dAEZTKWzfHR1A5Sbfktj/0V5EN+
 bXAHYYMrqtDSyHxFhKuI1P1oyZA6VjwdbDJA9PVK9MMIprJW0shUDDuWuHUdAmo7F6tIyvvM6ZO
 4UAfHtc4I4k8QcqwAAReeBzqw=
X-Received: by 2002:a05:6a20:2590:b0:1be:c4b9:c222 with SMTP id
 adf61e73a8af0-1c0cc73ae13mr1449638637.11.1720092477722; 
 Thu, 04 Jul 2024 04:27:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8azz9Iug+LD4wmGMj0HC66BDpa52Ka+HrjrTsfxoVxsbzuxQhNJu7aYgNgTqEzK1qdcE9ix/Qa1e1ITw7Ioc=
X-Received: by 2002:a05:6a20:2590:b0:1be:c4b9:c222 with SMTP id
 adf61e73a8af0-1c0cc73ae13mr1449628637.11.1720092477385; Thu, 04 Jul 2024
 04:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240702-stat04-v1-0-e27d9953210d@suse.com>
 <20240702-stat04-v1-1-e27d9953210d@suse.com>
 <CAEemH2dcP695G=Lef+kJfusLoKMZSti_rFYPyEGBHATbnVzKiQ@mail.gmail.com>
 <ZoZov55YEzVMogMd@yuki> <ZoZp_DbLtR-Y4NIh@yuki>
In-Reply-To: <ZoZp_DbLtR-Y4NIh@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Jul 2024 19:27:45 +0800
Message-ID: <CAEemH2cB8naFy3Mjm01D42m4F7OFtYjivMivcS+RJzo+e+n6Dg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/5] Add stat04 test
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

T24gVGh1LCBKdWwgNCwgMjAyNCBhdCA1OjIz4oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+ID4gPiArICAgICAgIC8qIGNoYW5nZSBzdF9hdGltZSAv
IHN0X210aW1lIC8gc3RfY3RpbWUgKi8KPiA+ID4gPiArICAgICAgIHNsZWVwKDEpOwo+ID4gPiA+
Cj4gPiA+Cj4gPiA+IERvZXMgdGhpcyAxc2VjIHNsZWVwIG1ha2UgcmVhbCBzZW5zZSB0byB0aGUg
dGVzdD8gQ2FuIHdlIHJlbW92ZSBpdD8KPiA+Cj4gPiBXaXRoIHV0aW1lbnNhdCB3ZSBjYW4gZWFz
aWx5IGNoYW5nZSBhY2Nlc3MgdGltZSBhbmQgbW9kaWZpY2F0aW9uIHRpbWUKPiA+IGJ1dCB5b3Ug
Y2FuJ3QgY2hhbmdlIHN0YXR1cyBjaGFuZ2UgdGltZS4gU28gd2UgZWl0aGVyIHNsZWVwIGhlcmUg
b3Igc2V0Cj4gPiB0aGUgc3lzdGVtIGNsb2NrIGJhY2ssIGNoYW5nZSB0aGUgZmlsZSBhbmQgdGhl
biByZXNldCB0aGUgc3lzdGVtIGNsb2NrCj4gPiBiYWNrLgo+Cj4gQW5kIGlmIHlvdSBhcmUgYXNr
aW5nIGlmIHRoZSB0ZXN0IHdpbGwgcnVuIGZpbmUgd2l0aG91dCB0aGUgc2xlZXAsIGl0Cj4gd2ls
bCBydW4gYW5kIGl0IHdpbGwgcGFzcywgYnV0IHRoZSB0aW1lc3RhbXBzIHdpbGwgYmUgc2FtZSBm
b3IgdGhlIGxpbmsKPiBhbmQgdGhlIGZpbGUsIHNvIGlmIGtlcm5lbCBwaWNrcyB1cCB3cm9uZyB0
aW1lc3RhbXAgd2Ugd2lsbCBub3QgZmluZAo+IG91dC4KPgoKSSdtIGNvbmZ1c2VkLCBkbyB5b3Ug
bWVhbiBpZiB0aGUga2VybmVsIHNldHMgYSB3cm9uZyB0aW1lc3RhbXAgaXQgY291bGQKcmVwb3J0
IFRGQUlMPwoKRnJvbSB3aGF0IEkgY2FuIHRlbGwsIHRoZSBzdGF0KHN5bV9wYXRoLCkgYWxzbyBy
ZXRyaWV2ZXMgaW5mb3JtYXRpb24gb2YKdGhlIHRhcmdldCBmaWxlLApzaG91bGRuJ3QgdGhhdCBh
bHdheXMgZXF1YWwgdGhlIHN0YXQoZmlsZV9wYXRoLCkgdGltZXN0YW1wPyAgQXMgbG9uZyBhcyB0
aGUKc3RhdCgpCndvcmtzIGNvcnJlY3RseSwgd2l0aCBzbGVlcCgxKSBvciBub3Qgd29uJ3QgaW1w
YWN0IGFueXRoaW5nLgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
