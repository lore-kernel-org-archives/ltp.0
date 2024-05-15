Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEF1C25B79
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 14:23:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B2293CF86D
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 16:23:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 195333CEFCB
 for <ltp@lists.linux.it>; Wed, 15 May 2024 16:22:46 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3F6842102EC
 for <ltp@lists.linux.it>; Wed, 15 May 2024 16:22:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4002333C4C;
 Wed, 15 May 2024 14:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715782965;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=mJKpEPBkscdjHFQOY0m/pKpigteyNVBf6K/6x9Gb8aY=;
 b=ldkza+M/iSUwQH3juJhVwPs6BG5e+ZVnAJUv3DQx5JDpTi4Lu8zXUVQLGNlN7xak3l9UQt
 oGqAue4u5WX8k3dXqbT1yEPk4HAogYV4wCNC8kqG/ekEPiyq8NB1PK/LYQIQ9P/B/Klq+V
 mjr4l0aZ/7mt0FzAAdzB/VK8YaLtNY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715782965;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=mJKpEPBkscdjHFQOY0m/pKpigteyNVBf6K/6x9Gb8aY=;
 b=A/DO5ZT317JsG/BjUVEat2ChKLNN9rJp2GUpihPHlf+UcbjOA6jCxFXfwASpe1lnIxzu0I
 A6fXcvTmxixKiHAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ldkza+M/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="A/DO5ZT3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715782965;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=mJKpEPBkscdjHFQOY0m/pKpigteyNVBf6K/6x9Gb8aY=;
 b=ldkza+M/iSUwQH3juJhVwPs6BG5e+ZVnAJUv3DQx5JDpTi4Lu8zXUVQLGNlN7xak3l9UQt
 oGqAue4u5WX8k3dXqbT1yEPk4HAogYV4wCNC8kqG/ekEPiyq8NB1PK/LYQIQ9P/B/Klq+V
 mjr4l0aZ/7mt0FzAAdzB/VK8YaLtNY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715782965;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=mJKpEPBkscdjHFQOY0m/pKpigteyNVBf6K/6x9Gb8aY=;
 b=A/DO5ZT317JsG/BjUVEat2ChKLNN9rJp2GUpihPHlf+UcbjOA6jCxFXfwASpe1lnIxzu0I
 A6fXcvTmxixKiHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E52631372E;
 Wed, 15 May 2024 14:22:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a7sbNDTFRGZ3PQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 May 2024 14:22:44 +0000
Date: Wed, 15 May 2024 16:22:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
Message-ID: <20240515142234.GA227672@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bbcfed6d-caff-43f8-96ce-77e6cb6afd2a@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4002333C4C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] Refactor fork14 using new LTP API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Hi!

> On 5/6/24 22:26, Petr Vorel wrote:
> > Hi Andrea, Martin,

> >> Hi,
> >> Reviewed-by: Martin Doucha <mdoucha@suse.cz>
> > +1

> > ...

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> >>> +
> >>> +static struct tst_test test = {
> >>> +	.test_all = run,
> >>> +	.setup = setup,
> >>> +	.cleanup = cleanup,
> >>> +	.forks_child = 1,
> >>> +	.skip_in_compat = 1,
> > BTW test on x86 (i.e. true 64 bit) behaves exactly the same as on compat mode:

> > tst_test.c:1614: TINFO: Timeout per run is 0h 00m 30s
> > fork14.c:46: TINFO: mmap() failed
> > fork14.c:46: TINFO: mmap() failed
> > fork14.c:46: TINFO: mmap() failed
> > fork14.c:46: TINFO: mmap() failed
> > fork14.c:46: TINFO: mmap() failed
> > fork14.c:46: TINFO: mmap() failed
> > fork14.c:46: TINFO: mmap() failed
> > fork14.c:46: TINFO: mmap() failed
> > fork14.c:46: TINFO: mmap() failed
> > fork14.c:46: TINFO: mmap() failed
> > fork14.c:46: TINFO: mmap() failed
> > fork14.c:49: TCONF: mmap() fails too many times, so it's almost impossible to get a vm_area_struct sized 16TB.

> > IMHO we should whitelist it as well, I can change before merge with diff below.

> > (More elegant way would be to add .skip_in_32bit.)

> > Kind regards,
> > Petr

> > +++ testcases/kernel/syscalls/fork/fork14.c
> > @@ -18,6 +18,8 @@
> >   #include <stdlib.h>
> >   #include <sys/wait.h>

> > +#ifndef __i386__
> TST_ABI32 is not enough? What about ".skip_in_compat"?

Yes, TST_ABI32 is actually better than limit to __i386__.
Do you give ack for these changes below? Or feel free to send new version?
IMHO the problem is 16TB is too much for 32 bit kernel (4 GiB limit).

.skip_in_compat would not be enough, because the problem is on pure 32 bit
distro e.g. with 32bit kernel (yes, there are people who use them), but
.skip_in_compat is for 64 bit kernel with 32bit userspace (compiled with -m32 in
CFLAGS and LDFLAGS).

Also, I suggested in the patch below to remove .skip_in_compat, but for info
version it would be good to keep it. I suppose it's not worth to add new flag
.skip_in_32bit for this single case (it'd be good for doc purposes).
@Cyril WDYT?

+++ testcases/kernel/syscalls/fork/fork14.c
@@ -7,17 +7,21 @@
 /*\
  * [Description]
  *
- * This test is a reporducer for this patch:
- * https://lore.kernel.org/lkml/1335289853-2923-1-git-send-email-siddhesh.poyarekar@gmail.com/
- * Since vma length in dup_mmap is calculated and stored in a unsigned
+ * This test is a reproducer for kernel 3.5:
+ * 7edc8b0ac16c ("mm/fork: fix overflow in vma length when copying mmap on clone")
+ *
+ * Since VMA length in dup_mmap() is calculated and stored in a unsigned
  * int, it will overflow when length of mmaped memory > 16 TB. When
  * overflow occurs, fork will incorrectly succeed. The patch above fixed it.
  */
 
+#include "lapi/abisize.h"
 #include "tst_test.h"
 #include <stdlib.h>
 #include <sys/wait.h>
 
+#ifndef TST_ABI32
+
 #define LARGE		(16 * 1024)
 #define EXTENT		(16 * 1024 + 10)
 
@@ -48,7 +52,7 @@ static void run(void)
 			if (failures > 10) {
 				tst_brk(TCONF, "mmap() fails too many "
 					"times, so it's almost impossible to "
-					"get a vm_area_struct sized 16TB.");
+					"get a vm_area_struct sized 16TB");
 			}
 
 			continue;
@@ -115,9 +119,11 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.forks_child = 1,
-	.skip_in_compat = 1,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "7edc8b0ac16c"},
 		{}
 	}
 };
+#else
+TST_TEST_TCONF("Not supported on x86 in 32-bit");
+#endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
