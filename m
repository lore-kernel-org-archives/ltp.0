Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D67DD4A5EA
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 02:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768531082; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=zzRwy3eRFjtn8YEhrfYjH2szIDdXzJoawNxRvzCQVDk=;
 b=fxY+4ssodaPtUvUMWmrQsSX4brjhzYmQ2mYJb1gXK7a88XwgIavUXxu8R1W/1mNrRhZtp
 qCJ//Ah3nPnfcFrpX2dkl/DOIcjaSi7LBRv4Oow+TqOeUdUS0EeIMNGtmrikuVx/jjxhmIi
 5WbcjdUwCzCzUi085IJ6eXEZrej98Kg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1DA43CA509
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 03:38:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A7B13CA4FB
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 03:37:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BE1B2600A78
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 03:37:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768531056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+m1MF/fqhVaufOy6vbnExgxBZL2o3+5n56p+siRbM4U=;
 b=DvX1O2+p1i6c196OcNju4APNVcGHHYajtkEgUP17uohAeJKQNkdtpjn2lSisccdTgPLuWa
 2aUQbjJfJgeGX+Fx9aw3X3VuwEXtpvOv/LWeuv4r8lRKfllj8iMMaHBmCJb8W37VVO34Mb
 xuH5X21+RFi8ZWhxFpSm3v5RZd1fd88=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-X6f-sXoUMP6mw4IChd7JJg-1; Thu, 15 Jan 2026 21:37:34 -0500
X-MC-Unique: X6f-sXoUMP6mw4IChd7JJg-1
X-Mimecast-MFC-AGG-ID: X6f-sXoUMP6mw4IChd7JJg_1768531054
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b04f8c5e84so1996090eec.1
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 18:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768531052; x=1769135852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+m1MF/fqhVaufOy6vbnExgxBZL2o3+5n56p+siRbM4U=;
 b=W+A1JjKHJkEJHN5o5m3Wjw93tWnivoOWy092YfQzAok1Uez4uYbN5JNtb450LbEvFi
 Y1vuVMmMFPYPR8MH/sg/BPA8K3ib/JmDCA9ncqvaSG43+1SMrisjQ4WB6XEU+cPImJMZ
 RfJcdoUPp55vxrzAFu9XA1faSLjxOu6DoszckN67lq2CD70VY7WTL3f0Wz2jyNWRjmi5
 PNn0543cQ0L243Ask9nA8PVi8kbyaScLaJNMUMyj/aVuixH1es8hQpv9vqo7YHp95Mqq
 ZQJmvBk6plTpb5cpu2zehUihQ0O+T48PC7L6ZCiJLufsNUTiV4NyOSzoaZQCu4uM/TMJ
 NOxw==
X-Gm-Message-State: AOJu0YypCz09WFagiL+StL4ovC3UIBJHqi0MZ+go9X/lkjcvflj7Ih72
 MK7fu0Nnb54CKUhewlXfWrOmghjyvYTiLuvdYMlyfs71vK6w+s/49uTJAe+7FTcl0GEvL/G5mBM
 yRWdDbaTB6wClNqt+KFR4Hzuy5Jn7Fgu+2GcVAcD2B1bnz2oQ7sd5iR/srZQLfe1FdfuQeMfYzt
 HPj8jSiLCcAqp69BGl9CtoM0XgKq11/0pDlotvLw==
X-Gm-Gg: AY/fxX7UlioR41o4tBfCi5quuz6VULBIz2TQ5Ajk3I/1H+rD70XBtW8+0Tx/iJ4gGxa
 PBH1htzB56CCJHeyMszfZy6m47tJV7rCQf/0WoFp6JqwqF4qXQNL7mUDY/BkdWy2LKoT1oHSAsG
 IR5rQpzHHDlcHFTfLQ5s0NJNENoq3Nc8Xg8CdQ86NRJk0lDixMYcxPO9d9BjJzoRynMkI=
X-Received: by 2002:a05:7301:7c0b:b0:2ae:56d7:b02 with SMTP id
 5a478bee46e88-2b6b46c6449mr1523760eec.9.1768531052410; 
 Thu, 15 Jan 2026 18:37:32 -0800 (PST)
X-Received: by 2002:a05:7301:7c0b:b0:2ae:56d7:b02 with SMTP id
 5a478bee46e88-2b6b46c6449mr1523746eec.9.1768531051975; Thu, 15 Jan 2026
 18:37:31 -0800 (PST)
MIME-Version: 1.0
References: <20260115153439.13337-1-chrubis@suse.cz>
 <20260115153439.13337-3-chrubis@suse.cz>
In-Reply-To: <20260115153439.13337-3-chrubis@suse.cz>
Date: Fri, 16 Jan 2026 10:37:20 +0800
X-Gm-Features: AZwV_QjCKSzJtBQt_O8KmJmu-R9eZ1tTLZndnkPsvhszXGxsQXoUPOSgIoV42qA
Message-ID: <CAEemH2eCjTh94itOm7jQ7zbUJ28o6u35iqXuQQpD635FSmkqgw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G31BhezkJBFjl209pOUiCZy28SgefUE4erXTzhVwhnw_1768531054
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc: Add ground rules page
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

PiArV3JpdGUgcG9ydGFibGUgY29kZQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tCj4gKwo+ICtBdm9p
ZCBub25zdGFuZGFyZCBsaWJjIEFQSXMgd2hlbiBhIHBvcnRhYmxlIGVxdWl2YWxlbnQgZXhpc3Rz
OyBkb27igJl0IGFzc3VtZQo+ICs2NC1iaXQsIHBhZ2Ugc2l6ZSwgZW5kaWFubmVzcywgb3IgcGFy
dGljdWxhciB0b29sIHZlcnNpb25zLgoKYW5kIGhlcmUgdGhlICJkb24ndCAiIF4gaXMgYWxzbyBu
b24tQVNDSUkuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
