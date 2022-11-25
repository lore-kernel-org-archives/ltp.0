Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B215CC4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:12:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5752B3CC895
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 12:12:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 183593CC87F
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 12:12:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7637D601412
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 12:12:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BFF171F74C;
 Fri, 25 Nov 2022 11:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669374757;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UqBVbXnqiqIh6UtGhZY5jCoh4El4F/wRRMuYue7aoZk=;
 b=ja3vLoaEdyjtxVl7u4OKqREI/4tdjGTdF0PXQ70S1Wz3sO7Ui/UpvX4L120qVB++nSK0TY
 xwVfwBLu0XN9oDtyI3wx8h4QTW6T0euIuXbftn6uPg37lYjHC4HvucrOoKkQOyyWvOQ4hO
 Vc5w5cdq3z80wkFmCaMSPI7w06UQ5KQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669374757;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UqBVbXnqiqIh6UtGhZY5jCoh4El4F/wRRMuYue7aoZk=;
 b=GOY6lalSG6N1fSFD9BhQalbrHdlFAkX+Oeu5ZgdSqD3JAN7oNVpmmkD83syBlz9bnsGmDo
 j17+Udy0WCCdDxAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FE8F1361C;
 Fri, 25 Nov 2022 11:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JN4JISWjgGN8AwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Nov 2022 11:12:37 +0000
Date: Fri, 25 Nov 2022 12:12:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: David Hildenbrand <david@redhat.com>
Message-ID: <Y4CjI7S/MHnQa7ex@pevik>
References: <20221125105201.59048-1-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221125105201.59048-1-david@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi David,

> When UFFD_FEATURE_MINOR_SHMEM is not defined, we still have to make the
> checkpoint happy, otherwise our parent process will run into a timeout.
> Further, we have to test if UFFD_FEATURE_MINOR_SHMEM is really returned by
> the UFFD_API ioctl: if the kernel knows about the feature but doesn't
> support it, it will be masked off.

> Reported-by: Martin Doucha <mdoucha@suse.cz>
> Cc: Petr Vorel <pvorel@suse.cz>
> Cc: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  .../dirtyc0w_shmem/dirtyc0w_shmem_child.c        | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

> diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
> index cb2e9df0c..c117c6f39 100644
> --- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
> +++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
> @@ -24,12 +24,12 @@
>  #include <linux/userfaultfd.h>
>  #endif

> -#ifdef UFFD_FEATURE_MINOR_SHMEM
Shouldn't be the check and TST_TEST_TCONF() actually be in dirtyc0w_shmem.c?
I overlooked that, but IMHO test does not make sense at all if
UFFD_FEATURE_MINOR_SHMEM not defined, right?

Also Martin noted that ("The parent process should not even fork() when
UFFD_FEATURE_MINOR_SHMEM is not defined in config.h.").

Therefore one fix would be to move the check to parent and second
(maybe better in separate commit) to add check for uffdio_api.features.

Kind regards,
Petr

> -
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
>  #include "tst_safe_macros.h"
>  #include "tst_safe_pthread.h"
> +
> +#ifdef UFFD_FEATURE_MINOR_SHMEM
>  #include "lapi/syscalls.h"

>  #define TMP_DIR "tmp_dirtyc0w_shmem"
> @@ -162,6 +162,10 @@ retry:
>  			"Could not create userfault file descriptor");
>  	}

> +	if (!(uffdio_api.features & UFFD_FEATURE_MINOR_SHMEM))
> +		tst_brk(TCONF,
> +			"System does not have userfaultfd minor fault support for shmem");
> +
>  	uffdio_register.range.start = (unsigned long) map;
>  	uffdio_register.range.len = page_size;
>  	uffdio_register.mode = UFFDIO_REGISTER_MODE_MINOR;
> @@ -236,6 +240,10 @@ int main(void)
>  	return 0;
>  }
>  #else /* UFFD_FEATURE_MINOR_SHMEM */
> -#include "tst_test.h"
> -TST_TEST_TCONF("System does not have userfaultfd minor fault support for shmem");
> +int main(void)
> +{
> +	tst_reinit();
> +	TST_CHECKPOINT_WAKE(0);
> +	tst_brk(TCONF, "System does not have userfaultfd minor fault support for shmem");
> +}
>  #endif /* UFFD_FEATURE_MINOR_SHMEM */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
