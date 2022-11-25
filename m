Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38B7C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:20:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A00833CC8A2
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 12:20:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F18463C00D1
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 12:20:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 55E561401149
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 12:20:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AAB1E1FD63;
 Fri, 25 Nov 2022 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669375236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W5cImaf+If0tRFv6bTd/I3JWSBRc7ghZvvumqWW4q2k=;
 b=ekn8fXJSmOZAumrN6A4ISFkFk7WPUGz0IoX6AT2dvoaljAIfdOscOfAOS9G4hHH+jYvIVB
 jSrIdiRgeaatIgt9ML4f60fdVDge/apwDP5YynR3SrBWD8hewjxT8/Is/3nJvCJNWfsVkR
 TsFOVk6WNiOGZXK4FehAofSVO9JT+uU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669375236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W5cImaf+If0tRFv6bTd/I3JWSBRc7ghZvvumqWW4q2k=;
 b=jrTbZYDZEC++pwuD2AkmRmdCq6lNI+vtLY5hey+EWPasY6zfgP41hUkLFpJSPQewiX3ozS
 tpB1c/23R+aeMoBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 835F31361C;
 Fri, 25 Nov 2022 11:20:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KUHhHgSlgGPWBwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 25 Nov 2022 11:20:36 +0000
Message-ID: <6ce3a102-f2ec-16be-927d-a32ab46eaf0c@suse.cz>
Date: Fri, 25 Nov 2022 12:20:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, ltp@lists.linux.it
References: <20221125105201.59048-1-david@redhat.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20221125105201.59048-1-david@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] security/dirtyc0w_shmem: Fix remaining cases
 where UFFD_FEATURE_MINOR_SHMEM is absent
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 25. 11. 22 11:52, David Hildenbrand wrote:
> When UFFD_FEATURE_MINOR_SHMEM is not defined, we still have to make the
> checkpoint happy, otherwise our parent process will run into a timeout.
> Further, we have to test if UFFD_FEATURE_MINOR_SHMEM is really returned by
> the UFFD_API ioctl: if the kernel knows about the feature but doesn't
> support it, it will be masked off.
> 
> Reported-by: Martin Doucha <mdoucha@suse.cz>
> Cc: Petr Vorel <pvorel@suse.cz>
> Cc: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   .../dirtyc0w_shmem/dirtyc0w_shmem_child.c        | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
> index cb2e9df0c..c117c6f39 100644
> --- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
> +++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
> @@ -24,12 +24,12 @@
>   #include <linux/userfaultfd.h>
>   #endif
>   
> -#ifdef UFFD_FEATURE_MINOR_SHMEM
> -
>   #define TST_NO_DEFAULT_MAIN
>   #include "tst_test.h"
>   #include "tst_safe_macros.h"
>   #include "tst_safe_pthread.h"
> +
> +#ifdef UFFD_FEATURE_MINOR_SHMEM
>   #include "lapi/syscalls.h"
>   
>   #define TMP_DIR "tmp_dirtyc0w_shmem"
> @@ -162,6 +162,10 @@ retry:
>   			"Could not create userfault file descriptor");
>   	}
>   
> +	if (!(uffdio_api.features & UFFD_FEATURE_MINOR_SHMEM))
> +		tst_brk(TCONF,
> +			"System does not have userfaultfd minor fault support for shmem");
> +
>   	uffdio_register.range.start = (unsigned long) map;
>   	uffdio_register.range.len = page_size;
>   	uffdio_register.mode = UFFDIO_REGISTER_MODE_MINOR;
> @@ -236,6 +240,10 @@ int main(void)
>   	return 0;
>   }
>   #else /* UFFD_FEATURE_MINOR_SHMEM */
> -#include "tst_test.h"
> -TST_TEST_TCONF("System does not have userfaultfd minor fault support for shmem");
> +int main(void)
> +{
> +	tst_reinit();
> +	TST_CHECKPOINT_WAKE(0);
> +	tst_brk(TCONF, "System does not have userfaultfd minor fault support for shmem");
> +}
>   #endif /* UFFD_FEATURE_MINOR_SHMEM */

This would work as a workaround but I'd recommend adding the necessary 
structures and constants to include/lapi/userfaultfd.h instead. Then you 
won't need this conditional compilation at all.

I also recommend looking at the fuzzy sync library we use for race 
conditions:
https://github.com/linux-test-project/ltp/wiki/C-Test-API#133-reproducing-race-conditions

The original dirtyc0w test was written before this library but using it 
generally makes race condition reproducers faster, simpler and more 
reliable.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
