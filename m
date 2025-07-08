Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5047C8303C
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 14:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751983925; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=G3m4pWRdu4urku0viLoo6i/mm0v39abKoIlNjeDv6CE=;
 b=e5ME3LZtDW/lOv9NAOl/XVY3ekB8t1L796lAshW5rCJTj+bW8A+8H5B/mIj/XLhAyOcPJ
 VTdR8VdVMdou4CiPGTgwYnBr2S00g1erVGjiMeEOKZ9RWlWakuL+HP7xAuch7WHpjTUFRA2
 BPKMYWaLvudgZRp21kYOgMm5jOvaFnU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AFDC3CA5E4
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 16:12:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F3203C5272
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 16:11:44 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BC02220075F
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 16:11:43 +0200 (CEST)
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso3928379f8f.1
 for <ltp@lists.linux.it>; Tue, 08 Jul 2025 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751983903; x=1752588703; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FTRDupW0aygIstBd9wSxQQzB4I9d+o1jGdxH2Nb8fH0=;
 b=C0mjyc6G/vPR9zFeKaGQ7qgGEb9WxaXe7RjakEGHFmuou+KA7p0XfIfNEbCpmHAoTC
 CtLG+GGEyCb9gyMAQnnHk5FXddmEUb36yPYHwrtSab3e82foziWzX2udtrRi+WA5aTG2
 p7k33nsC2ecqu5CWzuzROCf+ky9CzRwSveybSlGzAZpEL5N4IQUvyO3kc7Xw6NYKMi+r
 8IBLlPhfP2/JFNEYImNTrCcg3ht3FTUZNvOWnZH+5s7+J7sZBvZvyvvEvug+5jY1+273
 NJFL+XQQ0A7yRrIKCSE5eqyjV5Hcbw/Ci1pEBF3q7yCqrQCKNqb6qZGnDMvErS/82rfY
 6MVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751983903; x=1752588703;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FTRDupW0aygIstBd9wSxQQzB4I9d+o1jGdxH2Nb8fH0=;
 b=C7VYpFgvxS8jqVREKTJrhoC/pD5b8o2R/jYg1TjLt02TolWwxZPipoNiJDD2h4PqY4
 t+0MqNMHcZhBIUrl1sd9D6iPWD/El580jM2i/FsNZzwqtZttv/gwZa2Vr19OnNbF8Zn8
 Um2V7x/0iEcAL1pO3KxlQUvat0vIPIsGHA3TxFrXBb1wD0cCN+rPTtvu4eQa0/Dx10PD
 VLzLcaQ2UfVQ2xsDYaQWV6cJTHUd279UxB5vDR2r1qr9nYvvYag8JNCTrN7nt/18SY3U
 gJ5Lv+gidigmAH0ozi17TC1duTBKJ8ECGDXQXBtXWdEBcAQy0tuHrJbwaY4Pwm9VFiyI
 3W+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc+D0qNP96Hha0PF8/1eJdOIaGFFvm4hQcWEPKZrBzyeil0R+ZtKfDdcws/oy7dNRVgHc=@lists.linux.it
X-Gm-Message-State: AOJu0YyrhFozdBs4Yh5N+YLSwvpctkY+v2cb3i3LHqn2QOLVX3eKQGG7
 i+s5rYa03GUt7KvqLhc9Fx9PXFTk5WFISdH0s47Av2sg/0F+rwjDWSMorF5IPkUvwPE=
X-Gm-Gg: ASbGncuQse6k0zcZuZYrHMvx9fTZnIrhXnfydUgebUcqzGYWUpN+Q2vsavO3QwdQiev
 C7t60G36FmsYvqTWIxXSSe7PCVGQ/qcRQ7HSb6Zrcu4sAcXtSUsT0tKexKrPwrfXWL/h7hv/8sd
 WUJtI/wGU07W62IzHia5llQ3XKfAW7/ZuFuPnJDdnAaYUxLY8VREGNCeUA2ZUo/vzFI3Gcx8FJF
 ErPcJDphqcIjgVN7NrPdvaqIfYL8XFKdQCPThh2KakkyuOHFoafVYurXLtAMQ3e/MotwLeJ2Uls
 Xva89kN7mQWi1idTJaDXhq1bghdQ9jTUNem1OQJOBdrK55QHM3jJadAf72N0upnIy0jgvq6idC6
 uDzsg+jBGGSKFhjI8jSptlrb+jl1dJvvatZVWiJ50m9OAr9JDzOztRk/5DmCD/rXj4qVrNBjyLB
 lrdH35CeBaEUVwD9HwZKmwwxHR3w==
X-Google-Smtp-Source: AGHT+IHziX+Up6PX3VqRyYEX+Y2ZK5nn41W/rgb5cIVhjSF1OU5Aqv3ytyMwD9nzPFrd1X2B8sK1vQ==
X-Received: by 2002:a05:6000:41c4:b0:3a5:8c27:8644 with SMTP id
 ffacd0b85a97d-3b497013072mr11934973f8f.24.1751983902946; 
 Tue, 08 Jul 2025 07:11:42 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8455d26fsm120205725ad.93.2025.07.08.07.11.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 07:11:42 -0700 (PDT)
Message-ID: <a2c5a454-38fb-4d2c-b9f5-ae6e58615875@suse.com>
Date: Tue, 8 Jul 2025 16:11:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250708-new-munmap04-v4-1-884f774179b1@suse.com>
 <ee61b370-13cd-4467-80d1-c38645592e69@suse.com>
 <DB6NP2I9LBC5.3PSVD9Z735NLY@suse.com>
Content-Language: en-US
In-Reply-To: <DB6NP2I9LBC5.3PSVD9Z735NLY@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls: munmap: Add munmap04 to check ENOMEM
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

Ck9uIDcvOC8yNSAyOjAxIFBNLCBSaWNhcmRvIEIuIE1hcmxpw6hyZSB3cm90ZToKPiBFdmVuIGlm
IHdlIHJlc3RvcmUgaXQgaW4gdGhlIGNsZWFudXAoKSBsaWtlIGhvdyBJIHN1Z2dlc3RlZD8gVGhl
IGRlZmF1bHQKPiBpcyB1c3VhbGx5IDY1NTMwIFsxXSBbMl0gYnV0IGNhbiBiZSBxdWl0ZSBoaWdo
IG9uIG90aGVyIHN5c3RlbXMsIGUuZy4KPiBUdW1ibGV3ZWVkOgo+Cj4gJCBjYXQgL3Byb2Mvc3lz
L3ZtL21heF9tYXBfY291bnQKPiAxMDQ4NTc2Cj4KPiBbMV06aHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvaW5jbHVk
ZS9saW51eC9tbS5oP2lkPWRmYmE0OGE3MGNiNjg4ODhlZmI0OTRjOTY0MjUwMmVmZTczNjE0ZWQj
bjE5Mwo+IFsyXTpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3N5c2N0
bC92bS5yc3Q/aWQ9ZGZiYTQ4YTcwY2I2ODg4OGVmYjQ5NGM5NjQyNTAyZWZlNzM2MTRlZCNuNDgw
Cj4KPiBUaGFua3MgZm9yIHJldmlld2luZywKPiAtCVJpY2FyZG8uCgpAQ3lyaWwgd2hhdCBkbyB5
b3UgdGhpbms/CgpUaGUgYWx0ZXJuYXRpdmUgaXMgdG8gc2V0IHRoZSB2YWx1ZSBhbmQgdXNpbmcg
dHN0X3Rlc3Quc2F2ZV9yZXN0b3JlCgotIEFuZHJlYQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
