Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B81FEB64D7
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 13:41:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4C733CEF3B
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 15:41:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D5B13CC739
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 15:41:28 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A49DB1400BEB
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 15:41:27 +0200 (CEST)
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-443628ee79dso1265142137.1
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687959686; x=1690551686;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yPaxtyuBCwLPaD8RSS8EaZb02FifsjqRTvpRb30GE3g=;
 b=MeeC6RLWsSHHMKVgYkYX5Lq5xXO530qEXgoVCmjTnZDhhtqQqxfvpry/S6KRJCYMGA
 NpHRteUA6IubdjUoHto6TVrdJ2ZBm0Bl2+moTjlGHKkGZqQzZMzhO7H27SJ11yMtwpK0
 Hp1506xYRo9SsYl3u7wTVSmvTzyjcNd6CeXgqC97J/eTsXk5qJ3P+BqT3YSn8FxSFVWe
 SPp4MR1Vq7uUoz6QjvNVr6jeOMU3j4rDB3ul/nZ6B72ACvdhJ6ecq/myYX4dtgqQ1O4s
 QIXHdHRR0a4LO8cLJe9MKPCRqSY5Fg1wLXzHLRxxF6Sht8Vy0yLUpgZQ547ZjLE8ynRx
 TQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687959686; x=1690551686;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yPaxtyuBCwLPaD8RSS8EaZb02FifsjqRTvpRb30GE3g=;
 b=NvY7mX/4LJV6JwTgKtdIUdG3LShs9nNYbVB5MATrXI5nnoCw2RF+yVmx5KqlxJmbQ1
 KwIb4Lf+MHbffzs96cbaIx3qI1nbr2odc67j4GrpWNdKXhKixCtRcvwN5ssdksbQlre3
 a1ORUMlsyLAu0cAUZm0WMOPXp/iFATqL0qHEXdKQjusqAoQVDFn3QQdKPeJdulyOBaG/
 yu9cWZZtN+DYCRVtWNBxENYz53sFASRANL6Hbbzy0QwpMbqJx9gF/oB2jw6iGdv5R0Z7
 mWdl4UoDcjdhVYjlr3zfa+Z/Ga8Bahu0pjGjgCeWTeY3Wohi+z2991mq55gJgiQ5juyv
 qxQw==
X-Gm-Message-State: AC+VfDx8oE0AXiq3LgYS+zq2BCz4dkjmZL4UyJaH9fdhsZcT1ZfnX9b4
 Dgm2ACYeSUT5afDKNDCCP827nd1aeTKbJ/3QkGY=
X-Google-Smtp-Source: ACHHUZ5Lg9ZKuMYnhSqkSRu8lw7tcb/Q7Xk8kxyHjxhE0dtI1K7l83efi2hrJEz2uoI/7v3W+Y+mxpkO3EdHcrzbpaE=
X-Received: by 2002:a67:f711:0:b0:443:9248:3410 with SMTP id
 m17-20020a67f711000000b0044392483410mr484425vso.32.1687959686332; Wed, 28 Jun
 2023 06:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <20230628113853.2b67fic5nvlisx3r@quack3>
In-Reply-To: <20230628113853.2b67fic5nvlisx3r@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Jun 2023 16:41:14 +0300
Message-ID: <CAOQ4uxhcZY1XSZ74wUuy=3tqfEW0vbOuwghc4ZoQt=FZ+Lw4-A@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/3] fanotify accounting for fs/splice.c
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
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 linux-fsdevel@vger.kernel.org, Chung-Chiang Cheng <cccheng@synology.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKdW4gMjgsIDIwMjMgYXQgMjozOOKAr1BNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gSGVsbG8hCj4KPiBPbiBUdWUgMjctMDYtMjMgMjI6NTA6NDYsIEFoZWxlbmlh
IFppZW1pYcWEc2thIHdyb3RlOgo+ID4gQWx3YXlzIGdlbmVyYXRlIG1vZGlmeSBvdXQsIGFjY2Vz
cyBpbiBmb3Igc3BsaWNlOwo+ID4gdGhpcyBnZXRzIGF1dG9tYXRpY2FsbHkgbWVyZ2VkIHdpdGgg
bm8gdWdseSBzcGVjaWFsIGNhc2VzLgo+ID4KPiA+IE5vIGNoYW5nZXMgdG8gMi8zIG9yIDMvMy4K
Pgo+IFRoYW5rcyBmb3IgdGhlIHBhdGNoZXMgQWhlbGVuYSEgVGhlIGNvZGUgbG9va3MgZmluZSB0
byBtZSBidXQgdG8gYmUgaG9uZXN0Cj4gSSBzdGlsbCBoYXZlIG9uZSB1bnJlc29sdmVkIHF1ZXN0
aW9uIHNvIGxldCBtZSB0aGluayBhYm91dCBpdCBsb3VkIGhlcmUgZm9yCj4gZG9jdW1lbnRhdGlv
biBwdXJwb3NlcyA6KS4gRG8gd2Ugd2FudCBmc25vdGlmeSAoYW55IGZpbGVzeXN0ZW0KPiBub3Rp
ZmljYXRpb24gZnJhbWV3b3JrIGxpa2UgaW5vdGlmeSBvciBmYW5vdGlmeSkgdG8gYWN0dWFsbHkg
Z2VuZXJhdGUKPiBldmVudHMgb24gRklGT3M/IEZJRk9zIGFyZSB2aXJ0dWFsIG9iamVjdHMgYW5k
IGFyZSBub3QgcGFydCBvZiB0aGUKPiBmaWxlc3lzdGVtIGFzIHN1Y2ggKHdlbGwsIHRoZSBpbm9k
ZSBpdHNlbGYgYW5kIHRoZSBuYW1lIGlzKSwgaGVuY2UKPiAqZmlsZXN5c3RlbSogbm90aWZpY2F0
aW9uIGZyYW1ld29yayBkb2VzIG5vdCBzZWVtIGxpa2UgYSBncmVhdCBmaXQgdG8gd2F0Y2gKPiBm
b3IgY2hhbmdlcyBvciBhY2Nlc3NlcyB0aGVyZS4gQW5kIGlmIHdlIHNheSAieWVzIiBmb3IgRklG
T3MsIHRoZW4gd2h5IG5vdAo+IEFGX1VOSVggc29ja2V0cz8gV2hlcmUgZG8gd2UgZHJhdyB0aGUg
bGluZT8gQW5kIGlzIGl0IGFsbCB3b3J0aCB0aGUKPiB0cm91YmxlPwo+Cj4gSSB1bmRlcnN0YW5k
IHRoZSBjb252ZW5pZW5jZSBvZiBpbm90aWZ5IHdvcmtpbmcgb24gRklGT3MgZm9yIHRoZSAidGFp
bCAtZiIKPiB1c2VjYXNlIGJ1dCB0aGVuIHdvdWxkbid0IHRoaXMgYmV0dGVyIGJlIGZpeGVkIGlu
IHRhaWwoMSkgaXRzZWxmIGJ5IHVzaW5nCj4gZXBvbGwoNykgZm9yIEZJRk9zIHdoaWNoLCBhcyBJ
J3ZlIG5vdGVkIGluIG15IG90aGVyIHJlcGx5LCBkb2VzIG5vdCBoYXZlCj4gdGhlIHByb2JsZW0g
dGhhdCBwb2xsKDIpIGhhcyB3aGVuIHRoZXJlIGFyZSBubyB3cml0ZXJzPwo+Cj4gQW5vdGhlciBp
c3N1ZSB3aXRoIEZJRk9zIGlzIHRoYXQgdGhleSBkbyBub3QgaGF2ZSBhIGNvbmNlcHQgb2YgZmls
ZQo+IHBvc2l0aW9uLiBGb3IgaGllcmFyY2hpY2FsIHN0b3JhZ2UgdXNlY2FzZSB3ZSBhcmUgaW50
cm9kdWNpbmcgZXZlbnRzIHRoYXQKPiB3aWxsIHJlcG9ydCBmaWxlIHJhbmdlcyBiZWluZyBtb2Rp
ZmllZCAvIGFjY2Vzc2VkIGFuZCBvZmZpY2lhbGx5IHN1cHBvcnRpbmcKPiBGSUZPcyBpcyBvbmUg
bW9yZSBzcGVjaWFsIGNhc2UgdG8gZGVhbCB3aXRoLgo+Cj4gV2hhdCBpcyBzdXBwb3J0aW5nIHlv
dXIgY2hhbmdlcyBpcyB0aGF0IGZzbm90aWZ5IG1vc3RseSB3b3JrcyBmb3IgRklGT3MKPiBhbHJl
YWR5IG5vdyAobm9ybWFsIHJlYWRzICYgd3JpdGVzIGdlbmVyYXRlIG5vdGlmaWNhdGlvbikgc28g
c3BsaWNlIG5vdAo+IHdvcmtpbmcgY291bGQgYmUgdmlld2VkIGFzIGFuIGluY29uc2lzdGVuY3ku
IFNvY2tldHMgKGFsdGhvdWdoIHRoZXkgYXJlCj4gdmlzaWJsZSBpbiB0aGUgZmlsZXN5c3RlbSkg
Y2Fubm90IGJlIG9wZW4gc28gZm9yIHRoZW0gdGhlIGlsbHVzaW9uIG9mIGJlaW5nCj4gYSBmaWxl
IGlzIGV2ZW4gd2Vha2VyLgo+Cj4gU28gb3ZlcmFsbCBJIGd1ZXNzIEknbSBzbGlnaHRseSBpbiBm
YXZvciBvZiBtYWtpbmcgZnNub3RpZnkgZ2VuZXJhdGUgZXZlbnRzCj4gb24gRklGT3MgZXZlbiB3
aXRoIHNwbGljZSwgcHJvdmlkZWQgQW1pciBkb2VzIG5vdCBzZWUgYSBiaWcgdHJvdWJsZSBpbgo+
IHN1cHBvcnRpbmcgdGhpcyB3aXRoIGhpcyB1cGNvbWluZyBIU00gY2hhbmdlcy4KPgoKSSd2ZSBh
bHNvIHRob3VnaHQgYWJvdXQgdGhpcy4KClRoZSB0aGluZyBhYm91dCB0aGUgSFNNIGV2ZW50cyBp
cyB0aGF0IHRoZXkgYXJlIHBlcm1pc3Npb24gZXZlbnRzCmFuZCBqdXN0IGxpa2UgRkFOX0FDQ0VT
U19QRVJNLCB0aGV5IG9yaWdpbmF0ZSBmcm9tIHRoZSBjb21tb24KYWNjZXNzIGNvbnRyb2wgaGVs
cGVycyB7cncscmVtYXB9X3ZlcmlmeV9hcmVhKCksIHdoaWNoIGFsc28gaGFwcGVuCnRvIGhhdmUg
dGhlIGZpbGUgcmFuZ2UgaW5mbyAod2l0aCBwcG9zIE5VTEwgZm9yIHBpcGVzKS4KCkFoZWxlbmlh
J3MgcGF0Y2hlcyBkbyBub3QgYWRkIGFueSBuZXcgcndfdmVyaWZ5X2FyZWEoKSB0byBwaXBlcwpz
byBubyBuZXcgRkFOX0FDQ0VTU19QRVJNIGV2ZW50cyB3ZXJlIGFkZGVkLgoKSWYgd2UgY291bGQg
Z28gYmFjayB0byB0aGUgZGVzaWduIG9mIGZhbm90aWZ5IHdlIHdvdWxkIGhhdmUgcHJvYmFibHkK
bWFkZSBpdCBleHBsaWNpdCB0aGF0IHBlcm1pc3Npb24gZXZlbnRzIGFyZSBvbmx5IGFsbG93ZWQg
b24gcmVndWxhcgpmaWxlcyBhbmQgZGlycy4gRm9yIHRoZSBuZXcgSFNNIGV2ZW50cyB3ZSBjYW4g
KGFuZCB3aWxsKSBkbyB0aGF0LgoKSW4gYW55IGNhc2UsIHRoZSBuZXcgZXZlbnRzIGFyZSBzdXBw
b3NlZCB0byBiZSBkZWxpdmVyZWQgd2l0aApmaWxlIGFjY2VzcyByYW5nZSByZWNvcmRzLCBzbyBk
ZWxpdmVyaW5nIEhTTSBldmVudHMgb24gcGlwZXMKd291bGRuJ3QgbWFrZSBhbnkgc2Vuc2UuCgpT
byBJIGRvIG5vdCBzZWUgYW55IHByb2JsZW0gd2l0aCB0aGVzZSBwYXRjaGVzIHdydCB1cGNvbXBp
bmcKSFNNIGV2ZW50cy4KCkhvd2V2ZXIsIG5vdGUgdGhhdCB0aGVzZSBwYXRjaGVzIGNyZWF0ZSBt
b3JlIGluY29uc2lzdGVuY2llcwpiZXR3ZWVuIElOX0FDQ0VTUyBhbmQgRkFOX0FDQ0VTU19QRVJN
IG9uIHBpcGVzLgoKV2UgY2FuIGxlYXZlIGl0IGF0IHRoYXQgaWYgd2Ugd2FudCwgYnV0IGZpeGlu
ZyB0aGUgaW5jb25zaXN0ZW5jaWVzCmJ5IGFkZGluZyBtb3JlIEZBTl9BQ0NFU1NfUEVSTSBldmVu
dHMgb24gcGlwZXMgLSB0aGlzCmlzIG5vdCBzb21ldGhpbmcgdGhhdCBJIHdvdWxkbid0IGJlIGNv
bWZvcnRhYmxlIHdpdGguCgpJZiBhbnl0aGluZywgd2UgY2FuIHJlbW92ZSBGQU5fQUNDRVNTX1BF
Uk0gZXZlbnRzIGZyb20Kc3BlY2lhbCBmaWxlcyBhbmQgc2VlIGlmIGFueWJvZHkgY29tcGxhaW5z
LgoKSSBkb24ndCBrbm93IG9mIGFueSB1c2VycyBvZiBGQU5fQUNDRVNTX1BFUk0gYW5kIGV2ZW4g
Zm9yCkZBTl9PUEVOX1BFUk0sIEkgZG9uJ3QgdGhpbmsgdGhhdCBBVi12ZW5kb3JzIGhhdmUgYW55
dGhpbmcKdXNlZnVsIHRvIGRvIHdpdGggb3BlbiBwZXJtaXNzaW9uIGV2ZW50cyBvbiBzcGVjaWFs
IGZpbGVzLgoKVGhhbmtzLApBbWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
