Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCFBC61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 08:33:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 097C33DFA35
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 10:33:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6E613DA1BE
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 10:33:05 +0200 (CEST)
Received: from mta0.migadu.com (out-170.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::aa])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 391311400C42
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 10:33:03 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=o+THxm7W19wwygg+er5ETcMO9ljrmfOdlh9FPfM+WFE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787905982; v=1; x=1788510782;
 b=l8W3s0MG/+46muVoQAnXTHxmF8NJBrlGs/POK7F+pMQL8OYCGiDxeXcwxE9RhWijJJ3W8E3j
 0lwzzb/unjF9hnHIYdOaOpOxmpu5lsCTMpmMJ+0c6VsMvyMAFOT1ivlk2WQ8LA45U6GzzWR0TCa
 R+covQgsVnaAXXaHJKLISF+s=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 79490f25d47dadd2;
 Fri, 28 Aug 2026 08:33:02 +0000
X-Mizu-Trace-ID: 79490f25d47dadd2
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 16:32:58 +0800
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <apFHunHIcZWSglnf@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 00/31] Add sysfs sanity tests
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Aug 27, 2026 at 01:21:26PM +0200, Cyril Hrubis wrote:
> This is a first bach of the sysfs sanity tests I've been working on
> recently.
> 
> The main goal of these tests is to make sure that these files contains
> expected data, e.g. files that are supposes to be boolean are 0 or 1,
> numeric files contain numbers, etc.
> 
> I've tried to make the code of the tests as clear as possible. Hence the
> first addition in this patchset is a library that implements common
> assertions for sysfs files to be done in a single line of a code.
> 
> Majority of these tests are just reading the files and checking that the
> content is sane. The exceptions are loop device, veth, tap tests that
> cerate virtual devices, which attributes can be changed freely.
> 
> v2:
> 
> Fixed all problems pointed out by Li and real problems by the LTP reviewer.
> 
> v3:
> 
> Fix for a CI compilation failure:
> 
>  - sys_net04 compilation on Leap 42.2
> 
> Fixes for issues found by OpenQA run by Peter:
> 
>  - sys_net04 use TST_RETRY_FUNC() for operstate
>  - sys_net02 use TST_RETRY_FUNC() for operstate
>  - sys_net01 make sure the we have a iface (directory) before run test
>  - sys_rtc01 use tst_is_virt() to multiply slack on VMs
>  - sys_cpu_topology02 use tst_is_virt() to relax package physical id checks
>  - sys_bdi01 max_bytes and min_bytes were added to 6.2
>  - sys_wakeup01 depend on CONFIG_PM_SLEEP=y
>  - sys_power01 In kernel lockdown disk state can be "disabled"
>  - sys_cpu_cache01 Report TCONF if no caches are exported
> 
> v4:
> 
>   - Added TST_SYSFS_TRY_OPENDIR() that handles ENOENT and produces
>     TCONF and hopefully finally fixed all possible missing directories
>     (e.g. hugepages could have been missing on ppc64le if lpar was
>     configured without support for them)
> 
>   - Fixed " vs `` in test doc spinx comments
> 
>   - Fixed copy&paste errors in tst_sysfs_assert.h
> 
>   - Fixed missing keywords in sys_cpu_vulnerabilities01 and sys_ata01
> 
>   - Fixed >= 0 vs != -1 in sys_net04

Patchset v4 looks good to me. I ran the tests and all passed on c9s, c10s,
and kernel v6.6 as well (x86_64 vm).

Feel free to add:

Reviewed-by: Li Wang <li.wang@linux.dev>
Tested-by: Li Wang <li.wang@linux.dev>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
