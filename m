Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C040C282C6
	for <ltp@archiver.kernel.org>; Mon,  3 Mar 2025 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741026910; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=5q0WHHUE3SvLfRr+FzHBIgda+Y2hcUKSxCK4dC4dqAQ=;
 b=WkxUVEXAHDqarjgaItTXChpNPqbnHjW3CeyRlMGMz5tQFk/nNktJY0XYf2acMecSx1Ugt
 JGE6jxO21PvQaLK2w6vmq1F5opn6HPNrdyEq3B5S+WrbhFnuALFSDAOJTXWQl+slPaNZTYe
 IeWlrgl29SvBoM2u7gWmjthlRbWQBkg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7981F3C99D7
	for <ltp@archiver.kernel.org>; Mon,  3 Mar 2025 19:35:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 790FC3C32FC
 for <ltp@lists.linux.it>; Mon,  3 Mar 2025 19:34:48 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C8A531010C27
 for <ltp@lists.linux.it>; Mon,  3 Mar 2025 19:34:47 +0100 (CET)
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-86718541914so4770990241.1
 for <ltp@lists.linux.it>; Mon, 03 Mar 2025 10:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1741026886; x=1741631686; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WVdmAigEB6fCOJ6EBJElBWukWy7PhGohVdbATP5w7x4=;
 b=MbmMDnW1ENs5kUgUL6PXymBAnaT/09Sjl6XQJX4njUgzaObcoOrY9Qa/cSE6sjN1b6
 MynQ7pbxZLfQSMlg08rw01ridb9AOnOxSilX6Elv2TVGgQVpxdT6AqBcoFMVQZMghkI5
 aTZex4MYac5yflOPaXM4G2vygGftiO+VsW+P5rehqgRtPnAdmxqSpu4gwjCgx093TZhU
 ifbetE91XZYM6AUdiLLV7rTjrzmi/07Jq/AkfHNLXo93/KA8IjwqXhgXFgRVJc6/eAdu
 7bjp5ERkTFiZtjQrNvISJqmnNK0sKdXnn8R02PmTnrzWrlpMdx0HjqN7br5WnqG4+J1a
 zpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741026886; x=1741631686;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WVdmAigEB6fCOJ6EBJElBWukWy7PhGohVdbATP5w7x4=;
 b=cWtIPKDpMx6vl3iT7hV56UXv4MIf96h8yOE3WiFirqyUNdXabtLmU2680UbyR3E/xv
 jnQrhqNONkWG1XCpzH03lfKFoIcdfmVxXGDvNHyIa6idttWSLZgNmZ25LMs/V7p4ZesZ
 inteO7UkD+7ZJzC+uWUEaGhiRYe89HT/N6nklK27MuzkYNJ3ZaOV8nsjAGC4Uwn2gd80
 bqAcjFf5mdB2TglTi5rTUf4761KAhsQlBKlKiiYQwK8dERy78gVPIzSho78M1N64kCNq
 fKtU0J/m4efDbNx0BadC+AF4w0o/ugmiP0Lb5of8VMdc8SGjQ+PuUh3xW1zy3LzOnvod
 dvow==
X-Gm-Message-State: AOJu0YwEkr6rCBLISX8fiDerYMGh5j/bnvFryEc9XLZY5Dyx8MAWlstl
 Gfok0Hwl/4NcicvClbu4nJKxVzzuVjNK/M+Lp2zTtzcHgD4ANSK1DKbAaoXnuf/Ur8FZ4BBEWBP
 0DtGFkO+oZBqLGHwp8J55Wa2eQC5vACnrrZAc
X-Gm-Gg: ASbGncvV7wXhtI3MPVtki7YuSkhCim34pp6YDFG65uJnz9WuAiJTzr2UBSplLg44xu4
 veqMv+ONMAipTsNS4VvPIvdFnM37wp51xwfVAwypKgjjViJb09cUmwK5SEyo1m+WA27ldzcnhQ9
 6qUM3XLqU7ragB5z/3vdoJ3jxKNlkkO7GuR+ezPnocViWDF78rF4YGRIxc
X-Google-Smtp-Source: AGHT+IHa/xcUhS7L4G/VUValJHLotcMpjCVWXXEfa+teIaLbtsc/6QfWq8Qee5htcFsCBuyzoVSfWQEm2Pet9f4XSyM=
X-Received: by 2002:a67:f501:0:b0:4c0:494a:6677 with SMTP id
 ada2fe7eead31-4c1b31a42fcmr332744137.7.1741026886178; Mon, 03 Mar 2025
 10:34:46 -0800 (PST)
MIME-Version: 1.0
References: <20250228184834.1330657-1-edliaw@google.com>
 <CAEemH2e-eEvbOT_ByL1cwJODUg7rS16nO0aYVd4DFCAQB=7uPA@mail.gmail.com>
In-Reply-To: <CAEemH2e-eEvbOT_ByL1cwJODUg7rS16nO0aYVd4DFCAQB=7uPA@mail.gmail.com>
Date: Mon, 3 Mar 2025 10:34:19 -0800
X-Gm-Features: AQ5f1JpvbvRFBs5tG0M1IHy-E1y7oH0jIXxNNXL8L59S1QCRvemV9uIWDks4Ihk
Message-ID: <CAG4es9Xqe2yO2oFJxNxic5WCXwvpgKhQ=afJbNv=xDp7c2PtLA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] input_common.h: Add retry loop for event device
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBNYXIgMywgMjAyNSBhdCAxOjM14oCvQU0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgoKPgo+Cj4gT24gU2F0LCBNYXIgMSwgMjAyNSBhdCAyOjQ54oCvQU0gRWR3YXJk
IExpYXcgdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0Pgo+IHdyb3RlOgo+Cj4+IEFuZHJvaWQg
aGFzIGEgZGVsYXkgYmV0d2VlbiB0aGUgZW50cnkgaW4gL3Byb2MvYnVzL2lucHV0L2RldmljZXMg
YW5kIHRoZQo+PiBwYXRoIC9kZXYvaW5wdXQvZXZlbnROIGJlY29taW5nIGFjY2Vzc2libGUuICBB
ZGQgYSByZXRyeSBsb29wIHRvIGFjY291bnQKPj4gZm9yIHRoaXMuCj4+Cj4KPiBEaWQgeW91IGNv
dW50IGZvciBob3cgbG9uZyBpdCB0YWtlcyB0byBlbnRyeT8gVGhlIGRlZmF1bHQgdGltZQo+IFRT
VF9SRVRSWV9GVU5DCj4gaXMgYmFja29mZiAxIHNlY29uZCwgaWYgdGhhdCB0aW1lIGlzIG5vdCBl
bm91Z2gsIHlvdSBjYW4gY29uc2lkZXIgdGhlCj4gY29tcGxldGVkCj4gdmVyc2lvbiBUU1RfUkVU
UllfRk5fRVhQX0JBQ0tPRkYgZm9yIHNldHRpbmcgbW9yZSBzZWNvbmRzLgo+Cj4gQW55d2F5LCB0
aGlzIGxvb2tzIGdvb2QuCj4gUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29t
Pgo+CgpZZWFoLCAxIHNlYyBzaG91bGQgYmUgbW9yZSB0aGFuIGVub3VnaCBmb3IgQW5kcm9pZDsg
dGhlIGRlbGF5IGhhcyBzbyBmYXIKYmVlbiBvbiB0aGUgb3JkZXIgb2YgbWljcm9zZWNvbmRzLgoK
Pgo+Cj4KPj4KPj4gU2lnbmVkLW9mZi1ieTogRWR3YXJkIExpYXcgPGVkbGlhd0Bnb29nbGUuY29t
Pgo+PiAtLS0KPj4gIHRlc3RjYXNlcy9rZXJuZWwvaW5wdXQvaW5wdXRfY29tbW9uLmggfCAyICst
Cj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4g
ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvaW5wdXQvaW5wdXRfY29tbW9uLmgKPj4gYi90
ZXN0Y2FzZXMva2VybmVsL2lucHV0L2lucHV0X2NvbW1vbi5oCj4+IGluZGV4IDBhYzE2MjRiMy4u
NWIxNzU1NzcxIDEwMDY0NAo+PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL2lucHV0L2lucHV0X2Nv
bW1vbi5oCj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvaW5wdXQvaW5wdXRfY29tbW9uLmgKPj4g
QEAgLTI5LDcgKzI5LDcgQEAgc3RhdGljIGlubGluZSBpbnQgb3Blbl9ldmVudF9kZXZpY2Uodm9p
ZCkKPj4gICAgICAgICAgICAgICAgICAgICAgICAgbWVtc2V0KHBhdGgsIDAsIHNpemVvZihwYXRo
KSk7Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgIHNucHJpbnRmKHBhdGgsIHNpemVvZihwYXRo
KSwgIi9kZXYvaW5wdXQvJXMiLAo+PiBkZXZpY2UpOwo+Pgo+PiAtICAgICAgICAgICAgICAgICAg
ICAgICBpZiAoIWFjY2VzcyhwYXRoLCBGX09LKSkgewo+PiArICAgICAgICAgICAgICAgICAgICAg
ICBpZiAoIVRTVF9SRVRSWV9GVU5DKGFjY2VzcyhwYXRoLCBGX09LKSwKPj4gVFNUX1JFVFZBTF9F
UTApKSB7Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHN0X3JlcyhUSU5GTywg
IkZvdW5kIGV2ZW50IGRldmljZTogJXMiLAo+PiBwYXRoKTsKPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBicmVhazsKPj4gICAgICAgICAgICAgICAgICAgICAgICAgfQo+PiAtLQo+
PiAyLjQ4LjEuNzExLmcyZmVhYmFiMjVhLWdvb2cKPj4KPj4KPj4gLS0KPj4gTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4+Cj4+Cj4KPiAtLQo+
IFJlZ2FyZHMsCj4gTGkgV2FuZwo+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
