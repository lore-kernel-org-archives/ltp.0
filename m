Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C2BC433EF
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 12:52:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4366F3C5DAD
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 13:52:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57B913C4EC5
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 13:52:13 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A67F0600556
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 13:52:12 +0100 (CET)
Received: by mail-lj1-x234.google.com with SMTP id z20so4156772ljo.6
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 04:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bell-sw-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=EHIw7HbAT0PQkz25jUjbvAuzdLCg/kVa+/yT6mGwjvQ=;
 b=SU0rKZBDhXRBSmdqUlTjQBovpi26p/M1RFVokGIvLTMzI7oP01+xjOpfAO1SQpXti4
 0066ou/DWRYJEL8W+HfacrpY9eidWnkxHedhmNWJSw4kJy4BF9vqgx8VIS7lRlXIy/lD
 lsiUHsL7WB25vq50y+V5aM60ICHbxWcWWPwiW9N5wsg0LXvQNoTiMx32MNKzwOE6ME3c
 jOKUrjBpLGE1dTc+ZlHXxoaF+7s+gfm3JWoezYA5dGGtfjdVgwHrJ0eDflKiWo5jCyTz
 HVE7B+zUrtEiQfiuO3KjWts6c78cFxqBI7ou0XbxVNBm/nSEIsQnD5WaI8MksVPAkaWN
 ohKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=EHIw7HbAT0PQkz25jUjbvAuzdLCg/kVa+/yT6mGwjvQ=;
 b=dA/ZKEkuu4drPPDBbMVkucGauz319kZpJ5ZyddTLK91ymoDF2c8UVi+F8Kp5Vyqv3N
 GUNls2ZXZbceTt99SBiahJnwbGlOUSHEpsGuLASvkvaZj0Uj2rS1K7qhfDZF06ONfil4
 uemkEI8AKKL2R8wsRhUywHQvvwgAqoV1xfV88w36csjs6HB3iUT4ZeWUr9tdRsMhoI5U
 821J1cA1VFaJ7LXzweHiOlOyvScYGB08Eo6wQogHC+VmmxZJhgVCNhw/7zdiVjSUwRhK
 RjzE3b5exXb6s47D9hp98hRghwX4ixiL7M44ie5JN/HQ1/VqYPZ5+4GP21/ledbQYKp8
 LiCA==
X-Gm-Message-State: AOAM530zva1wJHtIoPJ3dHb4A2UQNiihNmAsypk1XjIlbdUQaxeJ7TU+
 H9cPVqjd/6qwgkBMQkyeYq/u
X-Google-Smtp-Source: ABdhPJx7zWxn7MTi4CNB8aXeDFO6hPjlytIadOTrWfEfE8lfX74jhSfRYE+bYoGXjiGudp8WPNJdiw==
X-Received: by 2002:a2e:bc26:: with SMTP id b38mr2775195ljf.54.1643287931988; 
 Thu, 27 Jan 2022 04:52:11 -0800 (PST)
Received: from [192.168.1.53] ([91.247.148.4])
 by smtp.gmail.com with ESMTPSA id h23sm1834342ljk.4.2022.01.27.04.52.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 04:52:11 -0800 (PST)
Message-ID: <7e0628fd-0815-ac51-79e3-9c544da55cb0@bell-sw.com>
Date: Thu, 27 Jan 2022 15:52:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220126150824.19331-1-pvorel@suse.cz>
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
In-Reply-To: <20220126150824.19331-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_net.sh: Print help ASAP
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,
On 26.01.2022 18:08, Petr Vorel wrote:
> This also allows not requiring printing help with root when using
> TST_USE_NETNS:
> 
>     $ PATH="/opt/ltp/testcases/bin:$PATH" gre02.sh -h
>     gre02 1 TCONF: Must be super/root for this test!
> 
> And with root setup was unnecessary things done just to print help:
> 
>     # PATH="/opt/ltp/testcases/bin:$PATH" gre02.sh -h
>     gre02 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
>     gre02 1 TINFO: add local addr 10.0.0.2/24
>     gre02 1 TINFO: add local addr fd00:1:1:1::2/64
>     gre02 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
>     gre02 1 TINFO: add remote addr 10.0.0.1/24
>     gre02 1 TINFO: add remote addr fd00:1:1:1::1/64
>     gre02 1 TINFO: Network config (local -- remote):
>     gre02 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
>     gre02 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
>     gre02 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
>     Usage: /opt/ltp/testcases/bin/gre02.sh [-6]
>     OPTIONS
>     -6      IPv6 tests
>     -h      Prints this help
>     -i n    Execute test n times
> 
> Now just help is printed, work for unprivileged user:
> 
>     $ PATH="/opt/ltp/testcases/bin:$PATH" gre02.sh -h
>     Usage: /opt/ltp/testcases/bin/gre02.sh [-6]
>     OPTIONS
>     -6      IPv6 tests
>     -h      Prints this help
>     -i n    Execute test n times
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_net.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 4dc0fca926..047686dc39 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -937,7 +937,7 @@ tst_default_max_pkt()
>  	echo "$((mtu + mtu / 10))"
>  }
>  
> -[ -n "$TST_NET_SKIP_VARIABLE_INIT" ] && return 0
> +[ -n "$TST_PRINT_HELP" -o -n "$TST_NET_SKIP_VARIABLE_INIT" ] && return 0
>  
>  # Management Link
>  [ -z "$RHOST" ] && TST_USE_NETNS="yes"

Acked-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
