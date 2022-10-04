Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10C6C433F5
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 12:20:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68D8B3C80B3
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 14:20:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9486C3C80B3
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 14:20:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8E83F200FCD
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 14:20:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AFB87218EC;
 Tue,  4 Oct 2022 12:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664886022;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R6oBoHbWoXgIlt6kp784VuMl4uEi9i8P+38rfgXi0ck=;
 b=qWgEJfFs2UOd+FI7+mH29GIz0oB0ZbYGzFeR9+oB1CHO9bZ+YVRDFNMdfbn/TItyTI3vUp
 e39SKLaQnJyg3dUkBMUofRPjRnMd/9987ruNCIYUeR+a11duU5ktNE/UrmZplgxCjHJDyP
 rc9OCihog2sWeIeFGe0Mz9my/9WSRAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664886022;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R6oBoHbWoXgIlt6kp784VuMl4uEi9i8P+38rfgXi0ck=;
 b=eh15FUcBoEQrS0OOewVamf6fOiOWc9ESOr58iqeYmBMB1MCEt3pNkzrMicJGbq5fxE3bVZ
 75DgRa+ChyD+EGCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83928139EF;
 Tue,  4 Oct 2022 12:20:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XKtyHgYlPGO4PAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Oct 2022 12:20:22 +0000
Date: Tue, 4 Oct 2022 14:20:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YzwlBEyDZHEvkMBy@pevik>
References: <43d65409eb3290b09e1c3a21cb0dc079c5f4849c.1664801307.git.jstancek@redhat.com>
 <938c864ee6bb82ffdee9371bd802642ffedc606c.1664872194.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <938c864ee6bb82ffdee9371bd802642ffedc606c.1664872194.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: introduce safe_write() retry
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

Hi Jan,

> Turn safe_write() len_strict parameter into 3-way switch, introducing
> one additional mode of operation "retry". On short writes, this
> resumes write() with remainder of the buffer.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> ---
>  include/safe_macros_fn.h    | 11 ++++++++--
>  lib/safe_macros.c           | 42 ++++++++++++++++++++++++++++---------
>  lib/tests/tst_safe_macros.c |  6 +++---
>  3 files changed, 44 insertions(+), 15 deletions(-)

LGTM. I just wonder if we need to add it to lib/safe_macros.c,
which implements it for the old API. Would it work to add it only to
tst_safe_macros.c and tst_safe_macros.h (instead of safe_macros_fn.h)?
Not a requirement, just if it makes sense to you.

...
> +++ b/include/safe_macros_fn.h
> @@ -24,6 +24,13 @@
>  #include <unistd.h>
>  #include <dirent.h>

> +/* supported values for safe_write() len_strict parameter */
> +enum safe_write_opts {
> +        SAFE_WRITE_ANY = 0,	// no length strictness, short writes are ok
> +        SAFE_WRITE_ALL = 1,	// strict length, short writes raise TBROK
> +        SAFE_WRITE_RETRY = 2,	// retry/resume after short write
> +};

Maybe use /* */ and for readability, maybe put into it's own line?

enum safe_write_opts {
	/* no length strictness, short writes are ok */
	SAFE_WRITE_ANY = 0,

	/* strict length, short writes raise TBROK */
	SAFE_WRITE_ALL = 1,

	/* retry/resume after short write */
	SAFE_WRITE_RETRY = 2,	// 
};

Also checkpatch.pl complains:

safe_macros_fn.h:29: ERROR: code indent should use tabs where possible
safe_macros_fn.h:29: WARNING: please, no spaces at the start of a line
safe_macros_fn.h:30: ERROR: code indent should use tabs where possible
safe_macros_fn.h:30: WARNING: please, no spaces at the start of a line
safe_macros_fn.h:31: ERROR: code indent should use tabs where possible
safe_macros_fn.h:31: WARNING: please, no spaces at the start of a line

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
