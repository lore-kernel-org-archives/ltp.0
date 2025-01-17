Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB35C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 08:14:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF9EE3C7C23
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 09:14:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B2683C7B3B
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:13:46 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 44F25257321
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:13:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737101623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eS3TBwF0wuMlBGnLlWHbibWFa/omj/6lVux39Ijzf5Q=;
 b=fRDUDBOhcukGsnLAH+ixX6yTpa5pyE5DwAy6yYGMzK1/4TTQ2g+ms8yIJeaqd5m/wsJxlk
 aUdwoihkKb6fk/ax6yFf1jYYslgHZh1oyioWi44/eub1QzAjZjS2gm6QjXJDd034hmpOV+
 QuJRoOFAFhSo9ooSx92rdb4GsvLzxhM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-m5O09YKkNsq6FarIGHrQ4g-1; Fri, 17 Jan 2025 03:13:41 -0500
X-MC-Unique: m5O09YKkNsq6FarIGHrQ4g-1
X-Mimecast-MFC-AGG-ID: m5O09YKkNsq6FarIGHrQ4g
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef9dbeb848so3647867a91.0
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 00:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737101620; x=1737706420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eS3TBwF0wuMlBGnLlWHbibWFa/omj/6lVux39Ijzf5Q=;
 b=ssq8KfzCiTRxhXggnyIBcsOnKBXtoDlCap6b3M6OUsILCs/TYs7WowdVbL5ps1+pW8
 lImkmFQ+Y6KroWygxZShTThEaJwXCo9sjNblnWAFSvouYrLIq1eGehMP9FHYQifvJjhU
 ZjXXfmmUzwRRdSqrclXlilURQoeptm2a1Yk/mWRng0rR+5lyRPRbw56vp7cgsAKBN/jJ
 a/qua2Sc+kVU29jU418Ij7nR/d6TAzVTkghWWX7ntmAMVCXWnBV4kApIVtS1uDp0uTdT
 468cP6LXIadIUdZ78LAQ3i0v/UTpZ2YjzRVBq7fTbiRC4Hng7BQntxuycbjZrF1Up86i
 DcJA==
X-Gm-Message-State: AOJu0YwpyPzDQPHh6ivsv9MrnRIO6Z0ksocqJ2nOZrFhr/i787HDhDRV
 1K+XYP4t1Z7+ok5v5pugkDevUBBq2i8Azqw37uvgX54YJPp0eLHG7wilZ74ZeluAUFiONn2rWOL
 fezWjsssYr01SoNRQ0qoIcCJeCIZYe6U37+eoJ4UlU4wIsi1lW0fDHvRxV4r8JRaHzkBh7SBWwd
 Q8u8wGVq0eUq/gbuC8X5sPkJM=
X-Gm-Gg: ASbGncvcVzlar0Mki80dXwAFItmTWYS1RJQx6jhgvSi3nqWWpL0fCm8kaaMX7POUdvz
 X0iDmHd6Tqh0jccOAmZL8nj+sCXzmfJwlvChJtHI=
X-Received: by 2002:a17:90b:520e:b0:2ee:44ec:e524 with SMTP id
 98e67ed59e1d1-2f782d8d6a8mr2371560a91.35.1737101620359; 
 Fri, 17 Jan 2025 00:13:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe/YnhPCP+9bNuYew7lec957aViExW4W7qfX5DyQ4dHMBsxEQ7klVFW3uDIjZMWm/IVEdSlihMttiUwX7/SDg=
X-Received: by 2002:a17:90b:520e:b0:2ee:44ec:e524 with SMTP id
 98e67ed59e1d1-2f782d8d6a8mr2371547a91.35.1737101620023; Fri, 17 Jan 2025
 00:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20250117071758.120366-1-liwang@redhat.com>
 <20250117073607.GA731427@pevik> <20250117080454.GD729073@pevik>
In-Reply-To: <20250117080454.GD729073@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Jan 2025 16:13:28 +0800
X-Gm-Features: AbW1kvZsvmqDLOFvzPQoW2fq8XFEqvWFy1clgBVreQ9lZ_WszyEE-_dS4nwCPsg
Message-ID: <CAEemH2e4VnKVHUEKPKsa0LUkx1gGdii_tZxtiqA9TBfd6SBRNA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mzCpswy-58kEylQpCowmhCaLzEL9QcddsogeoRfMYGg_1737101620
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lib: add TST_NO_SLOW_KCONFIG_CHECK macro for
 testcase tools
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

T24gRnJpLCBKYW4gMTcsIDIwMjUgYXQgNDowNeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiA+IEhpIExpLAo+Cj4gPiA+IFRoZSBtYWNybyBUU1Rf
Tk9fU0xPV19LQ09ORklHX0NIRUNLIGlzIGFkZGVkIHRvIGNvbnRyb2wgd2hldGhlcgo+ID4gPiB0
aGUgdHN0X2hhc19zbG93X2tjb25maWcoKSBmdW5jdGlvbiAod2hpY2ggcHJlc3VtYWJseSBjaGVj
a3MgZm9yCj4gPiA+IHNsb3cga2VybmVsIGNvbmZpZ3VyYXRpb25zKSBzaG91bGQgYmUgZXhlY3V0
ZWQuCj4KPiA+IFRoYXQgd2FzIHF1aWNrLCB0aGFua3MgYSBsb3QhCj4KPiA+IEJ1dCB1bmZvcnR1
bmF0ZWx5IHRoZSBwYXRjaCBkb2VzIG5vdCBoZWxwIHRvIGF2b2lkIHByaW50aW5nIFRJTkZPCj4g
PiAodGVzdGVkIG9uIGEgZnJlc2ggY2xvbmUpOgo+Cj4gPiAjIG1ha2UgJiYgLi90c3RfbnNfZXhl
YyAxNDUzNiBuZXQsbW50IHNoIC1jICIgY2F0Cj4gL3Byb2Mvc3lzL25ldC9pcHY2L2NvbmYvbHRw
X25zX3ZldGgxL2Rpc2FibGVfaXB2NiIKPiA+IENDIHRlc3RjYXNlcy9saWIvdHN0X25zX2V4ZWMK
PiA+IG1ha2VbMV06IE5vdGhpbmcgdG8gYmUgZG9uZSBmb3IgJ2FsbCcuCj4gPiB0c3Rfa2NvbmZp
Zy5jOjg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmlnICcvcHJvYy9jb25maWcuZ3onCj4g
PiB0c3Rfa2NvbmZpZy5jOjY2NzogVElORk86IENPTkZJR19MQVRFTkNZVE9QIGtlcm5lbCBvcHRp
b24gZGV0ZWN0ZWQgd2hpY2gKPiBtaWdodCBzbG93IHRoZSBleGVjdXRpb24KPiA+IDAKPgo+ID4g
TWF5YmUgaXQncyBiZWNhdXNlIHNhZmVfY2xvbmUoKSB0cmlnZ2VycyBpdD8gT3Igd2hhdCBhbSBJ
IG1pc3Npbmc/Cj4KPiBUaGUgcHJvYmxlbSB3aHkgaXQgZG9lcyBub3Qgd29yayBpcyB0aGF0IGl0
IHVzZXMgbGliL3RzdF90ZXN0Lm8gdmlhCj4gbGliL2xpYmx0cC5hLCB3aGljaCB3YXMgY29tcGls
ZWQgd2l0aG91dCBUU1RfTk9fU0xPV19LQ09ORklHX0NIRUNLLgo+CgpSZWFsbHk/IEhvdyBkb2Vz
IHRoYXQgVFNUX05PX0RFRkFVTFRfTUFJTiB3b3JrPwpSZWFkaW5nIHRoZSBjb2RlLi4uCgoKCj4K
PiBJTUhPIFdlIGNhbm5vdCBlYXNpbHkgc29sdmUgdGhpcyB3aXRoIHByZXByb2Nlc3NvciBkZWZp
bml0aW9uLgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+ID4gS2luZCByZWdhcmRzLAo+ID4g
UGV0cgo+Cj4gPiA+IFRoaXMgYWxsb3dzIHRlc3QgY2FzZXMgYW5kIHRvb2xzIHRvIG9wdCBvdXQg
b2YgdGhpcyBhZGRpdGlvbmFsCj4gPiA+IGNoZWNrLCBlbmFibGluZyBtb3JlIGZsZXhpYmxlIGFu
ZCBmYXN0ZXIgdGVzdCBleGVjdXRpb24gaW4KPiA+ID4gY2VydGFpbiBzY2VuYXJpb3MuCj4KPgoK
LS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
