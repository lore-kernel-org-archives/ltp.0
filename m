Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555BCEE6457
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 12:40:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA4A53CE694
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 14:40:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C0D33CB133
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 14:40:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 25E5E1009BC7
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 14:40:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694781627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2n7rBGqds31tlmGDRUJxa5s3Ly3pkFlvfVOHLzzTYQE=;
 b=NSFb7WoYvd2CjpQPFkV6Rf1YtXffAikv4VWmKoC7l5aUQG5RzUVWbHNfitPqgVFFdAyHSK
 NHOj1Qu41sfqW7P0vBW9w06u/6mBpbRFCXi5Fyr00Sz2RWhmgy7S4EWcM7VLo6KhIBfsYo
 KYAdaigkybs3tqh2MkU7p0E2pIzVg4I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-e8-GN_FTOraAfezHlCp9lw-1; Fri, 15 Sep 2023 08:40:25 -0400
X-MC-Unique: e8-GN_FTOraAfezHlCp9lw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-501c70f247cso649831e87.1
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 05:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694781624; x=1695386424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2n7rBGqds31tlmGDRUJxa5s3Ly3pkFlvfVOHLzzTYQE=;
 b=pqpXn1One4UeI6SL+EeQPpR3dyAedSlee/0VlZbUKL0mtGZs0f+46YjRSBDTIIFzyT
 k+F+If9+NJAAFpH+DwbB+LNEdxs+1rIG+Wy6M/AOmxWGOUMCW4xX1Jeyg7y91KaizHV6
 V/GZulbZrwWVYbAdPeVBOY++FYMQCLs7eZADK4E7HvcafDgO2LtE6JHDuDnQiEb3dKTD
 YIXdYQqzBqa2ieerQMuljcrONpTaeTP09TTLtbY7h0OHh7vvQwucHn5BIcRzxi4bd5yw
 VDnBWdVXKA+a/iXGrnOgvnGNKl1Kh+lNpkKacE/HZXxhU60c9BOrn9cNzGCOK6NuUPT9
 yYPQ==
X-Gm-Message-State: AOJu0YyS8RkvY4APnP2R77tFxUcOiW6d8DX+osROEwi0MnNzIR9BXF31
 WZM1QD7ZXY8CmzhSw8frYYSsA2sMpr7i8g8Zyn/aD+HWd+aRkxI9pdno9pA/Zbpk4qWE8my6gMO
 pjTLC2iuWf39j7SB2fclVlXYLQwA=
X-Received: by 2002:ac2:4db3:0:b0:502:9bd7:ec79 with SMTP id
 h19-20020ac24db3000000b005029bd7ec79mr1339917lfe.29.1694781624131; 
 Fri, 15 Sep 2023 05:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdMUmfQaifobs5BB9P8xccBT/Vyk3h0mQ/MpVIJvtZxyEkS1FAKkPQAX8rStPwqcVf+oUUaLQ3gFb7ntGzcBs=
X-Received: by 2002:ac2:4db3:0:b0:502:9bd7:ec79 with SMTP id
 h19-20020ac24db3000000b005029bd7ec79mr1339893lfe.29.1694781623630; Fri, 15
 Sep 2023 05:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230728132120.17322-1-pvorel@suse.cz>
In-Reply-To: <20230728132120.17322-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 15 Sep 2023 20:40:11 +0800
Message-ID: <CAEemH2fq1zGiB43uy34uAQYBSugNXryc1urEMvLWJ1=LvNP8ow@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 0/4] shell: Add TST_SKIP_IN_{LOCKDOWN,
 SECUREBOOT}=1
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

Rm9yIHBhdGNoZXM6CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgpP
biBGcmksIEp1bCAyOCwgMjAyMyBhdCA5OjIx4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBhbmQgdXNlIGl0IGluIGluc21vZDAxLnNoLgo+Cj4gUGV0ciBWb3JlbCAo
NCk6Cj4gICBsaWI6IHNoZWxsOiBBZGQgVFNUX1NLSVBfSU5fTE9DS0RPV049MQo+ICAgbGliOiBz
aGVsbDogQWRkIFRTVF9TS0lQX0lOX1NFQ1VSRUJPT1Q9MQo+ICAgaW5zbW9kMDEuc2g6IFNraXAg
dGVzdCBvbiBsb2NrZG93biBhbmQgc2VjdXJlIGJvb3QKPiAgIGRvYy9zaGVsbC1BUEk6IERvY3Vt
ZW50IFRTVF9TS0lQX0lOX3tMT0NLRE9XTixTRUNVUkVCT09UfT0xCj4KPiAgZG9jL3NoZWxsLXRl
c3QtYXBpLnR4dCAgICAgICAgICAgICAgICAgfCAgNSArKysrKwo+ICBkb2MvdGVzdC13cml0aW5n
LWd1aWRlbGluZXMudHh0ICAgICAgICB8ICA0ICsrLS0KPiAgdGVzdGNhc2VzL2NvbW1hbmRzL2lu
c21vZC9pbnNtb2QwMS5zaCAgfCAgMyArKysKPiAgdGVzdGNhc2VzL2xpYi8uZ2l0aWdub3JlICAg
ICAgICAgICAgICAgfCAgMiArKwo+ICB0ZXN0Y2FzZXMvbGliL01ha2VmaWxlICAgICAgICAgICAg
ICAgICB8ICAyICstCj4gIHRlc3RjYXNlcy9saWIvdHN0X2xvY2tkb3duX2VuYWJsZWQuYyAgIHwg
MTIgKysrKysrKysrKysrCj4gIHRlc3RjYXNlcy9saWIvdHN0X3NlY3VyZWJvb3RfZW5hYmxlZC5j
IHwgMTIgKysrKysrKysrKysrCj4gIHRlc3RjYXNlcy9saWIvdHN0X3Rlc3Quc2ggICAgICAgICAg
ICAgIHwgMTAgKysrKysrKysrLQo+ICA4IGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMvbGliL3RzdF9s
b2NrZG93bl9lbmFibGVkLmMKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9saWIvdHN0
X3NlY3VyZWJvb3RfZW5hYmxlZC5jCj4KPiAtLQo+IDIuNDEuMAo+Cj4KPiAtLQo+IE1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApS
ZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
