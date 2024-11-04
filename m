Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661A2D132A8
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 10:23:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B95123D0661
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 11:23:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D8153D058D
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 11:23:24 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2E9A9645546
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 11:23:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730715802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GQleUqX9+fbgza1vu01IAtKEaFouYz7VksaA3J45IcU=;
 b=H7XVTGKBh61onsjxRMuOQHVgB6xfOXz72w00aVCbF1akCXV5Y/3cfAAQQ+DtLn0pIlmnUL
 OFThrMp+0iDIAtPg7P/5TAqA30Ape32OW1iUN8m1OeFUoG1aU8WxwN+3vTu8JKYV//nEz6
 pdQPpyFGRb38IG2+dhrsBifyLEiDPNw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-mD-D_L5uOqWSeigs2g049w-1; Mon, 04 Nov 2024 05:23:15 -0500
X-MC-Unique: mD-D_L5uOqWSeigs2g049w-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2e5efb04da7so3981004a91.0
 for <ltp@lists.linux.it>; Mon, 04 Nov 2024 02:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730715794; x=1731320594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GQleUqX9+fbgza1vu01IAtKEaFouYz7VksaA3J45IcU=;
 b=cGe858dyDh5h4LQ1aN77F4h+lX6OPyiynWF8xs3vaW2qYIoJtoI3w9eCyxaBm5hE7n
 aoasxhiEWk52I3U4MMnY9E+EiO4m69PLMRsT/AVKlQQGX/0AZMnarta7hhCl4M8S74EA
 x/b3S3NXi7EWlIsA0zltTAHYca+NeoSLY0eeWcaqzXAgqxaOU/pyCi0+FSji8zdm37rg
 auL5IagNlsY1Xflc1ymObTdtvzsj+Ld1OlsLLZ/5Pfx7DB7He1QJ+gpeRb0WkGqLztCt
 EDDQ4x0qmCoceCwXS4dLwrFEfzyc3oawKyn70ULiORgSvfQB7MrVRuHRYptNtvRueu3R
 X8tQ==
X-Gm-Message-State: AOJu0Yy9UKcEOhCVCYfuxIPVzYQ48E04o8zonECHAF8tMVrxuNxK4Ugp
 ldPFfgBdcEAMH5WMNCNzCT5qAQvQ7w8mSUU+w+m7i7we427XNbgw2NoauKs9l2g3HWhNhATmx3B
 Gne1YjZpg0FosFPuB6xCjhqMRnJJRQMScnRToPAHn1bYStl9Ehf/g3bnLpj027BzDr4wrgfc4eN
 PPh0PF4rQ2RE7vTBU85xZC5ck=
X-Received: by 2002:a17:90b:3ec9:b0:2e2:bf7f:3369 with SMTP id
 98e67ed59e1d1-2e8f105811emr36188681a91.5.1730715794277; 
 Mon, 04 Nov 2024 02:23:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVdmwjue8slV4GO+2Uk5OaEUrkNTencyg4dQwM9TXmlg3S7XrapkIx7W4qU4n5j1dKzp5mEpgwG3VbVKIvT8E=
X-Received: by 2002:a17:90b:3ec9:b0:2e2:bf7f:3369 with SMTP id
 98e67ed59e1d1-2e8f105811emr36188663a91.5.1730715793829; Mon, 04 Nov 2024
 02:23:13 -0800 (PST)
MIME-Version: 1.0
References: <a0c8683d576671c055a4fe5edde45b5232a27660.1730714163.git.jstancek@redhat.com>
In-Reply-To: <a0c8683d576671c055a4fe5edde45b5232a27660.1730714163.git.jstancek@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 4 Nov 2024 18:23:01 +0800
Message-ID: <CAEemH2eC865_SRSYFXWHAxH8pvMAyyWSEFVDh6B02ggCM0VNKA@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lapi/sched.h: don't include itself
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

T24gTW9uLCBOb3YgNCwgMjAyNCBhdCA1OjU34oCvUE0gSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJl
ZGhhdC5jb20+IHdyb3RlOgoKPiBUaGUgaGVhZGVyIGFwcGVhcnMgdG8gYmUgaW5jbHVkaW5nIGl0
c2VsZiBieSBtaXN0YWtlLgo+Cj4gU2lnbmVkLW9mZi1ieTogSmFuIFN0YW5jZWsgPGpzdGFuY2Vr
QHJlZGhhdC5jb20+Cj4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4K
Ci0tLQo+ICBpbmNsdWRlL2xhcGkvc2NoZWQuaCB8IDEgLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBk
ZWxldGlvbigtKQo+Cj4gTG9va3MgdHJpdmlhbCB0byBwb2ludCBJJ20gZG91YnRpbmcgaWYgSSdt
IG1pc3Npbmcgc29tZXRoaW5nLgo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGFwaS9zY2hlZC5o
IGIvaW5jbHVkZS9sYXBpL3NjaGVkLmgKPiBpbmRleCA4ZTc3NDhkNmU4ZDguLjM2ZjFlY2FkOTNj
MiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xhcGkvc2NoZWQuaAo+ICsrKyBiL2luY2x1ZGUvbGFw
aS9zY2hlZC5oCj4gQEAgLTEzLDcgKzEzLDYgQEAKPiAgI2luY2x1ZGUgPGludHR5cGVzLmg+Cj4g
ICNpbmNsdWRlICJjb25maWcuaCIKPiAgI2luY2x1ZGUgImxhcGkvc3lzY2FsbHMuaCIKPiAtI2lu
Y2x1ZGUgImxhcGkvc2NoZWQuaCIKPgo+ICAvKiBzY2hlZF9hdHRyIGlzIG5vdCBkZWZpbmVkIGlu
IGdsaWJjIDwgMi40MSAqLwo+ICAjaWZuZGVmIFNDSEVEX0FUVFJfU0laRV9WRVIwCj4gLS0KPiAy
LjQzLjAKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
