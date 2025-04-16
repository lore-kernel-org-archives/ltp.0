Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BB8C369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 04:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744778714; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=n0iOAT9mA0hMyN9FPXhROf5JUvpZItSKp2+mQno5T6E=;
 b=HL5bur2OcG5bxrSUBo/cxGF0nt1x9Htjwr4+B1ifL2DP2HgCXJz7pS2ttnNArAmllKbzk
 7haA9fO6+yIWpwS8SYRyVgolDDFXrtqIHkPWpY0VgawFIXHAH5LomRlFF7Oc1+J8JzfIwwu
 oRr7zQ/m5r/gS7Btz3BJoRHqR5CaDkg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C6213CB940
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 06:45:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75E543CB940
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 06:44:46 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5532A60071B
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 06:44:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744778684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2FRjxLT3VDWigYvirL73Sdjo7XSsYUCr62a6pjPHaAM=;
 b=OAr/L4MK6PsgGKmfPo4xGPic759BtvRt18+vVc3AyA9AdvSx2fVO58xqPfuf9i14jyTS7P
 SIAPQpkV3sFMcGxjmvppIw2/WgV180Fc5RzAklxOdTxtKAYOX9PJqOdJNHw/h6ruvIhSzU
 AtAhLVaP2Gi/CS6HHBmtXfqxVJ3UmRg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-Bs2RU5BpMSq6tDajcKtFbg-1; Wed, 16 Apr 2025 00:44:42 -0400
X-MC-Unique: Bs2RU5BpMSq6tDajcKtFbg-1
X-Mimecast-MFC-AGG-ID: Bs2RU5BpMSq6tDajcKtFbg_1744778681
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-30364fc706fso5438400a91.3
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 21:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744778681; x=1745383481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2FRjxLT3VDWigYvirL73Sdjo7XSsYUCr62a6pjPHaAM=;
 b=W6uo9uP8JCe+E1pQzv4xnqjaF0VEL3KPx+Q8E/4sXe8aqTVn2T2C9MXwVuV/0c8r/k
 AHkv56Lx21kP7oDfl0SEvRZitE1Fz0ev5B64McOr0ntcANVTrMtwsV3tG9IubM5JkTGC
 uDJmeL4ASYKnleqrc5iDy2tXEva2oBp2P/Y2YEb/sjzFJXntMlMpy6FxiQv5KsroJLCT
 m8uUVGNi839PorzHGFy0YLwip8p/WU+Y6cQajdJS7ipIc2GZVW8/0EX78KDUbs98I+x+
 yhAci1fZt8Lb5iasbcT114Ufpjo/Ent9BN4hm/3RvmhFLz8vMvNDoGu/dWXLJzAS1OCA
 P27Q==
X-Gm-Message-State: AOJu0Yz5D9tzNLl7UqK88PdsfuO4jkuLjwboT1ERgefzyuFsQdPxuAi9
 3Uy8ZjtjIGSvbZjlYSaQUHE55PeLHg2SF5Nw7hd6R3rgabKSIZw4PNCtpwuc9tHZrB3J6MzAmAx
 wF+Y4+dj1cR/Tz68QG/g7y8mhQbjh0Xmi62I+qnKCuC1EqHCUlX+wM3EhTWLYme9BYxAIVYvFUr
 Pm5iEVD7pbhYfFoq9e/Y/yvRg=
X-Gm-Gg: ASbGncvq3gG17JMbuR6hHmL5psma6nO6Gz7Ho8dJ1gX3jN02fw+l54w8IIEwJ8KKG20
 XRUgJWtLcr+7eVg0NgyR9d9mKoSI51IX6X8aObjR61Ep/xGVHT9HsR+ndjT/akK+PB5la
X-Received: by 2002:a17:90b:58eb:b0:2ee:bc7b:9237 with SMTP id
 98e67ed59e1d1-3086415ce2amr473824a91.27.1744778681333; 
 Tue, 15 Apr 2025 21:44:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9+MyrwYMzxqaC5wtNWNzqNdfPoV4n5Xt5XD5HqAwNGq+SClH4EhbHX3uk84s3EpQ29Il/Qeufe7hffIGdG4Y=
X-Received: by 2002:a17:90b:58eb:b0:2ee:bc7b:9237 with SMTP id
 98e67ed59e1d1-3086415ce2amr473814a91.27.1744778681123; Tue, 15 Apr 2025
 21:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250415220845.548155-1-pvorel@suse.cz>
 <20250415220845.548155-2-pvorel@suse.cz>
In-Reply-To: <20250415220845.548155-2-pvorel@suse.cz>
Date: Wed, 16 Apr 2025 12:44:29 +0800
X-Gm-Features: ATxdqUH52-nImb2VUvS2rdeQgHPFphcx-QhOLXXKuSUKLZ3vXXY7uS0wyXkS2vI
Message-ID: <CAEemH2dUfFr5bHmUuJnWaTc0mf6eSOX840UV--y1rW4J8jfvWw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xfnq9oBHtOpC6ne7OLifph8BQXBufkQtzPhmOfCVgkQ_1744778681
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] cgroup_regression_test.sh: simplify last
 controller detection
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

T24gV2VkLCBBcHIgMTYsIDIwMjUgYXQgNjowOeKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gU2ltcGxpZnkgbGFzdCBjb250cm9sbGVyIGRldGVjdGlvbiBieSB1c2lu
ZyBhd2sgb25seSAtIHJlcGxhY2UgdGFpbCBhbmQKPiBwaXBlIHdpdGggJ0VORCcgYXdrIGNvbW1h
bmQgKHdvcmtzIGFsc28gb24gQnVzeWJveCkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVs
IDxwdm9yZWxAc3VzZS5jej4KPgoKVGVzdGVkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNv
bT4KUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKLS0tCj4gIHRlc3Rj
YXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY2dyb3VwL2Nncm91cF9yZWdyZXNzaW9uX3Rlc3Quc2gg
fCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+
Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY2dyb3VwL2Nncm91
cF9yZWdyZXNzaW9uX3Rlc3Quc2gKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY2dy
b3VwL2Nncm91cF9yZWdyZXNzaW9uX3Rlc3Quc2gKPiBpbmRleCBjMjQxYTVjNGZjLi4yNzYyMzFm
ZThkIDEwMDc1NQo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY2dyb3VwL2Nn
cm91cF9yZWdyZXNzaW9uX3Rlc3Quc2gKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xs
ZXJzL2Nncm91cC9jZ3JvdXBfcmVncmVzc2lvbl90ZXN0LnNoCj4gQEAgLTM1Miw3ICszNTIsNyBA
QCB0ZXN0NygpCj4gICAgICAgICAgICAgICAgIHJldHVybgo+ICAgICAgICAgZmkKPgo+IC0gICAg
ICAgc3Vic3lzPWB0YWlsIC1uIDEgL3Byb2MvY2dyb3VwcyB8IGF3ayAneyBwcmludCAkMSB9J2AK
PiArICAgICAgIHN1YnN5cz0kKGF3ayAnRU5EeyBwcmludCAkMSB9JyAvcHJvYy9jZ3JvdXBzKQo+
Cj4gICAgICAgICAjIHJlbW91bnQgdG8gYWRkIG5ldyBzdWJzeXN0ZW1zIHRvIHRoZSBoaWVyYXJj
aHkKPiAgICAgICAgIHdoaWxlIFsgJGkgLWxlIDIgXTsgZG8KPiAtLQo+IDIuNDkuMAo+Cj4KCi0t
IApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
