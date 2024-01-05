Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3F3C47074
	for <ltp@archiver.kernel.org>; Fri,  5 Jan 2024 02:47:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4286B3CE72C
	for <ltp@archiver.kernel.org>; Fri,  5 Jan 2024 03:47:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33B103CC136
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 03:46:49 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 063CB14000E1
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 03:46:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704422807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G2uDzeq/7ONBgKFcRDwU/vBIepZ7xHTZnlbF9nlmzrE=;
 b=Dp4jDVSV++6dgXoT8x9gs3n++yOHzrwRuAi50QsWqInSCClDGfCyGe47KHQJ9cQXTWk/J7
 U8b5uRSUwEeHQcnMYcRi2qGtrJj0hZrqQE7MavNCmUyocrbYSD4gUR1ynCgt7tXvLcXm4x
 LiHo2X8n2dklhU+S4N0XUfTzRcF0HMo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-YsJ5kRb7N0eNJ4yNZtWXSQ-1; Thu, 04 Jan 2024 21:46:46 -0500
X-MC-Unique: YsJ5kRb7N0eNJ4yNZtWXSQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ccbfa17001so8851591fa.2
 for <ltp@lists.linux.it>; Thu, 04 Jan 2024 18:46:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704422803; x=1705027603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G2uDzeq/7ONBgKFcRDwU/vBIepZ7xHTZnlbF9nlmzrE=;
 b=ezo/bL+nWsRNoqWxK6fGOD0LjHi7YDsfNLxUHjxRrH/9OSKPguQQLsI72kQH3h007P
 lNCBNgcdB6GnrkyeqrITNLcj0Lya43XmfI8i8C/WyckVsngv+ppO1Wo1cj5LvYS3Aodn
 G7VLohK/kP4RuwwKmv4PsmP1OXY2vbvDTr5bOPhmrHsxc3CcpjRKa+3N5d8yQIxibWzj
 bfuNhiidDFjVW1FZGpaqWFz9GMI0sQw95aKW27o1h6Xv+N63VZRHLw1/JfaIEXsftS3x
 e5ZWm5Cq7Iz60JxFA5qhExoD4YfPz4jl8uQwEsSez13q6NopV8CEIg5OrWaDiPvbudZi
 sQBA==
X-Gm-Message-State: AOJu0YzBSsxxHsiHkY1dgXPdje0YQg7aMzBv9ludDjDo2/9yOuSo98HN
 vWxhIFX45jrmF363iiaF+0i+k7TAyWGxJeMd7Xuv1YzWSR5blJuyscSyJNJOCneBPqGMEkelc0W
 C1fyxlM5WKkCtgyH2+Cr+B9vo9/FBdpvwBH5ljsjQwxLRqBWWjBg=
X-Received: by 2002:a2e:b010:0:b0:2cc:eb95:684f with SMTP id
 y16-20020a2eb010000000b002cceb95684fmr626514ljk.52.1704422803617; 
 Thu, 04 Jan 2024 18:46:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENMr/MFwN4pnGK/PiurU5O51h9o84A6UrsiSu4QquqvDXV//UMAKslDBHqYPkDEjCtyTJ9mYp6HRXEt04n6uw=
X-Received: by 2002:a2e:b010:0:b0:2cc:eb95:684f with SMTP id
 y16-20020a2eb010000000b002cceb95684fmr626509ljk.52.1704422803347; Thu, 04 Jan
 2024 18:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20240104154953.1193634-1-pvorel@suse.cz>
In-Reply-To: <20240104154953.1193634-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 5 Jan 2024 10:46:31 +0800
Message-ID: <CAEemH2f82SBAMYSrFVt8krkMocdZKKh0edYQmC=nC0u67bE+JQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] MAINTAINERS: Update LTP maintainers
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
Cc: Mike Frysinger <vapier@gentoo.org>,
 Stanislav Kholmanskikh <stanislav.kholmanskikh@bell-sw.com>,
 linux-kernel@vger.kernel.org, Wanlong Gao <wanlong.gao@easystack.cn>,
 Andrew Morton <akpm@linux-foundation.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKYW4gNCwgMjAyNCBhdCAxMTo1MOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKClRoZXJlIGFyZSBtb3JlIHBlb3BsZSB3aXRoIGdpdCBwdXNoIHBlcm1pc3Np
b25zLCBidXQgd2Uga2VlcCBvbmx5IHBlb3BsZQo+IHdobyBhY3R1YWxseSBkaWQgcmV2aWV3IGFu
ZCBtZXJnZSBwYXRjaGVzIGxhc3QgeWVhci4KPgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwg
PHB2b3JlbEBzdXNlLmN6Pgo+CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+CgoKZm9yIHRoZXNlIGludGVyZXN0ZWQsIGFjdGl2ZSBjb21taXR0ZXJzIGZvdW5kIHdpdGg6
Cj4gZ2l0IHNob3J0bG9nIDIwMjMwMTI3Li4KPgo+IFlhbmcgWHUgaXMgc3RpbGwgYWN0aXZlIGFz
IHJldmlld2VyIChsYXN0OiAyOCBOb3YgMjAyMykuCj4KCisxIFlhbmcgd29ya2VkIHRpcmVsZXNz
bHkgdG8gZG8gbXVjaCB3b3JrLiBUaGFua3MhIQoKCj4gUmljaGllIGFubm91bmNlZCB1cyBrbm93
IGluIHByaXZhdGUgZW1haWwsIHRoYXQgaGUgd291bGQgbm90IGJlIGFibGUgdG8KPiB3b3JrIG9u
IExUUCBhbnkgbW9yZSBkdWUgam9iIGNoYW5nZSwgdGh1cyBJJ20gbm90IGFkZGluZyBoaW0uCj4K
Cgo+IFRoYW5rcyBSaWNoaWUsIHlvdSBkaWQgYW1hemluZyB3b3JrLCB5b3VyIGNvbnRyaWJ1dGlv
biB3aWxsIGJlIG1pc3NlZCEKPgoKVGhhdCdzIHRydWUsIFJpY2hpZSBpbXByZXNzZWQvdGF1Z2h0
IG1lIHdpdGggYSBsb3Qgb2YgZXhjZWxsZW50IHRob3VnaHRzCmFuZCBjb2RlLgpUYWtlIGNhcmUg
YW5kIGhvcGUgeW91IGFyZSBiYWNrIHNvbWVkYXkuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
