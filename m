Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD2CC02182
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 01:51:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 312E13C2C1F
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 02:51:51 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0A583C227F
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 02:51:33 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4D5F61BD256C
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 02:51:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737510690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/RmUi4n9smdWDt4kTwCU1Zu+tuwV3DECzhbjY8hJiIo=;
 b=Lr46UTgvPGZf5ppLn4VP1VPexlZEiMwPOefU3nsfzSYrUq5WLZogZDEvZ+MQnnSb5EbZvR
 To8yx3qab//q3lrDw+qsCutKtAuFW5PGV6CId1sNtVXapY3m+UDca7EX0mX6ZSxEXoU+Tu
 je5sRgi/l5fETTcM4uD0oTnY5jVKRfI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-VwD5EN7VOSyPLlHZHFxEGw-1; Tue, 21 Jan 2025 20:50:55 -0500
X-MC-Unique: VwD5EN7VOSyPLlHZHFxEGw-1
X-Mimecast-MFC-AGG-ID: VwD5EN7VOSyPLlHZHFxEGw
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ef35de8901so11608142a91.3
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737510654; x=1738115454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/RmUi4n9smdWDt4kTwCU1Zu+tuwV3DECzhbjY8hJiIo=;
 b=ggDrdLFQjB4acWJJasM9IkG+0x5vuCPuj49yd0OIBXbZKq/9GMIc2u+5c7xWqLPfm5
 XuGuPUAZgbc8OayBReP38cb5QOJW/CzMcIeCw2tRUeoRYIGGrO7I+YjrKUklc2GpCcZf
 nSf3f3YbTuYSaqUUNxjxLAdGpJzdq+9S9XagBM05oO1dS+bgATAhFWXlBG46R/JdjabI
 FlRzie0fzkbsvlzwTrF7BHXfIPn3Xv4H9WrgRTIry6BEWnAt3B6JwhyAMbLNAVvzaBjp
 b3pbFAZc0Ev75W15xMuLbs4AN+I0i3KdWPFfdONhuKTK4hbJwl3iEVBdqbVact/ZUgWO
 IOkw==
X-Gm-Message-State: AOJu0YzWe7Uga6GTBIKuOxIoedhzNqgHAdvDF2ub5M3znPNPFFKIXJue
 GhFz0/VW8VNxnM9fsD/BllXVlhKuvPr8W8WHQecsBZ/QAIMoJ8CB5ciRdvmiGXLCNkp6MEOSdPw
 R3A2rnxLNihTg+a+TOgfb/lLOiTed38zfWOHkSn1JABgrgq6zYMYMfgl5b4Yeu21JuJZ+Y0m1K2
 P++IuPFTksKpbxwqYt2C56Qig=
X-Gm-Gg: ASbGncvrUm1FoYVR3rllhSA8PPflr5ok6/hkWy3rryrHJq1Xs7pUPhWRgFHGDH4stK0
 kN2In7DbNd0o7qar2khGJFEng5pCbiHruGViJDqe32E/UCLu52pK9
X-Received: by 2002:a17:90b:4ec8:b0:2ea:3f34:f18f with SMTP id
 98e67ed59e1d1-2f782ca2c76mr26121985a91.19.1737510654327; 
 Tue, 21 Jan 2025 17:50:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqoqR3XzW/WU9r2KH3N5gMMgxcXYlQsBU3UxuHOwexSezNWkttj0z4M3I2TsX3IXWdnrEDuds7VLe82qH+b5k=
X-Received: by 2002:a17:90b:4ec8:b0:2ea:3f34:f18f with SMTP id
 98e67ed59e1d1-2f782ca2c76mr26121957a91.19.1737510653923; Tue, 21 Jan 2025
 17:50:53 -0800 (PST)
MIME-Version: 1.0
References: <20250121082236.5247-1-liwang@redhat.com>
 <Z4_H15ZITj4QVWea@yuki.lan>
In-Reply-To: <Z4_H15ZITj4QVWea@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Jan 2025 09:50:41 +0800
X-Gm-Features: AbW1kvZIPEY4SIKvYu6LyZXF2fKPJaHWgPWdiexHojeyxpVE2NkqipEprcwX01U
Message-ID: <CAEemH2fSk6mhsu4BOKt3p-EBC=kqnn7YwLBxHZPd3LCzQFDGHQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JKhxmGjgL7W9lpsrBLXbhgMnKjt_1-mQYI5wYrKD8p8_1737510654
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] eventfd06: add AIO support check
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

T24gV2VkLCBKYW4gMjIsIDIwMjUgYXQgMTI6MTTigK9BTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cgo+IEhpIQo+ID4gSnVzdCBsaWtlIHdoYXQgd2UgZGlkIGZvciBpb19z
ZXR1cDAxLmMgdG8gYXZvaWQgRU5PU1lTIGVycm9yOgo+ID4gICBldmVudGZkMDYuYzoxNDA6IFRC
Uk9LOiBpb19zZXR1cCgpIGZhaWxlZDogRU5PU1lTCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogTGkg
V2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICB0ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2V2ZW50ZmQvZXZlbnRmZDA2LmMgfCAyICsrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2V2ZW50ZmQvZXZlbnRmZDA2LmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZXZl
bnRmZC9ldmVudGZkMDYuYwo+ID4gaW5kZXggNzMzOWRkNDcxLi40NmQ3ZjczZDMgMTAwNjQ0Cj4g
PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2V2ZW50ZmQvZXZlbnRmZDA2LmMKPiA+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZXZlbnRmZC9ldmVudGZkMDYuYwo+ID4g
QEAgLTEzNiw2ICsxMzYsOCBAQCBzdGF0aWMgdm9pZCB0ZXN0X3BvbGwodm9pZCkKPiA+ICBzdGF0
aWMgdm9pZCBzZXR1cCh2b2lkKQo+ID4gIHsKPiA+ICAgICAgIFRFU1QoaW9fc2V0dXAoTUFYRVZF
TlRTLCAmY3R4KSk7Cj4gPiArICAgICBpZiAoVFNUX1JFVCA9PSAtRU5PU1lTKQo+ID4gKyAgICAg
ICAgICAgICB0c3RfYnJrKFRDT05GIHwgVFJFUlJOTywgImlvX3NldHVwKCk6IEFJTyBub3Qgc3Vw
cG9ydGVkIGJ5Cj4ga2VybmVsIik7Cj4gPiAgICAgICBpZiAoVFNUX1JFVCA8IDApCj4gPiAgICAg
ICAgICAgICAgIHRzdF9icmsoVEJST0ssICJpb19zZXR1cCgpIGZhaWxlZDogJXMiLAo+IHRzdF9z
dHJlcnJubygtVFNUX1JFVCkpOwo+ID4KPgo+IEFsdGVybmF0aXZlbHkgd2UgY2FuIGFkZCBDT05G
SUdfQUlPIHRvIHRoZSBuZWVkc19rY29uZmlncyBidXQgYW55d2F5czoKPgo+IFJldmlld2VkLWJ5
OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPgoKUGF0Y2ggbWVyZ2VkLCB0aGFua3Mu
CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
