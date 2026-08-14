Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AABC5CFCF
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 06:25:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE8AD3C7176
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 08:25:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA4823C1C41
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 08:24:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9C14E1000932
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 08:24:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A6F3982D88;
 Fri, 14 Aug 2026 06:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786688684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z6dp6073oW6AvfKDR6pTU4fWicNh4pYmQ8XdML0PN/U=;
 b=ukEV0B87iHUeBaKn23QhanflyMRxvEq3TH22DBL3fqKt3Y108nh+uXa6UpOxwVXtzeZb2g
 1xqtjFskGHs+pwmS72P/ED9P/yBHwb1EpPb6UMb7A8kSCR1kT3nJixmJUvB1n22Jl9r2gU
 aurG+sa9f3M7YoJOSo3LHskKOlbfU0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786688684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z6dp6073oW6AvfKDR6pTU4fWicNh4pYmQ8XdML0PN/U=;
 b=jN/XE2zUcSNXsgBh1fykGxFWMp3gB6EixLvG7Z1xYtzJUf6hhKLaKSetCHMPiyl4jKtekz
 fOUkmQz/Jm4id/Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786688680;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z6dp6073oW6AvfKDR6pTU4fWicNh4pYmQ8XdML0PN/U=;
 b=ASPYCkbCbv6D2biy2KgzDEM3KenqXhllg7q2ZLaUMGkwye7DI3O/wjP9MPmRNZlOJfHcvE
 bRA466EUlA39UBYpjyNR9ufmDNqhvbCcmCJ/CTC+9aTZLaCBNIMSHvncsj+1/UH1TR8JEq
 Dj+ZmTs8r3k9jsWSRHjv3f04kKQxR/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786688680;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z6dp6073oW6AvfKDR6pTU4fWicNh4pYmQ8XdML0PN/U=;
 b=Mx4x1hcjy/+eQPcITs7L8etNiCqXPkuaST/Nk599zZSfav2VxE6j9M5gqSNLP4USG+QJqb
 aNm+ybV1LgAfuwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 214107822D;
 Fri, 14 Aug 2026 06:24:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qnlcBqi0fmodOwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 14 Aug 2026 06:24:40 +0000
Date: Fri, 14 Aug 2026 08:24:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260814062434.GD261864@pevik>
References: <20260811155202.1744316-4-pvorel@suse.cz>
 <6a7d66d6.be490abf.203406.d67e@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a7d66d6.be490abf.203406.d67e@mx.google.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr,

> > +	TST_EXP_FD_OR_FAIL(fd = open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);

> the correct usage should be:

> fd = TST_EXP_FD_OR_FAIL(open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);

Just a note: both compile and works the same (i.e. both are correct), but of
course the variant you suggested (fd = TST_EXP_FD_OR_FAIL...) is clearer.

This is because newer macros use ({  ...  TST_RET; }). But the original macro
TEST() use do { ... } while (0), that's why we slightly ugly code:

$ git grep 'TEST.*(fd ='
testcases/kernel/syscalls/fsconfig/fsconfig01.c:        TEST(fd = fsopen(tst_device->fs_type, 0));
testcases/kernel/syscalls/fsconfig/fsconfig02.c:        TEST(fd = fsopen(tst_device->fs_type, 0));
testcases/kernel/syscalls/fsconfig/fsconfig03.c:        TEST(fd = fsopen(tst_device->fs_type, 0));
testcases/kernel/syscalls/fsmount/fsmount02.c:  TEST(fd = fsopen(tst_device->fs_type, 0));
testcases/kernel/syscalls/fsopen/fsopen01.c:    TEST(fd = fsopen(tst_device->fs_type, tc->flags));
testcases/kernel/syscalls/move_mount/move_mount01.c:    TEST(fd = fsopen(tst_device->fs_type, 0));
testcases/kernel/syscalls/move_mount/move_mount02.c:    TEST(fd = fsopen(tst_device->fs_type, 0));
testcases/kernel/syscalls/mq_open/mq_open01.c:  TEST(fd = mq_open(qname, tc->oflag, S_IRWXU, tc->rq));
testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c:      TEST(fd = open_by_handle_at(*tc->dfd, fhp, tc->flags));
testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c:      TEST(fd = open_by_handle_at(*tc->dfd, *tc->fhp, tc->flags));
testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c:      TEST(fd = open_by_handle_at(tc->dfd, *tc->fhp, tc->flags));
testcases/kernel/syscalls/openat2/openat201.c:  TEST(fd = openat2(*tc->dfd, tc->pathname, myhow, tc->size));
testcases/kernel/syscalls/socket/socket01.c:    TEST(fd = socket(tc->domain, tc->type, tc->proto));

Anyway, this could be fixed before merge if this is a single thing to fix, but I
worry about agents findings:
https://lore.kernel.org/ltp/20260811160555.9333-1-linuxtestproject.agent@gmail.com/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
