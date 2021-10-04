Return-Path: <SRS0=YkbW=OY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0000C433EF
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 22:10:52 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD69614C8
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 22:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFD69614C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EA703C6ACF
	for <ltp@archiver.kernel.org>; Tue,  5 Oct 2021 00:10:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B36543C4D0C
 for <ltp@lists.linux.it>; Tue,  5 Oct 2021 00:10:38 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1D53F1A003EF
 for <ltp@lists.linux.it>; Tue,  5 Oct 2021 00:10:38 +0200 (CEST)
Received: by mail-pl1-x631.google.com with SMTP id y1so875786plk.10
 for <ltp@lists.linux.it>; Mon, 04 Oct 2021 15:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NwsTI3CQQGkDOXyEM9w3e5p7zsfy6iE7LxChlq/1awE=;
 b=pVVWEJUhvECA3Ztq+eLszPXiei3Em3wSlDGFQiYRu7fOwHu/d0aBud/VI6fYIxMJm3
 v6Gx7Kr67JUTOIB8i79js8PNFpBZYRulwHXL89vApoFDKz6kOLOM4VZAcVGxD91lcA0v
 TNZJrF6adYW8wXDgoFknI4m1zsubKjXWrx5PqiPh5ORNmDA8sNg7NfG7HyTDkge9LZcc
 OHprvVIUWnfXkw5lGgtKzOfCiQXgiYBBuceeClC/jRwkE1H2/2Bde0ZuIIHoEIlZIkHP
 RL/fN+Fd/otTp13OTK8xvNtGFgNsEzN2uqZWKgEac+6uIMKM48V6PtnCs6ekx/FxEqKT
 H9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NwsTI3CQQGkDOXyEM9w3e5p7zsfy6iE7LxChlq/1awE=;
 b=k9I4Jbv1jsXgVKc4DMLuXVIUfoU9RnJWERN7NlW+cXIHKn4oI4GqxtbjpSeiheZC9m
 SbeWPDgV03EqyIpEEugRcUfJEG0hYLgUQ0l2IykGdJAi6fEjbWCl4gGW6ViNvOMGKULs
 4wNccoJ6FsSmmMpaw4oZn/7HlZX+XEK1NV48SZyqOcO9e4iPynPzQS8l5y6JY2vgyuZY
 SdoAFs0U6Fa0igV1hZccdLixd2VVczZHTtnfEL6YfE8R3hIssi4Lk+Bho7ITtrMf0i9M
 c9itM8MOdYKT5jEXJXAi8ovhbamWvs+PgrIQIyEc8JTugYbGlAOFKrH5YCDTrF5RCQAR
 ijbQ==
X-Gm-Message-State: AOAM530IPAZY5JYr9Nt1oQ5yAvcJ/0ruxCKv/NLptb2hx3awoTcVT1YY
 DnRs5uRqN2lWs+vOM8trh6moD93PC7R/pw==
X-Google-Smtp-Source: ABdhPJzWUzcNBpayaPbtcj2+VigPM0fZyl/xizVvCd5EOIDq2keZdGKNRjFRjz+qb+1V/nfHHmXRiA==
X-Received: by 2002:a17:90a:7892:: with SMTP id
 x18mr6053630pjk.33.1633385435641; 
 Mon, 04 Oct 2021 15:10:35 -0700 (PDT)
Received: from [192.168.4.77] (c-73-53-102-249.hsd1.wa.comcast.net.
 [73.53.102.249])
 by smtp.gmail.com with ESMTPSA id z12sm13741413pjb.52.2021.10.04.15.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Oct 2021 15:10:34 -0700 (PDT)
To: Petr Vorel <petr.vorel@gmail.com>, Sandeep Patil <sspatil@android.com>
References: <linux-test-project/ltp/releases/50325863@github.com>
 <YVQf9xSxrXjobBM9@pevik>
 <CA+nhYX2qvXjaxOBRmEJyqBr0B3JY053PiqMZ3MN-M8HdYvEnRA@mail.gmail.com>
 <YVtBt+WeskISn5+9@pevik>
Message-ID: <2a6a43e1-25da-7eef-f212-bfe0371275d3@google.com>
Date: Mon, 4 Oct 2021 15:10:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVtBt+WeskISn5+9@pevik>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Requested user & group [was: Re: [linux-test-project/ltp]
 Release 20210927 - LTP 20210927]
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
From: Steve Muckle via ltp <ltp@lists.linux.it>
Reply-To: Steve Muckle <smuckle@google.com>
Cc: Sandeep Patil <sspatil@google.com>, ltp <ltp@lists.linux.it>,
 Martin Doucha <martin.doucha@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 10/4/21 11:02 AM, Petr Vorel wrote:
> I'm sorry, I was wrong, I meant GID "nogroup". Looking into the source, there is
> no "AID_NOGROUP", thus we need to keep using GID "daemon" for AOSP instead
> "nogroup". IMHO instead SAFE_GETGRNAM_FALLBACK() this should be set somewhere in
> the library, so that it's for all tests.

Hi Petr, I've created an issue internally to track adding 'nogroup'. It 
may be a little while before it goes in though.

cheers,
Steve

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
