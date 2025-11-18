Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ED2CEE347
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 18:03:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BF623CF7C9
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 19:03:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61C293C01E6
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 19:02:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C24FD1000984
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 19:02:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C51B8216EA;
 Tue, 18 Nov 2025 18:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763488969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9AvQnDSlNy9/QXp4uE5siAenOyw61dmaaT44dzgIU9Y=;
 b=0E9hbxIXzm6j1Q5/RwetA7bM5iwW+AIuzAtwh8aqATztQYZTbnpLzGXqrND3yoYXWPmA4X
 amQHUDAzsFJqsSOhahRrPZz8+3udZueK8i89nhYp57L2rw8Q8JjX4odJI9A5TJFw+A1e6/
 PAcUXFe8Pj8eo2o82dgpn4h2j5G4Gv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763488969;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9AvQnDSlNy9/QXp4uE5siAenOyw61dmaaT44dzgIU9Y=;
 b=UzrE/HfbIMv1slA4M+fak1qTBi3ic5ltybqOpcZhocOjWpXehQXhVWEpdWNqLHDzKf9yxv
 ul9kq2Z+xaWAaOCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763488968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9AvQnDSlNy9/QXp4uE5siAenOyw61dmaaT44dzgIU9Y=;
 b=NuOKp1yy8aOv8PUvfuXTtBGkbBZIStJZ+bOKzywvKIX1GYIutnftBuQTayiezNws+Z5G8Y
 Y71m3LchAlELk4AFRvg7bU1klhbj4P6a2D6ZCnnj5QB87iSwDxalz3Gb/7RY5VAfR40rRu
 f8wB8NCY0z2Cq8cq+R1WLTVlz7HOn3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763488968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9AvQnDSlNy9/QXp4uE5siAenOyw61dmaaT44dzgIU9Y=;
 b=yW+0EqQJZ6BgPV5lKuG7rxQW60WTS4YayxGBnowIVTImjIp6KFEtXkaJaw7j9w71CHxGzr
 kBneW5x25MDnNyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1AB43EA61;
 Tue, 18 Nov 2025 18:02:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MkAkKsi0HGnUUAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 18 Nov 2025 18:02:48 +0000
Date: Tue, 18 Nov 2025 19:03:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wake Liu <wakel@google.com>
Message-ID: <aRy0-9KIPlRBvnNk@yuki.lan>
References: <20251117034023.415246-1-wakel@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251117034023.415246-1-wakel@google.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Ignore cve-2022-2590_64bit CVE for Kernel
 versions below 5.16+
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
Cc: Kodanda Rami Reddy V <quic_kreddyv@quicinc.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> CVE 2022-2590_64bit is applicable only for kernel versions 5.16 onwards.

Why? What happens if you run the test on an older kernel? This
information should be written here.

> Add kernel version check to skip/Ignore the test case.
> Test Module: vts_ltp_test_arm_64
> Test Case: cve.cve-2022-2590_64bit#cve.cve-2022-2590_64bit
> GBUG: 418679607
> 
> Change-Id: Ibbb18a168b727725faab2beb6841640e034fc468
> ---
>  testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
> index 2c7ad00f2..0651ae122 100644
> --- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
> +++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
> @@ -19,6 +19,7 @@
>  #include <stdbool.h>
>  #include <pwd.h>
>  
> +#include "tst_kvercmp.h"
>  #include "tst_test.h"
>  
>  #define TMP_DIR "tmp_dirtyc0w_shmem"
> @@ -41,6 +42,9 @@ static void sighandler(int sig)
>  
>  static void setup(void)
>  {
> +	if (tst_kvercmp(5, 16, 0) < 0) {
> +		tst_brk(TCONF, "Test requires kernel 5.16.0 or newer for CVE-2022-2590 fix");
> +	}

You should use the .min_kver field in the tst_test structure instead.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
