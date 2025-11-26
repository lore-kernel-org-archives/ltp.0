Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB0DD10384
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 07:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764142715; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=TWnD8yQUMONSJbSZQRhakCkjED6qNZni5P1l7XoZ84k=;
 b=lY4aRk5zoO8/qoGWFjgG2AJLYvkqSjpkt0siYQ9t6Fh8EC9q4hqJjMCGMOE895nqwjT1A
 EbO/n61v7MFOeMKEOyYBbkFa0CQXeTpSPki/CKWwfhh8S8VFVcNGD1lKyFQcoJTvQrOwy3s
 jDGIkwVeWifD3rpwOH4XBNHt81cK+Hk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30B733CF2B9
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 08:38:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDC823C0FCA
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 08:38:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2A1F71A00997
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 08:38:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764142689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gDNcfs+NJ5PSqOvxRzlj7ySadfRHjT1iCy+KMWxhmuw=;
 b=YaLtO88eeYSjGgRePG1TdLcsuZnugPYduHQOFZu5thNAHk5kFXoAxnFHNRb/tM3uodXNgt
 +tfxugSe/SzVb/wHT4qOMRUoQP2NYWSfmOtAg2K9eNbepCnmia4Sisjdy+orX+ec+O0G/7
 lqoPBnztNrEn1AYxTZMFoyETn1AXUTM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-bns6DkLTNzqRrhMjwBMPXw-1; Wed, 26 Nov 2025 02:38:06 -0500
X-MC-Unique: bns6DkLTNzqRrhMjwBMPXw-1
X-Mimecast-MFC-AGG-ID: bns6DkLTNzqRrhMjwBMPXw_1764142686
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b993eb2701bso6154813a12.0
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 23:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764142686; x=1764747486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDNcfs+NJ5PSqOvxRzlj7ySadfRHjT1iCy+KMWxhmuw=;
 b=ggNEkAFy2xd/ALzBVgE2cK8UjatI5hgYcZoK03pTVyL4FKXFYatgaCb4DfSqauSS0G
 +QAHd24Z+xO9o2jl/6Lveh2L8fHiiUTYoDmWLFGmpMcrtVXdpDlaSRmuyfFojrGCq6vx
 HE6+Lts15tltPLjOO4MUPTiEGuDfaOuK9HN0D6U9kr1q5GvtCOapTT6t43pL3vVeBBdI
 HiI8/gmmvZv/w7+qriZez5PmXVm1fMz7bUvnZg1ZVIyqKQPxVVdqwBFaWEMuMsJAUhVM
 +bDq0d+nL5BRlYuk0KrQ1u7x72/Bx6XTGvsw1avpEITIc+qN4Zdr4M4RwP3Dp5+8Xru9
 44Bw==
X-Gm-Message-State: AOJu0YxMfLWb6avapDDVZRs8zzBGnocqvYKXqRZbSyDIgu1KtBbqNJ+X
 uNfiKpHJM6WhR4YaylXb3QbTVMEH4APsiLzMjGtErLiU11AT6jii7QLoqwukK76dl9wJdxgtOvJ
 cTJPxYh3ynrgm1L9CC2KrxGt0uOV7FWGkSZAST3rOSIOoKnQrHI4kGGQsXNgCbHIhBqxuyBlD1l
 Mb768Vt4V6B2QWBKWkymXDKgqgcCs=
X-Gm-Gg: ASbGncvmEGZ+ndRfNFRyrl5QTb/BfOXmWfyzXC3M7f/Y8hRb/i8QkAYQg3q3pU19BfB
 taA7rP2tOPT5vt8NDpGZvinJi5pXcKynP5nsc7oC/9t5lsjiPaqIIGGr82UqNsEt7BVjJet2jNl
 +Zp7MOodixwfn/UkFn/NVSszq/9xhJgt9Bx2mTpzk2u8FSj30u7GRYox1IFPYScwujv2Y=
X-Received: by 2002:a05:7022:fa0:b0:119:e56b:98ba with SMTP id
 a92af1059eb24-11cbba5232bmr4747599c88.33.1764142685558; 
 Tue, 25 Nov 2025 23:38:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/jyhEPe1Zx9r22PZpzkR9pr/ATNJr0ltvepFmRLoKmEysxpkDHMWcv1efNyKkOGZBbjpi2YzT+JFNhyNXMmM=
X-Received: by 2002:a05:7022:fa0:b0:119:e56b:98ba with SMTP id
 a92af1059eb24-11cbba5232bmr4747581c88.33.1764142685155; Tue, 25 Nov 2025
 23:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20251124131335.5009-1-chrubis@suse.cz>
In-Reply-To: <20251124131335.5009-1-chrubis@suse.cz>
Date: Wed, 26 Nov 2025 15:37:53 +0800
X-Gm-Features: AWmQ_bnDUBqXN2ZgHr0N61XvaD_alBrGIcwZQAsYNYwjib39glLruXJFnHdqado
Message-ID: <CAEemH2dJSt51Xwt-GfqM=ZrmAybrxJptV2_15miAjMdHoQYEXA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eJifzeQJbQ06o57hO0DaLg9heD5LjrGBcwSjEHEA0yI_1764142686
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] syscalls/readahead02: Wait for the readahead()
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
Cc: Amir Goldstein <amir73il@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBOb3YgMjQsIDIwMjUgYXQgOToxM+KAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gVGhlIHRlc3QgZGlkIHJlcXVlc3QgcmVhZGFoZWFkIG9uIGEgZmls
ZSBhbmQgdGhlbiBpbW1lZGlhdGVsbHkgdHJpZWQgdG8KPiBhY2Nlc3MgdGhlIGRhdGEgYW5kIG1l
YXN1cmUgaWYgcmVhZGFoZWFkIHNhdmVkIEkvTyBvciBub3QuIFRoZSBwcm9ibGVtCj4gaXMgdGhh
dCB3ZSBuZWVkIHRvIHdhaXQgYSBiaXQgZm9yIHRoZSByZWFkYWhlYWQgdG8gaGFwcGVuLCBlc3Bl
Y2lhbGx5IG9uCj4gaGFyZHdhcmUgd2l0aCBzbG93ZXIgSS9PIHNwZWVkcy4gU28gdGhlIHRlc3Qg
bm93IHdhaXRzIGEgYml0IGZvciB0aGUKPiByZWFkYWhlYWQgdG8gc3RhcnQgYW5kIHRoZSBsb29w
cyBmb3IgYSB3aGlsZSwgd2l0aCBhIHNob3J0IHVzbGVlcHMsCj4gdW50aWwgcmV0aXJlcyBhcmUg
cmVhY2hlZCBvciB1bnRpbCBwYWdlIGNhY2hlIHN0b3BzIHRvIGdyb3cuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPgoKUmV2aWV3ZWQtYnk6IExpIFdh
bmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
