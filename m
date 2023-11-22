Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD797C5AD4C
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 10:21:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E4623CEFCA
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 11:21:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6463D3CC2D5
 for <ltp@lists.linux.it>; Wed, 22 Nov 2023 22:34:54 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B35701400273
 for <ltp@lists.linux.it>; Wed, 22 Nov 2023 22:34:53 +0100 (CET)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6ce2b6b3cb6so153659a34.3
 for <ltp@lists.linux.it>; Wed, 22 Nov 2023 13:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1700688892; x=1701293692; darn=lists.linux.it;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=36p0YB0KR7O+G8lyACYy5o5yT1uc/pOfxqTgExJINwE=;
 b=z2gMbOwaxVa8zXYtkouwPqzvuO7B/ZAI+YWEGbbWolwC5cJMOp9KLyfksj4mRzmIA1
 R4vm4pCc7+hlGhatykf7forBv4FZlwIjIFhF4ltha2FlJzAVz/h6qbiXfgAJZjfVvHP3
 N0oXaQCwjKCrHXSqDuNeea+lWN17nI4UaKyQQcQWzeNyGIMum4oCcmGcfb0pi/Y18G4I
 PH8pIilG8R34v4x0dwarto7kP9EdSg/cNKFsIkFGwEShaXe9DxpZHIYixvnH6MhUjIsD
 D/23NX7aLfnz2dUI5OI1TFIzrBGLigEAdQJkSzclDFUqoolr9YKR0B4S5MSe7OsOjfcb
 m4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700688892; x=1701293692;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=36p0YB0KR7O+G8lyACYy5o5yT1uc/pOfxqTgExJINwE=;
 b=b79Dwy2BgDun5OIjUfborO1+/scJyg1HFWB5Yzo1HMOKGXXf1wb4DgZS6TuqfrVioi
 +WB5rImSSxK2gtyjkEbrQVDCnaQvzGCx6FqoQYz2LpvEfv8D2m6six30msznThfSEWXD
 5bx76QvhlSQjGFJPcAscsVC6SY/v+PNMg5TigXSQgpEGY0c64wQY5lqqbwM2Bjot2UjF
 Yobl81WkmPKsRGIKnfAc0hzDBe2gP3YiRnyP4YSYxgOQhDZsgZWKCNk4fXiTcCJT9s9E
 tr1tZSahs8ISC+x3laXC9v6rJCW+LFVhAZcWDw+OmcsulHCW3GGHn6MpTNmeE2DnxC21
 VWPg==
X-Gm-Message-State: AOJu0YzvCYB2OLnyolVJbZuAlxU/FYg+wMeRWuydg3InVnmPrheAkEx9
 u02svuii5ecEABX9UnLRLXtIUQ==
X-Google-Smtp-Source: AGHT+IFwMY3SgfREnZHEqzqmHiaM5728FRyA2VzbRjHPJgC6AoJTeiFgDXwUiYUVcDXU4jGdNCfrXg==
X-Received: by 2002:a9d:6c92:0:b0:6d6:4633:a735 with SMTP id
 c18-20020a9d6c92000000b006d64633a735mr4147790otr.8.1700688892225; 
 Wed, 22 Nov 2023 13:34:52 -0800 (PST)
Received: from ripple.attlocal.net
 (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a9d51cd000000b006c619f17669sm67156oth.74.2023.11.22.13.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 13:34:51 -0800 (PST)
Date: Wed, 22 Nov 2023 13:34:39 -0800 (PST)
X-X-Sender: hugh@ripple.attlocal.net
To: Petr Vorel <pvorel@suse.cz>
In-Reply-To: <20231122211318.31358-1-pvorel@suse.cz>
Message-ID: <27f877cb-1135-dcd8-7a1a-4f1c1b8e6e87@google.com>
References: <20231122211318.31358-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Nov 2023 11:21:30 +0100
Subject: Re: [LTP] [PATCH 1/1] diotest4: Skip test 3 and 14 for tmpfs
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
From: Hugh Dickins via ltp <ltp@lists.linux.it>
Reply-To: Hugh Dickins <hughd@google.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
 Hugh Dickins <hughd@google.com>, Christoph Hellwig <hch@lst.de>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 22 Nov 2023, Petr Vorel wrote:

> tmpfs in kernel v6.6 got support for O_DIRECT in e88e0d366f9c ("tmpfs:
> trivial support for direct IO"). There is no reason for tmpfs to reject
> direct IO of any size therefore follow the approach already used for
> Btrfs, NFS and FUSE: skipping test 3 (odd count of read and write)
> and 14 (read, write with non-aligned buffer).
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Acked-by: Hugh Dickins <hughd@google.com>

Great, thanks a lot. I've never minded tmpfs failing those LTP tests,
but had never looked at them closely enough to notice that there is
this established way to avoid the failures...

... but hold on: I can't look at the LTP source at the moment,
but records tell me that the two tests failing were dio04 and dio10,
whereas you say test 3 and test 14 - please clarify or correct, thanks.

> ---
>  testcases/kernel/io/direct_io/diotest4.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
> index 45c677b5b..ad00fa3e0 100644
> --- a/testcases/kernel/io/direct_io/diotest4.c
> +++ b/testcases/kernel/io/direct_io/diotest4.c
> @@ -270,6 +270,7 @@ int main(int argc, char *argv[])
>  	case TST_NFS_MAGIC:
>  	case TST_BTRFS_MAGIC:
>  	case TST_FUSE_MAGIC:
> +	case TST_TMPFS_MAGIC:
>  		tst_resm(TCONF, "%s supports odd count IO",
>  			 tst_fs_type_name(fs_type));
>  	break;
> @@ -443,6 +444,7 @@ int main(int argc, char *argv[])
>  	case TST_NFS_MAGIC:
>  	case TST_BTRFS_MAGIC:
>  	case TST_FUSE_MAGIC:
> +	case TST_TMPFS_MAGIC:
>  		tst_resm(TCONF, "%s supports non-aligned buffer",
>  			 tst_fs_type_name(fs_type));
>  	break;
> -- 
> 2.42.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
