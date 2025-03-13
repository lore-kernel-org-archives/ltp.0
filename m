Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83C0C28B28
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 02:55:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E098F3CA4DD
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 03:55:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21C073C9308
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 03:55:08 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0179A20022F
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 03:55:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741834505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LY34qYH1Qmfeh0FyRJTD+FeBfU29FyrIpf/sISWJ24s=;
 b=A4XI5bghFD8to0+MBhgo5V3NMM4fFmRLz+f7+vCj4rDSIZvtbopGpa5pZlOeCNUh/+1MEm
 +vOqnXXXMwhLorQwGfpRsO1LLI8RNQF2ygjGGiwgGPhUHvJodOCs676WjPxzgZsOR7tomM
 dnQNGfwEVlDxKa3LVMeRBomuedDemf8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-EwBb4tKDMLmtrTSOyEWNIA-1; Wed, 12 Mar 2025 22:55:03 -0400
X-MC-Unique: EwBb4tKDMLmtrTSOyEWNIA-1
X-Mimecast-MFC-AGG-ID: EwBb4tKDMLmtrTSOyEWNIA_1741834502
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff798e8c93so870068a91.2
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 19:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741834502; x=1742439302;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LY34qYH1Qmfeh0FyRJTD+FeBfU29FyrIpf/sISWJ24s=;
 b=K1evxeHplSOtvvGb6M4domRH8BLJzR8Z++cz1eDZif1savSUNWPWas2GgJTUBXy1qq
 z462ktd9F1dnunnM9HPtH0zJ1kiIh6HUrTve5O/25ZMqHZbYTLwf/tSa5tzQ9lA+5Dg0
 57Vb/MqE2Xq3H1ArbMGOv6i7DqqeQL8WcSpFmQmRl9H1N5bTUn8v0K+LFf+C9mPklQbH
 Fgg3RIDngqq3GKPgYMCwL3Tem5cdEMEbqfsjQBrNvWhu+ssUBqF1eENjeooM7cFLXRjl
 Q79gGRdIYXdltkQFltr0j5cXK8u5KGfAxzkq/ERscZriXVLdYtxxjAIDMfw/id722cNC
 GBwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS/9iCCstUQH/r+LTfVkTchq0Sijz0wVJG35i5hrtwgItmxgz+wDxE0iSRsyhpg8U3IjM=@lists.linux.it
X-Gm-Message-State: AOJu0YxOEX4HkqfA7Yr83BxGV2+qL1jufK4x33PS7eVoCi/O2YpuelvE
 Qt2Afdfrhu3a1qcN7lba+oXOETV8bILTbgofDQWDCFWG5FBHPvP6Xlw/HbYDhot6YZ1mMm1dVcT
 bjE4SBuTvDZ2jD1iS3vtQJfJnNs5gVWXeIxLn/nZGPHW1G5aID6JdV/EopXXcy2v823euLPpFea
 E/D/aVIbhBTbyJeyns/wNXICs=
X-Gm-Gg: ASbGncuZRDlaidzn099xTQK+QexVH+kMVsMWwz7XFVYwyEtCvg0dKjcbG59CPV+D+ta
 RL+f9dGk9PlYcA79GVXSEYaivEI+Rhwok/AtixdHQ5aPZRxlDcvw5GiZmVEDAHiPeewDh6nMiLw
 ==
X-Received: by 2002:a17:90b:35ce:b0:2fe:861b:1ae3 with SMTP id
 98e67ed59e1d1-300ff0d4869mr13116368a91.8.1741834502078; 
 Wed, 12 Mar 2025 19:55:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErFm8oJeAyCu02yc/MhkvC4oTWK5WrYZYhjMW9W+EcPWSCJfb1S4ypJjdbnT+/rvKnAfSyycejdeGZZmPhwm4=
X-Received: by 2002:a17:90b:35ce:b0:2fe:861b:1ae3 with SMTP id
 98e67ed59e1d1-300ff0d4869mr13116323a91.8.1741834501531; Wed, 12 Mar 2025
 19:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250312050028.1784117-1-mcgrof@kernel.org>
 <20250312052155.GA11864@lst.de>
 <Z9Edl05uSrNfgasu@bombadil.infradead.org> <20250312054053.GA12234@lst.de>
 <Z9EfKXH6w8C0arzb@bombadil.infradead.org>
 <CAEemH2du_ULgnX19YnCiAJnCNzAURW0R17Tgxpdy9tg-XzisHQ@mail.gmail.com>
 <20250312135912.GB12488@lst.de>
In-Reply-To: <20250312135912.GB12488@lst.de>
From: Li Wang <liwang@redhat.com>
Date: Thu, 13 Mar 2025 10:54:49 +0800
X-Gm-Features: AQ5f1JopjZoXGKHMIs8-ENYIz75tZXvx8J7qiSRcPcMkB-rqH_1FtQsM0derRjo
Message-ID: <CAEemH2c_S_KMMQcyAp702N0DDBWrqOVxgz6GeS=RfVrUCJFE1Q@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PWP3G0yVpHmn4MyOvUTijho1HrIp0-x9Pkv-H3vZYEw_1741834502
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] block: add BLK_FEAT_LBS to check for PAGE_SIZE
 limit
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
Cc: p.raghav@samsung.com, ritesh.list@gmail.com, brauner@kernel.org,
 lkp@intel.com, john.g.garry@oracle.com, da.gomez@samsung.com,
 djwong@kernel.org, david@fromorbit.com, oe-lkp@lists.linux.dev,
 willy@infradead.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 oliver.sang@intel.com, hare@suse.de, gost.dev@samsung.com, kbusch@kernel.org,
 kernel@pankajraghav.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBNYXIgMTIsIDIwMjUgYXQgOTo1OeKAr1BNIENocmlzdG9waCBIZWxsd2lnIDxoY2hA
bHN0LmRlPiB3cm90ZToKCj4gT24gV2VkLCBNYXIgMTIsIDIwMjUgYXQgMDU6MTk6MzZQTSArMDgw
MCwgTGkgV2FuZyB3cm90ZToKPiA+IFdlbGwsIGRvZXMgdGhhdCBwYXRjaCBmb3IgaW9jdGxfbG9v
cDA2IHN0aWxsIG1ha2Ugc2Vuc2U/Cj4gPiBPciBhbnkgb3RoZXIgd29ya2Fyb3VuZD8KPiA+IGh0
dHBzOi8vbGlzdHMubGludXguaXQvcGlwZXJtYWlsL2x0cC8yMDI1LU1hcmNoLzA0MjU5OS5odG1s
Cj4KPiBUaGUgcmVhbCBxdWVzdGlvbiBpcyB3aGF0IGJsb2NrIHNpemVzIHdlIHdhbnQgdG8gc3Vw
cG9ydCBmb3IgdGhlCj4gbG9vcCBkcml2ZXIuICBCZWNhdXNlIGlmIGl0IGlzIGxhcmdlciB0aGFu
IHRoZSBwaHlzaWNhbCBibG9jayBzaXplCj4gaXQgY2FuIGxlYWQgdG8gdG9ybiB3cml0ZXMuICBC
dXQgSSBndWVzcyBubyBvbmUgY2FyZWQgYWJvdXQgdGhvc2UKPiBvbiBsb29wIHNvIGZhciwgc28g
d2h5IGNhcmUgYWJvdXQgdGhpcyBub3cuLgo+CgpUaGF0J3MgYmVjYXVzZSB0aGUga2VybmVsIHRl
c3Qtcm9ib3QgcmVwb3J0cyBhIExUUC9pb2N0bF9sb29wMDYgdGVzdApmYWlsIGluIGtlcm5lbCBj
b21taXQ6CiAgNDdkZDY3NTMyMzAzODAzICAoImJsb2NrL2JkZXY6IGxpZnQgYmxvY2sgc2l6ZSBy
ZXN0cmljdGlvbnMgdG8gNjRrIikKClRoZSBpb2N0bF9sb29wMDYgaXMgYSBib3VuZGFyeSB0ZXN0
aW5nIGFuZCBhbHdheXMgZmFpbCB3aXRoCkxPT1BfU0VUX0JMT0NLX1NJWkUgc2V0IGEgdmFsdWUg
bGFyZ2VyIHRoYW4gUEFHRV9TSVpFLgpCdXQgbm93IGl0J3Mgc2V0IHN1Y2Nlc3NmdWxseSB1bmV4
cGVjdGVkbHkuCgpJZiB5b3UgYWxsIGJlbGlldmUgdGhlIGJvdW5kYXJ5IHRlc3QgZm9yIGxvb3Bi
YWNrIGRyaXZlciBpcyByZWR1bmRhbnQsCkkgY2FuIGhlbHAgcmVtb3ZlIHRoYXQgZnJvbSBMVFAg
Y29kZS4KCgoKPiBCdXQgaWYgd2UgZG9uJ3Qgd2FudCBhbnkgbGltaXQgb24gdGhlIGJsb2NrIHNp
emUgdGhhdCBwYXRjaCBsb29rcwo+IHJpZ2h0Lgo+CgpZZXMsIGl0IGhpZ2hseSBkZXBlbmRzIG9u
IHRoZSBrZXJuZWwgYmVoYXZpb3IuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
