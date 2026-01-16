Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF65EC79FBC
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768571939; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=nekGLAmw7ndKTB4RSL1Ab2abvBpvw1cva21XHg5RjCE=;
 b=qUkZ7E6zoPPUNrAXhY1XVZYr7+sEdD8M9vwUcIY6gfXE7ben0Fe1AL+3BJmIouereeN5p
 9c3qiv6AX08WHmavpcJN3z/xn/sxcwpKnDwk1f5OoyphZmd44HrBUucvAiXdzUjRum2k7dp
 BzjixOXknP6Yqwem5ap/MddFiuDQEhQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4094B3CAA4B
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 14:58:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4CE13C92B9
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 14:58:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3707910007E3
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 14:58:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768571913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pykVfGCuRsXx24DFC9QAKmUS7YIsCfWwzFJ4d+NIu5g=;
 b=KYYg600gK1BPuaZB6mhjkltJ4udnhgdzW1T235vGRftBx02euJomQ9OAHfi3ObUcwjcGjm
 ARpEy9yRRWUM8LL+ukzM04+NurR76GRbV3Ta1mYZhqzt8/fCttK1dLMlhs8QHZFBUvvhbl
 vimkvhlrftDqF2ZbFXak3XM/Wnkk+1g=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-3dh3o1hQP_yJWSLhhhtdwA-1; Fri, 16 Jan 2026 08:58:32 -0500
X-MC-Unique: 3dh3o1hQP_yJWSLhhhtdwA-1
X-Mimecast-MFC-AGG-ID: 3dh3o1hQP_yJWSLhhhtdwA_1768571911
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-123308e5e6aso3780034c88.1
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 05:58:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768571910; x=1769176710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pykVfGCuRsXx24DFC9QAKmUS7YIsCfWwzFJ4d+NIu5g=;
 b=eOrHoyzv+PbqnhmGwdPAxX0n/OKcJsRqdlnnfJdsy0vdEX/T7Yizvk7ofgEqr2Jt04
 aPC/F4B9B8q1/0DG3M/xnNpAxujqdTKe0wQlXwblCKfjNWzMdrkbRydf0QCjz+YGNZb7
 h41TuP++qWt1M/xdGfINLdhvrh01lTnZY8kQ+bK+LH5AsbIIf7rLBGCXOTrl7Ge6b9zn
 HsUfkK7DxNKBMWUSTL36SPS8Ycx2a+b18RJKk86ZqyhKbYV3GG2XQQylXic5sa2jlJ87
 cQbAfKfixDJAmv5ixsqooWC9K6m08rqRU/6krqYlVAqfyXQb4/Z8PGEmrIyopLyLZJvh
 xXWw==
X-Gm-Message-State: AOJu0YzDFjye++JH7BHGS1dist0TACRU8SFCAZWQ96VW3p07CORx98ii
 xxnIRVUl6iz2pS3ZiN/hxEIdcqlOcsG2f+LeAxsNYqbxQtqXV4Ix52qeaYvkry8dv/YhvUvRlYM
 zcxAz/y+v6K8kxG7EAvDrZWw/C+5s0vbK8DbPWAIpMAA1YslDJm2TqiWZmrN8/HPN2gkawCfNA8
 m16AYSj3j87bLvzTrx9mXjDYu7TpOOF2P62uGSzg==
X-Gm-Gg: AY/fxX4Z52vQmvHJFg3cTpDfH0q8H0zFbOCLP9ocwLecdKMJQoVndugGeXgJMDAUMa5
 /LgIWI3d/fjXyRRe5ukN95G+a4iR2FSBdHvg1LTcaGkuUaUYpOffo7CcPutC//K8+tvzvW73T1H
 yAgeXmXHWIW6LGSmSUfiMOlLgcjzV+NSCajPgyNqZgxxdjPkp58QgLRlLcViEuzjMjT20=
X-Received: by 2002:a05:7022:2387:b0:11b:c86b:386a with SMTP id
 a92af1059eb24-1244a6cf54amr2367152c88.5.1768571909638; 
 Fri, 16 Jan 2026 05:58:29 -0800 (PST)
X-Received: by 2002:a05:7022:2387:b0:11b:c86b:386a with SMTP id
 a92af1059eb24-1244a6cf54amr2367136c88.5.1768571909114; Fri, 16 Jan 2026
 05:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20251223020836.9439-1-wegao@suse.com>
 <20260109061716.20258-1-wegao@suse.com>
 <20260109061716.20258-3-wegao@suse.com>
In-Reply-To: <20260109061716.20258-3-wegao@suse.com>
Date: Fri, 16 Jan 2026 21:58:17 +0800
X-Gm-Features: AZwV_QgMcJCV-g9-LEgzz0iKB9hYEAD5AHzrU-iavu8bf7pkhX44PxYOVcCkDKI
Message-ID: <CAEemH2fa66_vM85x+kzieLaeYKhb-yPOu449USJPEm4u1DdVmw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MZMUBe3XJSnHrhSqIF9BvotgaKc6mDNJD9aRhzv8u0I_1768571911
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/4] tst_test.c: Add tst_cmd_present check if a
 command is present
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

SGkgV2VpLAoKSSBkb24ndCBnZXQgdGhlIHBvaW50IHdoeSB3ZSBuZWVkcyBzZXBlcmF0ZWx5IGRl
ZmluZSB0aGUgdHN0X2NtZF9wcmVzZW50KCkKZnVuY3Rpb24sIGZyb20gd2hhdCBJIHVuZGVyc3Rh
bmQsIGFzIGxvbmcgYXMgd2UgZmlsbCAiY29tbWFuZHMiIGluIHRoZQpuZXcgc3RydWN0IGZpZWxk
LCB0aGF0IHdvdWxkIGJlIGNvbXBsZXRlZCB0aGUgY2hlY2sgYW5kIHN0b3JlIHRoZSBzdGF0ZQpp
biAucHJlc2VudCwgcmlnaHQ/CgpTaG91bGRuJ3Qgd2UgdXNlIHRoYXQgLnByZXNlbnQgdmFsdWUg
aW4gdGVzdGNhc2UgZGlyZWN0bHk/CgoKCk9uIEZyaSwgSmFuIDksIDIwMjYgYXQgMjoxOOKAr1BN
IFdlaSBHYW8gdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKPgo+IFNpZ25lZC1v
ZmYtYnk6IFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29tPgo+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVs
IDxwdm9yZWxAc3VzZS5jej4KPiAtLS0KPiAgaW5jbHVkZS90c3RfdGVzdC5oIHwgMTIgKysrKysr
KysrKysrCj4gIGxpYi90c3RfdGVzdC5jICAgICB8IDE4ICsrKysrKysrKysrKysrKysrKwo+ICAy
IGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L3RzdF90ZXN0LmggYi9pbmNsdWRlL3RzdF90ZXN0LmgKPiBpbmRleCBkYzJlOWEzOTcuLmQxNWJm
ODdmZCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3RzdF90ZXN0LmgKPiArKysgYi9pbmNsdWRlL3Rz
dF90ZXN0LmgKPiBAQCAtNzI2LDYgKzcyNiwxOCBAQCBpbnQgdHN0X2NyZWF0X3VubGlua2VkKGNv
bnN0IGNoYXIgKnBhdGgsIGludCBmbGFncywgbW9kZV90IG1vZGUpOwo+ICAgKi8KPiAgY29uc3Qg
Y2hhciAqdHN0X2dldF90bXBkaXJfcm9vdCh2b2lkKTsKPgo+ICsvKioKPiArICogdHN0X2NtZF9w
cmVzZW50KCkgLSBDaGVjayBpZiBhIGNvbW1hbmQgaXMgcHJlc2VudAo+ICsgKiBAY21kOiBUaGUg
bmFtZSBvZiB0aGUgY29tbWFuZCB0byBjaGVjayBmb3IuCj4gKyAqCj4gKyAqIFRoaXMgZnVuY3Rp
b24gaXRlcmF0ZXMgdGhyb3VnaCB0aGUgJnRzdF90ZXN0LT5uZWVkc19jbWRzIGFycmF5LiBJdCBj
b21wYXJlcwo+ICsgKiB0aGUgZ2l2ZW4gY29tbWFuZCBuYW1lIHdpdGggZWFjaCBlbnRyeSBpbiB0
aGUgYXJyYXkgYW5kIHJldHVybnMgdGhlCj4gKyAqICZ0c3RfY21kLT5wcmVzZW50IGZsYWcgZm9y
IHRoZSBtYXRjaGluZyBjb21tYW5kLgo+ICsgKgo+ICsgKiBSZXR1cm46IGB0cnVlYCBpZiB0aGUg
Y29tbWFuZCBpcyBwcmVzZW50LCBgZmFsc2VgIG90aGVyd2lzZS4KPiArICovCj4gK2Jvb2wgdHN0
X2NtZF9wcmVzZW50KGNvbnN0IGNoYXIgKmNtZCk7Cj4gKwo+ICAvKgo+ICAgKiBWYWxpZGF0ZXMg
ZXhpdCBzdGF0dXMgb2YgY2hpbGQgcHJvY2Vzc2VzCj4gICAqLwo+IGRpZmYgLS1naXQgYS9saWIv
dHN0X3Rlc3QuYyBiL2xpYi90c3RfdGVzdC5jCj4gaW5kZXggMDlhYTdmY2UyLi4wYzJiYmJiZDYg
MTAwNjQ0Cj4gLS0tIGEvbGliL3RzdF90ZXN0LmMKPiArKysgYi9saWIvdHN0X3Rlc3QuYwo+IEBA
IC0xMzc1LDYgKzEzNzUsMjQgQEAgc3RhdGljIGNvbnN0IGNoYXIgKmRlZmF1bHRfZnNfdHlwZSh2
b2lkKQo+ICAgICAgICAgcmV0dXJuIHRzdF9kZXZfZnNfdHlwZSgpOwo+ICB9Cj4KPiArYm9vbCB0
c3RfY21kX3ByZXNlbnQoY29uc3QgY2hhciAqY21kKQo+ICt7Cj4gKyAgICAgICBzdHJ1Y3QgdHN0
X2NtZCAqcGNtZCA9IHRzdF90ZXN0LT5uZWVkc19jbWRzOwo+ICsKPiArICAgICAgIGlmICghY21k
IHx8IGNtZFswXSA9PSAnXDAnKQo+ICsgICAgICAgICAgICAgICB0c3RfYnJrKFRCUk9LLCAiSW52
YWxpZCBjbWQiKTsKPiArCj4gKyAgICAgICB3aGlsZSAocGNtZC0+Y21kKSB7Cj4gKyAgICAgICAg
ICAgICAgIGlmICghc3RyY21wKHBjbWQtPmNtZCwgY21kKSkKPiArICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gcGNtZC0+cHJlc2VudDsKPiArCj4gKyAgICAgICAgICAgICAgIHBjbWQrKzsK
PiArICAgICAgIH0KPiArCj4gKyAgICAgICB0c3RfYnJrKFRCUk9LLCAiJyVzJyBub3QgY2hlY2tl
ZCIsIGNtZCk7Cj4gKyAgICAgICByZXR1cm4gZmFsc2U7Cj4gK30KPiArCj4gIHN0YXRpYyB2b2lk
IGRvX3NldHVwKGludCBhcmdjLCBjaGFyICphcmd2W10pCj4gIHsKPiAgICAgICAgIGNoYXIgKnRk
ZWJ1Z19lbnYgPSBnZXRlbnYoIkxUUF9FTkFCTEVfREVCVUciKTsKPiAtLQo+IDIuNTIuMAo+Cj4K
PiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo+CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
