Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BC2C282C6
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 01:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741050033; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=MROf9U+7e+hZrvaq+LJS9Ihd8P7Ja/PCiXH2KyIfwtQ=;
 b=CavX3935o77ZrgIGQALUn6S/6heyt4RbeAGmEnwWIV+sQhwKSDyaozp2ZyOQcfFS7zqsB
 GtIVTcaShV/HF80o8LofpXgZuIhi9qlATOSyetGH9HyDZThnwALfAY11peVtXT5AUx03ZoO
 dmfslkWTE/ng0sZDO2G4XQgL1brBDi0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97DDC3C2E57
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 02:00:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8E943C65A8
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 02:00:12 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4A79E1A00FA6
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 02:00:12 +0100 (CET)
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-86b2cc89e4aso4482500241.1
 for <ltp@lists.linux.it>; Mon, 03 Mar 2025 17:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1741050011; x=1741654811; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q3LaxJgzsMX4qJVjOlwS0IokvICaHlLtQsoaRVSI0W8=;
 b=i+EcYaYxEJznJQmYRtVxyA1w/Tcn4ELwEW8TaHVtMelLWDUCPb016PfiRiJoRTFYZ4
 E83OGJgOsQZt6YJY0T3mUU59VngQLbjknE7DaWE/A0y7XdBybRaOi/ycfnbIUk0fiQAJ
 hnDngZ0ef3RjjsFRoDqIXak3MtKKPi5N77evCca0p03kUTstrgz5l95NVETcEbCswCCV
 eMsb1Tf2zB67X2Al+c47KoGbKE7sa9dfI/cFAFm+4tpVW/CFjiC4cnhNv072e9TJCaV0
 53UWEQ/cwNWfx5BVnW50qqzni5/KNLjMBqkqMxW2irN0vARcwLc2WXoJLMd+YCz+xtnb
 yt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741050011; x=1741654811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q3LaxJgzsMX4qJVjOlwS0IokvICaHlLtQsoaRVSI0W8=;
 b=XXWfzEMomAxxgY71QvTyBRFEQR7mSOiJdQaUFgu3RHYENJt+yVXcbZkgA8bj9xqgCE
 qagbecbrViFVLM4CCv49InZVXRoQpRbZFPdC+fWHz629lH2L/PwN3jOdolKW0cUObPjs
 z0efmo6KI7gJLQnYQxgFdhw8a0ZzAVrQ41XetlUS6gyyLs0x+mlEb3JBxFEorGR3dGyr
 121WM4eHo/zPsyvewMBbr7E7qbb30g5/ihRS8JdJ64KtvQahyaEMfqN3JuXayIFE6y7/
 sJWpWmITqsUsiVDA3u5YxJdE/GxWaEuPvWMrh9j2wH2UjABvutPiURwLQtE0Zsz4xZIa
 C9Lg==
X-Gm-Message-State: AOJu0YyDoq0YQfuX4XAqqkVZqV5OuliPsSS5PqmVhRAZVGbqlzMy6YyI
 JODz7V0lO6QUwdVvEbGd9N1f1/awWylQH5BOBzBAOb15e3BWeFV2pNh4/JClLIHMYAap8HDTEIl
 sFR3+oEPfrLMN22pZjgrftOczE0sLI9QHe019
X-Gm-Gg: ASbGncvO1jY2rU4ZELq3X7/3bvAIz4MKky/j8R0PeQSk6eBtRtBKf53qh/d+cZLnYAA
 BLlXGmgmeamHgeOehAtrgHFIAl7BPYt/J4EeTwp9TBNEIIpDmAihQEC0ynMe6b95mVvJ/8MFEUT
 dYN/cbEHo0oIwkaGrY376FZYDqaRFoN2gQMJb9lxVTzQwVqGZTkz9WFTbW
X-Google-Smtp-Source: AGHT+IGyh5wbVhw1nXC6xZxhJOLOIuVUkIu1AlP9UeM1Bh2xNKnozAKHbW88f1Mw5TV2K8ohoPY6O4baEuGwiiiRxF0=
X-Received: by 2002:a05:6102:dd2:b0:4bb:d64d:8331 with SMTP id
 ada2fe7eead31-4c044987b91mr10891639137.11.1741050010720; Mon, 03 Mar 2025
 17:00:10 -0800 (PST)
MIME-Version: 1.0
References: <20250228184834.1330657-1-edliaw@google.com>
 <CAEemH2e-eEvbOT_ByL1cwJODUg7rS16nO0aYVd4DFCAQB=7uPA@mail.gmail.com>
 <CAG4es9Xqe2yO2oFJxNxic5WCXwvpgKhQ=afJbNv=xDp7c2PtLA@mail.gmail.com>
In-Reply-To: <CAG4es9Xqe2yO2oFJxNxic5WCXwvpgKhQ=afJbNv=xDp7c2PtLA@mail.gmail.com>
Date: Mon, 3 Mar 2025 16:59:43 -0800
X-Gm-Features: AQ5f1JodJZ0dblcJUmutwFzB-T-Db1t1_UIMGCGMkSRl64IthbejTh3AU7Y5_ag
Message-ID: <CAG4es9VUWVEmHzBgo66KKsqQwm9j0v2uqk-2ybfE4iM9=bGuTA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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

T24gTW9uLCBNYXIgMywgMjAyNSBhdCAxMDozNOKAr0FNIEVkd2FyZCBMaWF3IDxlZGxpYXdAZ29v
Z2xlLmNvbT4gd3JvdGU6Cgo+Cj4KPiBPbiBNb24sIE1hciAzLCAyMDI1IGF0IDE6MzXigK9BTSBM
aSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPj4KPj4KPj4gT24gU2F0LCBNYXIg
MSwgMjAyNSBhdCAyOjQ54oCvQU0gRWR3YXJkIExpYXcgdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4
Lml0Pgo+PiB3cm90ZToKPj4KPj4+IEFuZHJvaWQgaGFzIGEgZGVsYXkgYmV0d2VlbiB0aGUgZW50
cnkgaW4gL3Byb2MvYnVzL2lucHV0L2RldmljZXMgYW5kIHRoZQo+Pj4gcGF0aCAvZGV2L2lucHV0
L2V2ZW50TiBiZWNvbWluZyBhY2Nlc3NpYmxlLiAgQWRkIGEgcmV0cnkgbG9vcCB0byBhY2NvdW50
Cj4+PiBmb3IgdGhpcy4KPj4+Cj4+Cj4+IERpZCB5b3UgY291bnQgZm9yIGhvdyBsb25nIGl0IHRh
a2VzIHRvIGVudHJ5PyBUaGUgZGVmYXVsdCB0aW1lCj4+IFRTVF9SRVRSWV9GVU5DCj4+IGlzIGJh
Y2tvZmYgMSBzZWNvbmQsIGlmIHRoYXQgdGltZSBpcyBub3QgZW5vdWdoLCB5b3UgY2FuIGNvbnNp
ZGVyIHRoZQo+PiBjb21wbGV0ZWQKPj4gdmVyc2lvbiBUU1RfUkVUUllfRk5fRVhQX0JBQ0tPRkYg
Zm9yIHNldHRpbmcgbW9yZSBzZWNvbmRzLgo+Pgo+PiBBbnl3YXksIHRoaXMgbG9va3MgZ29vZC4K
Pj4gUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+Pgo+Cj4gWWVhaCwg
MSBzZWMgc2hvdWxkIGJlIG1vcmUgdGhhbiBlbm91Z2ggZm9yIEFuZHJvaWQ7IHRoZSBkZWxheSBo
YXMgc28gZmFyCj4gYmVlbiBvbiB0aGUgb3JkZXIgb2YgbWljcm9zZWNvbmRzLgo+ClNvcnJ5LCBt
aWxsaXNlY29uZHMqIG5vdCBtaWNyb3NlY29uZHMuCj4KPgo+Pgo+Pgo+Pj4KPj4+IFNpZ25lZC1v
ZmYtYnk6IEVkd2FyZCBMaWF3IDxlZGxpYXdAZ29vZ2xlLmNvbT4KPj4+IC0tLQo+Pj4gIHRlc3Rj
YXNlcy9rZXJuZWwvaW5wdXQvaW5wdXRfY29tbW9uLmggfCAyICstCj4+PiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvaW5wdXQvaW5wdXRfY29tbW9uLmgKPj4+IGIvdGVzdGNhc2VzL2tlcm5l
bC9pbnB1dC9pbnB1dF9jb21tb24uaAo+Pj4gaW5kZXggMGFjMTYyNGIzLi41YjE3NTU3NzEgMTAw
NjQ0Cj4+PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL2lucHV0L2lucHV0X2NvbW1vbi5oCj4+PiAr
KysgYi90ZXN0Y2FzZXMva2VybmVsL2lucHV0L2lucHV0X2NvbW1vbi5oCj4+PiBAQCAtMjksNyAr
MjksNyBAQCBzdGF0aWMgaW5saW5lIGludCBvcGVuX2V2ZW50X2RldmljZSh2b2lkKQo+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgbWVtc2V0KHBhdGgsIDAsIHNpemVvZihwYXRoKSk7Cj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgICBzbnByaW50ZihwYXRoLCBzaXplb2YocGF0aCksICIvZGV2
L2lucHV0LyVzIiwKPj4+IGRldmljZSk7Cj4+Pgo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAg
aWYgKCFhY2Nlc3MocGF0aCwgRl9PSykpIHsKPj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGlm
ICghVFNUX1JFVFJZX0ZVTkMoYWNjZXNzKHBhdGgsIEZfT0spLAo+Pj4gVFNUX1JFVFZBTF9FUTAp
KSB7Cj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRzdF9yZXMoVElORk8sICJG
b3VuZCBldmVudCBkZXZpY2U6ICVzIiwKPj4+IHBhdGgpOwo+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBicmVhazsKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgIH0KPj4+IC0t
Cj4+PiAyLjQ4LjEuNzExLmcyZmVhYmFiMjVhLWdvb2cKPj4+Cj4+Pgo+Pj4gLS0KPj4+IE1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Pj4KPj4+
Cj4+Cj4+IC0tCj4+IFJlZ2FyZHMsCj4+IExpIFdhbmcKPj4KPgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
