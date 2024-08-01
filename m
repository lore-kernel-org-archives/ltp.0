Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA887C3DA4A
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 12:00:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D99A3D1B07
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:00:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8E6E3D1EF6
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:00:07 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A4B1C206510
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:00:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 154031FB4D
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 12:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722513604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MuZxSEFGt4OpGyXO4eJiNtKNbH/FLCVtwWMDH6WYcNc=;
 b=i0yicqCHCRwuhOWQlqD5FUJg/4yBYaOJZla6UWNotA/sjYwVnSmrcoEKppJWQcT/6UalyV
 19CWBpqF/GWl6n2dwgvVRhQGRnuHMDy25PWFjfGRV4/AoNVrStrM/fFhZD2Jdt2xOAxDbl
 igA0regYo+8cv7HXs5cvvjOlsAilzj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722513604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MuZxSEFGt4OpGyXO4eJiNtKNbH/FLCVtwWMDH6WYcNc=;
 b=JTa4SK1vBN0hD7maZY54HA2cTH0gfD68EbZNH9CWygLUdz5GJK+X8m7pZmbX7q9PegzVy2
 nrYZpkedLwxIgXDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i0yicqCH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JTa4SK1v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722513604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MuZxSEFGt4OpGyXO4eJiNtKNbH/FLCVtwWMDH6WYcNc=;
 b=i0yicqCHCRwuhOWQlqD5FUJg/4yBYaOJZla6UWNotA/sjYwVnSmrcoEKppJWQcT/6UalyV
 19CWBpqF/GWl6n2dwgvVRhQGRnuHMDy25PWFjfGRV4/AoNVrStrM/fFhZD2Jdt2xOAxDbl
 igA0regYo+8cv7HXs5cvvjOlsAilzj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722513604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MuZxSEFGt4OpGyXO4eJiNtKNbH/FLCVtwWMDH6WYcNc=;
 b=JTa4SK1vBN0hD7maZY54HA2cTH0gfD68EbZNH9CWygLUdz5GJK+X8m7pZmbX7q9PegzVy2
 nrYZpkedLwxIgXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00D0713ADB
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 12:00:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5vrVOsN4q2b2VAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 01 Aug 2024 12:00:03 +0000
Date: Thu, 1 Aug 2024 14:02:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <Zqt5UA5gVyq2glNC@rei>
References: <20240731100743.9665-1-chrubis@suse.cz>
 <20240731100743.9665-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240731100743.9665-2-chrubis@suse.cz>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 154031FB4D
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] Add support for mixing C and shell code
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index e5bc5bf4d..7e1075fdf 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -4,6 +4,8 @@
>   * Copyright (c) Linux Test Project, 2016-2024
>   */
>  
> +#define _GNU_SOURCE
> +

And this actualy causes obscure build failure on musl.

The problem is that on musl sched.h exposes clone() when _GNU_SOURCE is
defined and at the same time sched.h does not get pulled before
tst_clone.h gets included, which means that the macro from tst_clone.h
that rewrites clone() functions actually rewrites the function
declaration in the system header.

The solution is to include sched.h in the tst_clone.h which guarantees
that headers are included in the right order, however after this the
compilation fails in:

testcases/kernel/controllers/cpuset/cpuset_lib/

Because the library defines sched_setaffinity() prototype incompatible
with the system headers and tst_sched.h gets pulled there from test.h.
(That is something to be fixed, but that would be likely complete
 rewrite of these testcases.)

However there is no need to include tst_clone.h in test.h since there is
only single old library test that uses ltp_clone() API. So the whole fix
should be:

diff --git a/include/old/test.h b/include/old/test.h
index 0e210e4ef..306868fb5 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -31,7 +31,6 @@
 #include "tst_pid.h"
 #include "tst_cmd.h"
 #include "tst_cpu.h"
-#include "tst_clone.h"
 #include "old_device.h"
 #include "old_tmpdir.h"
 #include "tst_minmax.h"
diff --git a/include/tst_clone.h b/include/tst_clone.h
index 56f23142d..a57d761ca 100644
--- a/include/tst_clone.h
+++ b/include/tst_clone.h
@@ -5,6 +5,8 @@
 #ifndef TST_CLONE_H__
 #define TST_CLONE_H__
 
+#include <sched.h>
+
 #ifdef TST_TEST_H__
 
 /* The parts of clone3's clone_args we support */
diff --git a/testcases/kernel/syscalls/clone/clone02.c b/testcases/kernel/syscalls/clone/clone02.c
index 821adc2d9..fd3ee1aed 100644
--- a/testcases/kernel/syscalls/clone/clone02.c
+++ b/testcases/kernel/syscalls/clone/clone02.c
@@ -59,6 +59,7 @@
 #include <sched.h>
 #include "test.h"
 #include "safe_macros.h"
+#include "tst_clone.h"
 
 #define FLAG_ALL (CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|SIGCHLD)
 #define FLAG_NONE SIGCHLD

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
