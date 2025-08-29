Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1A0CA0FF9
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 13:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756472486; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=C8X1O8xlWX3mXqUvLZwWWOBoYTeHY81mNTYY+de2L9M=;
 b=SGVi5Lwj8s77BMmP+qrZayUz0vVtQl89OEO+bup7/GzIGHqwDoMvYgO27xwKeHjssD1ss
 n78vQgiFxn9D6UXIbaj2b4sSG2BIdks/DqfeokyWjoetEWVEwO6vFPgwVPKnbHN5eCvWqaG
 xC2fVnbkZHZCG6H7oLzQulD8AsVwTF8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C41ED3CD191
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 15:01:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 677793CD13C
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 15:01:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D367C100092C
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 15:01:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oLn+Pyq4S4ck6rRxm0hj1ZsS6fppYtDjMydFbToV2XY=;
 b=QVMWNG2t+FBL5Tz656TCV0V9tdAOjcPGeRsk1Qnp+OVwzYqpw+qRCOFFTKW3yctVKLGgVe
 ZpE/lOqiceabVrHaUTEztxojTODl3UBcLQhv4QqCYS1ExW07HHr+gzB6UJFdPX9coipRwJ
 hHM/dfLgxg/gv4b4ny0OfI+JKh9mvF4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-rc8x9j4WM12bDW5pk-j4zg-1; Fri, 29 Aug 2025 09:00:59 -0400
X-MC-Unique: rc8x9j4WM12bDW5pk-j4zg-1
X-Mimecast-MFC-AGG-ID: rc8x9j4WM12bDW5pk-j4zg_1756472458
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24457f59889so22270275ad.0
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 06:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472457; x=1757077257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oLn+Pyq4S4ck6rRxm0hj1ZsS6fppYtDjMydFbToV2XY=;
 b=KdS3Z3BUw0F7r5nRk//R/lF2e0uljrdI/CmnjbP+2ORGaajCEghzirBBTWT+mQw91S
 Ed6UXpa0pr1UCKa4/d5zBIpukjQ+aSLVAEmVD28QdAsutWDy27/7deOZOW251WE7+Z7q
 ww5DVX0UCycNDqlh5RqLW5lw2vG/yGeH/Px0qrdIgcacOllPMZyTtk2E+kAz0SIkQwiV
 RfQrJ3N0jWyF3Cn0deY7CLn8iayi4KXh8LZuEXfht21pxsVnSezEoOfa9rB6dmW92J8R
 5nskDdKicn1MNInyDubiFQMEXE84sMNetmMerKvX2+ijYavxl8kbPtcxRavQdnu3ai3X
 vdsg==
X-Gm-Message-State: AOJu0Yxz442L4uerJz/XDt0DjGtsNvGElDbpRPncMlGD1OxrbFX74zF0
 OZmrBN8Dr1IHojBCUKnZYS/1pHTAY107l7LNGeGnnQOx7FEdfNMo87mDvVYxCbUgvyZRzNilZQr
 4fVM9CtNneysCMyxw7iTJ4Q40WOAg5QsmjwS3stDSM8RjDhxgmYbfRS12BjwJszyDsHDQ2ORq4c
 kAFGfjWl8wEe8ObPlhHi3i8WIZ/FPsu6Wr7+AAxA==
X-Gm-Gg: ASbGncthYFYycXIn/y2YAilHQsCn4pEOHqCPGOUpmzzEDPfknsbph7CUkrCNcY2LLYK
 kTkIkpzGQH3UW9hgFIL4G02Y+ErL+mmqlzsTz7yqbQDpShGiCTf2JFrAIdxeCi7AyJZ2j3vZJUl
 3vkhZuqvjUxAxEQDbplT2Csg==
X-Received: by 2002:a17:902:fc4c:b0:249:3381:96c0 with SMTP id
 d9443c01a7336-249338229fbmr625655ad.37.1756472457248; 
 Fri, 29 Aug 2025 06:00:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDJXO5SYpwCcasmXL9zDAwxD4yhLTs4aiP3iVv+vrxR5bkblCPp19v34rG6MFyN3c9ISNZq0m6+w50oQIHAIw=
X-Received: by 2002:a17:902:fc4c:b0:249:3381:96c0 with SMTP id
 d9443c01a7336-249338229fbmr624395ad.37.1756472456192; Fri, 29 Aug 2025
 06:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250630153205.19017-1-chrubis@suse.cz>
In-Reply-To: <20250630153205.19017-1-chrubis@suse.cz>
Date: Fri, 29 Aug 2025 21:00:44 +0800
X-Gm-Features: Ac12FXxDF2azePlcMWcvEyPnaFwnGx4P0nw4DXiec1rNsLNPPPPKa3lTgzDZACw
Message-ID: <CAEemH2fVbtpMht7kDEGpT-fS+PH_qX9sOytZkFFpxjUnNxZAiA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5i8uydhdAQpO-k4wCLHUuZucsQ8r58_3ErOZtosV2cQ_1756472458
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] lib: Add is_fuse flag to SAFE_MOUNT() and
 tst_device
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

T24gTW9uLCBKdW4gMzAsIDIwMjUgYXQgMTE6MzLigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cgo+IFRoaXMgYWxsb3dzIHVzIHRvIGFkanVzdCB0ZXN0cyB0aGF0IG5l
ZWQgZGlmZmVyZW50IGV4cGVjdGF0aW9ucyBvbiBGVVNFCj4gYmFzZWQgZmlsZXN5c3RlbXMuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPgoKUmV2aWV3
ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKCi0tIApSZWdhcmRzLApMaSBXYW5n
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
