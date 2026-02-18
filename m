Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F1FE9A04B
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 21:10:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18B653D072A
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 22:10:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBFD03CB063
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 22:10:14 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 218F2600550
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 22:10:14 +0100 (CET)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-896d82bc48bso262556d6.2
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 13:10:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771449013; cv=none;
 d=google.com; s=arc-20240605;
 b=CJVyduTkyhsiVC4+B5z0ZkyEiaWjzudOY9VU3VRNYXI54NQ5j8ASWXTA4w6WGml0wZ
 3jgHCmkdjOzuTdDlABHBiAWn1gJssC5pRbd95Cm1PE80qfqx49y83YD4yyCE26Fbvyfl
 /6aIaR46UPgAEWu4vZyItR/kKd3WPdqFpfmvQ4i9CIYLlwEB/f9AKXR8hkaHzWc1UwSa
 VdQ6b1arfIW+tdfq1glMB5eQA2jCRAnli9LMIxub1WHg6YY0PGZAu21YHyEqncYktZQn
 sv412uJ1Jh3w7mxSSyJa/DUcC7ghQwYTLPamTZa6KDS96GSdxs8k/rAlbLLXzMfDVRQ9
 lTXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gnoQwah1MkHqX34hLUie1YZ2otQu0suVz1EPn1stCak=;
 fh=rshL9A501dKaPv0/sfTO7cBAtelv3b+wlanicE6DmIs=;
 b=g2E5i2L6cULkwtFa6r0VJS4k1BrlShqh6x8Ya7bwMdf5cxAgH61QAUQYEm6AOlYEO4
 e1+xahwqzXvq6+GEuE9XPowZpnBzNaPZygPpjGAeLrTNoSx6bo3BDAycyDT+BODa+uZ0
 UUeqAmBH1C/gfrNi4u3ew8vF6kJCXFWpnbjTud0OMISL8SY562ZujVfoVwimPf9UtEmw
 adHoTdK3fa9bQ0Hd0v4U4WYtZWYlf0Qs4mxEkGew5fBZjkOriPBFIll7rC+oHLcX66i2
 s6K1g0PMHoeaj2Lf//IR81YgK4js0ZJ44i/36P2shWxEQZaTBIczLgzl8U61jLNQImku
 1n4A==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771449013; x=1772053813; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnoQwah1MkHqX34hLUie1YZ2otQu0suVz1EPn1stCak=;
 b=oXSsH8U1rtgQnEnwG473i7OyDpPklaEXgQ7ivxxKTLY/B4dw83TTLRXuNxFlqA2gPv
 Cc+7JLiGwWRE896U7Z9ullIUB/D0Mh8x1+AWypmn/txEZ+OiL+Rd5szlzuZjrfekBXuG
 qLDsX7FVxEVpdfc01dNCWc8NdUN+xvEF7ruhynCMSmJGn6JsIOq/BPS1UtSl3ZfaiwMq
 ItCL7of3cmq/BBeYGmfqP0NbOAEGH3qvalj383JXv47nKCEQjIqUKw3dCRKZdOtV8ed5
 9TsnFxJYHJTHvyBnhYB9xf+0GbpiMH0CKy3nBIVwYv/XszkDeCBLNYnQmfB/rtZshEw/
 dkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771449013; x=1772053813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gnoQwah1MkHqX34hLUie1YZ2otQu0suVz1EPn1stCak=;
 b=Q7gkj6HiKsLgvOJdpf1VP3ODiGsNbAjhHfOGFvArBjDjtTEVRcNVnVBEn3NyrE9MRx
 CozUrwi1ZL0LtD3EdgK9kPzKvSx9/FiveHA8K+CBlo0UNuTHOcxUTX06y0d8j/rGydce
 MXcKtBupu8Ze3MxlwtPy7OOL4FFCegjymdKn5mVkwUVWlmKs3Y1tkiIJPApGe6ei0bnB
 VsBMiYjm42Z8YFM8m1uqHoJf65b5JfVVQxBDJEp2xSEGGP1xnfYW0jL8PaXwuVni+Jjx
 Hmffwgk3iDF0OjkS/rdl5Rijqi93y2bRwx/s5UvJ1iany4C+4NuitTIfc8dMW862U7WE
 QP6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU57e774GLdz8E4UVLJAzgb6v7XQWwy8DizzUt7ZPQ7koC9pdOy3DIANX6biCF4ZxmIc2k=@lists.linux.it
X-Gm-Message-State: AOJu0YwW66ZKqC4Ulo/0ktomVa5EnHd7g+SIjqXHp7215R7lJH9zYskk
 o0EKb9B5l7mkmGBpgUq1IUkdwuwZxrpbla0j7gEGbV4T/kviHbPIZcdI1udCilPwnWtgFMNkb4t
 mnMuf8Z3Ufj6ou8wpteMg9Ry4KgjW7oTMbzW7yAaDXw==
X-Gm-Gg: AZuq6aJUiXZ75w65S3xQijypvMy/yxw0NCtRYkDWbi2yqbIUXh8IEQC6zxRq/y12YTF
 rHCowivPFHLHarLcQHJaNGARsOvs0+sBbObX+Wynur+gJq5mN/ekskJV7AuItRBk2NLpwLHL5Mr
 bMDwwkmZIwu8YNPtCxS1VN/+YxT5ITzxMdgjnRzuCuOdr+S0zKfAdKqiRGS+Uibn4tUSpIZNqzP
 3+iM9U+lwrX135lr6PMqQEKNFJYPLuKPjmat2mi/pGHmVyMf2Ur5ohi8AcaNzyOXD5EseBBZjgf
 ZwbtjHzEJ6U+KAkL
X-Received: by 2002:a05:6214:6105:b0:895:1c9a:25fd with SMTP id
 6a1803df08f44-897347f7c0cmr181744256d6.8.1771449012785; Wed, 18 Feb 2026
 13:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20260205121540.329921-1-pvorel@suse.cz>
 <20260205121540.329921-7-pvorel@suse.cz>
 <29BA2651-45AB-4A29-973D-AAE15C887ACB@gmail.com>
In-Reply-To: <29BA2651-45AB-4A29-973D-AAE15C887ACB@gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 18 Feb 2026 22:10:00 +0100
X-Gm-Features: AaiRm50EpwgK4IOIu3nWGfQVMCnPYfn9wSya2mDxKc68WPryWCZJOz5toAoc_mk
Message-ID: <CADYN=9KdF0f3bTCtvDba3ro4qqn7tWwT8OP_3u2+0XzezfcCqw@mail.gmail.com>
To: "Enji Cooper (yaneurabeya)" <yaneurabeya@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/6] kirk: Remove runltp-ng symlink
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
 Tim Bird <Tim.Bird@sony.com>, Julien Olivain <ju.o@free.fr>,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCAxNyBGZWIgMjAyNiBhdCAyMzowMiwgRW5qaSBDb29wZXIgKHlhbmV1cmFiZXlhKQo8
eWFuZXVyYWJleWFAZ21haWwuY29tPiB3cm90ZToKPgo+Cj4gPiBPbiBGZWIgNSwgMjAyNiwgYXQg
NDoxNeKAr0FNLCBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4gPgo+ID4ga2ly
ayBpcyBoZXJlIGxvbmcgZW5vdWdoIHRvIHJlbW92ZSB0aGUgc3ltbGluay4KPiA+Cj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiA+IC0tLQo+ID4gdG9vbHMv
a2lyay9NYWtlZmlsZSB8IDIgLS0KPiA+IDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQo+
ID4KPiA+IGRpZmYgLS1naXQgYS90b29scy9raXJrL01ha2VmaWxlIGIvdG9vbHMva2lyay9NYWtl
ZmlsZQo+ID4gaW5kZXggODc2ZWIzZTJlZC4uODU5YWZkZTZlNiAxMDA2NDQKPiA+IC0tLSBhL3Rv
b2xzL2tpcmsvTWFrZWZpbGUKPiA+ICsrKyBiL3Rvb2xzL2tpcmsvTWFrZWZpbGUKPiA+IEBAIC0x
Nyw4ICsxNyw2IEBAIGlmbmVxICgkKHdpbGRjYXJkICQoYWJzX3NyY2Rpcikva2lyay1zcmMvbGli
a2lyay8qLnB5KSwpCj4gPiBpbnN0YWxsIC1tIDAwNjQ0ICQoYWJzX3NyY2Rpcikva2lyay1zcmMv
bGlia2lyay8qLnB5ICQoQkFTRV9ESVIpL2xpYmtpcmsKPiA+IGluc3RhbGwgLW0gMDA2NDQgJChh
YnNfc3JjZGlyKS9raXJrLXNyYy9saWJraXJrL2NoYW5uZWxzLyoucHkgJChCQVNFX0RJUikvbGli
a2lyay9jaGFubmVscwo+ID4gaW5zdGFsbCAtbSAwMDc3NSAkKGFic19zcmNkaXIpL2tpcmstc3Jj
L2tpcmsgJChCQVNFX0RJUikva2lyawo+ID4gLQo+ID4gLSBjZCAkKEJBU0VfRElSKSAmJiBsbiAt
c2Yga2lyayBydW5sdHAtbmcKPiA+IGVuZGlmCj4gPgo+ID4gaW5jbHVkZSAkKHRvcF9zcmNkaXIp
L2luY2x1ZGUvbWsvZ2VuZXJpY19sZWFmX3RhcmdldC5tawo+Cj4gUmV2aWV3ZWQtYnk6IEVuamkg
Q29vcGVyIDx5YW5ldXJhYmV5YUBnbWFpbC5jb20+CgpSZXZpZXdlZC1ieTogQW5kZXJzIFJveGVs
bCA8YW5kZXJzLnJveGVsbEBsaW5hcm8ub3JnPgoKQ2hlZXJzLApBbmRlcnMKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
