Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB64C83F1A
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 12:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752238017; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=ZEoccZ0tR4Aabt8O8H25hFYT0hmBPhPhOmM6T6joXsc=;
 b=kJ9Sq4tqVDwQtVPRA2+SecherK2Xnt8gzZKs70h5cTdTjRltHSI9faGLrh4G2r2k/QLsn
 fTjr8GB07J2/UPUIx9hMgj+oPE+ys5GWpWoAcFdNLUKbSdpzikK5lIo1swUCz8iVA9aQMea
 2cyo2vCS2t+0GUk6P5O3Yt3GANdwC5g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 940103CB31F
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 14:46:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9EDD3C06B5
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 14:46:36 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BCC07600952
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 14:46:35 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a5123c1533so1109494f8f.2
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 05:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752237995; x=1752842795; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lE+PUHvSj1I8gPS5KqVqkqrk5YZJiWzYi/ki25U1BZI=;
 b=eZpn0wjySeGAZ8kCiecBzpTi32k5u97L9hJ0n2C7SFN26Rrw3TEgHXEfbDLf3iwkCQ
 UmW2aWQsrt6MonKWPhvBlvMCNu704FBZND0YwFPrJB4896AqWAJo00fxtc5aYMNJIrcR
 YRJWFDs4v6HxfhagAk8hfqTV7MsjdHBQpum0Ahr2KkhtA/GXhB/N1kx/fgazYMLI3eAi
 bDsDAVBYksjR15w1WDJOXlo4Ogvomqs/ZwuAb07VZnGeUH8RKYYoF/JZmZigWks/cIqY
 YdrTTDxfKpCQIhCXY7g/MCaN3Pp/wM/KnRULtwoGLfck5w56F2bQ5aOBa3A/1iKP/xC3
 /gzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752237995; x=1752842795;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lE+PUHvSj1I8gPS5KqVqkqrk5YZJiWzYi/ki25U1BZI=;
 b=ZT17j56BbyF0Em1Mm9U+Y1CKqVWUQHhk+BjnsKa0A6Lj7ljCNjhpLH24lM9sOcbcrt
 1z0+YttLRIhvNTbRSRk3dyTLhk++8ZR+So6+ndx77dbhp2RHVphAYD7dK85L1nT3qwZ9
 TQiY0SZDuE7NAkrtCFBIBduJ765CDikgacM3QnFIXVnvtY8W2aubKBAVN1m9nvnafSrl
 +z/PIKZpnLrBgvsOttpB+lYjWPGBM5RefXAMzgtEThavUwGxKCzPWGzhMIXWbk0jxMWj
 xpRbsh64m1W2N7QhZYhYogIafHK3LPWta7oLaK3bTBV+JNshqGKldlY+fA9U261ifxzO
 5s6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpAd9s4OwmQaL0p4A5/ApGCqsbPBH0i1jkg1+ZpiJrwqNWoIolqBOtC8/iVuPsoD2JFF8=@lists.linux.it
X-Gm-Message-State: AOJu0YxrZbHRro6JLl6AhyIai2M0CeKsbxgANOTobvm7ukKiE6XIS3MS
 0oC+XvnfpwYWv3X5JBkvNtdO97P4ciMi9/MKIMMMZAFiCgVLBQV+XupF7bHmCc/Px6IJsMwglhE
 Dvem7L6OMGA==
X-Gm-Gg: ASbGncugCeiH7lFdOLWohH/H9QovYTybeiq3f8aFmGzBm7ENfjHrFTRK7rJaLMwByPi
 4G12uw3qPlqPRYSr8FI9JHzzJ8hnpSAxqmwryLtua3WVghXjrto56bSXMJY4BnwF0gErLIBcI8Y
 iP5ZgZmx4ExTmpN9BOcgALopZ3UNi+0qiMdUMutvx1QnviuyqpuK5Y0B6bwmRKnRL+lY0luA3d5
 dtmRR7pDZcEa2hB+0+kcLMks302+hPWrJO3Iq+iF2vnufRxftJbHVqNk7toI/QVKVm5MFz+23KY
 Rl3U28yk8nmIb1h1IBvIJ3zwx7svCcHmAjnI/XS0JUHrNl8asWOFWNpbA9YJc8aTksIB/5tJBfs
 AYKvE4PRiqGzkpzBjB9pujFa46DkFFDyOzwptQGj/7mO1p7d3RWW+38YlVOVWHoUiURuTaHQPZL
 Al46orL3Woh8HmDht7JqFuAiJ8qiYo9n9RMEqfApiHi8Fa/VzEvig9gEIrPpcLhg==
X-Google-Smtp-Source: AGHT+IHzQSP6FR+5q0ok/ECYFz8pt/MRFR6UflPJSBNZAnSPq9gHaX5dRmshcdxq1kFuPygzReuBxw==
X-Received: by 2002:a05:6000:2b11:b0:3a6:d92d:9f7c with SMTP id
 ffacd0b85a97d-3b5f187e900mr2194407f8f.9.1752237995046; 
 Fri, 11 Jul 2025 05:46:35 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f49f80sm4900026b3a.117.2025.07.11.05.46.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 05:46:34 -0700 (PDT)
Message-ID: <b3b69967-a546-473d-8be6-e1cbe0e2ac06@suse.com>
Date: Fri, 11 Jul 2025 14:46:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20250711113632.11391-1-chrubis@suse.cz>
 <20250711113632.11391-3-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20250711113632.11391-3-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] metaparse: Map arrays with designated
 initializers to JSON objects
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpOb3cgZG9jcyBzZWVtIHRvIGJlIGJyb2tlbiBmb3IgdHN0X3Rlc3QuZmlsZXN5c3RlbXMu
IFRoaXMgcGF0Y2ggd2lsbCAKc29sdmUgdGhlIGlzc3VlIGFuZCBpdCBuZWVkcyB0byBiZSBhZGRl
ZCB0byB0aGUgcGF0Y2gtc2V0OgoKZGlmZiAtLWdpdCBhL2RvYy9jb25mLnB5IGIvZG9jL2NvbmYu
cHkKaW5kZXggZGE3NjgyMzJiLi5jYWRmZWIyYjMgMTAwNjQ0Ci0tLSBhL2RvYy9jb25mLnB5Cisr
KyBiL2RvYy9jb25mLnB5CkBAIC00MDYsMTMgKzQwNiwxMiBAQCBkZWYgX2dlbmVyYXRlX3NldHVw
X3RhYmxlKGtleXMpOgogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2U6CiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2YWx1ZXMuYXBwZW5kKGYne3ZhbHVlWzBdfSwge3ZhbHVl
WzFdfScpCiDCoMKgwqDCoMKgwqDCoMKgIGVsaWYga2V5ID09ICdmaWxlc3lzdGVtcyc6Ci3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGZvciB2IGluIHZhbHVlOgotwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGZvciBpdGVtIGluIHY6Ci3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiBpc2luc3RhbmNlKGl0ZW0sIGxpc3QpOgotwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZQotCi3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBpdGVtLnN0YXJ0c3dpdGgoJy50eXBlJyk6Ci3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbHVlcy5hcHBlbmQoaXRl
bS5yZXBsYWNlKCcudHlwZT0nLCAnJykpCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciBwYXJh
bXMgaW4gdmFsdWU6CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yIHBrZXksIHB2
YWwgaW4gcGFyYW1zLml0ZW1zKCk6CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiBwa2V5ID09ICJ0eXBlIjoKK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdmFsdWVzLmFwcGVuZChmIi0ge3B2YWx9IikKK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2U6CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbHVlcy5hcHBlbmQoZiIge3BrZXl9OiB7cHZhbH0iKQog
wqDCoMKgwqDCoMKgwqDCoCBlbGlmIGtleSA9PSAic2F2ZV9yZXN0b3JlIjoKIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBmb3IgaXRlbSBpbiB2YWx1ZToKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHZhbHVlcy5hcHBlbmQoaXRlbVswXSkKCi0gQW5kcmVhCgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
