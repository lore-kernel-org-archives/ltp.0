Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73872C02181
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 12:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737374414; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=NYOdl1TaYF4ZigCIcpzTfc9A5pjLEVJSKgknN+ojmMc=;
 b=QcqEM7C7nxed3YITUz1+pcrYZgJ0KBMi031Tg7cph4zmurAG0FrXX06zlra0qae6wmUEc
 Cow6434cdH1qqko8KdvliNDN3RdbHWgx5cX/dLv0HoMq0jx+zmeDGB2WLO08xl79qDU+axe
 7fXfGFvSbxmRaSzFpHAhGL9R59cGKNQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB6623C1AD3
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 13:00:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A030E3C03BD
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 12:59:52 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A1F6364ECB8
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 12:59:51 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so30025305e9.1
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 03:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1737374391; x=1737979191; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jVW2QeHQspBTSAJqqOkF7xOZCNrkP7xpQCjb7AJJfpY=;
 b=PFvc47WgY3ItwLwHBkPgAfHjXczOh88i+KXKOYJrBilRKil0Bt715qlPP7g+gjgXnx
 k7SOMBSDSG2UrmCt3IunEXj+gmRxu8CQGCtsuzM2h7Ez4AUbpUPMtkeiWBZYLS/O17gE
 ZjTWiYrM+wlNPfzwDxXB8S0TgH+MNNIgDZfzer621fd34NPfOD93Pfhp4TuXXlYR9Ah4
 PmxquqjR/HC05MUn5wvmCzbhH9bRMDtMc1HZymEgO8VZX8tCeKUHGSkxVXXS5uT+twIF
 P6iOsW1p26+xhzeDsYYS8DmWmXOkHy+reH7b+cdRZVv6ZSw8eBGgZqw2mSeQLTN1weT/
 i0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737374391; x=1737979191;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jVW2QeHQspBTSAJqqOkF7xOZCNrkP7xpQCjb7AJJfpY=;
 b=VDm3DAL1Cf91l4ooR1meDaQhECQKk6spSuSINsarwQJi6B10eg/IHalrHVFqc2zF+a
 M9EEysAKkxpqanctyNZnPiiKParfNZAsGOkEQ4BkQXspCYvedF47fH5jg8e4XBfq++hY
 yXmWbRrLrcGA7bPhU8h4w/yFIATqdwUA4ZEMb7JhJ6YxWlfGrpI0xdsT7HbBtwTKeHYQ
 Oy/9/SMy49SrWnQA+VXxKMxomBrqp1EEZn3hIbR4lTjoNUW5GEJwRfcdZh1D9iwR+cwS
 ZATEJrdPKOOG884f+uoxMOPBXeiARmJbXQNs1EMaP9hdmXhmU9NoLk2yUUXkaKw9Qx51
 b7kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcYqu2vaOS8oGKhminTCA+21igxmFufxw5qGgr7hMulQTSVHD87f+jz1ErUqw3Gg7iU2I=@lists.linux.it
X-Gm-Message-State: AOJu0YyAwULVgecw+pAI9AkEadLOzfo4fb4eCS/oXbLJYq6hIGLrktA4
 pxKbYkNJ/Q5oTJxzfhA5oS2JEX+Am1ZRJZ3FvBewD9VBeuAmuLxxTfiyL/R5IJE=
X-Gm-Gg: ASbGncvSoGdlm/34Jma2ee0Ch+56tDrJ3LjO46aeut/93xIB6Ixqr7YBGoAcgj+h8wW
 Cf6tc/oOy/cvxIX5vnZ/fFqSaehCWbKh/w3AJJlXs+cS0SBw5tQG9y3AJqm1DnUQFZvfWzYY11H
 d8xorNdjutZqJTTKVOvWx50n6LuNOgAPDUH/bmzWRptgh1ShfODk5MVrrbFz9f9b2TMD9WTUsKy
 n/PjCvSTeKsBeCoRkishq9JQlB+rosQaWyQ1JanH3lFuYeTxAtcx465+Cqe/IgiTUbyAUwAZKgR
 CEdp5+XxcKn2AqvcWzrfzSHz3EkqEzO/rsU24D2xWl7oArLeSGet
X-Google-Smtp-Source: AGHT+IG4APdRBiNOw8/+nwGSsKIKIscNqGNMEFUsNxvKEtNjWzC3MaQvpa/+oXBvDPVJsUfJoL18rg==
X-Received: by 2002:a05:600c:1908:b0:434:9c1b:b36a with SMTP id
 5b1f17b1804b1-438913dbf63mr113676115e9.13.1737374391025; 
 Mon, 20 Jan 2025 03:59:51 -0800 (PST)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389046b0f5sm137609045e9.39.2025.01.20.03.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 03:59:50 -0800 (PST)
Message-ID: <5202b2ba-a13e-4250-97c5-937dde849975@suse.com>
Date: Mon, 20 Jan 2025 12:59:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <Z3vJ6zXDVPACBIGd@yuki.lan> <Z4pj78casC9Ioyga@yuki.lan>
Content-Language: en-US
In-Reply-To: <Z4pj78casC9Ioyga@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

all good from my side. Feel free to freeze it.

Andrea

On 1/17/25 15:06, Cyril Hrubis wrote:
> Hi!
> Can we freeze git today? There are some fixes that are still
> work-in-progress but these can go in after the freeze.
>
> If there are any patches that add new functionality and should be
> reviewed before the release please let me know now.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
