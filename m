Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133B0C433F5
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 09:12:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADA193C97A3
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 10:12:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 063B03C72A7
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 10:11:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DC2811000540
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 10:11:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D8C78215FF;
 Thu, 24 Mar 2022 09:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648113117;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X6pKG5+J7DXEVBJCylYI4vs9dVX3Adpzz/H4WjZpgxM=;
 b=Jg8j1DVhIfRv08auVcJ9C/bpuPHQPQdBEnGOrTTNwrchBOkSYO66+qzonct1uQvRlb/CbF
 KgFQPkh4E0hvCO1ZUoiONq5LnYk/g0c/3CYtXXBA11np8Ubvo2DOn+S8JUiYcDGoB+Ht/x
 DqRFpUyYA16qY9VhrINhNygvTe66/mA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648113117;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X6pKG5+J7DXEVBJCylYI4vs9dVX3Adpzz/H4WjZpgxM=;
 b=eF/HgDt67kjeYlZIh3I4v4m/gkeFsz66aYL0IIv1E4O89Qm+FH8+ctTF7WbKLlcPIJKNGU
 P3wPg/1tpzbzN+BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B32CC13AA8;
 Thu, 24 Mar 2022 09:11:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vUUaKt01PGKoLQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 24 Mar 2022 09:11:57 +0000
Date: Thu, 24 Mar 2022 10:11:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>
Message-ID: <Yjw13F9Tc2m8Hz6k@pevik>
References: <Yjt21XFn+8n78gZ7@pevik>
 <1648136116-22026-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1648136116-22026-1-git-send-email-daisl.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/umount2: Convert to new API and use
 SAFE_ACCESS
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

Hi Dai,

We're nearly there, IMHO 2 minor changes are required.

nit: you can help reviewers to list changelog from previous version (for your
next patches), see:

https://patchwork.ozlabs.org/project/ltp/patch/20220324022455.245300-1-zhaogongyi@huawei.com/
https://patchwork.ozlabs.org/project/ltp/cover/20211103120233.20728-1-chrubis@suse.cz/

> 1. use TST_EXP_FAIL and TST_EXP_PASS macro
> 2. use SAFE macro
> 3. simplify verify operations
> 4. merge umount2_03 to umount2_02

very nit: more important that "use SAFE macro" (that's one of the main reasons
why we use new API) is to mention the reason why to merge tests.

...
> +/*\
> + * [Description]
> + *
>   *  Test for feature MNT_EXPIRE of umount2().
This must be:
  * Test for feature MNT_EXPIRE of umount2().
extra space after '* ' leads text to be formatted as <pre> or <code>.

> - *  "Mark the mount point as expired.If a mount point is not currently
> - *   in use, then an initial call to umount2() with this flag fails with
> - *   the error EAGAIN, but marks the mount point as expired. The mount
> - *   point remains expired as long as it isn't accessed by any process.
> - *   A second umount2() call specifying MNT_EXPIRE unmounts an expired
> - *   mount point. This flag cannot be specified with either MNT_FORCE or
> - *   MNT_DETACH. (fails with the error EINVAL)"
> + *
> + * - EINVAL when flag is specified with either MNT_FORCE or MNT_DETACH
> + * - EAGAIN when initial call to umount2(2) with MNT_EXPIRE
> + * - EAGAIN when umount2(2) with MNT_EXPIRE after access(2)
> + * - succeed when second call to umount2(2) with MNT_EXPIRE
> + *
> + *  Test for feature UMOUNT_NOFOLLOW of umount2().
And here as well:
* Test for feature UMOUNT_NOFOLLOW of umount2().

run make in metadata/ and then check docparse/metadata.html
(or docparse/metadata.pdf).

(1st thing to change)

> + *
> + * - EINVAL when target is a symbolic link
> + * - succeed when target is a mount point
>   */

> -#include <errno.h>
>  #include <sys/mount.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
>  #include "lapi/mount.h"
> -
> +#include "tst_test.h"
>  #include "umount2.h"
umount2.h is now used only in this test. Please put the content into the test
and delete the file (2nd change to do).

...
> +} tcases[] = {
> +	{MNTPOINT, MNT_EXPIRE | MNT_FORCE, EINVAL, 0,
> +		"umount2() with MNT_EXPIRE | MNT_FORCE expected EINVAL"},
nit: I was thinking about using macro to not repeat to flag and exp_errno,
(something similar to POLICY_DESC_TEXT(x, y) in
testcases/kernel/syscalls/mbind/mbind01.c), but as description varies a lot it's
probably better to keep it as is (unless you rephrase it).

...

> +	{SYMLINK, UMOUNT_NOFOLLOW, EINVAL, 0,
> +		"umount2('symlink', UMOUNT_NOFOLLOW) expected EINVAL"},
...
> +	{MNTPOINT, UMOUNT_NOFOLLOW, 0, 0,
> +		"umount2('mntpoint', UMOUNT_NOFOLLOW) expected success"},
> +};

...
> +	if (tc->do_access)
> +		SAFE_ACCESS(MNTPOINT, F_OK);

> -	if (TEST_ERRNO != test_cases[i].exp_errno) {
> -		tst_resm(TFAIL | TTERRNO, "%s failed unexpectedly",
> -			 test_cases[i].desc);
> -		return;
> +	if (tc->exp_errno) {
> +		TST_EXP_FAIL(umount2_retry(tc->mntpoint, tc->flag), tc->exp_errno,
> +			"umount2_retry(%s, %d)", tc->mntpoint, tc->flag);
> +		if (!TST_PASS)
> +			mount_flag = 0;
> +	} else {
> +		TST_EXP_PASS(umount2_retry(tc->mntpoint, tc->flag),
> +			"umount2_retry(%s, %d)", tc->mntpoint, tc->flag);
> +		if (TST_PASS)
> +			mount_flag = 0;
>  	}

nit: this would be more compact:

	if (tc->exp_errno)
		TST_EXP_FAIL(umount2_retry(tc->mntpoint, tc->flag), tc->exp_errno,
			"umount2_retry(%s, %d)", tc->mntpoint, tc->flag);
	else
		TST_EXP_PASS(umount2_retry(tc->mntpoint, tc->flag),
			"umount2_retry(%s, %d)", tc->mntpoint, tc->flag);

	if (!!tc->exp_errno ^ !!TST_PASS)
		mount_flag = 0;

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
