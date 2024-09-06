Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B48CE7AA6
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 01:54:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF2F13C2604
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 03:54:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 499AD3C24E2
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 03:54:13 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 044D21400745
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 03:54:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725587649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s31E3uo3JUoPTni5HhBqaPmI8w0ODiIssGuxPHGMLJI=;
 b=KhUWiokofzWEoeo+9K6GmA57AybafmMssfpSAmfgtPiFqhpjMoVYRMe/DNq/lVNCmliY9r
 K6bRn6OHnRWom333o3ugZes9YdNYsdCzpk8AAvMNJtoBRImgsJNBMKlKeFgwuZ6UjpSqnC
 vwdi/uTtxMDfkTUZYIfbbWJdYWBv0PQ=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-RSuRTCsnNKaq1fIvCXARnQ-1; Thu, 05 Sep 2024 21:54:07 -0400
X-MC-Unique: RSuRTCsnNKaq1fIvCXARnQ-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-710cbc3ddfcso447460a34.2
 for <ltp@lists.linux.it>; Thu, 05 Sep 2024 18:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725587646; x=1726192446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s31E3uo3JUoPTni5HhBqaPmI8w0ODiIssGuxPHGMLJI=;
 b=MvpBJdYCRjDjxCMHpWzree8zc56RpiF9BxGed9qes215HolLjXVOLCbcBUi6aiD7IE
 CDDaiQhrMQEO5Pe1mBkQa4U03gFunzeg+sJtbUwUj3rMW335SM4a2hN1X76c6kMTHr8E
 Q3Nq9Uik6x+8WwL5pso58tgC0AV2ZQiIZqEYbQqBsEwj95XkpZOtr+h3z+4yfNV33sVH
 L9nr4Bnxn7rX30lqSQlM82vPUy5lajBIUBESFmZwVmK0QWylJ1VZ9EVHMc2jSRvFqNAz
 DPdqQVJnUhz1T2iCogBEIEiDj507OqpvX++LjXHDagiUmJURbe/08okNzT7gLAKgOTMq
 QnsA==
X-Gm-Message-State: AOJu0YxXmPAa7/aIbr8DiQeROHzw9cxs1atQXUKaXvIRWO+nhtKFkdJ2
 0jcoZoy8Yl8w5tDsr/5Ml1KSH0F2jcuUxCeI1vKqIG8ud5hoO9HiFZxZL/9+KYA1FIoMpHQZ+9o
 g3MpNH2qp6C4lO+m5hOWBhJW18CP44T0MgvPEDcD+UIgNaMT9c0/ZJZ4tM7tvwewusVy0gE5Il0
 evvIQfnxU6eHaZF7fD4mca/88=
X-Received: by 2002:a05:6358:99a0:b0:1b8:3283:ec6e with SMTP id
 e5c5f4694b2df-1b8386f861amr146227255d.24.1725587646577; 
 Thu, 05 Sep 2024 18:54:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOo7A3Mlr06lbmyfojiYm1+U6wUuHrUdHdlCtyL0TCEK1Hp7X+HP6IIIWMcE0pyRon7czuuwz3S79r+bwuKVo=
X-Received: by 2002:a05:6358:99a0:b0:1b8:3283:ec6e with SMTP id
 e5c5f4694b2df-1b8386f861amr146225855d.24.1725587646098; Thu, 05 Sep 2024
 18:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240905134502.33759-1-mdoucha@suse.cz>
In-Reply-To: <20240905134502.33759-1-mdoucha@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 6 Sep 2024 09:53:54 +0800
Message-ID: <CAEemH2exTL=vtSYk3DvxXM-Hbf9JUwgJrFCsVo+8aUYriGWjsA@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] fallocate05: Check that deallocated file
 range is marked as a hole
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

T24gVGh1LCBTZXAgNSwgMjAyNCBhdCA5OjQ14oCvUE0gTWFydGluIERvdWNoYSA8bWRvdWNoYUBz
dXNlLmN6PiB3cm90ZToKCj4gU2lnbmVkLW9mZi1ieTogTWFydGluIERvdWNoYSA8bWRvdWNoYUBz
dXNlLmN6Pgo+IC0tLQo+Cj4gVGhlIG5ldyBsc2VlayhTRUVLX0hPTEUvU0VFS19EQVRBKSBjaGVj
a3Mgd2lsbCBiZSB1c2VmdWwgZm9yIGRpYWdub3NpbmcKPiB3aHkgdGhlIGZpbmFsIHdyaXRlKCkg
Y2hlY2sgZmFpbHMgd2l0aCBFTk9TUEMuIElmIHRoZSBob2xlIGRvZXNuJ3QgZ2V0Cj4gY3JlYXRl
ZCBhdCBhbGwsIHRoZSBsc2VlaygpIGNoZWNrcyB3aWxsIGZhaWwuCj4KCk1ha2Ugc2Vuc2UhCgpS
ZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgoKLS0gClJlZ2FyZHMsCkxp
IFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
