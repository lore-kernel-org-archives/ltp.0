Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48460D49791
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 01:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733101938; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=URLi1ryzWNvExTjHv6jGCTc5ck8rglvPfSTNIyal78o=;
 b=aNkXwKrmeMuIAtAKabnij0s5/QJX63vnKhzLNYMTrNLvaFkHykNGXi3W2KvFMO7XUyjqe
 EH8f6OaFoB+ihrke+u+xuScRc8oVXsWe95K/x3tI7vuP6HCSlD/pK2sKIfF4uAKpeZJJYFh
 X+qUJOYA/FFxFS55XpjPfOd4mQ9ZEWs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A4713DD057
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 02:12:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08B523DD031
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 02:11:55 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CBC8414198F1
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 02:11:54 +0100 (CET)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa52edbcb63so831180566b.1
 for <ltp@lists.linux.it>; Sun, 01 Dec 2024 17:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1733101914; x=1733706714; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vp0U7zcY8byRtwa11w5k9qm3qD9qk9jjs1g2NsDqlVc=;
 b=I0i9Yj8UAPSwn4oSwqIMVHCW1O+mG2fj3QAY4u7xb6LE7bLDPs462xv+mMY/8e41cX
 RQosjMSwptD2QV+Z96eI1KRjMhMjN776pAd5C7P/6qoJ4K9B4PiA/JQWdjXCWF5RQmx7
 tBbkwqSx5HrIEew6CHqIn3KAy1B04jK6Oz70iE7CcUCDTbiZ0dYHQRY8zi9ZW4pqQa3t
 4j3ajBY1P2tm/oBIsPuonKPQZCwZ+TCPkZl0wSVufn4iaCdjeaW6RHgjixv0x8cX+E/n
 1KjR9IkdXjhBf4kvJIN/z68eZG0fDSrLRPXGVZWeFsSC2AkgxR7fcngXe1LGLUa5w2m4
 EoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733101914; x=1733706714;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vp0U7zcY8byRtwa11w5k9qm3qD9qk9jjs1g2NsDqlVc=;
 b=nHZrJCTxndmFqDStmdmjfUG98gratpXHESp/bBe0w4UN5mHIcxiKIJBiGCowD8yVEx
 bYya6CjNKUoI9m72jOdi1u7BbRnbruVKlf0cLEYqCnawPKsVkxdBmhjc+rx/lkko3CqR
 P594Y6MnsrgVlb2yedaJEFwOuSDxmt9W6RxVkJDYGq8IWPAy0AeQFOfa4woaSQPMuoLs
 n1cbEPxrm+DnITf9rGJ6mU5BJRbEoY8tsOEZs3kq/VsI/oY8Mm6V7pg6KxpIqOKHBnju
 0aZYUhUV4hlVEbmiBk9rHpWsoaA3E224aArMcUx2RAreptmhs5SLU25p/hX8oed+fFNG
 WKVQ==
X-Gm-Message-State: AOJu0YwwavYSBvsP0icOilG/dvVwEctOSYW0s8lJvlIdk3lrsWALXzHW
 Kef2ZWsroaq6eL0ycWywkfa72xEtdBkbanVMZ9U33aBdsT5/PkYnJXjbI8t0wA==
X-Gm-Gg: ASbGncugAuWVp3WMMNNAbaKWadtpG6Mnn+NXKu+UNbiC+Qih9ZgaMTUfxcMh0lO5A7t
 uttTfE5YdCbhfsJ65GZCIkdHk2lbtvXiIMzQHDf4+0AK2/d0YOopRMy0kYlSYAqRLMUuApNX2xq
 ul5QTdkXZqku+RlSZ+7QbJpOB7uaKxUxYFQupUGaBhXT4yHg39SkkG/2cQle5R5TW3WPh8uAqBp
 JBpVOTHJXqrUdw0jUhuSsVLYG1jR/7ZpA==
X-Google-Smtp-Source: AGHT+IGlnlTZyLVdUFj6zmiM94Pu/4/qjG1lyfxDBA/jStnHW5L+X3q2BIPmvQz2UIiqYbJqTTIHbA==
X-Received: by 2002:a17:906:bfea:b0:aa5:2cff:ede2 with SMTP id
 a640c23a62f3a-aa59466fd18mr1720924766b.26.1733101914046; 
 Sun, 01 Dec 2024 17:11:54 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa59990a7a7sm446762966b.172.2024.12.01.17.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 17:11:53 -0800 (PST)
Date: Sun, 1 Dec 2024 20:11:47 -0500
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Message-ID: <Z00JU0fJKS1qQteP@wegao>
References: <20241128072820.364726-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241128072820.364726-1-po-hsu.lin@canonical.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] logrotate: support new rotate debug message
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Nov 28, 2024 at 03:28:19PM +0800, Po-Hsu Lin wrote:
> This test was found failing on Ubuntu Oracular with:
>     grep -q forced from command line (5 rotations) tst_logrotate.out
>     failed unexpectedly
> 
> This is because the logrotate debug message has been changed in upstream:
> https://github.com/logrotate/logrotate/commit/be6a263c87
New msg contain extra string "empty log files are rotated" compare with original one but i have not see
any relation with above commit, correct me if i am wrong.
> 
> Include the new debug message to fix this issue.
> 
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  testcases/commands/logrotate/logrotate_tests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
> index 0aa9f12e1..1cd355f02 100755
> --- a/testcases/commands/logrotate/logrotate_tests.sh
> +++ b/testcases/commands/logrotate/logrotate_tests.sh
> @@ -90,7 +90,7 @@ test1()
>  	ROD logrotate -fv tst_logrotate.conf > tst_logrotate.out 2>&1
>  
>  	EXPECT_PASS grep -q "reading config file tst_logrotate.conf" tst_logrotate.out
> -	EXPECT_PASS grep -q "forced from command line (5 rotations)" tst_logrotate.out
> +	EXPECT_PASS grep -E -q "forced from command line (5 rotations)|forced from command line empty log files are rotated, \(5 rotations\)" tst_logrotate.out
I guess you forget escape "(" and ")" for the original string after add "-E"
/command line (5 rotations)|forced from/command line \(5 rotations\)|forced from/s 
>  	EXPECT_PASS grep -E -q "compressing new|log with" tst_logrotate.out
>  
>  	check_log /var/log/tst_logfile.1.gz
> -- 
> 2.25.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
