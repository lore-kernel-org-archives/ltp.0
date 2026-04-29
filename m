Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182C1FF8875
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 09:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777456143; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=OgBYtz+TdDwgzhQ/J0JzMMEdfGp10sxLi+J/hP17oeE=;
 b=JYlrEI1aMwjagM+wd+yO1hRNtKlyfTPcfVcDJvcfN5pRX8KTWeqij8K61QoVJ4YooHQaK
 F1tQ+KLECpPVH+OGWvG6s3YKW0MfEy4b0lJ/6+AB681SLb7fdtXhMBvY1rHpwbQh7VJJGQj
 MOz/cYqLnL1VYNhlNIxW1rXX8/fbN9M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABFCE3E2D43
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 11:49:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40EDD3C2C93
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 11:48:41 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8F91A1A00906
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 11:48:40 +0200 (CEST)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35fb0bb27e7so8339273a91.1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 02:48:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777456119; cv=none;
 d=google.com; s=arc-20240605;
 b=aJhHGPrUHsW8GaL9IuQY3l9pWtVBCPkYnwcdcslupKiNns52nIcvGi5Hh6ZfaDKtKG
 fV6mbvTB1/MyHOoV3z/70hs6Na51RYrNhIul+ebnnOXfvvrsrgYYseLN9m3fHgT+UB+6
 BPdNksT9JWoxmgL4dm4OM5MEkkLaFTkF4E0GbU+2GMIS1qPlraBA3uC6+u/lZ4zjlMkN
 CMMjXkN3fQHXndAXmu4lAUQIeoN6lrn4fspzApbekggTuLl0nDsYrykxF6kg1XMFD/hs
 QMy4GOX6sRK6uQHD23fZ84NxzDqMzifsoj3c7izJOr+t35G60jPKa5biZBpLr3UsBSDe
 +pjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GhGrws1hNi+ZcCcsfWUM++uhI+tRKeHLBdHZWgHwBIw=;
 fh=qFEG16QLF8nzMvpGOA11J1RuCwVQ35mvz3NsCaNtro8=;
 b=JFW9h/V2oRFqnncXFy9/+jvmrxwQmDt6lJzWiX2i246j3bsDpPruLRoX4mHbbwTVYx
 goyLmx7oxKWSYmPyrK2dxALz1Vewu1ebVOLxgJFJYsk0f8TylMk21OgKZ+CHrcgbnh6W
 ROkx7Y81XEQgT1guEasd9jE6XTTgzDOGOgfRi5Cc3Q07uSDFeQo3XulwTXplcblTg03A
 PvVfPZV4ImbBDsUkR3qv5Ede7Ts+JV93PXYnl4A+nkE2KqCoLZl6F3sDXPP82Xo/hU3u
 vPOjf+35YTBdfkmKEid3jvDxV+Cc2AN8jUM0m6pNz2yxtbvNdolKE56lEujE2DAcBSCH
 Y9+w==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777456119; x=1778060919; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhGrws1hNi+ZcCcsfWUM++uhI+tRKeHLBdHZWgHwBIw=;
 b=Jm9RTnnv5GWZ0mFOJV/DXJgsUXc+QANe0kT8vRnpEzRjkeyGuG2eaaEZXVZftnFr17
 ulTT5F7vVmWe+1VM8qpRsF/pju/OC1em8QUlVMQBpHatJ5QaRJTWry8tufHMofNA7ono
 s3YBc5E8KyljIIvZmsXk4hmcPzqqeDHChPJdx/PLG2UyKRf99gHzdhUw6gNH5qVTb0bj
 YM2Ya35LX7bXS6iEU6H0DRnFMWNde2AovgGwhPPztPxeQ+aIpIEkExpmFLOHLJe73wkr
 oGL+2J0unAgyQKGrqgRZjHbZAF+Zq+OtgIAwHzAmGCo5ZokHael4QjxxjheJBGJlvZft
 rIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777456119; x=1778060919;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GhGrws1hNi+ZcCcsfWUM++uhI+tRKeHLBdHZWgHwBIw=;
 b=oI03CgBqSVqnk/Fvoa+XV72+O9LSuY+o25Kg5nqbdIired1dbJd7P81nIIjLO4pzhl
 m0GC1olvOnjckrEQgACDN1CVFtxfNhiP0MJXdgTkqdD3JslfVFecpqVyq1BHruXiz606
 YkHH3w0Mjb0+vJVPVn3a8UZMJNCtlE/HwiCvI+vmDWhohom6IPXO7eohixGIa0AUzkBc
 tuhDHKgh8NieJKUmX6hlX6SC3aOEdA/2PjiVw391eB4NJNBTIxuEOcpeGz+SI+6wi2QU
 ZqGVgStKQdoAw/W4IA21sR4oQGaHGnbY7+hV18KtHc3Acj3JOfr4mQsIhu5RjYisB/19
 /guw==
X-Gm-Message-State: AOJu0Yy2qXo8vsG1LAfBCye30Inl9koGsmTetnOfRjOHoqhMsTZgViUr
 v3Azk9fXwVL7hw01y5SM8gB67EYiiMox2l0QEZCrcw/1URM82WqGJAWYWHoUl2wIrCXklrT5aJv
 YJgcZ3VfqIFSc1ugn3ciNsFD2jdefgSyOmQYzfavAN6SKyCeyLK9hTcykjFY=
X-Gm-Gg: AeBDiev8TIIwua4iN9l6zIoOcX+RR5Q0ti+5pLFEkKI37sb5nmcIKCtftU3WKHanw0W
 nQ+gjXwXiJm4nnidcrt9ZBrXiHX/dtK83+wItbhpwXGF5vCcixI3bPDXxpcsfahpoMQYEvojh6f
 sWbdwCQfcFkx+kV+nEPZFt740UtpEGpXH2S7tgTwloq2tt4x+mvYbJiFl7yTLYEO1GQEjwHq/UX
 MjVikhmCSrOHdm7g21vaQUm8+yrf1QnkIEQhFjy4Jln3CeJRkuSI7enTKOJHNhRQpXxiWa0Y/05
 3PDjGHwU5aFqZ701F6AgDET2ku+7y/5II8g2vVGszmD4j1y3k1N02FSOl2M=
X-Received: by 2002:a17:90b:3d8d:b0:35e:577c:c9f with SMTP id
 98e67ed59e1d1-364a0b317b8mr3065898a91.9.1777456118435; Wed, 29 Apr 2026
 02:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAOcRiAEh+CFKBeaT+beQzhX_TRNiau4zP0iCuRFsahPkw7WhxA@mail.gmail.com>
 <69f1cdbc.050a0220.29173d.95d4@mx.google.com>
In-Reply-To: <69f1cdbc.050a0220.29173d.95d4@mx.google.com>
Date: Wed, 29 Apr 2026 17:48:02 +0800
X-Gm-Features: AVHnY4L8_L6nfWo_VH7O9iygdGqNDFQSUm73tpSq6Mgq-LxvExsACW_Hbwz71MY
Message-ID: <CAOcRiAEQnOGn7X5U51Jr_dYGCc6mRYwL_Vh68FNtkvRXXrCh7g@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/userfaultfd: Handle ENOSYS in
 SAFE_USERFAULTFD
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: rbranco@suse.com, Wake Liu via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

IFRoYW5rIHlvdSBmb3IgeW91ciByZXBseSBhbmQgZm9yIHBvaW50aW5nIG91dCB0aGUgYmVoYXZp
b3Igb2YgdHN0X3N5c2NhbGwoKS4KCiAgICBJIG11c3QgYXBvbG9naXplIGZvciB0aGUgY29uZnVz
aW9uLiBZb3UgYXJlIGFic29sdXRlbHkgY29ycmVjdAp0aGF0IHRzdF9zeXNjYWxsKCkgYXV0b21h
dGljYWxseSBoYW5kbGVzIEVOT1NZUyBhbmQKICByZXR1cm5zIFRDT05GLiBJIGFzc3VtZWQgaXQg
d2FzIEVOT1NZUyB3aXRob3V0IGxvb2tpbmcgY2xvc2VseSBhdAp0aGUgZXhhY3QgZXJyb3IgY29k
ZSBpbiB0aGUgbG9ncy4KCiAgICBBZnRlciBjaGVja2luZyB0aGUgbG9ncyBhZ2FpbiwgSSBmb3Vu
ZCB0aGF0IGluIG91ciBBbmRyb2lkIEdLSQp0ZXN0aW5nIGVudmlyb25tZW50IChrZXJuZWwgNi4x
Mi43NC1hbmRyb2lkMTYpLCB0aGUKICB1c2VyZmF1bHRmZCgpIHN5c2NhbGwgYWN0dWFsbHkgcmV0
dXJucyBFT1BOT1RTVVBQICg5NSkgaW5zdGVhZCBvZgpFTk9TWVMgd2hlbiBDT05GSUdfVVNFUkZB
VUxURkQgaXMgZGlzYWJsZWQuCgogICAgSGVyZSBpcyB0aGUgcmVsZXZhbnQgbG9nIHNuaXBwZXQg
Zm9yIHVzZXJmYXVsdGZkMDQ6CgogICAgZXh0ZXJuYWwvbHRwL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvdXNlcmZhdWx0ZmQvdXNlcmZhdWx0ZmQwNC5jOjczOgpUQlJPSzogc3lzY2FsbChfX05S
X3VzZXJmYXVsdGZkLCA1MjYzMzYpCiAgZmFpbGVkOiBFT1BOT1RTVVBQICg5NSkKCiAgICBCZWNh
dXNlIHRoZSBlcnJvciB3YXMgRU9QTk9UU1VQUCwgdGhlIFRDT05GIGxvZ2ljIGluIHRzdF9zeXNj
YWxsKCkKKHdoaWNoIG9ubHkgY2hlY2tzIGZvciBFTk9TWVMpIHdhcyBieXBhc3NlZCwgYW5kCiAg
dGhlIGVycm9yIGZlbGwgdGhyb3VnaCB0byBzYWZlX3VzZXJmYXVsdGZkKCkuIFNpbmNlCnNhZmVf
dXNlcmZhdWx0ZmQoKSBvbmx5IGhhbmRsZXMgRVBFUk0gZm9yIFRDT05GIGFuZCBkZWZhdWx0cyB0
bwogIFRCUk9LIGZvciBldmVyeXRoaW5nIGVsc2UsIGl0IHJlc3VsdGVkIGluIHRoZSBUQlJPSyBm
YWlsdXJlLgoKICAgIEdpdmVuIHRoaXMgYmVoYXZpb3IsIEkgdGhpbmsgd2Ugc2hvdWxkIHVwZGF0
ZSB0aGUgcGF0Y2ggdG8gaGFuZGxlCkVPUE5PVFNVUFAgaW4gc2FmZV91c2VyZmF1bHRmZCgpIGFz
IHdlbGwgKGFuZCBtYXliZQogIGtlZXAgRU5PU1lTIGp1c3QgaW4gY2FzZSBvdGhlciBrZXJuZWxz
IGRvIHJldHVybiBpdCkuCgogICAgV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgdGhpcz8gSSB3b3Vs
ZCBiZSBoYXBweSB0byBzZW5kIGEgdjIgcGF0Y2gKYWRkcmVzc2luZyB0aGlzLgoKCkFuZHJlYSBD
ZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+IOaWvCAyMDI25bm0NOaciDI55pel
6YCx5LiJIOS4i+WNiDU6MjLlr6vpgZPvvJoKPgo+ID4gSSBlbmNvdW50ZXJlZCB0aGlzIGlzc3Vl
IGR1cmluZyBBbmRyb2lkIEdLSSAoR2VuZXJpYyBLZXJuZWwgSW1hZ2UpIGFuZAo+ID4gVlRTIChW
ZW5kb3IgVGVzdCBTdWl0ZSkgdGVzdGluZyBvbiB2YXJpb3VzIGRldmljZSB0YXJnZXRzIChlLmcu
LCBQaXhlbAo+ID4gNiwgdmlydHVhbCBkZXZpY2VzKS4gSW4gb3VyIHRlc3RpbmcgZW52aXJvbm1l
bnQsIHdlIHJ1biB0aGUgc2FtZSB0ZXN0Cj4gPiBzdWl0ZSBhZ2FpbnN0IGEgd2lkZSB2YXJpZXR5
IG9mIGtlcm5lbCB2ZXJzaW9ucyBhbmQgY29uZmlndXJhdGlvbnMuCj4gPgo+ID4gU3BlY2lmaWNh
bGx5LCBvbiBzb21lIGtlcm5lbHMgd2hlcmUgQ09ORklHX1VTRVJGQVVMVEZEIGlzIGRpc2FibGVk
LAo+ID4gdGhlIHVzZXJmYXVsdGZkKCkgc3lzY2FsbCByZXR1cm5zIEVOT1NZUy4gV2hpbGUgeW91
IG1lbnRpb25lZAo+ID4gdHN0X3N5c2NhbGwoKSBoYW5kbGVzIGl0LCBpbiB0aGUgdmVyc2lvbi9j
b25maWd1cmF0aW9uIHdlIGFyZSB1c2luZywKPiA+IHRzdF9zeXNjYWxsKCkgcmV0dXJucyAtMSBh
bmQgc2V0cyBlcnJubyB0byBFTk9TWVMuIFRoaXMgaXMgdGhlbiBwYXNzZWQKPiA+IHRvIHNhZmVf
dXNlcmZhdWx0ZmQoKSwgd2hpY2ggY3VycmVudGx5IG9ubHkgY2hlY2tzIGZvciBFUEVSTSB0byBz
a2lwCj4gPiAoVENPTkYpIGFuZCBmYWxscyBiYWNrIHRvIFRCUk9LIGZvciBhbnkgb3RoZXIgZXJy
b3IsIGluY2x1ZGluZyBFTk9TWVMuCj4KPiBJJ20gYSBiaXQgcHV6emxlZCBiZWNhdXNlIGFjY29y
ZGluZyB0byB0aGUgdHN0X3N5c2NhbGwoKSBpbXBsZW1lbnRhdGlvbgo+IHRoaXMgc2hvdWxkIG5v
dCBoYXBwZW4uIElmIHN5c2NhbGwgcmV0dXJucyAtMSB3aXRoIGVycm5vID09IEVOT1NZUywKPiB0
aGUgdHN0X3N5c2NhbGwoKSBpbXBsZW1lbnRhdGlvbiB3aWxsIGFsd2F5cyBUQ09ORi4gVGhpcyBp
cyB2aXNpYmxlCj4gaW4gaW5jbHVkZS9sYXBpL3N5c2NhbGxzLmggZ2VuZXJhdGVkIGJ5IHRoZSBi
dWlsZCBzeXN0ZW0gYmVmb3JlCj4gY29tcGlsaW5nLgo+Cj4gUGxlYXNlIHByb3ZpZGUgdGhlIGV4
YWN0IHRlc3QgdGhhdCBpcyBmYWlsaW5nLCBhcyB3ZWxsIGFzIHRoZSBsb2dzCj4geW91IGhhdmUg
c2VlbiBoYXZpbmcgdGhpcyBpc3N1ZS4KPgo+IFJlZ2FyZHMsCj4gLS0KPiBBbmRyZWEgQ2VydmVz
YXRvCj4gU1VTRSBRRSBBdXRvbWF0aW9uIEVuZ2luZWVyIExpbnV4Cj4gYW5kcmVhLmNlcnZlc2F0
b0BzdXNlLmNvbQoKCgotLSAKQmVzdCBSZWdhcmRzLApXYWtlIExpdQoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
