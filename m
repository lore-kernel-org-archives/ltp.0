Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A38BC3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 12:50:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D116E3D1C29
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 14:50:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A99D93D0FA8
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 14:49:52 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 79A451400E50
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 14:49:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721825389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H2ITTJx/JasrtVzIpEC9rGtbAvK7bAoL3dc+LJG4QhU=;
 b=R1PQpFvFQZUlkvzZvACWp3iDecrJs+pp9pBbMYx+BKofytUFsLLLBz/HmwZKBtV+EMw7gR
 4cLozC/AHGK83GpdUNDlUyfBf9wpoolwb87DKSK4bMhH0qexfQDE4iuAMmtVJFGT61pUJl
 4s126VPi+m+QJPmKHhPs3QZWQehoz4Y=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-vtUgS3hVMuuyZXgbDw1Klw-1; Wed, 24 Jul 2024 08:49:46 -0400
X-MC-Unique: vtUgS3hVMuuyZXgbDw1Klw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2cb7364bac9so927075a91.0
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 05:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721825385; x=1722430185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H2ITTJx/JasrtVzIpEC9rGtbAvK7bAoL3dc+LJG4QhU=;
 b=iOE3c0Es3bryUDCmq+6yO9m8s/5F67p0SLLuvzIECSxnl707gHAddYpIO7ZYXIqi2e
 9xTy6FGLmdCiLC1g/MZubetpiwWep5povk0fW1WDJZlABPz+5wSyxZDVNMOfm/O/Yro9
 S0RxKaDhU1V5vdCN07BexOtICefxXz90xKb6tU0jPCTiiihgzKF0btI64xwo2rw4um7O
 vrbLKt9nwHkfylKQ1IB+h9fxjT7mm2/0osFvTrXjbTZU35IeXbftq7hdWnSQ+KdTo7uQ
 zgzb67pyahCsV6jMeZUvuxnZi0RClFmxmcZSSuOI0O1TIvBYHe0nRgLHSlpFMDN7e+Tp
 a5BA==
X-Gm-Message-State: AOJu0YwRRSYH79627aaYm/SEy8zlgZ1yHJThnj/04MO9C0UYXB3dOEFX
 H86iTgjCCpEVxsl38sKEHBR9X9wUXHopF6OcoeEC9Qrr74scsWd2s7wfQaIpR5bcwsHXGSIlK8u
 UJAXa2GHqZJsb71dU0pD7Z8aLlq6WGQCoklMLVlfHs4kc9QKpB6Wf2Cz/UsTLi1gHadjefoOCcx
 UqRrDpBbwS15xg2WoDZPR5KJc=
X-Received: by 2002:a17:90a:f481:b0:2c8:2236:e2c3 with SMTP id
 98e67ed59e1d1-2cdb94412fbmr2849494a91.17.1721825385394; 
 Wed, 24 Jul 2024 05:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaSq9xk5PqzLjX26Co1mreunRVxuRhVBc5WdKXt+ZI8NGDEqGgAFH2bvhHhxcpVxRVIlHNAALadBX1yoPAcnM=
X-Received: by 2002:a17:90a:f481:b0:2c8:2236:e2c3 with SMTP id
 98e67ed59e1d1-2cdb94412fbmr2849461a91.17.1721825384874; Wed, 24 Jul 2024
 05:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240724092238.6774-1-chrubis@suse.cz>
In-Reply-To: <20240724092238.6774-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 24 Jul 2024 20:49:33 +0800
Message-ID: <CAEemH2dcCC0cW2pv9Y7g00dyDr-pAsVfrbHW5Fthwfho6Fueew@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] tst_tmpdir: Do not SegFault when .needs_tmpdir
 was not set
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

T24gV2VkLCBKdWwgMjQsIDIwMjQgYXQgNToyM+KAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gUHJpbnQgVEJST0sgbWVzc2FnZSBhYm91dCB0aGUgbWlzc2luZyAu
bmVlZHNfdG1wZGlyIGZsYWcgaW5zdGVhZC4KPgo+IFNpZ25lZC1vZmYtYnk6IEN5cmlsIEhydWJp
cyA8Y2hydWJpc0BzdXNlLmN6Pgo+CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhh
dC5jb20+CgotLS0KPiB2MjogRml4IHdhcm5pbmcgYWJvdXQgdW5kZWZpbmVkIHRzdF9icmsoKSB0
aGlzIGlzIGFuIG9sZCBsaWJyYXJ5Cj4gICAgIGZpbGUgaGVuY2Ugd2UgbmVlZCB0c3RfYnJrbSgp
Lgo+Cj4gIGxpYi90c3RfdG1wZGlyLmMgfCAxMiArKysrKysrKysrLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvbGli
L3RzdF90bXBkaXIuYyBiL2xpYi90c3RfdG1wZGlyLmMKPiBpbmRleCAxZmIxYmQ2OTguLjc5ODZm
MWJjMCAxMDA2NDQKPiAtLS0gYS9saWIvdHN0X3RtcGRpci5jCj4gKysrIGIvbGliL3RzdF90bXBk
aXIuYwo+IEBAIC0zNTgsNiArMzU4LDkgQEAgY2hhciAqdHN0X3RtcGRpcl9wYXRoKHZvaWQpCj4g
IHsKPiAgICAgICAgIHN0YXRpYyBjaGFyICp0bXBkaXI7Cj4KPiArICAgICAgIGlmICghVEVTVERJ
UikKPiArICAgICAgICAgICAgICAgdHN0X2Jya20oVEJST0ssIE5VTEwsICIubmVlZHNfdG1wZGly
IG11c3QgYmUgc2V0ISIpOwo+ICsKPiAgICAgICAgIGlmICh0bXBkaXIpCj4gICAgICAgICAgICAg
ICAgIHJldHVybiB0bXBkaXI7Cj4KPiBAQCAtMzY4LDExICszNzEsMTYgQEAgY2hhciAqdHN0X3Rt
cGRpcl9wYXRoKHZvaWQpCj4KPiAgY2hhciAqdHN0X3RtcGRpcl9ta3BhdGgoY29uc3QgY2hhciAq
Zm10LCAuLi4pCj4gIHsKPiAtICAgICAgIHNpemVfdCB0ZXN0ZGlyX2xlbiA9IHN0cmxlbihURVNU
RElSKTsKPiAtICAgICAgIHNpemVfdCBwYXRoX2xlbiA9IHRlc3RkaXJfbGVuOwo+ICsgICAgICAg
c2l6ZV90IHRlc3RkaXJfbGVuLCBwYXRoX2xlbjsKPiAgICAgICAgIHZhX2xpc3QgdmEsIHZhYzsK
PiAgICAgICAgIGNoYXIgKnJldDsKPgo+ICsgICAgICAgaWYgKCFURVNURElSKQo+ICsgICAgICAg
ICAgICAgICB0c3RfYnJrbShUQlJPSywgTlVMTCwgIi5uZWVkc190bXBkaXIgbXVzdCBiZSBzZXQh
Iik7Cj4gKwo+ICsgICAgICAgdGVzdGRpcl9sZW4gPSBzdHJsZW4oVEVTVERJUik7Cj4gKyAgICAg
ICBwYXRoX2xlbiA9IHRlc3RkaXJfbGVuOwo+ICsKPiAgICAgICAgIHZhX3N0YXJ0KHZhLCBmbXQp
Owo+ICAgICAgICAgdmFfY29weSh2YWMsIHZhKTsKPiAgICAgICAgIHBhdGhfbGVuICs9IHZzbnBy
aW50ZihOVUxMLCAwLCBmbXQsIHZhKSArIDI7Cj4gLS0KPiAyLjQ0LjIKPgo+Cj4gLS0KPiBNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+Cgot
LSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
