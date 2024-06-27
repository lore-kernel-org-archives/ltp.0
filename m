Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC449C3064D
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 12:00:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66A383D12FC
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 14:00:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65D823D0FAF
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 13:59:51 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8893160208B
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 13:59:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719489587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=77fHa1ugiotPT8NpexkwhE9fglw/RwRSIJKVBBj9qaw=;
 b=PCrnxGsrWQGMuIOUtcebJaKaPq2cuztZQJyKNoBhoC7sIdLqTRay5F/bHgdN2kBWjMjp+e
 w/z5mNwyqbTMZOx8g6Qvozioh/4N7x1P+0LDIIlJ9jVwUfXER4vBob8Tv99tJqh3wqP+1M
 4XtqFmiLrwzQWGwDBUdV1dBEvk8CSp0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-98wt67jMPAKMpvFz_VF0wQ-1; Thu, 27 Jun 2024 07:59:45 -0400
X-MC-Unique: 98wt67jMPAKMpvFz_VF0wQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c8f8388f60so736471a91.3
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 04:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719489583; x=1720094383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=77fHa1ugiotPT8NpexkwhE9fglw/RwRSIJKVBBj9qaw=;
 b=puNJnM2L3kujbu6uEiSEYf0m4gidnrQyamT9zj036Jf3aRwdPhUXJXqzsRRk8h0HGU
 IKBjq+oECE6ZhQzrR7zCh2NHPGkK153isO5OlH6FbmA/cOEe9GEkDGQGZr2rQHKY+jxb
 ADoptg8fHOUYlti7JHhFImTMJgjJBo7Y5hyPB/H4OBeVGLSNtlNgI7CUhQdUDfG10rst
 A3J1DHIhTFc67OJiueMv3NIBAMqS3Go9oRseZVRNi9ZD3w/tuj7QH0bgNYTuTyYqxLzG
 hLDfCl4GdO9gNJwDhMTBD+wbMDrcmC2kXQlyxgJbHr/jj1MPRQQX6bI7GAtD8OevJ8gn
 EvLw==
X-Gm-Message-State: AOJu0Yzgjh8sPhFJi1lreSJcT63A5xsDFgSf8UAEd92lP5dr2ShJiYf4
 nqzQTYw8yTpDnXHbrBUV8zs6sacQwQbW83rdurJ4VJvOuw6aP79gdBGvi6fK0pTYeh+Fve11xl6
 edrwkhoPhEE0SjeabPkQdfzVMWAqPaaO84YZaIEd/d87Qljj/O+a8WFY5cYWWqPmBjro+Pf1gfp
 9P35funSCW5pFRJ/nwXLtac2AfdOtU2Q1grG8N
X-Received: by 2002:a17:90a:a011:b0:2c5:10a6:e989 with SMTP id
 98e67ed59e1d1-2c8582917d4mr11557021a91.35.1719489583076; 
 Thu, 27 Jun 2024 04:59:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq1SBqaY1U+ze9KkBW+x+c9uzQ3EtlUYfk1VD2UfLaZ8UOPDRf9azfxsD2E3XoY9wLTPUpXyhXKCVZ9LdTF0o=
X-Received: by 2002:a17:90a:a011:b0:2c5:10a6:e989 with SMTP id
 98e67ed59e1d1-2c8582917d4mr11557008a91.35.1719489582736; Thu, 27 Jun 2024
 04:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2fsBssjDyyozHnFt4T5y7LCWFEDqfN3nE7t3kyd19FjLg@mail.gmail.com>
 <20240627031440.799114-1-liwang@redhat.com> <Zn1PluxR0lVO1qdn@yuki>
 <CAEemH2eh3kDZ7xLPp94buH1f9b3Z3JgiVaRVEzvgiGw8mv3mow@mail.gmail.com>
 <Zn1RbDki07G3_yJB@yuki>
In-Reply-To: <Zn1RbDki07G3_yJB@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 27 Jun 2024 19:59:31 +0800
Message-ID: <CAEemH2dr-UMbVQo9EVcr8mbW-PpVJ6mvv33GoKnRLVWq2ez77w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] msgstress01: remove TWARN from runtime
 remaining
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

T24gVGh1LCBKdW4gMjcsIDIwMjQgYXQgNzo0OOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBBaCB5ZXMsIGJ1dCBpZiB0aGUgc2Vjb25kIHJ1bnRp
bWUgb3V0IGhhcHBlbnMsIGl0IHN0aWxsCj4gPiBub3QgZ2V0IGFuIGV4cGVjdGVkIHJlc3VsdCBv
biB0aGUgdGVzdCwgc28gbWF5YmUgd2UKPiA+IHNob3VsZG4ndCBwcmludCAiVFBBU1MgKyBBbGwg
bWVzc2FnZXMgcmVjZWl2ZWQiPwo+Cj4gSSBzdXBwb3NlIHRoYXQgd2UgY2FuIHByaW50ICJTb21l
IG1lc3NhZ2VzIHJlY2VpdmVkIiBpbnN0ZWFkIGluIHRoZSBjYXNlCj4gdGhhdCBzdG9wIHdhcyBp
biB0aGUgc2Vjb25kIGxvb3AuCj4KCkhvdyBhYm91dCBnaXZpbmcgdGhlIGFjdHVhbCBmaW5pc2hl
ZCBudW1iZXJzPwoKICAgICAgICBpZiAoISgqZmFpbCkpCi0gICAgICAgICAgICAgICB0c3RfcmVz
KFRQQVNTLCAiVGVzdCBwYXNzZWQuIEFsbCBtZXNzYWdlcyBoYXZlIGJlZW4KcmVjZWl2ZWQiKTsK
KyAgICAgICAgICAgICAgIHRzdF9yZXMoVFBBU1MsICJUZXN0IHBhc3NlZC4gJWQgbWVzc2FnZXMg
aGF2ZSBiZWVuCnJlY2VpdmVkIiwgKmZpbmlzaGVkKTsKCgotLSAKUmVnYXJkcywKTGkgV2FuZwoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
