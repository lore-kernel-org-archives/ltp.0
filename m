Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB00BCA0FF0
	for <ltp@archiver.kernel.org>; Wed, 27 Aug 2025 01:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756258861; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=vs4/KwLHsw5EwR3UFBjdqPV7DNPlXvjLme8ez1Wj5zM=;
 b=A6FpnrWfn951kS1Yrzayv/TpbjcWBWYSBwpkcdfWrjGlcbmFDKVTfILJJvA1knjZegzDp
 dJ/t8jSb8a+/Ikh2OpDkOJDn+FXM7hsU0aUOzwZBP7sGL9G135QrH/h8+DHeBsZIrrDJTUp
 ck0DtHjf004bBrzbn0JtpD5nUM3Otzw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E39613CCF9F
	for <ltp@archiver.kernel.org>; Wed, 27 Aug 2025 03:41:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F201E3CC00D
 for <ltp@lists.linux.it>; Wed, 27 Aug 2025 03:40:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 12EDB100040A
 for <ltp@lists.linux.it>; Wed, 27 Aug 2025 03:40:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756258839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M2Ie6p4A/U6nDhSkxHaXAuoIT4WsEyISCI7FC/7i0mQ=;
 b=LjV1yGanQIUPkPMVXyqXpsU98lQA34H9J+aQoVwnSC1LhuiHKiGlE8h4P0p1TiHUspRFcK
 MrBstLJw629F6ZxnR3c9QSQaFAFM14QtBr760/aPSn86k8gThUlfuTt/fElYIKzZjH7lGj
 AeWxs+5Tf+ujl7eM9riap7J9F5GEPpI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-g9WifgLoN7KFIxpINOUReA-1; Tue, 26 Aug 2025 21:40:37 -0400
X-MC-Unique: g9WifgLoN7KFIxpINOUReA-1
X-Mimecast-MFC-AGG-ID: g9WifgLoN7KFIxpINOUReA_1756258836
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-246cf6af2f4so56037745ad.1
 for <ltp@lists.linux.it>; Tue, 26 Aug 2025 18:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756258835; x=1756863635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M2Ie6p4A/U6nDhSkxHaXAuoIT4WsEyISCI7FC/7i0mQ=;
 b=eqg9J498fKoj4oeaDZIvlmbruqF5O491hbxneuBHByGD8PhOFvHayg6Tc4qc1YZZjr
 v0SjlKF+nwXZpSdrmnHMa18BPW85LWo5qg7zF+C7qEaUCvH1ya5gPcACw9wSwI+xgTbR
 XesyteH9dJs3jWgbvy7JJwqVAHCWXAjeHbYigqgcttGFr2XgwEzlE9E/C7EHbc9RUyzj
 FlnPtX2JweKVTwd20/tGsKjgdsbQplqahPh0m1WyBojnK34dwDp6xQ68GvXo0MLFWxyx
 Z1cALQSn7hBlO4FgXwgX8pLbDronBcp++1HNrnYev2ZeojCvghc7Mxv74rbgz4o7APnV
 5pUg==
X-Gm-Message-State: AOJu0YymNvQmm3TdclMidrjfbJHgXB4m1kq831gGMMExxK+wMPbxfNXQ
 yAMNpWzJQT3GWnGurexadRWo0FpIsKYIqSkHzxGlWPY16X8mq158orUZfjo/27qQrjIhR5w/rpI
 tgFwFYpe2xvsvK+vmaM0X1LMFPTngQD0IoLDgPDxBhiyIdSanu1i9fk/tfn6HdgniO+SHggk0Sy
 Y8uXydwtfaIvAmhgeujQVAQki8xIcy4wf2v13Z1g==
X-Gm-Gg: ASbGnct9uZ/ITvaADvu9zwUPLO9JTTa6yAl/Qg7FWGUzs9EdnPs4zuRH5KIWW+33N+Z
 wauooCJC6Mfk+CtFdL/fTODRKQLwY3XkkKxs77D8HXopduG3uu/ienDKezVz46yPb4lEiDtKVVO
 EDCv+avLJT9J2RW2wrgjrUHw==
X-Received: by 2002:a17:902:c94c:b0:246:273:c694 with SMTP id
 d9443c01a7336-2462edac306mr280405525ad.12.1756258835124; 
 Tue, 26 Aug 2025 18:40:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwPSDiS1rI5AkC4QlktaowDibb89WJq+6tI1QeEJx142N23uKkgOsvllgnURC5OWkfz8q2oWGdiT4wcf5zRN8=
X-Received: by 2002:a17:902:c94c:b0:246:273:c694 with SMTP id
 d9443c01a7336-2462edac306mr280405265ad.12.1756258834693; Tue, 26 Aug 2025
 18:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250826-upgrade_tools-v1-0-1e9d8d4c5e2f@suse.com>
 <20250826-upgrade_tools-v1-2-1e9d8d4c5e2f@suse.com>
In-Reply-To: <20250826-upgrade_tools-v1-2-1e9d8d4c5e2f@suse.com>
Date: Wed, 27 Aug 2025 09:40:20 +0800
X-Gm-Features: Ac12FXzsc9osT0S7hJ7oWJtNhpfEXRBGNc23I45yicYZQqOEXalvGJPu6V-Wtlw
Message-ID: <CAEemH2d2o4Laoue5y=JNRDFDyPnBLZzJsn2g_Pcecv6fa41S-w@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sV2D2bXFeax1ZMWYGAwRkFS1U7B7YKa8Ga7y88WtoGQ_1756258836
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] ltx: version 1.3
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBBdWcgMjYsIDIwMjUgYXQgOToyMeKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5kZT4Kd3JvdGU6Cgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFu
ZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVz
YXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8
bGl3YW5nQHJlZGhhdC5jb20+CgotLS0KPiAgdG9vbHMvbHR4L2x0eC1zcmMgfCAyICstCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdp
dCBhL3Rvb2xzL2x0eC9sdHgtc3JjIGIvdG9vbHMvbHR4L2x0eC1zcmMKPiBpbmRleAo+IDU4MGUx
ZjMzNmY5OTJkZTk2NDQzZWEzZDNmZmNkZWQyMDJjZjg5YzkuLmNlNzIwM2I3MTUzYzhhNGViMGNi
Y2FhZjlhYjRlYjllNmU3OGQzYTkKPiAxNjAwMDAKPiAtLS0gYS90b29scy9sdHgvbHR4LXNyYwo+
ICsrKyBiL3Rvb2xzL2x0eC9sdHgtc3JjCj4gQEAgLTEgKzEgQEAKPiAtU3VicHJvamVjdCBjb21t
aXQgNTgwZTFmMzM2Zjk5MmRlOTY0NDNlYTNkM2ZmY2RlZDIwMmNmODljOQo+ICtTdWJwcm9qZWN0
IGNvbW1pdCBjZTcyMDNiNzE1M2M4YTRlYjBjYmNhYWY5YWI0ZWI5ZTZlNzhkM2E5Cj4KPiAtLQo+
IDIuNTEuMAo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
