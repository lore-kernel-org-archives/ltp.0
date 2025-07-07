Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C7AC8303C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 11:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751887664; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=sCuYN/5CiDFt6e3cQ2kWD9TdSSmgdC0Jo4WpcsVVuzE=;
 b=AEETY3wYybx9iXjeAmz3BxqfDdzSyTpAxJFpQGoWb1BG/RiZndUV+/MX/V8aSk7a0r3g5
 sNMH/VzxCclP4hkiOEnWomCL6YH860y9QbzA6JCJe9H3xjgRsf9H3sh5C7CYLxhh4PI217V
 3N9W1SZbenjWkpjvC7cduslutrECsTc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56BBF3C99D4
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 13:27:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42BBF3C2365
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 13:27:24 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 724C87EEB5F
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 13:27:23 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso28289005e9.0
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 04:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751887643; x=1752492443; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wyB+weHapd1j4O25d3WsMJQd/e+i+/g4oavHglGLRtw=;
 b=V4xnYdgQUpopKmhPNOdNX91befybq7Sdt8YLfqtsjQQ0IuDCztME+u6/Yv0/y6nYHV
 D+fznDpq0hvWFTxKJVwTLsdmLejubTRqK/9ccROxJw4bz1cd2HsiQEOqTV1uo+s6kllW
 gr0XlPz07ayh9STA939pqo8NlGwD6gUqVNd+PRZhJloI1PbJQQsznbwmxWFvRIdwGm1O
 +UVgo1S0SbgWkfgujOtccnXq1KmFIKz+RbtneM9/xvAXuK3FPdJgWe1/Wh7T2fPg1dMF
 zH25ZDNZutfTtkeqyhHfXUzLLeP2B3lqBavW3DSXls2UoAQ2VWln/eyaDC4ZI+gYRW8P
 i03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751887643; x=1752492443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wyB+weHapd1j4O25d3WsMJQd/e+i+/g4oavHglGLRtw=;
 b=jyXzCM/PqSYzfDxBP8yJsIVMe5eaSL5rJckgROdCOmWclPWEmc7BG8NCSImk6udgy9
 bzFQ5AgQEs6uSCle0VeA8IlSeQgCTHV6rd/L6f64/IyWBF4IHfIakowPBCSpu2hF4wYL
 BE1gEeCdKIIGLl6AolNN8vv/AXs2hn6SKCHYShq+mCmbJ2LVX+uzY3tes1V2320mZ96w
 CBtHj2QeyQrNrzau1L3a/peC5yaO9yVUpOhPSh5BkMyqzAINLO5TBPd4gzkKkb1cbzsX
 /dDKmuDorg3DK8BnEJ03G/Pfcrpnw/mW60KSZV7NeBPMv6xmQJ7DaX3euqfp1WSReJ2W
 SCow==
X-Gm-Message-State: AOJu0YwKbCh3CkpjPz9ZaXV/RuSsnJ8BpmLu2hoSLIA2BZrBozZvcFSI
 R41EUULLyCddOZFAnRgP2Rw+P2aXSvbWXTrBazexcfGIvpsD5efcmL/rYOHs2+eDL6s=
X-Gm-Gg: ASbGncvd91WJj10VmhnEUS6HuVJeLXHJcKvYNFnSey7xqWKVKvkKEsxG1xQeppVNIcg
 PKiQ3SrPGa0rqoOd92knX942r52Wr0QpQPkb23p1zTY1w8M1xsAJt7NQ89I5A1EpxoepPputxoi
 3tXact4+Ka9pikk1t1Pz31/N/Sf1sobfHd2MDJ9nBqW+9poPSs9DX1pYkIXdQ0ED+jp7trrsT/h
 HRwdnho/QyTybxOZSRem0IeB54bYDyUwYx0F8ADlBxaSFXCtKxHT9xMLapvLzctob1NrvclwvBh
 3qRWdtk5711EF+C4FYpGG+DxbuFcBBqXt5gkgQibI6jZ9wkoo5JUuU8de8e+yC/myjbfMKDG
X-Google-Smtp-Source: AGHT+IEDfrCKe8T4lJzxOwYqSenzPiKSQLPu/SqTXENU0TcBF92+sACFUbzTsU9zxQJqxP12KC8Zwg==
X-Received: by 2002:a5d:5f96:0:b0:3a4:eb7a:2ccb with SMTP id
 ffacd0b85a97d-3b495575dc1mr10441292f8f.16.1751887642813; 
 Mon, 07 Jul 2025 04:27:22 -0700 (PDT)
Received: from [192.168.0.223] ([83.1.218.186])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8458113esm84353985ad.185.2025.07.07.04.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 04:27:22 -0700 (PDT)
Message-ID: <ea380d60-6a11-41f5-b1f0-9ff6359206e3@suse.com>
Date: Mon, 7 Jul 2025 13:27:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20250620154346.19864-1-chrubis@suse.cz>
 <9fe4918b-431b-4ce0-9094-710385d5dd89@suse.com> <aGurP-pQEQkcPIy2@yuki.lan>
Content-Language: en-US
In-Reply-To: <aGurP-pQEQkcPIy2@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Two more metadata parser fixes
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 7/7/25 1:10 PM, Cyril Hrubis wrote:
> Hi!
>> Feel free to merge, I will fix kirk later on.
> These changes also crash doc generator since the format of the metadata
> has changed:
>
> Traceback (most recent call last):
>    File "/home/metan/Work/ltp/doc/.venv/lib/python3.12/site-packages/sphinx/events.py", line 97, in emit
>      results.append(listener.handler(self.app, *args))
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    File "/home/metan/Work/ltp/doc/conf.py", line 517, in generate_test_catalog
>      text.extend(_generate_setup_table(conf))
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    File "/home/metan/Work/ltp/doc/conf.py", line 407, in _generate_setup_table
>      values.append(f'{value[0]}, {value[1]}')
>                       ~~~~~^^^
> KeyError: 0
>
Sigh, we need a patch to include in this patch series then..

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
