Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E8EC83F1B
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 07:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752651295; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=PCuNWuAiXFk6CVe7uj/54BLIYXC+TrGfnQ2GBL8Ep94=;
 b=p9zPFw/lzvBCoJXPhkfobNcRtv+zBtdEN3lPBR8JNIIfn6ALKcYoN9UlYrXlKtySnqQaP
 co5jbGiN0Bu4wfhUs93FEFlv2WsnvyJOM0BUQd/aA1KwMbR7QRFUYKpq5px41QgY0rvqMlI
 3R3S3kHB/e23IhY2T15ukNFPoorlDp8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91E183C2857
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 09:34:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0292B3C2857
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 09:34:32 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3225A6001A2
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 09:34:32 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so3641134f8f.0
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 00:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752651271; x=1753256071; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pOoYNFD2223g06E4MhwB94DHvlp2MMvzfNkTsPnjQnQ=;
 b=HeASgRAB6dahB09+RsDWzvPh/RRP8gW+qGd/p63NY5TL4UCxa3u2NmmD1gkjsC5ZIT
 7gW3Meg2mWJdgslh6qwOJHJAvtoT5d9pfWPm9F1lvzwgJWhB1PwvnLp2/9MFpgQ9gJ1e
 LK6/PCeKNnCTtKsl9hdmV9P4UE1hpmSuI1tHvSzwr8uX4pqK2m2GG6Phn9R5KmPKofbo
 Tx0PdcNnwGCnvbV4e152fUq2RPxFUovPTPxxaM1NM5dtAlCmWUP6ifbzwRm7mD2NCggI
 H3o345q6WTd75BNiSclgYTpzyHqeV7160E5hqfzq8SJktBSJMNo4X6/IV0OB6Krt3TuZ
 WQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752651271; x=1753256071;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pOoYNFD2223g06E4MhwB94DHvlp2MMvzfNkTsPnjQnQ=;
 b=MR5JsDIl6aN9mPQUn6ZaQHYvaIWPk82kHIcW1asrWE54wj2UOw9NizlJ6oJtHwCjV5
 gkaKOZNm7b8WP0ZvLJu3e/sApL39x5mJhhLi+0yeozNqgIHAdlIcQGCm3L0963x5uLpn
 Uy6W8qleE17NpsZs3Ohs9aX1qNqbCROwjTj0fc7qF1PA1e2+8A/rxW9mbEeqlWuYEYVt
 51gGC44z6IJfT6o+BwULQZyIKtvGXGp5wy3FFKvLCb6bUTRyuw3iIvpJQKQdXMb0c+fv
 UMv0SaCJSYKOIJTJOZE+7hNIUlFD3Ia9AlMas+THp0MoF1M0xjM+7vGfmhYnYbV4e9ab
 7oog==
X-Gm-Message-State: AOJu0YxngImN2zuAtfvwX5m59RfWIA9w3ulQq/Hwc7FNOPwSPXgf4p69
 v6/FxDbBL906AOHqSXzau8GM8nCshuT/KKxCycewG91+m4UtP/QKu1nnvAZ4EBYmXwk=
X-Gm-Gg: ASbGncst0NJhLCTau/oOa7uKOzgAT4VQ5+aiN10kTJlPpR8zvGd91NhqnfscR3Ybvjz
 8fDbojss05rXZOmw5ry6Fm/J/q3eB+PPut6q/SvxtjtYflrZNHOn54qKIgVfWrnnAcKMmTFAIMD
 /RiLGT7/wxlztW3ueD6QnDjlp7xk87riQdYK8dBb3t6XxZCOAbBKwH7SouHstI/4WDBgdwx+Bjn
 nNMS0HwUTb4ATx5IDC7MXdJp9oYYvWAmWWzIYbeTquyQkCH11E6hQmm6wWgmigEb9ImKhi6WgZZ
 of235ZvsEoBdjV7peGLdrDpP/q/367S3rYOlaRYoGdHLKbwWwsKMszeffGmHBUgKdxmY1w1DeJr
 epLue0VFcJbTBZePyQE6DlcVCEHQ1EtlDaF0Nq0uOkviu1ADscj5gfUgum4KxuG0vV4cbsg7luU
 z5iPkbwEMG117oH06IVwcA4dBmB2qvzhXeY1dVU6PhN0hHDmtxCSPGPZeUv/GTWw==
X-Google-Smtp-Source: AGHT+IEGXnazpq/aWGDTQw0Y9/NcMMbDFOnt8DvzIXse6sd17xaqXORDgx5BJiYaYJIyYFRNAwSQMQ==
X-Received: by 2002:a05:6000:26c2:b0:3a4:f55a:4ae2 with SMTP id
 ffacd0b85a97d-3b60dd8de28mr1264579f8f.50.1752651271568; 
 Wed, 16 Jul 2025 00:34:31 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d785sm17398134f8f.59.2025.07.16.00.34.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 00:34:31 -0700 (PDT)
Message-ID: <f97ca222-fd8d-49e2-8e32-6e888d832f68@suse.com>
Date: Wed, 16 Jul 2025 09:34:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250709-xattr_bug_repr-v3-0-379c2c291bb7@suse.com>
 <20250709-xattr_bug_repr-v3-2-379c2c291bb7@suse.com>
 <aHf839WS0BPIa5Zq@MiWiFi-CR6608-srv>
Content-Language: en-US
In-Reply-To: <aHf839WS0BPIa5Zq@MiWiFi-CR6608-srv>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add listxattr04 reproducer
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

T24gNy8xNi8yNSA5OjI2IFBNLCBXZWkgR2FvIHdyb3RlOgo+IEN1cnJlbnQgdHN0X3NlbGludXhf
ZW5hYmxlZCB3aXRoaW4geW91ciBwYXRjaHNldCBub3QgY2hlY2sgcnVubmluZyBzdGF0ZQo+IG9m
IHNlbGludXguIHNvIGkgZ3Vlc3MgeW91IG5lZWQgY2hlY2sgL3N5cy9mcy9zZWxpbnV4L2VuZm9y
Y2UgdmFsdWUKPiBoZXJlLgo+IE9yIHlvdSBjYW4gdXNlIHRzdF9zZWxpbnV4X2VuZm9yY2luZy4g
Q29ycmVjdCBtZSBpZiBhbnkKPiBtaXN1bmRlcnN0YW5kaW5nLgpJZiBTRUxpbnV4IGlzIGVuYWJs
ZWQsIHdlIHdpbGwgaGF2ZSAvc3lzL2ZzL3NlbGludXggZm9sZGVyIGZpbGxlZCB3aXRoIApmaWxl
cyB0aGF0IGNhbiBiZSB1c2VkIHRvIHZlcmlmeSBTRUxpbnV4IHN0YXR1cyAoc3VkbyBzZXN0YXR1
cyAtdikuCnRzdF9zZWxpbnV4X2VuYWJsZWQoKSBpcyB1c2luZzoKCiDCoMKgwqAgYWNjZXNzKFNF
TElOVVhfUEFUSCwgRl9PSykgPT0gMCAmJiAhdHN0X2Rpcl9pc19lbXB0eShTRUxJTlVYX1BBVEgs
IDApCgpUaGF0IGlzIGVub3VnaCB0byBrbm93IGlmIHdlIGhhdmUgU0VMaW51eCBvciBub3QuIEFj
Y29yZGluZyB0byBDeXJpbCB3ZSAKcHJvYmFibHkganVzdCBuZWVkOgoKIMKgwqDCoCB0c3RfaXNf
bW91bnRlZChTRUxJTlVYX1BBVEgpCgpMaWtlIGl0IGlzIGluIGlzX3NlbGludXhfZW5hYmxlZCgp
LgoKLSBBbmRyZWEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
