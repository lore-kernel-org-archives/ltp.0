Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F01AC6379F
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 16:03:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40AB63CBECB
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 17:03:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 526453C00D1
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 17:03:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 360E71000D13
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 17:03:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5D87520392;
 Fri, 17 Feb 2023 16:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676649819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ES3RP51/ypEYyBWrpx8buWkNpet2RwR22uuY2fY2tto=;
 b=SIX4o47F1lUhnfaSdkPr7iqqf8uv8KGqNnvlZ43qzS0pHZSfGfY0BDwU32qx7j+VhdzpKR
 DajSkoRS2yeXwkAWq6unvuS9U6TiVxVuWo/XF6J01XPrHknnZ8bK0X/Z6YE1h1yA8q9vt0
 iFoS3sn6unMhDsGeqss3YKg50+5seZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676649819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ES3RP51/ypEYyBWrpx8buWkNpet2RwR22uuY2fY2tto=;
 b=5EjBxo6EojFvcoI3nIU/NC8R1lSx7W49ZWh4PKqi8Fdmbte1pItS2jQxGqAXddJb+l8Gyg
 eEYYvzg4knDmJdAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C80A13274;
 Fri, 17 Feb 2023 16:03:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iEhnEVul72MjRwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 17 Feb 2023 16:03:39 +0000
Date: Fri, 17 Feb 2023 17:05:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Y++lsqEyHVZp9uZp@yuki>
References: <20230215144820.17876-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230215144820.17876-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mq_notify03.c: New test CVE-2021-38604
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

Hi!
> +/*\
> + * [Description]
> + *
> + * Test for NULL pointer dereference in mq_notify(CVE-2021-38604)
> + *
> + * References links:
> + * - https://sourceware.org/bugzilla/show_bug.cgi?id=28213
> + */
> +
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <mqueue.h>
> +#include <signal.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include "tst_test.h"
> +#include "tst_safe_posix_ipc.h"
> +
> +static mqd_t m = -1;
> +static const char msg[] = "hello";
> +
> +static void check_bz28213_cb(union sigval sv)
> +{
> +	char buf[sizeof(msg)];
> +
> +	(void)sv;
> +
> +	TST_EXP_PASS(!((size_t) mq_receive(m, buf, sizeof(buf), NULL)

Does this line of code even compile?

> +	TST_EXP_PASS(!(memcmp(buf, msg, sizeof(buf)) == 0));
> +
> +	exit(0);
> +}
> +
> +static void check_bz28213(void)
> +{
> +	struct sigevent sev;
> +
> +	memset(&sev, '\0', sizeof(sev));
> +	sev.sigev_notify = SIGEV_THREAD;
> +	sev.sigev_notify_function = check_bz28213_cb;
> +
> +	/* Step 1: Register & unregister notifier.
> +	 * Helper thread should receive NOTIFY_REMOVED notification.
> +	 * In a vulnerable version of glibc, NULL pointer dereference follows.
> +	 */
> +	TST_EXP_PASS(!(mq_notify(m, &sev) == 0));
> +	TST_EXP_PASS(!(mq_notify(m, NULL) == 0));

That's not how use use the TST_EXP_PASS() macro, the bare mq_notify()
call should be inside.

> +	/* Step 2: Once again, register notification.
> +	 * Try to send one message.
> +	 * Test is considered successful, if the callback does exit (0).
> +	 */
> +	TST_EXP_PASS(!(mq_notify(m, &sev) == 0));
> +	TST_EXP_PASS(!(mq_send(m, msg, sizeof(msg), 1) == 0));

Here as well.

> +	/* Wait... */
> +	pause();
> +}
> +
> +static void do_test(void)
> +{
> +	static const char m_name[] = "/bz28213_queue";
                                       ^
				       We tend to prefix globaly visible
				       object with ltp_ and use the test
				       name in there, so in this case
				       this would be "/ltp_mq_notify03"
> +	struct mq_attr m_attr;
> +
> +	memset(&m_attr, '\0', sizeof(m_attr));
> +	m_attr.mq_maxmsg = 1;
> +	m_attr.mq_msgsize = sizeof(msg);
> +
> +	m = SAFE_MQ_OPEN(m_name,
> +			O_RDWR | O_CREAT | O_EXCL,
> +			0600,
> +			&m_attr);
> +
> +	if (m < 0) {
> +		if (errno == ENOSYS)
> +			tst_brk(TCONF, "POSIX message queues are not implemented");
> +		tst_brk(TFAIL | TTERRNO, "mq_open failed");
> +	}

This will never work, the SAFE_MQ_OPEN() will exit the test if the call
fails with ENOSYS. You have to check for the support in a test setup
instead.

Also I think that unlike the SysV IPC the POSIX IPC cannot be disabled
in kernel .config, so ENOSYS handling may not be needed after all.

> +	TST_EXP_PASS(!(mq_unlink(m_name) == 0));

Here as well.

> +	check_bz28213();
               ^
	       This is poorly choosen name for a function, can we please
	       call this more descriptive name? What about
	       try_null_dereference() ?
> +}
> +
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +	.tags = (const struct tst_tag[]) {
> +		{"glibc-git", "b805aebd42"},
> +		{"CVE", "2021-38604"},
> +		{}
> +	},
> +	.needs_root = 1,
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
