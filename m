Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB4FCAC59A
	for <ltp@archiver.kernel.org>; Thu, 18 Sep 2025 15:30:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10E183CDD30
	for <ltp@archiver.kernel.org>; Thu, 18 Sep 2025 17:30:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64C723CDC82
 for <ltp@lists.linux.it>; Thu, 18 Sep 2025 17:30:38 +0200 (CEST)
Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D7ECA1A00806
 for <ltp@lists.linux.it>; Thu, 18 Sep 2025 17:30:37 +0200 (CEST)
Received: from r6.localdomain (82-217-174-174.cable.dynamic.v4.ziggo.nl
 [82.217.174.174])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by gnu.wildebeest.org (Postfix) with ESMTPSA id B711C3141377;
 Thu, 18 Sep 2025 17:30:36 +0200 (CEST)
Received: by r6.localdomain (Postfix, from userid 1000)
 id 516DF34068E; Thu, 18 Sep 2025 17:30:36 +0200 (CEST)
Message-ID: <959ee7399987c087f0d11dd0e2d9e2b1499273ac.camel@klomp.org>
From: Mark Wielaard <mark@klomp.org>
To: ltp@lists.linux.it
Date: Thu, 18 Sep 2025 17:30:36 +0200
In-Reply-To: <20250918152640.1146279-1-mark@klomp.org>
References: <20250918152640.1146279-1-mark@klomp.org>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap04: Make sure the scanf address format is at
 least 8 hex chars
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
Cc: Martin Cermak <mcermak@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Sorry, I cannot type...

On Thu, 2025-09-18 at 17:26 +0200, Mark Wielaard wrote:
> The addresses in /proc/self/maps are at least 8 hex chars. Zeros are
> added to the front of the address when shorted (both on 32bit and
                                               ^ should be shorter.
> 64bit systems.
               ^ missing closing bracket ).
> 
> Under valgrind the mmaps used in kernel/syscalls/mmap/mmap04.c come
> out very low in the address space and might be shorter than 8 hex
> chars. This causes the scanf to fail:
> mmap04.c:62: TBROK: Expected 1 conversions got 0 FILE '/proc/self/maps'
> 
> Fix this by using "%08" PRIxPTR when creating the fmt used.
> 
> Signed-off-by: Mark Wielaard <mark@klomp.org>
> ---
>  testcases/kernel/syscalls/mmap/mmap04.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/mmap/mmap04.c b/testcases/kernel/syscalls/mmap/mmap04.c
> index 4a050b7b50da..5b28180df29b 100644
> --- a/testcases/kernel/syscalls/mmap/mmap04.c
> +++ b/testcases/kernel/syscalls/mmap/mmap04.c
> @@ -58,7 +58,8 @@ static void run(unsigned int i)
>  
>  	addr2 = SAFE_MMAP(addr1 + pagesize, pagesize, tc->prot, tc->flags | MAP_FIXED, -1, 0);
>  
> -	sprintf(fmt, "%" PRIxPTR "-%%*x %%s", (uintptr_t)addr2);
> +	/* A /proc/self/maps address is at least 8 hex (left zero padded) */
> +	sprintf(fmt, "%08" PRIxPTR "-%%*x %%s", (uintptr_t)addr2);
>  	SAFE_FILE_LINES_SCANF("/proc/self/maps", fmt, perms);
>  
>  	if (!strcmp(perms, tc->exp_perms)) {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
