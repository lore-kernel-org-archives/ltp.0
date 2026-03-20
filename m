Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F161093168
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 03:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773976450; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=SUJAwoenCJHiUeMnTgv1q9a9UZI1rm63iI7TWNu6nnc=;
 b=Q7U25PayS003WVEzzhgg4fIeMlxRtu/8frf9IKeJBjzBjzy0Qb1YlRB5UzGnNXmU+E0Rg
 d0HIHfFxzfkNn6AKQrnAP0P8bcfvOGh1qODq0f9+zA8UG/6CTtwYOLotDvCqxq3q77SoPS3
 HwzGOIMIBmLlqDVAND6+pCa5T/M7pNk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F80B3E30CF
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 04:14:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3193D3E1664
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 04:13:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D2A18140097B
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 04:13:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773976423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z7aOVyGgsDsscghp0D24GFMbyODmiYmjQhnjngxlSDE=;
 b=TlzmmC6+LA0/mbC1/caS9pFG/pBX6Gaz+wjvVWQhy04m1dfdhHsfdpoGk0spzG3Dfz5Xer
 6ijMzWZO5k+V+lo/9uYfGQAYl7FjrI5+nHbjl//solOWl9dVCiWU3XqEHHPc+80Yxjl5du
 k3VvET+pObRW3lDqQza12TYdC00T8JM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-BTFKk3u9NZC47MuWRfDg5Q-1; Thu, 19 Mar 2026 23:13:41 -0400
X-MC-Unique: BTFKk3u9NZC47MuWRfDg5Q-1
X-Mimecast-MFC-AGG-ID: BTFKk3u9NZC47MuWRfDg5Q_1773976421
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b05d170cadso2971155ad.0
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 20:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773976420; x=1774581220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7aOVyGgsDsscghp0D24GFMbyODmiYmjQhnjngxlSDE=;
 b=sHOgqcXYrheaOoFDNVE8N9oHzvkGBefCUlz1nAwyZT6SSn0B4mYOJ/lcy8yaesvkTu
 WqqGtI3Z/BNnRk8drKpX73g6AnhMOfwePvc/gJOnCk7vVe3eU/+OLzkGHwKLe75nTPaB
 L7YLZyYwZNPUy5mEB6rN9Q6Ve7OKIBcX7rX5PU25EjOdqy/0oxIWOEA1xse8CWCgWPgV
 XSTDhxzvIKZPU9UAf7oG586P71Ilif3uZ+V7qITCrKf3IEiXU4puB6OUXOKHVJ8lxhaX
 sPhdOx495C8HpSjXoH77KrEkSySSR8JIBfOlQfeCxT2omLSPSc9lx2mSAlyR0VAxTsNT
 0LZw==
X-Gm-Message-State: AOJu0Yxf4OuAAcQBfDvJORG8B5JqUaS4XlJEq5klJSxQVfKW7BB8GzDh
 VkLo7jrIonHUr3GAhYJdMQMChYWAmqc/2nHsfOWZz62qIhUQ6rIKu3MlBFeJS5C/grwu32IyYTH
 3nO53h8AdZkKZJiCmgN27EN0YC5FLdNIGsuBoi4RJ0yPAlYq7Cgs3
X-Gm-Gg: ATEYQzySenr3L4+KXCydHobeySQ05+67UflnKeym1kZOffFfBhk86KFOyAgDsNNvjs2
 Z9jl97i0fcO9dWNzOHoNOlt2lU07kjtybvA4gxnrZ3bwTI65+pvhvJ7DoISbBPp+sXqIj1W/Ck0
 ena5ABebIX5abCUsbiggOubh7kCoHbTbT2YHZC42hKS1n79Ql7BBWNC5xnCqWyJkv5oBAib65XC
 L3m4vBvIeovGwrv4tD186ndamFu5lSl5AY8V/FntmznapBFLXZftthykm7wex1CxaxH8+FwbruT
 s7uPmlBVcZOouq1XsA9gVU/kYLr1/kEvdfK6L/21CRCWOXko8AcoRCYbyoaUMf4VNCwgkkzcZgl
 DdLAIXO1JCQ44JKdkig==
X-Received: by 2002:a17:902:d4cc:b0:2ae:ab2b:bd75 with SMTP id
 d9443c01a7336-2b0826d8db3mr12933385ad.3.1773976420613; 
 Thu, 19 Mar 2026 20:13:40 -0700 (PDT)
X-Received: by 2002:a17:902:d4cc:b0:2ae:ab2b:bd75 with SMTP id
 d9443c01a7336-2b0826d8db3mr12933115ad.3.1773976420136; 
 Thu, 19 Mar 2026 20:13:40 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0836a3066sm6242315ad.75.2026.03.19.20.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 20:13:39 -0700 (PDT)
Date: Fri, 20 Mar 2026 11:13:36 +0800
To: Chris Wailes <chriswailes@google.com>
Message-ID: <aby7YE-yhJz1BTzi@redhat.com>
References: <20260319185455.3683566-1-chriswailes@google.com>
MIME-Version: 1.0
In-Reply-To: <20260319185455.3683566-1-chriswailes@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D98YUDnwCmJA-VaJE_Ld7--ThjyRl7tY7vOKWypNrdA_1773976421
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Update clone3 wrapper signature
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Mar 19, 2026 at 11:54:55AM -0700, Chris Wailes via ltp wrote:
> This CL adds the `ltp_clone3_raw` wrapper for direct testing of the
> syscall, conditionally defines `clone_args_minimal`, and adds a
> `ltp_clone3` wrapper for libc implementations that provide `clone3`.

When you signed off patch better to use 'git commit -sm "xxx"'
otherwise patch has no signature:

  Signed-off-by: Chris Wailes <chriswailes@google.com>

Also, the next patch version better to have "v2" keywords:

  git format-patch --subject-prefix="PATCH v2" -1 

add notes like "v2: blablabla..." via:

  git notes add 

> ---
>  include/lapi/sched.h                        | 27 +++++++++++++++------
>  testcases/kernel/syscalls/clone3/clone301.c |  2 +-
>  testcases/kernel/syscalls/clone3/clone302.c |  2 +-
>  3 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/include/lapi/sched.h b/include/lapi/sched.h
> index 36f1ecad9..fc367f772 100644
> --- a/include/lapi/sched.h
> +++ b/include/lapi/sched.h
> @@ -49,8 +49,7 @@ static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
>  # define SCHED_ATTR_SIZE_VER0 48	/* sizeof first published struct */
>  #endif
>  
> -#ifndef HAVE_CLONE3
> -struct clone_args {
> +struct clone_args_minimal {
>  	uint64_t __attribute__((aligned(8))) flags;
>  	uint64_t __attribute__((aligned(8))) pidfd;
>  	uint64_t __attribute__((aligned(8))) child_tid;
> @@ -59,12 +58,10 @@ struct clone_args {
>  	uint64_t __attribute__((aligned(8))) stack;
>  	uint64_t __attribute__((aligned(8))) stack_size;
>  	uint64_t __attribute__((aligned(8))) tls;
> -	uint64_t __attribute__((aligned(8))) set_tid;
> -	uint64_t __attribute__((aligned(8))) set_tid_size;
> -	uint64_t __attribute__((aligned(8))) cgroup;
>  };
>  
> -struct clone_args_minimal {
> +#ifndef HAVE_CLONE_ARGS

In LTP, these HAVE_* macros are typically generated by the configure
script (autoconf). The configure script checks for the existence of
types, functions, and headers in the system, and defines corresponding
macros in config.h.

But here you use a non_exist HAVE_CLONE_ARGS, I think we should to
use HAVE_CLONE3 or add struct clone_args check there(then we can
use HAVE_STRUCT_CLONE_ARGS).

See: ltp/configure.ac

> +struct clone_args {
>  	uint64_t __attribute__((aligned(8))) flags;
>  	uint64_t __attribute__((aligned(8))) pidfd;
>  	uint64_t __attribute__((aligned(8))) child_tid;
> @@ -73,12 +70,28 @@ struct clone_args_minimal {
>  	uint64_t __attribute__((aligned(8))) stack;
>  	uint64_t __attribute__((aligned(8))) stack_size;
>  	uint64_t __attribute__((aligned(8))) tls;
> +	uint64_t __attribute__((aligned(8))) set_tid;
> +	uint64_t __attribute__((aligned(8))) set_tid_size;
> +	uint64_t __attribute__((aligned(8))) cgroup;
>  };
> +#endif
>  
> -static inline int clone3(struct clone_args *args, size_t size)
> +static inline int ltp_clone3_raw(struct clone_args *args, size_t size)
>  {
>  	return tst_syscall(__NR_clone3, args, size);
>  }
> +
> +#ifdef HAVE_CLONE3_WRAPPER

Here as well.

You can check with:

  grep -r "HAVE_CLONE3_WRAPPER" configure.ac m4/ include/config.h.in

before using unsure macros.

> +static inline int ltp_clone3(struct clone_args *cl_args, size_t size,
> +               int (*fn)(void *), void *arg) {
> +	return clone3(cl_args, size, fn, arg);
> +}
> +#else
> +static inline int ltp_clone3(struct clone_args *cl_args, size_t size,
> +                             int (*fn)(void *), void *arg)
> +{
> +	return -1;
> +}
>  #endif
>  
>  static inline void clone3_supported_by_kernel(void)
> diff --git a/testcases/kernel/syscalls/clone3/clone301.c b/testcases/kernel/syscalls/clone3/clone301.c
> index deed30b9f..58fc1702e 100644
> --- a/testcases/kernel/syscalls/clone3/clone301.c
> +++ b/testcases/kernel/syscalls/clone3/clone301.c
> @@ -123,7 +123,7 @@ static void run(unsigned int n)
>  	parent_received_signal = 0;
>  	SAFE_SIGACTION(tc->exit_signal, &psig_action, NULL);
>  
> -	TEST(pid = clone3(args, sizeof(*args)));
> +	TEST(pid = ltp_clone3_raw(args, sizeof(*args)));
>  	if (pid < 0) {
>  		tst_res(TFAIL | TTERRNO, "clone3() failed (%d)", n);
>  		return;
> diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel/syscalls/clone3/clone302.c
> index 9e98f1954..883112183 100644
> --- a/testcases/kernel/syscalls/clone3/clone302.c
> +++ b/testcases/kernel/syscalls/clone3/clone302.c

We need to modify it in clone304.c as well.

The rest part looks good.

> @@ -83,7 +83,7 @@ static void run(unsigned int n)
>  		args->tls = tc->tls;
>  	}
>  
> -	TEST(clone3(args, tc->size));
> +	TEST(ltp_clone3_raw(args, tc->size));
>  
>  	if (!TST_RET)
>  		exit(EXIT_SUCCESS);
> -- 
> 2.53.0.959.g497ff81fa9-goog
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
