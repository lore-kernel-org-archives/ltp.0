Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2038CD6E55
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 21:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780521785; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=F9JlfhnUckz4CNKPYr4ZCn7wsHcBFyMPxli7AM7xglU=;
 b=lmgDRwPD5aTRgGhC3M4SMCp8Sqpm1AtQuhriubCmf2gZW6hu6uwG2UybFvF89PIfyqYYy
 oPwRn+Xcmim7x9um3nyhcOkKOBaigxFShHxfYz1TR/nrHA9/GuapyOAdC4aIACDfDx35DTd
 ZJGxHIYeaUszxy80qf7NCb843iD2xEQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93D023E486B
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 23:23:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E46E3E1B49
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 23:22:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E0BAC200767
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 23:22:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780521759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yUZ6j7tTWV0It8l4Eb+9UrjgtVi6R4fAATCgT/hzV3g=;
 b=Ff9Me0XOGOOV19tLEOqFAc5dl6Q+kQ+/VwGPq/3y5kPOPUIb1A0swCDphMO6/5HpRb1eii
 uIm1vH9HHpOoN8FmfAPvYwiXMSqplRVGhtPWKNfgvqLWTfs+YZeycX7UTkdwaQsN2QWcUR
 4hKgib9LfGA8RcMsalH8FWEDwDPjafQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-mHFwg_8aMtiGl_H1o9XJ7Q-1; Wed, 03 Jun 2026 17:22:38 -0400
X-MC-Unique: mHFwg_8aMtiGl_H1o9XJ7Q-1
X-Mimecast-MFC-AGG-ID: mHFwg_8aMtiGl_H1o9XJ7Q_1780521757
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45ef6b407b4so2297123f8f.1
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 14:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780521757; x=1781126557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yUZ6j7tTWV0It8l4Eb+9UrjgtVi6R4fAATCgT/hzV3g=;
 b=TVzCTRpWHfyLKqlaF2EpP1VHIosYmsQFL+WZTDG5zWDNev2+lUI9b2Lpklb6yXOuvq
 Ys/jyfOrHSQFJ5DI+L/8ZbrwGSlmx/279t88Ytz+M0Ll9c7mtRzt2d1m084my5JTlG4M
 3qJXXp08gKXa8Qq0sfsnRrDVgwKE0HNGb31ix4YpcAh1wi7bT6m1jinEu5OnmZJHT9OH
 PlQ0qHdRp2WNf+fA+eoQGQwttrB8eGt5qkJgQ74jlbTQWAvC7/3WRbzRMVMzs4LSgurz
 6mAzAsGb6Q/2q9F6oneVGTu3zH/Z8OiVBbWprainL6l6ndKBDew7mTupz6I8tVmytlep
 RTWg==
X-Gm-Message-State: AOJu0YwkusabEkowonI+nGdhOLzUgt5Npd3mJp/cGTjGq2OdQCbn2CP3
 4sVKglwrZMcyMnsaOoidfumnGbY6pOf87KFRvjczj/O684TYeRXxJKz2w/G2qCoQCw5CRMv7sA8
 Xan+tiaUGYWDKOuTSToiHZclEg/Uzt7BEGHr3hWt69gB2N1VQUh5BBH2jkzdi5/yFHRydQxoxzK
 Ju5KAqIt7Yi6pobe5iz4mYY7Enlns=
X-Gm-Gg: Acq92OH74LY9VPTAp9PTuTEzDhHphiGdaWfZKE01pTeW5p7WTN5UcVhIF6HOA3Yv2rm
 gaUAPQOrxDMOPBpIZHFMg+Ap+F12rEl1opKnmO3D+RtlHOf/EnE6VJQ4GjTBdu+9GVtW76lKUDN
 A/Rj+ddBpZUBiu9MdHqltQH3xoyKLBG6NKF+37aBY+tgLj1Bv63xtt+qIrDFw1q3M7p03had4Hg
 YYNb2WxbjzYk/Q=
X-Received: by 2002:a05:6000:2408:b0:45e:b2b7:1863 with SMTP id
 ffacd0b85a97d-460217ef094mr7758452f8f.16.1780521756809; 
 Wed, 03 Jun 2026 14:22:36 -0700 (PDT)
X-Received: by 2002:a05:6000:2408:b0:45e:b2b7:1863 with SMTP id
 ffacd0b85a97d-460217ef094mr7758421f8f.16.1780521756451; Wed, 03 Jun 2026
 14:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260530-gitignore_ltp_agent-v1-1-e8812d8de8c5@suse.com>
In-Reply-To: <20260530-gitignore_ltp_agent-v1-1-e8812d8de8c5@suse.com>
Date: Wed, 3 Jun 2026 23:22:20 +0200
X-Gm-Features: AVHnY4LT4sRVny4vE8ATQIxBdOjWtGR1E2nsSiwwZmz9i1c8wTEVaW1RAE3j4E0
Message-ID: <CAASaF6y7ub0XFU3Cf66=_ztNWAhWVRuxWJGx6on=jaMLJSpJEw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EO2giy6bDPCIgRaPo9_smhLQCpL6pEjAD_VaoqHyHHg_1780521757
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] gitignore: ignore ltp-agent setup files
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Q2FuIHlvdSBlbGFib3JhdGU/IFdvdWxkbid0IGJldHRlciBwbGFjZSBmb3IgaXQgYmUgeW91ciBy
ZXBvLXNwZWNpZmljCmlnbm9yZSBsaXN0PyAoLmdpdC9pbmZvL2V4Y2x1ZGUpCgpPbiBTYXQsIE1h
eSAzMCwgMjAyNiBhdCA5OjMy4oCvQU0gQW5kcmVhIENlcnZlc2F0bwo8YW5kcmVhLmNlcnZlc2F0
b0BzdXNlLmRlPiB3cm90ZToKPgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2
ZXNhdG9Ac3VzZS5jb20+Cj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRy
ZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+IC0tLQo+ICAuZ2l0aWdub3JlIHwgOSArKysrKysrKysK
PiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhLy5naXRp
Z25vcmUgYi8uZ2l0aWdub3JlCj4gaW5kZXggZjEwY2QwYzgwZTM2NTVhZDcyMGU0NjVmNDdjMTJh
ZDBkNTFlN2NkMS4uNjE1NzRiMWE0MTc0NWI2ZDhhNjg3NTlmZDQzOTdlNTIwMWJhZGMzMSAxMDA2
NDQKPiAtLS0gYS8uZ2l0aWdub3JlCj4gKysrIGIvLmdpdGlnbm9yZQo+IEBAIC02MywzICs2Mywx
MiBAQCBjb21waWxlX2NvbW1hbmRzLmpzb24KPgo+ICAjIGFkZGVkIGJ5IHNjcmlwdHMvY2hlY2tw
YXRjaC5wbAo+ICAuY2hlY2twYXRjaC1jYW1lbGNhc2UuKgo+ICsKPiArIyBsdHAtYWdlbnQgc2V0
dXAKPiArQUdFTlRTLm1kCj4gK0dFTUlOSS5tZAo+ICsuYWdlbnRzCj4gKy5jbGF1ZGUKPiArYWdl
bnRzCj4gK2xpbnRlcgo+ICtza2lsbHMKPgo+IC0tLQo+IGJhc2UtY29tbWl0OiA1Y2NmODE2ZjVk
MGU2YzBlYzNkODA4YmU0NTZkZDlmZmEyYTc3MzZkCj4gY2hhbmdlLWlkOiAyMDI2MDUzMC1naXRp
Z25vcmVfbHRwX2FnZW50LTBjN2MxMzdiNjE1Ngo+Cj4gQmVzdCByZWdhcmRzLAo+IC0tCj4gQW5k
cmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPgo+Cj4gLS0KPiBNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgoKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
