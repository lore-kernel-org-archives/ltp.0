Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AAAC433F5
	for <ltp@archiver.kernel.org>; Sun, 12 Dec 2021 03:23:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0386A3C8852
	for <ltp@archiver.kernel.org>; Sun, 12 Dec 2021 04:23:31 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C62043C1D8F
 for <ltp@lists.linux.it>; Sun, 12 Dec 2021 04:23:20 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 126151A00CDC
 for <ltp@lists.linux.it>; Sun, 12 Dec 2021 04:23:20 +0100 (CET)
Received: by mail-pj1-x102e.google.com with SMTP id
 nh10-20020a17090b364a00b001a69adad5ebso10650474pjb.2
 for <ltp@lists.linux.it>; Sat, 11 Dec 2021 19:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:subject:mime-version:from:in-reply-to:cc
 :date:message-id:references:to;
 bh=aWmVkGYm/Hbc/drqIbTnuHJB4Gd4mOKfDFaTu3AxVtc=;
 b=qsRS0xB6Z9pHjZLb3aYb8pDeCrf2BeA5PpWdqRwXYlNtyE0nB3OL/dCaLO6iumCnGN
 OFcHOh52d9BAR6yYax7kobdAXJxp4lfj59x7fZJ0yr3WAyVoEesnoQJDQZ6XcNFSrX2Q
 y+fp0UcLLp/T+6lQN0Tk+6c9KsBFAerVS8g714a3L06tHHtsjJQZyhHL4ESPQ7ZTRcUz
 05wwq1W0XZ+Jbo1DXkR2mT7P90KSN4dWVXyqM0MKj1pADzePstCZLEVbgGY7NNdQS5qR
 hybEobx4k6j3w+dlSEO49fuv7RaEEHdv9fyoRXGuNq+fCZ0jGf6b4A6sHtpx6bRwVNT2
 qE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:content-transfer-encoding:subject:mime-version
 :from:in-reply-to:cc:date:message-id:references:to;
 bh=aWmVkGYm/Hbc/drqIbTnuHJB4Gd4mOKfDFaTu3AxVtc=;
 b=EV5YY6DBV3qPSgKqTWHjK52NqllZ9Y+XnGboT9n/qRZJjSch09ntaDsFHV1eIYov7P
 anYbsnGOXfAwqzHdtoZ225oYrVbnIp+LMM2LojF70WVE3Q2crEvxc/xV2KpGrJ/rBFAH
 3adaHVas1GC3lnd+yudx2QhZC2ccbTfUsJNQ0xxrMs60Gi6AkLNM8SwpuA6obbmJBz7n
 WGoZ3eBgbG/b5uCk/O7WDND8dCUTAKnBY7QH2zXMRs/rGEBgJQjMClwvYeUKOdzm/3xp
 5kptORnbvO4fJcGoINT8C9FC8iSUHPX6WkEBqJpjLWpeQkW47OIZglKCFJFw7DNIjcZd
 YGmA==
X-Gm-Message-State: AOAM53071zQRlQIMYagOiVaH3P0kWgE6mH3UDMQpGavVZ5g+Vz/iDyc9
 aUCH6RT7sJ09QLX3HUZshqM=
X-Google-Smtp-Source: ABdhPJyS91HolR7htNyAxHDS1+ext7YDFXK+j3HaDB2N5meq6ecXGYtKnZppzkxJrntquunX/8Tq4g==
X-Received: by 2002:a17:90b:1644:: with SMTP id
 il4mr34905071pjb.39.1639279398401; 
 Sat, 11 Dec 2021 19:23:18 -0800 (PST)
Received: from smtpclient.apple (c-73-19-52-228.hsd1.wa.comcast.net.
 [73.19.52.228])
 by smtp.gmail.com with ESMTPSA id v19sm2989132pju.32.2021.12.11.19.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Dec 2021 19:23:17 -0800 (PST)
Mime-Version: 1.0 (1.0)
X-Apple-Notify-Thread: NO
X-Universally-Unique-Identifier: 6003D6CE-9DF0-48F5-978F-78A89D008180
From: Enji Cooper <yaneurabeya@gmail.com>
In-Reply-To: <YbTYI2iKkopqLIjx@vapier>
Date: Sat, 11 Dec 2021 19:23:16 -0800
X-Apple-Message-Smime-Encrypt: NO
Message-Id: <FB9939BA-DAB2-436A-B000-E5264956EFB6@gmail.com>
References: <YbTYI2iKkopqLIjx@vapier>
To: Mike Frysinger <vapier@gentoo.org>
X-Mailer: iPhone Mail (19B81)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/maintainer: Add policy for new
 functionality
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Xiao Yang <yangx.jy@cn.fujitsu.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cgo+IE9uIERlYyAxMSwgMjAyMSwgYXQgMDg6NTUsIE1pa2UgRnJ5c2luZ2VyIDx2YXBpZXJAZ2Vu
dG9vLm9yZz4gd3JvdGU6Cj4gCj4g77u/T24gMTEgRGVjIDIwMjEgMTY6MTksIFBldHIgVm9yZWwg
d3JvdGU6Cj4+Pj4gU3VnZ2VzdGVkLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4K
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPj4+PiAtLS0K
Pj4+PiBkb2MvbWFpbnRhaW5lci1wYXRjaC1yZXZpZXctY2hlY2tsaXN0LnR4dCB8IDMgKysrCj4+
Pj4gMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+PiAKPj4+PiBkaWZmIC0tZ2l0IGEv
ZG9jL21haW50YWluZXItcGF0Y2gtcmV2aWV3LWNoZWNrbGlzdC50eHQgYi9kb2MvbWFpbnRhaW5l
ci1wYXRjaC1yZXZpZXctY2hlY2tsaXN0LnR4dAo+Pj4+IGluZGV4IGM3YmI0NzgxMC4uNGUyYjI2
N2FjIDEwMDY0NAo+Pj4+IC0tLSBhL2RvYy9tYWludGFpbmVyLXBhdGNoLXJldmlldy1jaGVja2xp
c3QudHh0Cj4+Pj4gKysrIGIvZG9jL21haW50YWluZXItcGF0Y2gtcmV2aWV3LWNoZWNrbGlzdC50
eHQKPj4+PiBAQCAtMzQsNiArMzQsOSBAQCBOZXcgdGVzdCBzaG91bGQKPj4+PiAgIEdQTC0yLjAt
b3ItbGF0ZXI7IHRoZSBsaWNlbmNlIGZvciB0ZXN0IChlLmcuIEdQTC0yLjApIHNob3VsZCBub3Qg
Y2hhbmdlCj4+Pj4gICB1bmxlc3MgdGVzdCBpcyBjb21wbGV0ZWx5IHJld3JpdHRlbgo+Pj4+ICog
T2xkIGNvcHlyaWdodHMgc2hvdWxkIGJlIGtlcHQgdW5sZXNzIHRlc3QgaXMgY29tcGxldGVseSBy
ZXdyaXR0ZW4KPj4+PiArKiBUZXN0cyBmb3IgbmV3IGZ1bmN0aW9uYWxpdHkgaW4gbWFpbmxpbmUg
a2VybmVsIHNob3VsZCBiZSBtZXJnZWQgYWZ0ZXIgZmluYWwKPj4+PiArICByZWxlYXNlIG9mIGtl
cm5lbCB3aGljaCBjb250YWlucyB0aGF0IGZ1bmN0aW9uYWxpdHkgKGl0J3Mgbm90IGVub3VnaCB3
aGVuIHRoZQo+Pj4+ICsgIGZlYXR1cmUgZ2V0cyBpbnRvIHJjMSwgYmVjYXVzZSBpdCBjYW4gYmUg
cmV2ZXJ0ZWQgaW4gbGF0ZXIgcmMgaWYgcHJvYmxlbWF0aWMpLgo+PiAKPj4+IFNvdW5kcyByZWFz
b25hYmxlIHRvIG1lLCBidXQgaWRlYWxseSB0aGlzIHNob3VsZCBiZSBhY2tlZCBieSB0aGUgcmVz
dCBvZgo+Pj4gdGhlIG1haW50YWluZXJzLgo+PiAKPj4gU3VyZSwgdGhpcyBjYW4gd2FpdCA6KS4K
PiAKPiBzZWVtcyBmaW5lCgpBQ0sKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
