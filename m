Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3899CD31A3A
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 09:39:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CD003C9999
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 10:39:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DED013C58A2
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 10:39:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D62A51A00888
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 10:39:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C0385C06F;
 Wed, 14 Jan 2026 09:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768383570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Een1KJjpb6oQyGGausabj4o6lIakkKKgNl583lemC/o=;
 b=SuW8rI32QMkPgSeYMPzsrg5hu+POx+rGjvF+lqGb1eiBlDTZrxvBdQbuKhNkmvoacRRXeI
 fr4z7q9ZJvSg2VEz+MId/RjCU6eduwigGD91gdMiP0SNLNQ4zJBEfG1dDQbFInoIxCGbel
 8LGPpfbqjGNhRVJFuIdeWvpQt0K/6p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768383570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Een1KJjpb6oQyGGausabj4o6lIakkKKgNl583lemC/o=;
 b=I30ihIpgQpm5EDRlNHTVnJeud/RiiL+nyZaleHF0gGQiR0x/gMj6Wjcq58uVD0+IAIeXbF
 yAZ2g1hqU6CaHwBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768383570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Een1KJjpb6oQyGGausabj4o6lIakkKKgNl583lemC/o=;
 b=SuW8rI32QMkPgSeYMPzsrg5hu+POx+rGjvF+lqGb1eiBlDTZrxvBdQbuKhNkmvoacRRXeI
 fr4z7q9ZJvSg2VEz+MId/RjCU6eduwigGD91gdMiP0SNLNQ4zJBEfG1dDQbFInoIxCGbel
 8LGPpfbqjGNhRVJFuIdeWvpQt0K/6p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768383570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Een1KJjpb6oQyGGausabj4o6lIakkKKgNl583lemC/o=;
 b=I30ihIpgQpm5EDRlNHTVnJeud/RiiL+nyZaleHF0gGQiR0x/gMj6Wjcq58uVD0+IAIeXbF
 yAZ2g1hqU6CaHwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C4483EA63;
 Wed, 14 Jan 2026 09:39:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sveLLFFkZ2lHGAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 14 Jan 2026 09:39:29 +0000
Date: Wed, 14 Jan 2026 10:40:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <aWdkmzC8pdtqVqk3@yuki.lan>
References: <20260113194936.GQ3634291@ZenIV>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260113194936.GQ3634291@ZenIV>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,linux.org.uk:email,yuki.lan:mid];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lack of ENAMETOOLONG testcases for pathnames
 longer than PATH_MAX
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
Cc: linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> 	There are different causes of ENAMETOOLONG.  It might come from
> filesystem rejecting an excessively long pathname component, but there's
> also "pathname is longer than PATH_MAX bytes, including terminating NUL"
> and that doesn't get checked anywhere.

We do have a couple of tests that checks that names over PATH_MAX are
rejected, there is no reason to add these kind of tests, however I do
not think that we tests that check that names that are just under the
limit work fine, that needs to be added.

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/testcases/kernel/syscalls/chdir/chdir04.c b/testcases/kernel/syscalls/chdir/chdir04.c
> index 6e53b7fef..e8dd5121d 100644
> --- a/testcases/kernel/syscalls/chdir/chdir04.c
> +++ b/testcases/kernel/syscalls/chdir/chdir04.c
> @@ -11,6 +11,8 @@
>  #include "tst_test.h"
>  
>  static char long_dir[] = "abcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
> +static char long_path[PATH_MAX+1];
> +static char shorter_path[PATH_MAX];
>  static char noexist_dir[] = "noexistdir";
>  
>  static struct tcase {
> @@ -20,16 +22,23 @@ static struct tcase {
>  	{long_dir, ENAMETOOLONG},
>  	{noexist_dir, ENOENT},
>  	{0, EFAULT}, // bad_addr
> +	{long_path, ENAMETOOLONG},

This test already exists in the form of long_dir just three lines above.

> +	{shorter_path, 0},

What about we add a separate test (chdir02.c) for paths that shouldn't
be rejected. Something as:

char path[PATH_MAX];
int i;

...
	for (i = 1; i < PATH_MAX; i++) {
		memset(path, 0, sizeof(path));
		memset(path, '/', i);
		TST_EXP_PASS(chdir(path), "chdir() len=%i", i);
	}
...


That would make sure that all lenghts of paths that are valid are
accepted.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
