Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C6DCD98CF
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 09:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781602646; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=kLLEMpsfHMsFD5x4gTFOiLaWaVg/pm0mzTlbWHmawoE=;
 b=D3z3AoDZLWAizV8JDLTYI8F9QGYFpx+5BCnY01OiH7RyBJMBsMDF/h2NUWrOh8fLNDuUc
 N0GI0bf3ZQAb2iiUnAUH55zmEPZ+xNky1Ygk7nw5MPT6wHBGz8sXlIiCp50kMXgF2hsaGn6
 DMIaF81NA7sAs1c9XwGON+4Iu7d2gns=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F18B43E5977
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 11:37:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF3673E2026
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:37:06 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 038661A00A55
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:37:05 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490b211ee6aso32393605e9.3
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 02:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781602625; x=1782207425; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fvvASeWJ7fraR64WQFes3xN3SybjsZdeM5z+4Gz+l70=;
 b=Y7w6V1Uio5ptTBN88qylwQTGvZXRNd/cqb6wAhse5AwVA7GhJvz0oPDqNu6B7GIxLI
 6lwaGvHtSG19WWhpWnQ0xS08Gu4Di83KgN0rybcmqhDxpiwhWKNuGOV27GSs7RqpWYNd
 JJJn0J12B39cssVHMW3EnGugziMRTkoUkesq3OvYZSaOFkWA5OkAoOAdWh4iCB9B5MbV
 G7SnKe6pmL9zIuaQib1Q3SkUvKzXZC499OzS52vMWBAtTJKCp4lmmgfHndXcF1bQn0Rh
 V269XvazEZA/+ZF6hYgYnwGt7E/8fJkMHsXoSOJ2CgnYaSII+Dm+4PQMtYUfL34d5z4u
 9b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781602625; x=1782207425;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvvASeWJ7fraR64WQFes3xN3SybjsZdeM5z+4Gz+l70=;
 b=ZQbrqKff0RLfqGX7jHGaWWuycIme5cufKs7c03jh1pSQUCyw0LQMnk8n1ice1ZggYN
 6PKKOkSdt5B+lZFgO5ivxcn6soHbRj61vJa/NnA9yvP39000Gb6NWmjAkFoBYd1h/CWM
 mOI02ZsHCU93XyNsb4LPVcskDqVw/ew2voIoJS4SQO5NoJ4HBv4IVvZ5NZuk1IGIcAnw
 2OBDCJJ7ydEBN0h+Y4FJ24I0T5WLCBmgCEOYXn0Kem4OGoiaY810TyAIZf+zfctaYS++
 FEDTBwYmlBdSwwQXijZGu+SzVt6ANdBY4RAYYjfgF35rR1LvFKwOYXUKhRf8dC98VIyN
 J3yQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lqQ8bYlEffm2j0FyNeXPTchMr/fSBCUuIAolxqZP4z14l6aiF3nHXf3Y1ca6/EhOU3NI=@lists.linux.it
X-Gm-Message-State: AOJu0YxAxxVjdnTGepYE7U35oF1iZCjEHg5O9J27sEZOe3USHhGwkDjH
 TfWxbcSt47dx9sHENRf00Eym57pNUR8TXJ+YGazVbTXoDibHZZLjO7HbyuvnRBKA2dk9vSCUUyW
 TB/ydk1Z7rA==
X-Gm-Gg: Acq92OGsjABg6Qe0cbC1tMjH7IHdWg55dMd3BhaL7gbf4UAT3NpanFbLUqEW9vPafcQ
 NbQPU1IEuJjAR6Z40wboAFHjkmr/2+0LVei3dMRjiprBybt+1jtlMsSh2YzGiv53KwbXWdt6ofu
 bvaMSvLZ8Z0iZeIVuNKocd9KnftSHCBZQA25pZ4iXTsYM2Q98/BthMS36yIwCk1DVs+WeMxv5bS
 GgpF30fqeTe1znIPW96sxuCFJDt/8EEwTO7JbyovM937kaH54yY8BfuLHOZ9MD5N5lAKQggqJCN
 RKiNGYq+5Oww5L6+C1XLE/yo/6mH32VpxBBZs6Sl3f3yD9EX9TqrfRL2LcUmurI7c1nOEj543Yd
 l5xq6n2/HaJhPw6m5q9dY26Gu8cye/1Pnghk13iwDSCzVfMpJxWZ1Ci8HU1mJcvgDVnyvlGgjQz
 slq44ScDtVdwFsTy9RS4qOh7ldwcHZRBOvf9i5AqSUlA5y5E9phmT585QaZIDRUst5dvpgVkOis
 uK5zAoSuFvwY7c8YXCPfZLLJnndiD7AU3OY5DfDE7BcLg==
X-Received: by 2002:a05:600c:e557:20b0:490:c024:2eba with SMTP id
 5b1f17b1804b1-4922ff95f5dmr29520275e9.22.1781602625016; 
 Tue, 16 Jun 2026 02:37:05 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a9a399sm41682285e9.14.2026.06.16.02.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:37:04 -0700 (PDT)
Message-ID: <6a311940.16c38fd9.3614ee.7013@mx.google.com>
To: "Jan Kara" <jack@suse.cz>
In-Reply-To: <un4jlftokjfzo7girjmf6yrpheg5nyye6wywtgmr3oxfnc3hob@uljmnxlllygu>
Date: Tue, 16 Jun 2026 09:37:03 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] fanotify21: Add test variants for
 FAN_REPORT_TID
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
Cc: amir73il@gmail.com, jack@suse.cz, ltp@lists.linux.it,
 AnonymeMeow <anonymemeow@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

> Hello!
> 
> On Tue 16-06-26 08:24:33, Andrea Cervesato wrote:
> > the patch-set is failing to compile on our CI. Please send a new
> > version fixing it:
> > 
> > https://github.com/linux-test-project/ltp/actions/runs/27572447779/job/81512172691
> 
> Hum, I had a look and the failure actually is:
> 
> parse_opts.c: In function 'usc_test_looping':
> parse_opts.c:521:3: warning: call to function 'usc_recressive_func' without a real prototype [-Wunprototyped-calls]
>    usc_recressive_func(0, STD_LP_recfun, *STD_bigstack);
>    ^
> parse_opts.c:107:13: note: 'usc_recressive_func' was declared here
>  static void usc_recressive_func();
>              ^
> CC libs/numa/tse_numa.o
> AR libltpnuma.a
> RANLIB libltpnuma.a
> CC lib/random_range.o
> CC lib/parse_opts.o
> CC lib/safe_file_ops.o
> In file included from ../../include/tse_sigwait.h:11:0,
>                  from tse_sigwait.c:8:
> ../../include/tst_timer.h: In function 'tst_ts_from_timespec':
> ../../include/tst_timer.h:626:3: warning: missing initializer for field 'tv_nsec' of 'struct timespec' [-Wmissing-field-initializers]
>    .ts.libc_ts.tv_nsec = ts.tv_nsec,
>    ^
> In file included from /usr/include/sys/select.h:43:0,
>                  from /usr/include/sys/types.h:219,
>                  from /usr/include/stdlib.h:314,
>                  from tse_sigwait.c:6:
> /usr/include/time.h:123:23: note: 'tv_nsec' declared here
>      __syscall_slong_t tv_nsec; /* Nanoseconds.  */
>                        ^
> CC lib/safe_pthread.o
> 
> So I'm a bit at loss what change in fanotify tests could have caused a
> failure in compilation of the generic LTP library code? Any idea?
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Those are warnings caused by old GCC. It's possible to fix them
by changing the explicit struct initialization with a 2 step init
such as:

struct mystruct s;
s.item0 = i1;
s.item1 = i2;

The real issue is that fanotify21 needs to link pthread:

-fanotify11: CFLAGS+=-pthread
+fanotify11 fanotify21: CFLAGS+=-pthread

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
