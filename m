Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA4AC5B572
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 13:54:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 326943CD694
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 15:54:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A7133CD519
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 15:54:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8545A1A007AB
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 15:54:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C3B33ED6;
 Wed, 19 Aug 2026 13:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787147649;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPP/qLz6X6z/iw79CjyUsNBsU7MChWdNzA2T97EbSJk=;
 b=Cgj2TZgyYTcNNGqBnoe2oqSZzW9CefvaBLiNxuRMOvSdFN4zHlQcaAYYkLF+PlMYKlfBPV
 Q69nUjS+Ili/f0lN5q6HjnVQtsiNMDGZHUSVuTOexbEEFBLseaTcdMay7ivrC75LqxpWOD
 pQY60Q1g1DuPDvUO7K3mztTyW1FB6Dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787147649;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPP/qLz6X6z/iw79CjyUsNBsU7MChWdNzA2T97EbSJk=;
 b=6XV6Awo1GayXejneV9jISSG90Xt/8YQ8qk4ePExrGq4BZ+PrnHm7N0lE2BBbKC+u+PRVSs
 VooaGB3sDRgDiVAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787147645;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPP/qLz6X6z/iw79CjyUsNBsU7MChWdNzA2T97EbSJk=;
 b=hzPObB/Xe4oYRv71JSkKh1nnqxrOk9OBg5IYcWa2Q5VVMbSs8FieEM+IBDyx7CVZMFJ98A
 YNP5Nv/gfP6If+pLTYeDixtVx+5XUaZK8w773ab1swnhn+Fwrv/5coCFN7nWgjIqhZ7n9y
 Wn9EiUgVqMuQPFskpOhmzsGBiZs2SOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787147645;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPP/qLz6X6z/iw79CjyUsNBsU7MChWdNzA2T97EbSJk=;
 b=7PfbOV7X/7GfulTvDT49XLhn7123fHLb3+2ba5FnFs3o/iNw9sOJY3ngEUGuwFqinoRxzk
 3cXRLXQJQ9Nfc3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F093362E;
 Wed, 19 Aug 2026 13:54:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xmyeEH21hWq0YwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 19 Aug 2026 13:54:05 +0000
Date: Wed, 19 Aug 2026 15:53:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it
Message-ID: <20260819135359.GA2139309@pevik>
References: <20260811155202.1744316-4-pvorel@suse.cz>
 <6a7d66d6.be490abf.203406.d67e@mx.google.com>
 <20260814062434.GD261864@pevik> <20260814063537.GE261864@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260814063537.GE261864@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] tree: Use TST_EXP_PASS_OR_FAIL() and
 TST_EXP_FD_OR_FAIL()
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

Hi Andrea, all,

> > > Hi Petr,

> > > > +	TST_EXP_FD_OR_FAIL(fd = open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);

> > > the correct usage should be:

> > > fd = TST_EXP_FD_OR_FAIL(open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);

@Andrea I suppose the reason why you or somebody else set whole patch as changes
requested was the line above. Once you have time, would you please have look at
the changes I proposed in my previous mail?

Kind regards,
Petr

> > Just a note: both compile and works the same (i.e. both are correct), but of
> > course the variant you suggested (fd = TST_EXP_FD_OR_FAIL...) is clearer.

> > This is because newer macros use ({  ...  TST_RET; }). But the original macro
> > TEST() use do { ... } while (0), that's why we slightly ugly code:

> > $ git grep 'TEST.*(fd ='
> > testcases/kernel/syscalls/fsconfig/fsconfig01.c:        TEST(fd = fsopen(tst_device->fs_type, 0));
> > testcases/kernel/syscalls/fsconfig/fsconfig02.c:        TEST(fd = fsopen(tst_device->fs_type, 0));
> > testcases/kernel/syscalls/fsconfig/fsconfig03.c:        TEST(fd = fsopen(tst_device->fs_type, 0));
> > testcases/kernel/syscalls/fsmount/fsmount02.c:  TEST(fd = fsopen(tst_device->fs_type, 0));
> > testcases/kernel/syscalls/fsopen/fsopen01.c:    TEST(fd = fsopen(tst_device->fs_type, tc->flags));
> > testcases/kernel/syscalls/move_mount/move_mount01.c:    TEST(fd = fsopen(tst_device->fs_type, 0));
> > testcases/kernel/syscalls/move_mount/move_mount02.c:    TEST(fd = fsopen(tst_device->fs_type, 0));
> > testcases/kernel/syscalls/mq_open/mq_open01.c:  TEST(fd = mq_open(qname, tc->oflag, S_IRWXU, tc->rq));
> > testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c:      TEST(fd = open_by_handle_at(*tc->dfd, fhp, tc->flags));
> > testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c:      TEST(fd = open_by_handle_at(*tc->dfd, *tc->fhp, tc->flags));
> > testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c:      TEST(fd = open_by_handle_at(tc->dfd, *tc->fhp, tc->flags));
> > testcases/kernel/syscalls/openat2/openat201.c:  TEST(fd = openat2(*tc->dfd, tc->pathname, myhow, tc->size));
> > testcases/kernel/syscalls/socket/socket01.c:    TEST(fd = socket(tc->domain, tc->type, tc->proto));

> > Anyway, this could be fixed before merge if this is a single thing to fix, but I
> > worry about agents findings:
> > https://lore.kernel.org/ltp/20260811160555.9333-1-linuxtestproject.agent@gmail.com/

> Therefore I suggest to merge with changes below (removed O_TRUNC and move fd =
> to the beginning).

> > Kind regards,
> > Petr

> +++ testcases/kernel/syscalls/landlock/landlock_tester.h
> @@ -254,13 +254,13 @@ static void _test_truncate(const int exp_err)
>  	tst_res(TINFO, "Test truncating file");

>  	TST_EXP_PASS_OR_FAIL(truncate(FILE_TRUNCATE, 10), exp_err);
> -	TST_EXP_FD_OR_FAIL(fd = open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);
> +	fd = TST_EXP_FD_OR_FAIL(open(FILE_TRUNCATE, O_WRONLY, PERM_MODE), exp_err);
>  	if (fd != -1) {
>  		TST_EXP_PASS_OR_FAIL(ftruncate(fd, 10), exp_err);
>  		SAFE_CLOSE(fd);
>  	}

> -	TST_EXP_FD_OR_FAIL(fd = open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);
> +	fd = TST_EXP_FD_OR_FAIL(open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);
>  	if (fd != -1)
>  		SAFE_CLOSE(TST_RET);
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
