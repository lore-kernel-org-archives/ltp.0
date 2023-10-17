Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63877CDB474
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 12:40:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A66C63CEF5E
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 14:40:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9394C3CEF64
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 14:40:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3C184600BDE
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 14:40:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697546435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v/1YAFVEu0oNCBcM2yNFYuJwTcBv7vLbexQD0pdWB3o=;
 b=BANaukgE2cXKn691lB+sQd0qVPqZ7XNmHzwhsi7pry2YR6K8OjyX5XtzhPwYY/lrb/r9ZL
 KJSX22a/u4uqXz7hKMBun4zQROJe6zOyBZgzKCGtuq2hPA+gS9haDgKOLnQiTrTUgk6k7T
 pwrIUvqOBCe1x//etX36GQ0H7kUF5Es=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-VoYAe2VhMWGWiLlOi49Qiw-1; Tue, 17 Oct 2023 08:40:27 -0400
X-MC-Unique: VoYAe2VhMWGWiLlOi49Qiw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507a04c6fdcso3534909e87.0
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 05:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697546424; x=1698151224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v/1YAFVEu0oNCBcM2yNFYuJwTcBv7vLbexQD0pdWB3o=;
 b=uB8ZE1ok5YSuVO/BE2RbK8/VNoAbi8BpZQSV2K3hHI7GtBdTwE9fUfYLE9S28md32+
 Nh8jgH5/VO9fKTrguWPvFUlp6K69FBcSDrNpaQJIiyqzCFR3HAOBb7/kXbuQ2UI2ADF2
 1CpOJpVDlFSJ8z38nWqJ02Cqt04XCqEpZpdlMp+iWjzQ9u7XI975sLLEryZdhoP7QccI
 y6KNR4pTk6FbhL1Wb/NJXnwsb5ZQ3SJ3Ca5PIYcD9myaYQcXo2TkP7dPNFeQcSBSe7bl
 3HwukW2L6hczOVNjm/d55jrO2LK5zyNLuycbkeM2gtV8xJOzku71mWCSYbKTl7wDd5jh
 5NxQ==
X-Gm-Message-State: AOJu0YxgC+sWbZ020lQwubt/AbE9O0JTFBm+KEelM7NdkVabXCADsXej
 TlZhbgijw0O2wKDhDJDnGOF9GM508go3x/+EJShh4r6bjWwx0fCfQEtDdpgRZoBJG3t1bftcRHH
 kOy+K4zj4U7F4HoAuGl+pK07XgW25PbBiKOMDlw8O
X-Received: by 2002:a05:6512:2019:b0:507:b911:6706 with SMTP id
 a25-20020a056512201900b00507b9116706mr1535103lfb.25.1697546424269; 
 Tue, 17 Oct 2023 05:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIq9sLGwbPm2kyWchog1u0FZbyrb918iqi/ZygAUf4Rv/8t2XVbrev2xtmOe2iMVjiUthYz/z6VAOw0Qo0x5I=
X-Received: by 2002:a05:6512:2019:b0:507:b911:6706 with SMTP id
 a25-20020a056512201900b00507b9116706mr1535088lfb.25.1697546423808; Tue, 17
 Oct 2023 05:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <1695273748-4607-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1695273748-4607-2-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1695273748-4607-2-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 17 Oct 2023 20:40:12 +0800
Message-ID: <CAEemH2feYps41z2v_-4RqTdrYC6VXW3E0a8zEPjQSw6xQrjoCg@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] syscalls/fchmodat02: Move errnos check to
 fchmodat02
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

T24gVGh1LCBTZXAgMjEsIDIwMjMgYXQgMToyM+KAr1BNIFlhbmcgWHUgPHh1eWFuZzIwMTguanlA
ZnVqaXRzdS5jb20+IHdyb3RlOgoKPiBDaGVjayBlcnJub3MgZm9yIGZjaG1vZGF0KCkuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBZYW5nIFh1IDx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPgo+IC0tLQo+
ICBydW50ZXN0L3N5c2NhbGxzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArCj4g
IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmNobW9kYXQvLmdpdGlnbm9yZSB8ICAxICsKPiAg
Li4uL2tlcm5lbC9zeXNjYWxscy9mY2htb2RhdC9mY2htb2RhdDAyLmMgICAgIHwgNjYgKysrKysr
KysrKysrKysrKysrKwo+ICAzIGZpbGVzIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKykKPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmNobW9kYXQvZmNobW9k
YXQwMi5jCj4KPiBkaWZmIC0tZ2l0IGEvcnVudGVzdC9zeXNjYWxscyBiL3J1bnRlc3Qvc3lzY2Fs
bHMKPiBpbmRleCA0ZjFlZTFmMzQuLjVhNmI0YTY0ZCAxMDA2NDQKPiAtLS0gYS9ydW50ZXN0L3N5
c2NhbGxzCj4gKysrIGIvcnVudGVzdC9zeXNjYWxscwo+IEBAIC0yNTksNiArMjU5LDcgQEAgZmNo
bW9kMDYgZmNobW9kMDYKPgo+ICAjZmNobW9kYXQgdGVzdCBjYXNlcwo+ICBmY2htb2RhdDAxIGZj
aG1vZGF0MDEKPiArZmNobW9kYXQwMiBmY2htb2RhdDAyCj4KPiAgZmNob3duMDEgZmNob3duMDEK
PiAgZmNob3duMDFfMTYgZmNob3duMDFfMTYKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9mY2htb2RhdC8uZ2l0aWdub3JlCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2ZjaG1vZGF0Ly5naXRpZ25vcmUKPiBpbmRleCBhOTUwOGJjNWEuLjA5ZDVjNDdkNSAxMDA2
NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZjaG1vZGF0Ly5naXRpZ25vcmUK
PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZjaG1vZGF0Ly5naXRpZ25vcmUKPiBA
QCAtMSArMSwyIEBACj4gIC9mY2htb2RhdDAxCj4gKy9mY2htb2RhdDAyCj4gZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmNobW9kYXQvZmNobW9kYXQwMi5jCj4gYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZjaG1vZGF0L2ZjaG1vZGF0MDIuYwo+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAwLi5hZDhlMmFhZjcKPiAtLS0gL2Rldi9udWxsCj4g
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mY2htb2RhdC9mY2htb2RhdDAyLmMKPiBA
QCAtMCwwICsxLDY2IEBACj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9y
LWxhdGVyCj4gKy8qCj4gKyAqIENvcHlyaWdodCAoYykgSW50ZXJuYXRpb25hbCBCdXNpbmVzcyBN
YWNoaW5lcyAgQ29ycC4sIDIwMDYKPiArICogQ29weXJpZ2h0IChjKSBMaW51eCBUZXN0IFByb2pl
Y3QsIDIwMDMtMjAyMwo+ICsgKiBBdXRob3I6IFlpIFlhbmcgPHl5YW5nY2RsQGNuLmlibS5jb20+
Cj4gKyAqLwo+ICsKPiArLypcCj4gKyAqIFtEZXNjcmlwdGlvbl0KPiArICoKPiArICogLSBmY2ht
b2RhdCgpIGZhaWxzIHdpdGggRU5PVERJUiBpZiBkaXJfZmQgaXMgZmlsZSBkZXNjcmlwdG9yIHRv
IHRoZQo+IGZpbGUKPiArICogICBhbmQgcGF0aG5hbWUgaXMgcmVsYXRpdmUgcGF0aCBvZiB0aGUg
ZmlsZS4KPiArICoKPiArICogLSBmY2htb2RhdCgpIGZhaWxzIHdpdGggRUJBREYgaWYgZGlyX2Zk
IGlzIGludmFsaWQuCj4KCkdlbmVyYWxseSwgdGhpcyB0ZXN0IGxvb2tzIGdvb2QsIGJ1dCBJIHdv
dWxkIHN0aWxsIHN1Z2dlc3QgY292ZXJpbmcgbW9yZQpFUlJPUyBjaGVjayBmb3IgY2htb2RhdCA6
LSkuCgoKCj4gKyAqLwo+ICsKPiArI2luY2x1ZGUgPHN0ZGxpYi5oPgo+ICsjaW5jbHVkZSA8c3Rk
aW8uaD4KPiArI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4gKwo+ICsjZGVmaW5lIFRFU1RESVIgICAg
ICAgICAiZmNobW9kYXRkaXIiCj4gKyNkZWZpbmUgVEVTVEZJTEUgICAgICAgICJmY2htb2RhdGZp
bGUiCj4gKyNkZWZpbmUgRklMRVBBVEggICAgICAgICJmY2htb2RhdGRpci9mY2htb2RhdGZpbGUi
Cj4gKwo+ICtzdGF0aWMgaW50IGRpcl9mZCwgZmlsZV9mZDsKPiArc3RhdGljIGludCBiYWRfZmQg
PSAtMTsKPiArCj4gK3N0YXRpYyBzdHJ1Y3QgdGNhc2Ugewo+ICsgICAgICAgaW50ICpmZDsKPiAr
ICAgICAgIGludCBleHBfZXJybm87Cj4gK30gdGNhc2VzW10gPSB7Cj4gKyAgICAgICB7JmZpbGVf
ZmQsIEVOT1RESVJ9LAo+ICsgICAgICAgeyZiYWRfZmQsIEVCQURGfSwKPiArfTsKPiArCj4gK3N0
YXRpYyB2b2lkIHZlcmlmeV9mY2htb2RhdCh1bnNpZ25lZCBpbnQgaSkKPiArewo+ICsgICAgICAg
c3RydWN0IHRjYXNlICp0YyA9ICZ0Y2FzZXNbaV07Cj4gKwo+ICsgICAgICAgVFNUX0VYUF9GQUlM
KGZjaG1vZGF0KCp0Yy0+ZmQsIFRFU1RGSUxFLCAwNjAwLCAwKSwKPiArICAgICAgICAgICAgICAg
ICAgICB0Yy0+ZXhwX2Vycm5vLCAiZmNobW9kYXQoJWQsICVzLCAwNjAwLCAwKSIsICp0Yy0+ZmQs
Cj4gVEVTVEZJTEUpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ICt7Cj4g
KyAgICAgICBTQUZFX01LRElSKFRFU1RESVIsIDA3MDApOwo+ICsgICAgICAgZGlyX2ZkID0gU0FG
RV9PUEVOKFRFU1RESVIsIE9fRElSRUNUT1JZKTsKPgoKSSBkaWRuJ3Qgc2VlIHdoeSB3ZSBuZWVk
IGRpcl9mZCBpbiB0aGlzIHRlc3RjYXNlLCB3ZSBkb24ndApldmVuIG5lZWQgdG8gY3JlYXRlIHRo
ZSBURVNURElSLCByaWdodD8KCgoKPiArICAgICAgIGZpbGVfZmQgPSBTQUZFX09QRU4oRklMRVBB
VEgsIE9fQ1JFQVQgfCBPX1JEV1IsIDA2MDApOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCBjbGVh
bnVwKHZvaWQpCj4gK3sKPiArICAgICAgIGlmIChkaXJfZmQgPiAtMSkKPiArICAgICAgICAgICAg
ICAgU0FGRV9DTE9TRShkaXJfZmQpOwo+CgpubyBuZWVkZWQuCgorCj4gKyAgICAgICBpZiAoZmls
ZV9mZCA+IC0xKQo+ICsgICAgICAgICAgICAgICBTQUZFX0NMT1NFKGZpbGVfZmQpOwo+ICt9Cj4g
Kwo+ICtzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gKyAgICAgICAudGVzdCA9IHZl
cmlmeV9mY2htb2RhdCwKPiArICAgICAgIC50Y250ID0gQVJSQVlfU0laRSh0Y2FzZXMpLAo+ICsg
ICAgICAgLnNldHVwID0gc2V0dXAsCj4gKyAgICAgICAuY2xlYW51cCA9IGNsZWFudXAsCj4gKyAg
ICAgICAubmVlZHNfdG1wZGlyID0gMSwKPiArfTsKPiAtLQo+IDIuMzkuMQo+Cj4KPiAtLQo+IE1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4K
Ci0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
