Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2858EE77188
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 01:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1735868607; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1RCtAQe5vTocpDGkvG3Lw5RYN30jl9qBwxFra5RyU2U=;
 b=gt7vsx7qytSPT55oqcP9bZEQTu0FPIXzUZ5DLWMaEDe2Z8BxZYqC9LHFbWpWdpJW0VK27
 C/3C0qZXw3x270gTvrdItPkaqRmLRw3nLkZOi7gS6ZQOxDaSj0gFp9GpG/wxCd/Lv7vAaUD
 S/DDB/JnFZ1JBvno0RmyQBscCcOjuoI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 312983F0A65
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 02:43:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 795883F0A4F
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 02:43:06 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 99209652029
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 02:43:04 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361f796586so122816255e9.3
 for <ltp@lists.linux.it>; Thu, 02 Jan 2025 17:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1735868584; x=1736473384; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qVh0InDCaRTGz8tucOn4oxe6wyXeIyRpViy8SFPJfdk=;
 b=N8k9PFiyNcR5SghCgJzUBMVIvMQqE19jmaFgw30sW5aRgAhpm+u6a1s9SZgV5rc3+j
 ywFc1dHnWzkrRr0UO+k4My2C2Pjmm0KmfDx/mL9Sq16LQlNMiH+KYc2Jt1fOH5IUV9dE
 rff4zqomynZZqPFLUo3TvAx8aYpvLwsH4yOd9rTInm3z0ksryyCD5NdHFz4y2XqfMA4a
 iEZRNrbZ2Rex7Xl5p8fP9bXuAMeksEwRGHCho5DgZtDTxK+rVmnZ2pzbQJIgpIsoUVpx
 WeEC2d5xf7lBpDauTNtY5hSxKlgamBiDD7RwPcJBl7mjsWca3UgSuiRw4EX9KPlgfpTd
 xWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735868584; x=1736473384;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qVh0InDCaRTGz8tucOn4oxe6wyXeIyRpViy8SFPJfdk=;
 b=W4Ec7QbrrLi8uIlcjuxtKRcu56uZNZZCCKdYgGJeTibM+FwdPisEXu2BKtZDb1CleM
 0egOmiyrlwn0+27Ecrf8CEwad+3npk9KGfwiW9xkLtG9WEFc3inZ18xaCtLW58TT35fH
 /Y+xTwxDn1HbBWcFWCt9IJWcVDkymvC6iLb09ALU3OKPF0mPzE8F+yuLeKJVvG7A/MsQ
 tpN8fLclFrduu/c4J9mdxNLk5411XaJdUAxNQcJFH1LKfd6a2jlSHtX2T0gJFCbFvNho
 RkF9jQl56EQoiqnb/EdAHkr6CuJNx9QbvfqhsmNAxjDtHmkLlAY5lzATt5u0QfCEDywf
 J+uw==
X-Gm-Message-State: AOJu0YzegTyMI7+XezwDK71V11BEH+TIRULnUdMzZP4YEHW3JyFevtLT
 UTVTvO6XXXgK+KIVQzuOrkYYacHo7oNWuDoMqXmsgwC5zzebqkB3idmUEOl9vg==
X-Gm-Gg: ASbGncsEhmh8mkoYnqDXPgmDnZHyAfYcymbay0HO8QYTJ+ZXyqQcrScwYjuwcg7XSzl
 ++1nAH3idD1RmOSibe6RqhuH0+ajIwjez3orWozBt2KXbfJ8n066EHxvhloN2dAiOKPpXd4t2MF
 pE2JQPuIi6TlRe0RlOBLRkSQRgTQ/O7j5ebQfUEVOrjsiIn7u0kDr2yaSYLdLi4z7CYELkU6gwe
 4oS+r+E/qH36D8HT6PLHmfud55k3vo1MJ6/2B288g==
X-Google-Smtp-Source: AGHT+IE/PPK3W5vVd8mVpWRPjnSVHtIjkxFNJCK59pS91+3y3sB3QAFPn0X8e5BJDW2ItxeSd8JtKg==
X-Received: by 2002:a05:600c:1388:b0:434:f131:1e71 with SMTP id
 5b1f17b1804b1-4366854c07emr388028245e9.8.1735868583942; 
 Thu, 02 Jan 2025 17:43:03 -0800 (PST)
Received: from wegao1 ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8bb4bcsm39642788f8f.111.2025.01.02.17.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 17:43:03 -0800 (PST)
Date: Thu, 2 Jan 2025 20:42:56 -0500
To: Li Wang <liwang@redhat.com>
Message-ID: <Z3dAoOp560iQBheO@wegao1>
References: <20241228133217.28945-1-wegao@suse.com>
 <CAEemH2cdZ1fJHma3xDF1r-wPycbLqXRXT0Q4smqivuAZcWC9GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cdZ1fJHma3xDF1r-wPycbLqXRXT0Q4smqivuAZcWC9GQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmap21.c: Test for new MAP_DROPPABLE flag for
 mmap
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBEZWMgMzEsIDIwMjQgYXQgMDY6MDQ6NTRQTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBPbiBTYXQsIERlYyAyOCwgMjAyNCBhdCA5OjMy4oCvUE0gV2VpIEdhbyB2aWEgbHRwIDxsdHBA
bGlzdHMubGludXguaXQ+IHdyb3RlOgo+IAo+ID4gU2lnbmVkLW9mZi1ieTogV2VpIEdhbyA8d2Vn
YW9Ac3VzZS5jb20+Cj4gPiAtLS0KPiAKPiArICAgICAgICAgICAgICAgZm9yIChzaXplX3QgaSA9
IDA7IGkgPCBhbGxvY19zaXplOyBpICs9IHBhZ2Vfc2l6ZSkgewo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKCEqKHVpbnQ4X3QgKikoYWxsb2MgKyBpKSkgewo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAqc2hhcmVkX3ZhciA9IDE7Cj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfQo+ID4g
KyAgICAgICAgICAgICAgIH0KPiA+ICsgICAgICAgfQo+ID4gKwo+ID4gKyAgICAgICBUU1RfRVhQ
X0VRX0xJKCgqc2hhcmVkX3ZhciksIDEpOwo+ID4KPiAKPiBUaGUgdGVzdCBhc3N1bWVzIHRoYXQg
cmVjbGFpbWVkIE1BUF9EUk9QUEFCTEUgcGFnZXMgd2lsbCBiZQo+IHplcm9lZCBvdXQgd2hlbiBh
Y2Nlc3NlZC4gV2hpbGUgdGhpcyBiZWhhdmlvciBpcyBwbGF1c2libGUsIGl0IGRlcGVuZHMKPiBv
biBob3cgTUFQX0RST1BQQUJMRSBpcyBpbXBsZW1lbnRlZCBpbiB0aGUga2VybmVsLgo+IAo+IERv
IHlvdSBoYXZlIGFueSBjbHVlIChkb2N1bWVudHMgb3IgY29kZSkgdGhhdCBpbmRpY2F0ZXMgdGhp
cyBpcyB0cnVlPwoKVGhhbmtzIGZvciB5b3VyIHF1aWNrIGZlZWRiYWNrICwgaSB3aWxsIHRyeSB0
byBnaXZlIGNsdWUgZm9yIHRoaXM6CgoxKSBCYXNlIHRoZSBrZXJuZWwgY29tbWl0IG1lc3NhZ2Ug
aW5kaWNhdGUgbWVtb3J5IHdpbGwgYmUgemVyby4KCmNvbW1pdCA5NjUxZmNlZGY3YjkyZDNmN2Yx
YWIxNzllOGFiNTViODVlZTEwZmMxCkF1dGhvcjogSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6
eDJjNC5jb20+CkRhdGU6ICAgVGh1IERlYyA4IDE3OjU1OjA0IDIwMjIgKzAxMDAKCgogICAgVGhl
c2UgY2hhcmFjdGVyaXN0aWNzIG1lYW4gdGhhdCB3ZSBjYW4gaW50cm9kdWNlIFZNX0RST1BQQUJM
RSwgd2hpY2gKICAgIGhhcyB0aGUgZm9sbG93aW5nIHNlbWFudGljczoKCiAgICBhKSBJdCBuZXZl
ciBpcyB3cml0dGVuIG91dCB0byBzd2FwLgogICAgYikgVW5kZXIgbWVtb3J5IHByZXNzdXJlLCBt
bSBjYW4ganVzdCBkcm9wIHRoZSBwYWdlcyAoc28gdGhhdCB0aGV5J3JlCiAgICAgICB6ZXJvIHdo
ZW4gcmVhZCBiYWNrIGFnYWluKS4gIDw8PDw8PDw8PDw8PDw8PDw8CiAgICBjKSBJdCBpcyBpbmhl
cml0ZWQgYnkgZm9yay4KICAgIGQpIEl0IGRvZXNuJ3QgY291bnQgYWdhaW5zdCB0aGUgbWxvY2sg
YnVkZ2V0LCBzaW5jZSBub3RoaW5nIGlzIGxvY2tlZC4KICAgIGUpIElmIHRoZXJlJ3Mgbm90IGVu
b3VnaCBtZW1vcnkgdG8gc2VydmljZSBhIHBhZ2UgZmF1bHQsIGl0J3Mgbm90IGZhdGFsLAogICAg
ICAgYW5kIG5vIHNpZ25hbCBpcyBzZW50LgoKMikgV2hlbiBrZXJuZWwgcmVhZCBiYWNrIHRoZSBk
cm9wcGVkIGFub255bW91cyBtZW1vcnkgd2lsbCB0cmlnZ2VyIGRvX3BhZ2VfZmF1bHQoKSwgCmZp
bmFsbHkgaXQgd2lsbCByZWFjaCBkb19hbm9ueW1vdXNfcGFnZSgpIGFuZCBoaXQgZm9sbG93aW5n
IGxpbmU6Cmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y0LjYvc291cmNlL21tL21l
bW9yeS5jI0wyNzUwClNvIG5vcm1hbGx5IHlvdSB3aWxsIHJlYWQgemVyb2VkIG1lbW9yeS4KCkNh
bGwgc3RhY2sgaGFwcGVuIHdoZW4gcmVhZCBiYWNrOgoKZG9fcGFnZV9mYXVsdCgpCuKGkwpoYW5k
bGVfbW1fZmF1bHQoKQrihpMKX19oYW5kbGVfbW1fZmF1bHQoKQrihpMKaGFuZGxlX3B0ZV9mYXVs
dCgpCuKGkwpkb19wdGVfbWlzc2luZygpCuKGkwpkb19hbm9ueW1vdXNfcGFnZSgpCgo+IAo+IC0t
IAo+IFJlZ2FyZHMsCj4gTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
