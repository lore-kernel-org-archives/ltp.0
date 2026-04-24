Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775B8FB44C8
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 08:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777017832; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=LgDxkAwFhLrarJu4t7j97IhKclyiqaEjWoLQilGXx4Y=;
 b=HnCui5/p6amZWo/8NVsPw+srXK8dr1iY7EAEptdERmh+HBSVq+TW7EBJc256fzKNV+/V2
 8W1s3CB2Ok3a+oucr3SIq92G3zGh+JizHGRnhArgTu8hlqyhYM6Kv6a17W1UUk4SK615RIz
 XVAVWNDMLRtzo+BuD6UNYwE9bFH7sEA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 076693E28C9
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 10:03:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55CB83E1C20
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 10:03:29 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6C55E14002BB
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 10:03:28 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so5110011f8f.3
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 01:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777017808; x=1777622608; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Vyr7bIJ/za64KWQpCBgOh/PHUy4JWJRw5TEmifVQ9y8=;
 b=Xtt/NUZoYi6Hg2fKz2QBCQm6CSeCDOuHaQDAOrq6SlJYmPg2+VrsHp+cdszwKf9k+z
 Qcdxy5pcRVvqr6gaMGzIOrzUwWzL4LXJR0hdEb5cQdfhTwTCbuduTwSmJDHRz5nB4caf
 Ut1AdFUVEFMy4HWKCyYGXdbAEIPOdyjJv+nIUAEIH/0V2mUF26zK5yF5vkWNmHYpdrWr
 Q4Ev6PlrUWw9LBEs/4XrMQkpgNijbm4pyf8yg5RhvvTH7nsOGHDRovsVd34yjoFsyddq
 O+hYiVrMpm2Iw8itNW8IG+BfYlKZPDrV3cIPhsgZwLPJF6PqsQkGhKXDDHCo52Ter9Li
 DqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777017808; x=1777622608;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vyr7bIJ/za64KWQpCBgOh/PHUy4JWJRw5TEmifVQ9y8=;
 b=fv6TR8OvZ3pC40+sXGsbTXmwdRVjDz6NM13tg5JXHK6hKckl/jEwbakM436tBbSeN4
 +phaYbkqwhinjfi8PXaORqncoi29Fw1Y3oDa8x8XJsnD6Q+PyT5V76dVsMKfJ/OYyIcO
 XNSTLzS+UYXx53o7HEgZqpF8AGz/t+sIzI8dhL1aE0Jf7dHYAP+EfJajSUem+mrZEiD5
 purPPrhlNRk9GlShxgtkegbP7zBP544DQgyuP/kdPtBPn3CM3IycsHy61fYHFAiZlXOV
 9/qNDJygg75zdtuSi4HZBnXw3FUf3SWNKfGApRrAVRThyJINpnh2+Xy66CGWEi4Z8fG0
 INKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gnVw9QPZcjksgBCNdFF+1CztwZZyoPcdb/oaHRCysfU57zrf9xwODqfjpqj9ReiwcrGg=@lists.linux.it
X-Gm-Message-State: AOJu0Yw6BP6cflcecf435NeDtXA5+P9sRF6McBsXiCynZX1cQw4Jnqo/
 dPO2KcldwjGFBYJpjMPW6ZG6nWcVpqYM3ZtFESYFIXCiwava7gzt+5DQ6jmbAz7FOQ==
X-Gm-Gg: AeBDiesLQJHr8C/JugtJALti0zH0hCi0urE5xihwfCP3SuIpMLUcb0o+2YS4Bgp2mNh
 GwzRa0Oj0jQ8xxNr17XCUE9kXXE7y24uEXcOYMmbY+Mjag7f6D78Gs4Pqz5BDSnsCAABBvQ1s1n
 uLux1mCtwfQWyEduCoQVuYEjmxiZ1nkZkYIpv4rPx4YNJygXtv7puC7LunT9DiR2kmkUE+F+wQU
 xFkfuytL6oDsMgfE78vGKVCrPHcHHNOoR6hFJ7I7lt47LK15AuGGBQXljbX4kr2ICSYPMUgWrXN
 8GQJlg+L4nF16evxw3YjHrxDPczgeeukMx4Td/KaiZOIU0kiKUX7UgBWem90QcuanewEf5r/HA3
 9uaYUTKFzkepU4+ZqFUSI7352QKQMF2Tw79lOBpGGFl7Ig8RfKbKlbDi85AdXcTTcJ4GJssNAWN
 NZLRUDXzVpKd+MYnHxTM6Xsh/zhos0G5l8ZITERP0bo5Px06IH+f8=
X-Received: by 2002:a05:600c:c0d3:b0:488:a916:14a8 with SMTP id
 5b1f17b1804b1-488fb74fe74mr345043225e9.10.1777017807534; 
 Fri, 24 Apr 2026 01:03:27 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm607283185e9.2.2026.04.24.01.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 01:03:27 -0700 (PDT)
Date: Fri, 24 Apr 2026 08:03:25 +0000
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <aesjzYw1HVynrVTy@autotest-wegao.qe.prg2.suse.org>
References: <20260424060543.462475-1-pvorel@suse.cz>
 <aesL6YSphAi5vJbO@linux.dev> <20260424063132.GE462697@pevik>
 <aesWy5_fBdPNzvle@linux.dev>
 <CAASaF6xiLDa_uOKkG2=aVhysnbKNCT-H_PiFYFt5=889g1K74Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xiLDa_uOKkG2=aVhysnbKNCT-H_PiFYFt5=889g1K74Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ioctl_pidfd06: Update kernel version
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

T24gRnJpLCBBcHIgMjQsIDIwMjYgYXQgMDk6MzM6NTVBTSArMDIwMCwgSmFuIFN0YW5jZWsgd3Jv
dGU6Cj4gT24gRnJpLCBBcHIgMjQsIDIwMjYgYXQgOToxM+KAr0FNIExpIFdhbmcgPGxpLndhbmdA
bGludXguZGV2PiB3cm90ZToKPiA+Cj4gPiA+ID4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2lvY3RsL2lvY3RsX3BpZGZkMDYuYwo+ID4gPiA+ID4gKysrIGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bF9waWRmZDA2LmMKPiA+ID4gPiA+IEBAIC01NCw3ICs1
NCw3IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gPiA+ID4gPiAgIGlmICghaW9jdGxfcGlk
ZmRfaW5mb19leGl0X3N1cHBvcnRlZCgpKQo+ID4gPiA+ID4gICAgICAgICAgIHRzdF9icmsoVENP
TkYsICJQSURGRF9JTkZPX0VYSVQgaXMgbm90IHN1cHBvcnRlZCBieSBpb2N0bCgpIik7Cj4gPiA+
Cj4gPiA+ID4gPiAtIGlmICh0c3Rfa3ZlcmNtcCg3LCAwLCAwKSA+PSAwKQo+ID4gPiA+ID4gKyBp
ZiAodHN0X2t2ZXJjbXAoNiwgMTgsIDE0KSA+PSAwKQo+ID4gPgo+ID4gPiA+IFdoYXQgd2lsbCBo
YXBwZW4gaWYgdGhpcyB0ZXN0IGlzIHJ1biBvbiBrZXJuZWwgcmFuZ2U6IHY2LjE5LjAgfiB2Ni4x
OS45Pwo+ID4gPgo+ID4gPiBGWUkgSSBoYXZlbid0IHRlc3RlZCB0aGF0LCBidXQgaXQgc2hvdWxk
IGZhaWwgb24gNi4xOC4wLi52Ni4xOC4xMyBhbmQgb24KPiA+ID4gdjYuMTkuMC4udjYuMTkuOSBk
dWUgbWlzc2luZyBiYWNrcG9ydC4KPiA+ID4KPiA+ID4gSSdkIGFzc3VtZSB0aGF0J3MgY29ycmVj
dCwgYmVjYXVzZSBvbiBzdGFibGUvTFRTIHdlIHNob3VsZCBJTUhPIGJlIG1vcmUgc3RyaWN0Cj4g
PiA+IHRvIGVuc3VyZSBpdCBiZWhhdmVzIGFzIGV4cGVjdGVkLiBXRFlUPwo+ID4KPiA+IEhtbSwg
bWF5YmUgdGhhdCdzIGFjY2VwdGFibGUuIE9yIGp1c3Q6Cj4gPgo+ID4gICBpZiAoKHRzdF9rdmVy
Y21wKDYsIDE4LCAxNCkgPT0gMCB8fAo+ID4gICAgICAgIHRzdF9rdmVyY21wKDYsIDE5LCAxMCkg
PT0gMCkgfHwKPiA+ICAgICAgICB0c3Rfa3ZlcmNtcCg3LCAwLCAwKSA+PSAwKQo+ID4KPiA+IEFu
ZCBpdCdkIGJlIGdyZWF0IHRvIGhhdmUgSmFuJ3MgY29tbWVudHMsIGhlIGlzIGFuIGV4cGVydCBp
bgo+ID4gdGhlIGtlcm5lbCBtYWludGVuYW5jZSBhcmVhOikuCj4gCj4gZWhtLCBub3Qgc3VyZSBh
Ym91dCB0aGF0IDotKS4KPiAKPiBUaGlzIGlzIGNoYW5nZSBpbiBlcnJvciBjb2RlLCB3ZSBkaWRu
J3QgdHJlYXQgcHJldmlvdXMgdmFsdWUgYXMgZXJyb3IgZm9yIG9sZGVyCj4gcmVsZWFzZXMsIHNv
IHdoeSBkbyB0aGF0IG5vdz8gSSBkb24ndCBzZWUgaXQgY292ZXJlZCBpbiBtYW4gcGFnZXMgKHll
dCksCj4gc28gd2h5IGJlIHN0cmljdD8KPiAKPiBJIHRoaW5rIHRoZSBwYXRjaCBzaG91bGQgZWl0
aGVyIHVzZSBtb3JlIHNwZWNpZmljIHZlcnNpb24gcmFuZ2VzIG9yCj4gYWxsb3cgYm90aCBlcnJu
b3Mgb24gdmVyc2lvbnMgPD0gNy4wLjAuCj4gCgpJIGFncmVlLCBpIHByZWZlciB1c2UgbXkgcGF0
Y2ggOikKaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2x0cC9wYXRjaC8yMDI2
MDQwNjAyMzUzOC4xNDczOS0xLXdlZ2FvQHN1c2UuY29tLwoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
