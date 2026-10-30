Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010BF606A31A
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q8hRFM6E
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 989463E707E
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 14:37:50 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68B513E4C15
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 14:37:36 +0100 (CET)
Received: from mail-qv2-x0b.google.com (mail-qv2-x0b.google.com
 [IPv6:2607:f8b0:4864:33::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CB68B600B34
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 14:37:35 +0100 (CET)
Received: by mail-qv2-x0b.google.com with SMTP id
 6a1803df08f44-90cdfc57039so2060906d6.0
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 06:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793367454; x=1793972254; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NB3q+ykstUxV0c86YhuZlD1A4RXG9BEpkrfFUgQ/6Ws=;
 b=Q8hRFM6Em3b56RzwQDuFjqGinURE0W3lGdZk/l3KK/WvaJ65qE+6GlTEEbPltJPqyM
 Zo4RJlzGoO6l8BYOv+HRR8YaKKCx3Y6A+pBJ9/lHuiGcvoM9y9pnxiuaLtOMIEJ5bHYx
 tvPg0PjK7JN+4ZZP1Tx8zAaSX5zUyEfkT/BFsWxDBiDvxM19mxtHETS54KEMtNzmhjEb
 O6gU1pcTD3K5SNqycXjHks0koK8L8z2xFyQJVxifczBBoR2DWjsCXsV0Ksky4c28WJmk
 ZIVDTIBgbsn4kvAu+q8lVTUwgQsQCXy0ZLm6ezwXi92lfQeptfDVEdxeKnMdJ8Nbxu1J
 s7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793367454; x=1793972254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NB3q+ykstUxV0c86YhuZlD1A4RXG9BEpkrfFUgQ/6Ws=;
 b=Hz6t5KgMxEW4f3XpjXeqaZqA82CrkoCqwpnAIZPG4Zd+EUNrPubmfY+JAWWAve696b
 wwEpVVdEMk0rk+mdjydb/9v5ajf4lnqquACnCRhDj9dtZCOCzhhjFo0eocVqMUj8y38k
 o03uHUDCgv0yNlKC+8Oprzt6qmUtBKdjEw3N5XLZ2AEF/NUY9Rh//prmsru89Ucd2FeK
 nSSnSk5m48SHIi4y1umA7BizXFeCtSkHxZk5JhKjuwznk2VtOZxgndZgf/nGuLXlx8It
 2LmYnVPxr5pcDzzG1yzlgicXDMsRWK1yGG6ZOgTC6m4xfAjuiAxeawM+F7/mlyJTO+J4
 Qd5g==
X-Gm-Message-State: AFq9FYKygEgLiGa41Ghp+5n+ZtnY9E3/oxfE7R3SLf/OvC9FF4zKw32m
 0tFqkwvof1gi7rlNJrdqqA81iicrG49an5fUyHb+GKXUxsRrOINMCXtq
X-Gm-Gg: AYBFou16TcEgqj/pRANUkaoVCCWvsnFQ8ImznTuiBM7uHUDqW7VT6u2caRrp/Oh9g9P
 R3+k6OyAA/90ykYNBXugRlDrdICLQkuboDf7c6NwYkHTCf0oNXBOGwD1ugezkzP+o5/kAjJWw7r
 qLXPCxG+KgNfahMCPxJcMzC1vR5E7B/nmXdu7QI5zoLHjqY4P6QCej33YLJ3Lp7ppufwpWxtO/T
 yi7jl/Kw4bMnqTzdrH7SRTJGgMpb7LLeMoQAH32f/yi/lamumaNtdgBGRB33daH15dPkAGxdd38
 DbmO+LIl2vyOPeaxm97g8NvD34hYqSr54Tv44u6N4b9JZMwY72LYFWQ00bXAZEh/Mm1cwKI3Ydq
 lr9VWh9O5h/UafNwvcalzfVl498OaC03mTlKTCs1K4vKKSebNJKVZhBvIn1gEsaWrimdW3Fhqs5
 iBUK7dVOhQJUjeKLk/GU46+BESlmwtjzxt6W+5tRYlb1yCqFiUqnE8M33GdR7GRFLFOK83+CL7p
 TIc2wFVJ3fdqCQuqkGcl6eNEq/rXwFOxO9QGfrAZlae1TNmUyueJ4HqN7h++IWhfHkmJgz9jvI4
 7TtJrJhIcz4f/12P3QoHv1I/QzMB9+gSbScyvpZYLMyzguZ5xeEH4N8w8mRVaCEKmk1s1tWcXdr
 Py1DMyvuq3K3nFB3AIfmeVhM2aCc9KhjQbJSel7V1iA==
X-Received: by 2002:a05:6214:1bcb:b0:91c:7a10:7fbc with SMTP id
 6a1803df08f44-91ca4a14adfmr37345236d6.4.1793367454178; 
 Fri, 30 Oct 2026 06:37:34 -0700 (PDT)
Received: from
 runnervmnwato.mza5ryxlfvpuhfi1egy5fgqpkh.bx.internal.cloudapp.net
 ([48.217.26.135]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca7e23441sm15777656d6.4.2026.10.30.06.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:37:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 30 Oct 2026 13:37:32 +0000
Message-ID: <20261030133732.3727-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030113637.78343-1-pvorel@suse.cz>
References: <20261030113637.78343-1-pvorel@suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] nfsstat02.sh: Properly fix netns enforcement
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Fri Oct 30 12:36:37 2026 +0100, Petr Vorel <pvorel@suse.cz> wrote:
> nfsstat02.sh: Properly fix netns enforcement

> diff --git a/testcases/network/nfs/nfsstat01/nfsstat02.sh b/testcases/network/nfs/nfsstat01/nfsstat02.sh
> index 75a1a01b5..193a52b59 100755
> --- a/testcases/network/nfs/nfsstat01/nfsstat02.sh
> +++ b/testcases/network/nfs/nfsstat01/nfsstat02.sh
> @@ -20,7 +20,7 @@ do_test()
>  }
>  
>  # Force use of nested net namespace
> -unset RHOST
> +tst_net_use_netns || tst_net_unset_2_hosts_variables
>  
>  . nfs_lib.sh
>  tst_run

tst_net_use_netns and tst_net_unset_2_hosts_variables are called before
nfs_lib.sh (which sources tst_net.sh) is sourced, so both functions are
undefined at this point and fail with "not found". Calling them after
sourcing nfs_lib.sh is also too late because tst_net.sh already evaluates
RHOST and runs tst_net_setup_network at top level while being sourced. Set a
variable such as TST_NET_FORCE_NETNS=1 before sourcing nfs_lib.sh and handle
unsetting the 2-host variables inside tst_net.sh before the RHOST check.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
