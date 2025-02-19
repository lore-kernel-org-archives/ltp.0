Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBE1C021B1
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 09:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739957403; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=ykwHyMszL+T4qCGI5Bzm/22jT9LwYVLHooSG9W9J1Tk=;
 b=N8bASDiKyi1zXQrVvOUHZCqoZEBAc9oL47nFJhYFT9113jA0k4FQBqTSXj9qyWVKcqW/+
 Ho+UgDoN++YkO0e+ebwLtNsy7PuqB5nxYTBK3hWHznO5QP5S1OUaaA2ksX5cX7b3sFFmdS0
 3mCGRecxVg28furFXACLIv2c2phhX5g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5585B3C29E6
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 10:30:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67E9F3C264A
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:29:42 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EC123200240
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:29:41 +0100 (CET)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e0573a84fcso5306691a12.2
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 01:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739957381; x=1740562181; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oROBdjAtvWcrOBaXAHtjmhonSVuqOQRljfzs+1k9KIk=;
 b=VVOUMMHrsON3nmXl3K89n28aT/E+Lo2I1dEhI2qiYHA5NTn0x2f+24R9KpUGG7+8Lv
 BNnbxfy5irx0kN9rAY9kvBCYuomYwEk1L9KDX9YyOrqPiMiMrmuBNmHjZzefCbNxcdzs
 iuLpJy5qEnU7llWpSfhrTiR/GqSIZWaNmuUcwDEeOQNLVuCzu2zkrCNBK6xCdyx6BKtA
 eX6dtpqQsReq+xpC4VC3AJ0cdyCa2cxKsqWIX+l3np76rdJgOu0utrhd6fs9PwohZios
 NcA+fkYMTSxyDqCIJqzmu23yvzVUbhGqlP6RVw/uLp5v4ahBMiQDPEWbVBA+9poGsWVY
 DQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739957381; x=1740562181;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oROBdjAtvWcrOBaXAHtjmhonSVuqOQRljfzs+1k9KIk=;
 b=bgtgXsw9yyXrKODOmRXs4f6ryQhAi6NZ3ny7Az/b+06sLiOWpAdnKP0k+r0krwWi4v
 zKHgWdzwqj/J/xD8/RiizYfsk5RCb4EQlHIId/pTkkCBngqwZK8E6ChRMDiCL/ezmjq0
 Smhv9o3wJbViA0pjT6KHfHfwaYfOC/xQGMyLG+5gYs7hFTGtUcE6dXRi0pOdIvnBkJnA
 SCAVseL7v2vIOPONadJDzWOt13VBflyXqq1NDV9NxduHc4IPm3vDB5h+WIQS8t8zLO30
 xB2a1sc6/Flp8VxY3ygBjxFwyD7Y6lESctgweIWtNGchFheSfuaXFeoDHITbMGdFiy6a
 V3rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaLjhsscy0Z91Vucwt8cSCBt46H1d9sHToGGd67LyVK/CTvgnO+gm31fkP446Cre+Zctg=@lists.linux.it
X-Gm-Message-State: AOJu0YwgzYxvqTyCft6DD8bib9ZlbhN5k/NotMaBcnM4fQyeYi3G+iqS
 rYiyidn57I9SShaGZKi8uJAhJgKJUeU/9v7szj8CBDg5Wazvb2bPlsveHf4Mf8Q=
X-Gm-Gg: ASbGncvrp72QlN43F5zByW5zVlXic2SnhwQgrFAkozktvWHAjPDPDAQkJ4FraDzIDjo
 usek60reHRfWfu9b3BmQ2sSJFmxtUt81TFMUXeY1/FDXJh/fyHCESVJlD2RW2eN6li2VFf5Vjrj
 wqFiRArtGrfMrIic8/R0DNiMh3t7jE8dq3C50sKVEtJg2azwvslKx8kWdN4DwgfqmhRk0zISOpN
 HI5Z+VCIe68TodVGbdb8fqBNUKRY/NjwvJLneEtNUbx8O45GEQSFVPlKuIOZKbGFIPXnpQEO8KI
 EBQsu6JGP2u1uZfYQhAn3BjH+WA5ws+wAqzTgNBz2zyA4gr66bgfCnVV5OkZJqxy5njERMIdsZy
 VEujutukHw9ZbyiPZRfM2e4bs3cDd4KFKTLumXYrn5lWP6WzLufA=
X-Google-Smtp-Source: AGHT+IHcXl44fztVK1n0LcFVZ+/GfMZbivxasQ06BarWk8nqWKYO3eAmMID3NpOX4BG8JfEiz9yIfQ==
X-Received: by 2002:a05:6402:2084:b0:5e0:8c55:52b with SMTP id
 4fb4d7f45d1cf-5e08c5515cemr1505204a12.15.1739957381181; 
 Wed, 19 Feb 2025 01:29:41 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ded709a92bsm9078701a12.63.2025.02.19.01.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 01:29:40 -0800 (PST)
Message-ID: <a611713d-898b-4e35-979b-13d52b28ec09@suse.com>
Date: Wed, 19 Feb 2025 10:29:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chunfu Wen <chwen@redhat.com>
References: <20250218023107.1208990-1-chwen@redhat.com>
 <D7VJNTFZM1Z5.1WXQYU2HD3T0P@marliere.net>
 <bc3276b8-8383-4ef8-a4d7-a2a786662cbd@suse.com>
 <CAAA2g-1G6q_+049zVD8=ZwuighYa6YHiXwzyXKUG8Uy3RAqaUw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAAA2g-1G6q_+049zVD8=ZwuighYa6YHiXwzyXKUG8Uy3RAqaUw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] Add test case to cover the setting resource
 limit64 for process
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
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpPbiAyLzE5LzI1IDAzOjM1LCBDaHVuZnUgV2VuIHdyb3RlOgo+IEhlbGxvLAo+IFNlZSBp
bmxpbmUgY29tbWVudHMuCj4gQmVzdCBSZWdhcmRzLAo+IENodW5mdSBXZW4KPgo+IE9uIFR1ZSwg
RmViIDE4LCAyMDI1IGF0IDk6MjnigK9QTSBBbmRyZWEgQ2VydmVzYXRvIAo+IDxhbmRyZWEuY2Vy
dmVzYXRvQHN1c2UuY29tPiB3cm90ZToKPgo+ICAgICBIaSEKPgo+ICAgICBUaGUgd2hvbGUgdGVz
dCBpcyBhIGR1cGxpY2F0aW9uIG9mIHRoZSBzZXRybGltaXQwNiwgc28gaXQncyBiZXR0ZXIgdG8K
PiAgICAgd29yayBvbiB0aGF0IG9uZSBhbmQgdG8gaW50cm9kdWNlIHRoZSA2NGJpdHMgc3VwcG9y
dCB1c2luZyA2NGJpdCB0ZXN0Cj4gICAgIHZhcmlhbnQuCj4gICAgIFtjaHdlbl1NYXliZSBpdCBp
cyBhIGdvb2QgaWRlYSB0byB1c2Ugc2VwYXJhdGUgc2V0cmxpbWl0MDcuYyBmaWxlCj4gICAgIHRv
IHN1cHBvcnQgdXNpbmcgNjRiaXQgdGVzdGluZywgc2luY2UgaXQgY2FuIGJyaW5nIGludG8gdHdv
Cj4gICAgIGJlbmVmaXRzLiAxKWFsaWduIHdpdGggZ2V0dHJsaW1pdCwgaXQgaGFzIHNlcGFyYXRl
Cj4gICAgIGZpbGXCoGdldHJsaW1pdDAzLmMgZm9yIDY0Yml0cywgYW5kIGl0IGhlbHAgZWFzaWx5
IGV4dGVuZCBtb3JlCj4gICAgIHNjZXJuYW8gY2FzZXMgZm9yIDY0Yml0cyAyKSBQdXR0aW5nIHRo
ZW0gaW4gc2VwYXJhdGUgZmlsZSBpcyBtb3JlCj4gICAgIGNvbnZlbmllbnQgZm9yIHVzZXJzIHRv
IHNlbGVjdCB0ZXN0IGNhc2Ugc3BlY2ZpYyA2NGJpdHMgdGVzdGluZwo+ICAgICBvbmNlIHVzZXJz
IG5lZWQgdGhhdC4KPgpJZiB0aGUgZ29hbCBpcyB0byBnZW5lcmF0ZSBhIDY0Yml0IGJpbmFyeSBz
byB1c2VycyBjYW4gZWFzaWx5IHJ1biBpdCAKd2l0aG91dCB2YXJpYW50cywgeW91IGRvbid0IG5l
ZWQgYSBuZXcgZmlsZSBidXQgdG8gZWRpdCB0aGUgTWFrZWZpbGUgYWRkaW5nOgoKIMKgwqDCoCBp
bmNsdWRlICQoYWJzX3NyY2RpcikvLi4vdXRpbHMvbmV3ZXJfNjQubWsKCiDCoMKgwqAgJV82NDog
Q1BQRkxBR1MgKz0gLURfRklMRV9PRkZTRVRfQklUUz02NAoKSW4gdGhpcyB3YXkgeW91IHdpbGwg
aGF2ZSBhIDY0Yml0IGJpbmFyeSBmb3IgZWFjaCB0ZXN0IGluIHRoZSBmb2xkZXIuIEF0IAp0aGF0
IHBvaW50LCB0byBzd2l0Y2ggYmV0d2VlbiBzeXNjYWxscyBhY2NvcmRpbmcgdG8gdGhlIDY0Yml0
IAphcmNoaXRlY3R1cmUgZGVmaW5pdGlvbiBpcyBlYXN5IGFuZCBydW50ZXN0IGZpbGUgd2lsbCBu
ZWVkIHRvIGJlIHVwZGF0ZWQgCmFjY29yZGluZ2x5LiBJZiB5b3UgdGFrZSBhIGxvb2sgYXQgdGhl
IG90aGVyIHRlc3QgY2FzZXMgeW91IHdpbGwgZmluZCAKbWFueSBleGFtcGxlcyBvbiB0aGlzIG1l
dGhvZC4KCkFuZHJlYQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
