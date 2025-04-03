Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA02C3600C
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 11:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743680054; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=W6T4RptoBTfffjey83fqifPGbbiE7tqNXmZcJyBy18U=;
 b=TtgsJXN3/2oUe5fKv1VerU0NepHARf9eqGxovnpXpGKBEHLwZZiT3q4QECt3tZwpqU8o9
 RBHYYWNM9FVXt/oIuBZ+udYoqDlmjwsQOVm9Q7NjWMf2nVPWOm341omW0g9K/+t9vYCe5d2
 /xA/EqY4FKvjrLkLXnjkap0m5ItmdFU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1B493CB285
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 13:34:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1A663CB27E
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 13:33:52 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E93451A00437
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 13:33:51 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4394a823036so7309265e9.0
 for <ltp@lists.linux.it>; Thu, 03 Apr 2025 04:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743680031; x=1744284831; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u7UPeqxXjbB8UELfuj50555+LCCn+ny0sPGm7R8wVAM=;
 b=G2997ReQ6JMsO9r2Dk4IT97ymipEz7qROtuBXGD5sD7j0KJ54Z79cgbRMvbqNhE/Oq
 dzuspvrd9MZytYttiyF3SS0xu2allB+wQ6bL67Zv1qhLmDldZlTjbxhXsJjvb8p5NLc8
 mWAjYZZ7260S8WfxDQUw9+/mGGguuE6kor/DK+iA3on+gaHwFytwkVHsyjipO+VsG2WB
 gt/+R7VqNO+6Mn7nNmg6XWuRS/OHkB13ww989WrUL1zBUUsu/fchFrOYo8jSjWPgJQQc
 3LzKc1eLpJM1YgCuzFy33RskizxV8YY6yvNlTtFdEtKQgOpAm/hjzWOu8y/85fxXK5VH
 ZjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743680031; x=1744284831;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u7UPeqxXjbB8UELfuj50555+LCCn+ny0sPGm7R8wVAM=;
 b=JZRzdVzgjBtVtiu8VYl4QJv1OddbNmluTfjfKXUyCCi3KvmPyuZjywwv5gptA5FFRl
 cENu5u0jRKvRgcb4YoXon3bv+Exo18sGRV+glIO6kdrc6Itu26J8DVTE7P8+PPxbdZ5F
 zh0hsUU+CCRrQRsiauwORci9/LzkNpMh1hEGgRTnMm2xjb+zPIyQ8FqGtOAddFdiYycU
 /tCM2C6cyjXo/bJ/WjrCAoua5m9DDpXR6NJ/azBmRsT+M4/AKBFDkwa1i4NoKxEyZlxT
 LQ3q+nBWnOSTx+rKa8EWsLYXXkl0wOGB+M1yDMntMDT1L+MGJnfA3Q+UCnZDsifcYV3q
 svqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLvqI27Xel/tbiIM5I4nRjWHSp8IE8/C/RKlME2olwmEPWi+Ys1qzSNZi8eNiI7B0xiMg=@lists.linux.it
X-Gm-Message-State: AOJu0YwLhYvvjbEKaEkSMu1k8Rsb+d5UHzJITuBRYRrcnOtA/2zMzD34
 +FsE0JoebJAG2YFOBdTaL2tJtIFXoIeRRYmyRFADyX4tU7BB8RrRdC/9nQ0T8bI=
X-Gm-Gg: ASbGncvNTREzuJQtp0ZX1VtlPrv8SrqY3yncyMwnEsMChO6anfWPsWTix3BKbPaAEr+
 TdtHlMx2WD80hcd2uMNpYiRym+KWQl+Z/8hxytcGSOzkKVEb3E+zp0FScK1JZl1VBVezeV/XnaU
 EPGaCk6ulm8iNaGxo8Fy7hZ0NZ3iaguOdyotQVcFDLNub5QnFx33sBCn3K+g9I+T1ZNl3GXpH1R
 vome85UU2SZImSR8+njRUxElh2Uo4VYoerZMJ+E2IdKzXrXwrBST1st5JibG83QrglPXUEinQq0
 GHryqAfMLtX/kdGTJy0VyuyVucNKK5orNUtbTHiFu1oPoFJ3Q/t0UumOB3tzPS31wq5FO5j9fNs
 xIsjx7s4IlALabCI27LJgX1RN3Tk=
X-Google-Smtp-Source: AGHT+IE5ppp1Rk7ekeVIafsVcIp6DTqOW5KQph24Kq0M0IbojkKcpf+qBn9PxRqV86sHFfjz3LJUZA==
X-Received: by 2002:a5d:5f91:0:b0:39c:d05:3779 with SMTP id
 ffacd0b85a97d-39c29806115mr4915728f8f.49.1743680031233; 
 Thu, 03 Apr 2025 04:33:51 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec342827fsm16274815e9.6.2025.04.03.04.33.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 04:33:50 -0700 (PDT)
Message-ID: <0045063b-ae7f-4dd6-9b8e-9d760713ea3b@suse.com>
Date: Thu, 3 Apr 2025 13:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250403101912.459507-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250403101912.459507-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 0/2] Merge runtest files
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

Hi Petr,

this is a _huge_ topic that might affect LTP automation configurations.

It's a job that IMHO should be done, but it makes more sense to wait for 
testing suites definition in metadata, as well as a total refactoring of 
old LTP tests.

The reason of my statements is not only that runtest files should be 
removed one day, but also that known issues inside products which are 
tested, often require years of analysis of the runtest files and their 
executions. By shuffling tests around will create issues where there's 
no need due to a small logical improvement.

I think we should start to push more on testing suites definition inside 
metadata and to refactor tests as fast as possible. So we will be free 
from runtest files, leading to a more coherent structure of the tests 
organization.

- Andrea

On 4/3/25 12:19, Petr Vorel wrote:
> Hi,
>
> besides runtest/ipc, there are other small runtest files.  I know we are
> slowly working towards removing runtest files, but until it happen we
> might want to optimize (=> merge) small runtest files into others.
>
> With this change we have in the runtest files (ignoring comments):
>
> $ for i in runtest/*; do echo "$(grep -v '#' $i | wc -l): $i"; done | sort -rn
>
>
> $ wc -l runtest/* | sort -nr # not taking into account the comments
> 1823: runtest/syscalls
> 392: runtest/controllers
> 140: runtest/scsi_debug.part1
> 140: runtest/ltp-aiodio.part1
> 137: runtest/net.nfs
> ...
> 9: runtest/watchqueue
> 9: runtest/tracing
> 9: runtest/ima
> 7: runtest/dma_thread_diotest
> 7: runtest/cpuhotplug
> 6: runtest/net.ipv6_lib
> 6: runtest/input
> 6: runtest/capability
> 5: runtest/power_management_tests_exclusive
> 5: runtest/power_management_tests
> 5: runtest/kvm
> 4: runtest/net.multicast
> 3: runtest/uevent
> 3: runtest/hyperthreading
> 3: runtest/crashme
> 3: runtest/can
> 2: runtest/nptl
> 1: runtest/s390x_tests
> 1: runtest/irq
> 1: runtest/fcntl-locktests
> 0: runtest/staging
>
> I would suggest to:
>
> * move runtest/can to runtest/kernel_misc (better
> name would be kernel_drivers, but I don't want to do renames, even
> merging runtest files will disturb folks testing with LTP.
>
> * move runtest/fcntl-locktests to runtest/net.nfs.
>
> * runtest/nptl is NPTL test for pthread_cond_timedwait(), can this be
>    moved to runtest/sched? (there are other pthread_* tests). Not sure if
>    tests are relevant now.
>
> * runtest/irq Obviously we would need more IRQ tests (IMHO none even in
>    kselftest)
>
> I wonder if runtest/dma_thread_diotest. runtest/crashme,
> runtest/power_management_tests and runtest/power_management_tests_exclusive
> are still relevant or that much outdated, that it should be removed.
>
> I think vmcp_m.sh (the only one in runtest/s390x_tests) should be removed.
>
> Other should probably be kept separate.
>
> runtest/staging is expected to be often 0.
>
> Kind regards,
> Petr
>
> Petr Vorel (2):
>    runtest/ipc: Enable named pipes on non-blocking IO
>    runtest: Move ipc into syscalls
>
>   runtest/ipc      | 30 ------------------------------
>   runtest/syscalls |  9 +++++++++
>   2 files changed, 9 insertions(+), 30 deletions(-)
>   delete mode 100644 runtest/ipc
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
