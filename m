Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B057CC6FA8E
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 14:20:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33AD43CDD02
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 15:20:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 887B13CB9CD
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 15:19:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 332EB1000967
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 15:19:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6AB1221E6F;
 Thu,  2 Mar 2023 14:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1677766798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rVzgVnfaS+4M8p5QrdC5cf62iI1UrX2XU9JLRoxK+eU=;
 b=Y415jrK5qwwKBySTXs2UqfoYPIRBQt3fqTPf6ooxByUdtgSLiJQ5ygzYNTu/Jejp95iizV
 8ZhNi8EwtSBQWpABp4Hwptl9SaWsd5zkeJtPV4PVuczmcgMi2C+6y7ZOozXYSEpzC/S0sg
 +XgUUmpWWp41o6+Zmsm21ZVG7cOJ10U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1677766798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rVzgVnfaS+4M8p5QrdC5cf62iI1UrX2XU9JLRoxK+eU=;
 b=Eja3rFY44LbRTXKajxFYrLZupbjHoWCrJ9ppRTUDWWbAfCqxXzFTFEpI1K6wCiKYsnEGEu
 JsmfoA8li99JSyBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47C3513A63;
 Thu,  2 Mar 2023 14:19:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id THaRD46wAGQsYQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 02 Mar 2023 14:19:58 +0000
Date: Thu, 2 Mar 2023 15:19:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Message-ID: <20230302141956.GA20234@pevik>
References: <20230301193332.27694-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230301193332.27694-1-Liam.Howlett@oracle.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mprotect: Add mprotect05 testcase
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

Hi Liam,

> Add a test that uses mprotect to split and combine VMAs.  Created to
> ensure the correctness of the VMA iterator after a bug report.

LGTM, thank you.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +/*\
> + * [Description]
> + *
> + *	Testcase to check the mprotect(2) system call split and merge
> + *
> + * Reference links:
> + *  - https://bugzilla.kernel.org/show_bug.cgi?id=217061
This would be formatted as inline in our docs.
> + *
> + */
> +
> +#include <errno.h>
> +#include <stdio.h>
These aren't needed.

Waiting little longer for any feedback before merging with the diff below.

Kind regards,
Petr

+++ testcases/kernel/syscalls/mprotect/mprotect05.c
@@ -9,14 +9,10 @@
  *
  *	Testcase to check the mprotect(2) system call split and merge
  *
- * Reference links:
- *  - https://bugzilla.kernel.org/show_bug.cgi?id=217061
+ * https://bugzilla.kernel.org/show_bug.cgi?id=217061
  *
  */
 
-#include <errno.h>
-#include <stdio.h>
-
 #include "tst_test.h"
 
 #define TEST_FILE "mprotect05-testfile"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
