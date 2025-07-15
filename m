Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1914C83F1A
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 13:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752499232; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Tv4flPA/WUH9kBkopIf8yEIQpNcgdEYLAZS2tSSkDms=;
 b=q6Olo1vu8mZnqUx9ktn8aVkeAptYsZXSPRSB8iU6ORO3Dk8EuoSXBZtpKW4wW+GPiDOq/
 FrM3SBOsUHG1lPNCx+jTt+ziTqN5ZCuRO/HyuFB4cjQeTO94rnJ0CXUnqYvKie+9fm30UyH
 Dmi6ZZ3raIj4dS5Op3Hq70ki4IySUH8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26EE53CB5C6
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 15:20:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 960523C83A9
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 15:20:10 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AB0CF1400E43
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 15:20:09 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-455fdfb5d04so11445635e9.2
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752499209; x=1753104009; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MQGNqK6lqJ2J4eR/bNrJE0mlCUvo430vvKWQF8m/+IQ=;
 b=Q0o5/yb8enD04BV3iABqugkPQAAy/ig88MlIsl5hx0uCO/J7PLIQ4VC7qAEpLOyJAy
 +UB4b0h2fTJyuNJtziVJ4ipW+iEF2+UACDZ3vzdQfudpuDab3fxDbGql0KSWu5KU1XaO
 x2wkImD5bnbOZ7RzHLQvnFCI0wL49r1NrGG0tq2k1Q7VUsGJgEBXHuUVODs1oEpU7UMO
 WCUvc1GcdgNMmGDxDfeqyBYy2cG1Oj+MdtvryOi9veMWEX3FUUVxKcsyganCqxJY7cuv
 SSpI4reDkDxQ31vYq9DiLJsU6VNogE0VMVoS5+Nh7Wg/d0fBV9jP1cpYBzKGaCw0E0eu
 QWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752499209; x=1753104009;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MQGNqK6lqJ2J4eR/bNrJE0mlCUvo430vvKWQF8m/+IQ=;
 b=RCpszRUgsBHEWk5FcQ6dvREtg/HaPOLRh7kMIDJMQjcFgRHDP0kiac2im4QXUsMT3C
 aXKlARlkOaCOmGVYEOY1T4O6lvWSjHXf3pRK/hEBusY5Efh8wCwPk5TL+nxYlbQZ8gIC
 5SK0M+JsTCAxn/hEW7bZCswEjrjDGrCCg0hMugkoJe964cJTfi5pjShn/NvLS4PBn9p7
 OJ8lUnXlSZYvm+PhHycc/sP4hQmHoYFWp+rtC/KHZdvMTbbTdVLKf7JVVrbtNWs323lY
 5OjFcPNoESJznS2oLPT7r8xY9nHo9pl8WqnHhzzDTq9XZKM2OGK/CawwD4+8tU8pdEav
 jxkw==
X-Gm-Message-State: AOJu0YxdwaeBzfqPaa4Kzq5JXdwNJFWBOr3vI6+hxdLHzBMKuk9kUcbP
 8T1Jv5LVQ+3DvyGLqmY+JBpa/VkRclfr+ariAaWMuVhEK5PK3iRH3GxuJufpVUMnWoAfWd/33z1
 Mmak=
X-Gm-Gg: ASbGncvdjXQ8HflJbcIniSrvCwYFTfXmGo7PDrnrRHfcjjC2YLOpaOrHjmieTYH42j0
 fJgse3bToIKdi4edjiwhiZiHf3WDGt7aCr5lO8bCot86hLkFRID8EaOIK8/ap/yASWQeDhaVQeH
 jlXQcb5mFQxuSEQ3xi6Qs4pSYRAz0cjk5gPCsek1RjLDsrHjYG9AUzTHlIYQo2cNAObSic2RJmF
 M0FCnZanOzouJyuQZH6tLjLA2ektusqNVg1J8ut1EkGPnoqnOIW2e5Mxe5m6Un11HqqCydQG/a/
 EFhxzjS94xOkQQ0Ib5iEnbR66j/x3R5hIKihGD4R7X5StNUJ3RMlbt2r7EhhVm/HNhYLOqXbV7Y
 Qie7PcVp6Lii1uQr8OwXr4Q==
X-Google-Smtp-Source: AGHT+IE3T+L3jq4F5+EKHy7huALt/f8ws3vt+Kyn/FUwXdCafQdiTjVl0V343t+NNexsqzRe4hh2pg==
X-Received: by 2002:a05:6000:2dc2:b0:3a4:f50b:ca2 with SMTP id
 ffacd0b85a97d-3b5f187591bmr10133636f8f.8.1752499208963; 
 Mon, 14 Jul 2025 06:20:08 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4332b0csm91622245ad.149.2025.07.14.06.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 06:20:08 -0700 (PDT)
Date: Mon, 14 Jul 2025 21:19:24 -0400
To: Florian Schmaus <florian.schmaus@codasip.com>
Message-ID: <aHWsnL8bUYkTJt21@MiWiFi-CR6608-srv>
References: <dbaa90bc-9f35-48f6-9072-0ab2b23dd6b9@codasip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dbaa90bc-9f35-48f6-9072-0ab2b23dd6b9@codasip.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify22: Make 'dev' the last debugfs argument
 for musl compat
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

On Fri, Jul 11, 2025 at 06:55:58PM +0200, Florian Schmaus via ltp wrote:
> The debugfs(8) man page specifies that the device to operate on should
> be the last argument. So instead of
> 
> debugfs -w /dev/loop2 -R "sif internal_dir/bad_dir mode 0xff"
> 
> the correct command line invocation would be
> 
> debugfs -w -R "sif internal_dir/bad_dir mode 0xff" /dev/loop2
> 
> The former works on glibc-based systems, due to glibc's optind
> handling. However, it breaks on musl-based systems, where the
> fanotify22 test will hang because debugfs is awaiting user input.
> 
> Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify22.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c
> b/testcases/kernel/syscalls/fanotify/fanotify22.c
> index 20c7a6aca243..357e74dbc702 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify22.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
> @@ -61,7 +61,7 @@ static void trigger_fs_abort(void)
>   static void do_debugfs_request(const char *dev, char *request)
>  {
> -	const char *const cmd[] = {"debugfs", "-w", dev, "-R", request, NULL};
> +	const char *const cmd[] = {"debugfs", "-w", "-R", request, dev, NULL};
>   	SAFE_CMD(cmd, NULL, NULL);
>  }
> -- 
> 2.49.1
> 
Thanks for your patch.

CI give following error, i think diff header has format issue need
fixed. BTW you another patch seems has same issue.

error: git diff header lacks filename information when removing 1 leading pathname component (line 6)
hint: Use 'git am --show-current-patch=diff' to see the failed patch

CI link: 
https://github.com/linux-test-project/ltp/actions/runs/16225674227/job/45816963576
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
