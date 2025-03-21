Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B17BC36000
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 12:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742559843; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=hngG7sA2Kik6uC3BnU9emJ8BRsr+OcSr+6m3McppLFY=;
 b=bngotANjknIjsDZ73JoGOB558Py7My6oi1UqEp1ml8WAtzC4qghapycj5vIfFIKcNO0qv
 wQUINEavgVJ1tN09kHo4PKvxj3W/xEpZxS6Vanl9KB741K1+TXWWElVEXzjvKGR5SqhpZNg
 UOQbiJXWmCqk4zrzKetc8TtGrYKcinc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 900B93CAD19
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 13:24:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 778413CAD19
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 13:23:41 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0CA1F1A000F2
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 13:23:36 +0100 (CET)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39127512371so1271908f8f.0
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 05:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742559816; x=1743164616; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/tb4mI4GccF4DKdzI9e14lp7HsBcjlkFD7pvscxosHA=;
 b=cNQRoiNayoL7410AI65S7n0HIvpN2+uD2jCe38BeKUXqiW8VV8X+GQ+NGgyjrJvIPt
 vsppTAIA5QFvjH2djnwLmBrQ6FRsL0aBBjaBR1xLOk5HGbse0DGDaoeIUDZVY3SSUg8N
 sjiSy0ybqm3NVwyvnBiWkA2Q1FXk1QB1S8RA+ugjmGt1ULNxYO5fw5kXlXpLw2c3IB14
 bX9DL0CqkSiRvotss+9hiZqgN//N3W2dF6wwdPZcz1rVzzPbeYWPH0BBfdr8RwKv7+4D
 CKpSEI+tB2ryL45OnuoFy4n5mO7diOItoN5n8Nt+g5JQ7CTEEVb08Mqt5CS7XquTz7VE
 9yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742559816; x=1743164616;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/tb4mI4GccF4DKdzI9e14lp7HsBcjlkFD7pvscxosHA=;
 b=hYBUoFED9UmOuqUrkI20L3TKyeijOI8MMaIe4lfethA1xXqHsIHt7UpvYy0YY8o6ki
 mqMdWfUcNJ6pSm7ln3dfl2dO//7MmZ/bRS+nP7zxHNx64jIa+i1Npn44sPhYdzb8o6nS
 1TLrMxOrMpggpdYKl6XsXfDx/VpkX0fKJiCwFPmVmrT+gaqATCu2li4J21fmlp3ArTSz
 4OW3saBtHI6vJezuyWYufqlvzdsvwunK436aPKNufzrPuDIrb+rQhDcAr4Not5c7jROQ
 xunEymnthR3zb/e8ZRF+30DkhgyGY4jUio0VnvKUHonPfcavpSWmKEmD1g6UMy/Q1b4n
 OWSg==
X-Gm-Message-State: AOJu0YziBG+uSnFuuyYQfc+Whupd//s2iMXk4KehMHS3ioPa2HQGKgr7
 cBVFbSgtF95KPFT2LARcVig7Q3kMOXHWb8lF81qyy8WjXOBvYbg0pa/QFkUepVE=
X-Gm-Gg: ASbGncsrswXbzLTAyqDhsWO8Bgi9xuaZ2YEOctwjfE9QLNLExVPyZ8AdXV0JNisiJF2
 O8G4fFXhMfKFYTv5WEZMAivcyLKCTl6YxxfoL1bG79xPi0yNwLI/RTs/PECl0TbqLVUZxvc4gYk
 U+vX8DdYWO/CJDlGxm+hEVMXDw53D2Efwkpwi4iNyCuJIPap2SCXWAKGsapGahUHlh8IGyA7Qr2
 9CTTWlQIXZdqxoLuj2ujpDq+g2iRNBqiC6ZcqVeLb8g7Wbp9yRul0Lz06lCvCQfyYOybNjijHQB
 eeEVx/RmsKicsPJOD2H12AQ+Ik/ZTNz7tga5K8L6nBf+SZTsXhUx856m1g/Y2/Xd+Z6M7iFTdof
 slXYIx7W+hMbEAFjUv0E+Jyc8y07kc+1R13rIssMGiWW8RGIsXNz+WJldYeMDKiCBLTxjOVcSj2
 8zgS39uos=
X-Google-Smtp-Source: AGHT+IFXt0Y8Lg8nh4Rsq02XHKuIvC6F27IZ510lqn3m9o+v6neyROwEXfGEDH9/3k99lZrEEmcRXg==
X-Received: by 2002:a05:6000:210b:b0:390:df02:47f0 with SMTP id
 ffacd0b85a97d-3997f9336fdmr2302460f8f.42.1742559816215; 
 Fri, 21 Mar 2025 05:23:36 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b2654sm2201783f8f.41.2025.03.21.05.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 05:23:35 -0700 (PDT)
Message-ID: <bd982369-c0bc-4952-9ff3-a3fd5181667e@suse.com>
Date: Fri, 21 Mar 2025 13:23:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
 <20250110-lsm-v2-4-bd38035f86bc@suse.com> <Z8b8CLkKbrRkkt9P@yuki.lan>
Content-Language: en-US
In-Reply-To: <Z8b8CLkKbrRkkt9P@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 4/7] Add lsm_get_self_attr03 test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsCgpPbiAzLzQvMjUgMTQ6MTEsIEN5cmlsIEhydWJpcyB3cm90ZToKPj4gKwo+PiAr
CWNvdW50ID0gVFNUX0VYUF9QT1NJVElWRSgKPj4gKwkJbHNtX2dldF9zZWxmX2F0dHIoTFNNX0FU
VFJfQ1VSUkVOVCwgY3R4LCAmc2l6ZSwgMCkpOwo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgo+IAkJCQkJCQkgIFRoaXMgZG9lcyBu
b3QKPiAJCQkJCQkJICBsb29rIHJpZ2h0Lgo+Cj4KPiBTaG91bGRuJ3Qgd2UgcGFzcyBzaXplIGlu
aXRpYWxpemVkIHRvIHNpemUgb2YgdGhlIGN0eC0+Y3R4W10gdGhlcmU/Cj4KPiBZb3UgYXJlIG1p
eGluZyB0aGUgc2l6ZSBvZiB0aGUgYXR0cltdIGFycmF5IGFuZCB0aGUgc2l6ZSBvZiB0aGUgY3R4
Cj4gaW50byBhIHNpbmdsZSB2YXJpYWJsZSB3aGljaCBpc24ndCByaWdodCBhdCBhbGwuIFRoZSBh
dHRyW10gc2l6ZSBjYW4KPiBhbHNvIGJlIG11Y2ggc21hbGxlciwgc2luY2UgaXQncyBqdXN0IGEg
c2luZ2xlIHN0cmluZy4KClRoaXMgaXMgaG93IGtzZWxmdGVzdHMgYXJlIHdvcmtpbmcgYXMgd2Vs
bCwgc28gSSdtIGEgYml0IGNvbmZ1c2VkLgpBY2NvcmRpbmcgdG8gdGhlIGRvY3VtZW50YXRpb24g
b2YgbHNtX2dldF9zZWxmX2F0dHI6CgogwqAqIEBzaXplOiBwb2ludGVyIHRvIHRoZSBzaXplIG9m
IHNwYWNlIGF2YWlsYWJsZSB0byByZWNlaXZlIHRoZSBkYXRhCgpJIGd1ZXNzIGtzZWxmdGVzdHMg
YXJlIGdpdmluZyBhIGJhcmUgbWluaW11bSBzaXplIGFjY29yZGluZyB0byB0aGUgCm1lbW9yeSBw
YWdlcy4KCkFuZHJlYQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
