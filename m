Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0815C3DA6E
	for <ltp@archiver.kernel.org>; Wed, 20 Dec 2023 10:41:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E36873CF2A6
	for <ltp@archiver.kernel.org>; Wed, 20 Dec 2023 11:41:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 766823C81C8
 for <ltp@lists.linux.it>; Wed, 20 Dec 2023 11:40:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 399401B6107F
 for <ltp@lists.linux.it>; Wed, 20 Dec 2023 11:40:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703068854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vA8HGCZoSs+O3oodQ1dGTWG6A5fHLdr2Xjjmh3R0ekQ=;
 b=YwdFg86VDVoScPqxDNlwn29HmMro3njWGkQJ+lOJ93I/4vw/wiuEqSptUMeo6jpndiMxYm
 FX6Bj53xA93K/rmeTjvj9n6vp92YlX79gTgGHiCZVPRN16kH77qKBSig5aYX3/tqXpd+Ir
 E/Heiid/n4KZ1CmlpJyPS7G8icBYVQg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-75LgWJz9NhecubKmeeXkJA-1; Wed, 20 Dec 2023 05:40:51 -0500
X-MC-Unique: 75LgWJz9NhecubKmeeXkJA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2cc2ddf70a1so42225691fa.1
 for <ltp@lists.linux.it>; Wed, 20 Dec 2023 02:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703068849; x=1703673649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vA8HGCZoSs+O3oodQ1dGTWG6A5fHLdr2Xjjmh3R0ekQ=;
 b=O8SyPvOu/d0QK8B73nhPDPvmHKNkSEnVdDLnhpe8QTHkjdwzClDCnkrGOa+kdtBgrr
 qQOU+1tanWPmX1uX0C95/T0FYcLMd1X+uGEtFX0j4j/r7lqEzJzTpdgYsWPihIgr9Frf
 XqVGd0K22RAt6wAxQGlkosebp9hdZ1Jr8jKA4DPLVW/rUznSPAEhEr4jRSRcLqoO4dCX
 /qjTor+7UB0yN3mKk20ESG1vvdB0JJ0F+f1KoQErM+N5RZZWz7z6tQColoLlJcBc6f+k
 0fvzUWTU/y3lMNTbd8D9n0X4BUG7A1VfUr7xFTIgWr5+JXqbtWkRXF7PDL+Gr78IYBG5
 28dw==
X-Gm-Message-State: AOJu0YzXtj9CJCblSPe5hMVJpzVQuKHk+QxWQAOA8cLh+9Vu0/UxA15q
 /V0QpBqRBnqGsbFiQYOVVDyR0aZU7aBSYr3a+4lWc9//fVKh5SGzwL38t2pB5LIaPfnSA5yYWPb
 MCq0EWRdRNWVR3OJ5Ok5MuVScxVU=
X-Received: by 2002:a2e:99d4:0:b0:2cc:6ddf:621d with SMTP id
 l20-20020a2e99d4000000b002cc6ddf621dmr2574362ljj.66.1703068849438; 
 Wed, 20 Dec 2023 02:40:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZGUkQW6Pkp3M3Knhm3EJjlQo3Ig1i2LGc6JubRxRelyvxXxfo4ch/Zyjov2sdCdxAlnit7LhpuPr8OfZE5aU=
X-Received: by 2002:a2e:99d4:0:b0:2cc:6ddf:621d with SMTP id
 l20-20020a2e99d4000000b002cc6ddf621dmr2574356ljj.66.1703068849076; Wed, 20
 Dec 2023 02:40:49 -0800 (PST)
MIME-Version: 1.0
References: <20231120154248.15048-1-andrea.cervesato@suse.de>
 <20231128125632.GB381183@pevik> <977d4dc47fa4c5163afc1a6646d4fb5a@suse.de>
In-Reply-To: <977d4dc47fa4c5163afc1a6646d4fb5a@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Wed, 20 Dec 2023 18:40:36 +0800
Message-ID: <CAEemH2e3rshuygLTq5LcK69ONnMAGO+Mcy_FkZJVS4OCHHf5ZQ@mail.gmail.com>
To: pvorel <pvorel@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] Delete fork09 test
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

T24gVHVlLCBEZWMgMTksIDIwMjMgYXQgMTA6NTXigK9QTSBwdm9yZWwgPHB2b3JlbEBzdXNlLmRl
PiB3cm90ZToKCj4gSGkgYWxsLAo+Cj4gT24gMjAyMy0xMS0yOCAxMzo1NiwgUGV0ciBWb3JlbCB3
cm90ZToKPiA+IEhpIEFuZHJlYSwKPiA+Cj4gPj4gRnJvbTogQW5kcmVhIENlcnZlc2F0byA8YW5k
cmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPiA+Cj4gPj4gVGhlIGZvcmswOSB0ZXN0IGlzIGFjdHVh
bGx5IHRlc3Rpbmcgd2hhdCBmb3JrMTAgaXMgYWxyZWFkeSB0ZXN0aW5nOgo+ID4+IGFjY2Vzc2lu
ZyBhbiBvcGVuIGNoaWxkJ3MgZmlsZSBmcm9tIHBhcmVudC4gRm9yIHRoaXMgcmVhc29uLCB3ZSBk
ZWxldGUKPiA+PiBpdCBhbmQgbGV0IGZvcmsxMCBkb2luZyBpdHMgam9iLgo+ID4KPiA+IGluIGZv
cmswOSBwYXJlbnQgb3BlbnMgbWF4aW11bSBudW1iZXIgb2YgZmlsZXMsIGNoaWxkIGNsb3NlcyBv
bmUgYW5kCj4gPiBhdHRlbXB0cyB0bwo+ID4gb3BlbiBhbm90aGVyLiBUaGF0IGlzIG5vdCBleGFj
dGx5IHRoZSBzYW1lLCBidXQgaXQncyB2ZXJ5IHNpbWlsYXIuCj4gPgo+ID4gSSdtIG5vdCBzdXJl
IGlmIHRoZSBzY2VuYXJpbyB3b3VsZCByZWFsbHkgdGVzdHMgZGlmZmVyZW50IGNvZGUgcGF0aCBp
bgo+ID4ga2VybmVsL2xpYmMgb3Igbm90IGFuZCB3ZSBjYW4gaGFwcGlseSBkZWxldGUgaXQuCj4g
PiBDeXJpbCwgV0RZVD8KPgo+IEBMaSwgV0RZVD8KPgoKUGV0ciwgSSB0aGluayB5b3UncmUgcmln
aHQsIHRoZXkncmUgbm90IHRoZSBzYW1lIHRlc3QuCgpJbiBmb3JrMTAgcGFyZW50IHRyaWVzIHRv
IHZlcmlmeSB0aGUgY29udGVudHMgb2YgdGhlIGZpbGUgdGhhdCByZXNldCB0aGUKZmlsZSBvZmZz
ZXQgcG9pbnRlciBieSBjaGlsZC4KCkJ1dCBmb3IwOSBpcyBhIGJvdW5kZXIgdGVzdCB0byB2ZXJp
ZnkgaWYgdGhlIGNoaWxkIGNhbiBvcGVuIG9uZSBtb3JlIGZpbGUKd2hlbiAnZmQnIG51bWJlciBh
cHByb2FjaGVzIChPcGVuTWF4LTEpLgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
