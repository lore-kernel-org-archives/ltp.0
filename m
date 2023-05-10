Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05033C7EE22
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 02:44:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 351A73CE163
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 04:44:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACBC93CB531
 for <ltp@lists.linux.it>; Wed, 10 May 2023 04:44:23 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6888C140098C
 for <ltp@lists.linux.it>; Wed, 10 May 2023 04:44:22 +0200 (CEST)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ac81d2bfbcso71856851fa.3
 for <ltp@lists.linux.it>; Tue, 09 May 2023 19:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20221208.gappssmtp.com; s=20221208; t=1683686661;
 x=1686278661; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m2XOAZShFq8RdiQ/JcdpE0C0lZjWyHGZgNTXx8hfjF8=;
 b=k+NwNKT47qVXF5SB+5jaJgZ68vytuEen6cXJRqJdvN55QPDagMivHS1JEziXJnVGCp
 pcFv6t8jNfYbzhjCDWnAipVtm7VELVVaOQ+oQLYPQP5OUjsQ6PYuB0fwLWod1odGVfEN
 6rbATTibKrwj5elLbDQSDxnqk7QIwGQsuLMsdaveIaZIJ8IvvLpvhou4EuOsdtsJr2n1
 000Yodsg085rID1m+TaW8Lc4kEiYBJHLFN/RTi7PsYZ/wfKCXYvxsGvDBi+JoPhZDbuI
 IllEsVvtPNrnEnBasseB8XoBPDo2Z04MHI63Fi2o6+qvgBYRloxREJ9kDM/FnUT0HpXp
 SHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683686661; x=1686278661;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m2XOAZShFq8RdiQ/JcdpE0C0lZjWyHGZgNTXx8hfjF8=;
 b=BlPswK7JAFMn6xrwicJAUUhjJTmoN7BxL9D++e5iIHis8L5LwNKAtRjABaOp5W3RjX
 NUPGgamMVl0U/kQLePSf8p5gqDzbCD0+0HaK0XZCM1DoabImpeypAirbQiVn2S9qlQYb
 QQtIWavYsXgVZXBkkO0XnFAoYfkgVBraJjx+EHcnLCoUZK0BJXYmPNb8cWg3vn1gX6pm
 YPIfcwHAyxzgEflF+m0B5dgDxIbALNsFgxsU5SVp7ffhw2mSTVhtKO5tZFGpo++2V1jg
 XoAipg9YGk/rsjq4hgXBGfE3L+c5QLZnZauLEiTTIlF+Jliu2BySbhKz1t3EFw1fDFbt
 HzIg==
X-Gm-Message-State: AC+VfDzNdNrfpl1T6ucM6TJJ3SJgIPlZ6dsryHYl/YZITmXuH3rI7aBR
 BOKUIgF7zKyzJmlE8+F/Mhp3DQ==
X-Google-Smtp-Source: ACHHUZ5/UgJSsNisMjjiVB+kpsbIVgeNwhiqSO3VQFx885KqxGdWVUnre0HiyrjMuXZkKron5g2OZw==
X-Received: by 2002:a2e:918c:0:b0:2ac:7d78:3465 with SMTP id
 f12-20020a2e918c000000b002ac7d783465mr1548638ljg.15.1683686661474; 
 Tue, 09 May 2023 19:44:21 -0700 (PDT)
Received: from [192.168.8.148] ([85.193.100.38])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a2e9b11000000b002adb0164258sm165813lji.112.2023.05.09.19.44.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 May 2023 19:44:21 -0700 (PDT)
Message-ID: <f7bb2f33-ef06-b372-b296-49dc70d37c95@cogentembedded.com>
Date: Wed, 10 May 2023 08:44:18 +0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: NeilBrown <neilb@suse.de>
References: <20230502075921.3614794-1-pvorel@suse.cz>
 <d441b9f9dfcbb4719d97c7b3b5950dfeeb8913d2.camel@kernel.org>
 <20230502134146.GA3654451@pevik>
 <81826e4f-aa4c-1213-8b2e-28ef57caf1a3@cogentembedded.com>
 <168367324318.15152.8314945101964061099@noble.neil.brown.name>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <168367324318.15152.8314945101964061099@noble.neil.brown.name>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] nfslock01.sh: Don't test on NFS v3 on TCP
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
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Steve Dickson <steved@redhat.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>> The overall picture is:
>>
>> - by design, filesystem namespaces and network namespaces are independent, it is pretty ok for two
>> processes to share filesystem namespace and be in different network namespaces, or vice versa.
>>
>> - the code in question, while being in the kernel for ages, is breaking this basic design, by using
>> filesystem path to contact a network service,
> 
> Not just in the kernel, but also in user-space.  The kernel contacts
> rpcbind to find how to talk to statd.  statd talks to rpcbind to tell it
> how it where it can be reached.

AFAIR the badness happens when in-kernel nfsd registers itself in rpcbind, using AF_LOCAL to contact it. 
When nfsd is started for a child network namespace, it immediately breaks nfsd running in the root 
network namespace, because ports used by the later get overwritten inside rpcbind and become no longer 
available for local or remote clients.

I'd say it is userspace responsibility to make entire setup consistent against the used namespaces, but 
it is kernel responsibility to keep namespaces isolation while executing individual operations. In the 
case of registering in-kernel nfsd being started, using namespace-safe way to do it looks more important 
for me than the reasoning outlined in commit 7402ab19cdd5 ("SUNRPC: Use AF_LOCAL for rpcbind upcalls") 
that you mention.

And, this won't be fixed by trying to an abstract AF_LOCAL socket before using a filepath-bound one, 
since if one is not available, the nfsd running in the root namespace will still get broken by starting 
nfsd in a child namespace.

Maybe, the way used to reach rpcbind to register in-kernel services shall be special cased.

Nikita

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
