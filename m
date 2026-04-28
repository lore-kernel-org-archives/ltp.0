Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C47FF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 12:58:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09A313E2D7F
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 14:58:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D5243C7A5F
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 14:58:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C6B521000975
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 14:58:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D60D45BD2E;
 Tue, 28 Apr 2026 12:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777381094;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z2EJLfMq7Cc+3u6R417PX3b+TfJBNS0yPQmzvflTyhs=;
 b=KiBiAitVvF3ibRkanMxWxl0Ig1/Y3W7xQiuPvJTOcaW9DzCYvRBSDWLm2D8F20fXnITO7t
 dZfbPRIeH1u0WD7ZlAaHLKmH5HEwiYUCr9d1j4y48PLYAcTYOlYUxDnuwPEzICg+SfpjtM
 ATbpnhgj4B1LHyVzdof5Ln4/h8MWyMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777381094;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z2EJLfMq7Cc+3u6R417PX3b+TfJBNS0yPQmzvflTyhs=;
 b=EO0ZgzYVcjtiif9JQ4QLlR4KdUIaI9hWpRf+FOpAwh6oaS9oC160r7+YEQJMd3D4SsYuMU
 m/o3yCklG3/wX1BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PKMZCCGZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=L3B2NKLC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777381093;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z2EJLfMq7Cc+3u6R417PX3b+TfJBNS0yPQmzvflTyhs=;
 b=PKMZCCGZ+aa9QunTptVo9yoOErsOHURP9OGiDUx/SxJakxzVcjwIBibvfD/fOFQvibHlIk
 NIMBIn5WBVXf4jWd6UgMUx6ljfdaaIxH6h1Td8swEkwZnHZfs1ySBnciqa33O2pqkoeO7l
 K6d5cyHJr2OkyI3fE27Fch5KPzmI3os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777381093;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z2EJLfMq7Cc+3u6R417PX3b+TfJBNS0yPQmzvflTyhs=;
 b=L3B2NKLC/TRUjwcY5wJTQQbbXzJu/zBIFJKW6Y2SdqAqgwETjxqXX6FF2CHonAWxuOaWHR
 qgNiR7Aeog0aoGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2DA0593B0;
 Tue, 28 Apr 2026 12:58:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zVqJKuWu8GnJTAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 Apr 2026 12:58:13 +0000
Date: Tue, 28 Apr 2026 14:58:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260428125804.GA921372@pevik>
References: <20260427115941.31945-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260427115941.31945-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D60D45BD2E
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: TCONF on systems without swap
 space
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
Cc: Li Wang <liwang@linux.dev>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> mmapstress06 is designed to stress the mfile_swap kernel primitive, which
> manages shared anonymous memory. On architectures with large pages (like
> 64KB on ppc64le), the test's hardcoded request for 32769 pages results
> in a ~2GB mapping. So in suse test system configured with 2GB of RAM and
> no swap space, the test will fails with following information:

> mmapstress06: errno = 12; large mmap failed
> for this test to run, it needs a mmap space of
> 32769 pages

> The failure occurs because the 2GB request cannot be fulfilled within
> the 2GB RAM limit without swap backing. Since the test specifically
> intends to exercise swap-related logic (mfile_swap), it should be skipped
> with TCONF when the system lacks swap space.

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/mem/mmapstress/mmapstress06.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

> diff --git a/testcases/kernel/mem/mmapstress/mmapstress06.c b/testcases/kernel/mem/mmapstress/mmapstress06.c
> index 37b7edc84..54b5febbf 100644
> --- a/testcases/kernel/mem/mmapstress/mmapstress06.c
> +++ b/testcases/kernel/mem/mmapstress/mmapstress06.c
> @@ -51,6 +51,8 @@ void ok_exit();

>  #define ANON_GRAN_PAGES_MAX	(32U)

> +#include "tst_memutils.h"
> +
>  extern time_t time(time_t *);
>  extern char *ctime(const time_t *);
>  extern int atoi(const char *);
> @@ -74,6 +76,12 @@ int main(int argc, char *argv[])
>  		(void)fprintf(stderr, "usage: %s sleep_time\n", argv[0]);
>  		anyfail();
>  	}
> +
> +	if (tst_available_swap() <= 0) {
> +		tst_resm(TCONF, "Test requires swap space to exercise mfile_swap logic");
Why to require swap for the test instead of checking for ENOMEM later?

> +		tst_exit();
nit: I'd use tst_brkm() although it has ugly "Remaining cases broken" message as
it will be more obvious when doing rewrite.

> +	}

How about this? (with cleanup of ugly printf).

Kind regards,
Petr

+++ testcases/kernel/mem/mmapstress/mmapstress06.c
@@ -89,10 +89,12 @@ int main(int argc, char *argv[])
 	    (mmapaddr, (ANON_GRAN_PAGES_MAX * NMFPTEPG + 1) * pagesize,
 	     PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, 0,
 	     0) == (caddr_t) - 1) {
-		ERROR("large mmap failed");
-		printf("for this test to run, it needs a mmap space of\n");
-		printf("%d pages\n", (ANON_GRAN_PAGES_MAX * NMFPTEPG + 1));
-		return 1;
+		if (errno == ENOMEM) {
+			tst_brkm(TCONF, NULL, "not enough memory or swap for mmap() %d pages",
+					 ANON_GRAN_PAGES_MAX * NMFPTEPG + 1);
+		}
+
+		tst_brkm(TBROK | TERRNO, NULL, "mmap() failed");
 	}
 	(void)sleep(sleep_time);
 	(void)time(&t);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
