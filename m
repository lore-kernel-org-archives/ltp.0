Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BD7C4321E
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 19:30:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A3383CC66B
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 20:30:40 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C2793C0367
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 20:30:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 15BBC600132
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 20:30:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF9F61FDCA;
 Mon, 28 Nov 2022 19:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669663828;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7BrhAbOmmPw51KvUTUbohA/fDXcgocI9IdgH0nai+Ok=;
 b=GX1siTSVnJK5KgXofNJYkPRr9HQjEiwA179p5B7bbLXtftdJgCor2nSpQt9pvLWwp45vAl
 s3k0xaPmlhQrMFuolMSzghMn2geu06Hg7y/ZdTPIWgWdQS04LKmWB+CWIqhkKzUpYRKOhu
 9qD25nmVe/YbZCEHX2imELaJzTOwVAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669663828;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7BrhAbOmmPw51KvUTUbohA/fDXcgocI9IdgH0nai+Ok=;
 b=e6EUjDdAfhKoxKMdz32/z1Gf2x1ZTItb548iSdAArDpqxtpTWD34jeqICflv3R1hs1mER+
 ibdxkhCpsDwHv5Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C28261326E;
 Mon, 28 Nov 2022 19:30:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id u3flLVQMhWMtQAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 28 Nov 2022 19:30:28 +0000
Date: Mon, 28 Nov 2022 20:30:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Message-ID: <Y4UMUqkLijWXOWu6@pevik>
References: <20221128091508.75414-1-teo.coupriediaz@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221128091508.75414-1-teo.coupriediaz@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 0/1] brk: use direct syscalls
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

> Hello LTP maintainers,

> This patch slightly reworks the brk01 and brk02 tests to use direct
> syscalls with tst_syscall rather than calling through the libc.

> While running LTP on a musl-based distribution, we noticed that the brk
> tests were failing. It turns out that Musl prevents the use of brk
> with their wrapper: it always returns an error.
> This isn't too egregious as using brk is deprecated in favor of malloc
> and it isn't part of POSIX anymore since POSIX.1-2001, but it _is_
> different from glibc's beavior, which allows using it.

> This patch allows proper testing of brk's functionality, independent of
> libc specifics, and thus allows the tests to pass on Musl-based
> distributions like Alpine.

> Do you think this is a correct approach for LTP ?
> From what I could see there are a few tests that use tst_syscall directly
> and it doesn't affect the logic much for brk.

LGTM.

I wonder if it makes sense to add .test_variants [1] for glibc and uclibc,
e.g. for brk01():

void verify_brk(void)
{
	if (tst_variant) {
		tst_res(TINFO, "Testing sbrk()");
		cur_brk = (uintptr_t)sbrk(0);
	} else {
		tst_res(TINFO, "Testing __NR_brk");
		cur_brk = (void *)tst_syscall(__NR_brk, 0);
	}

}

struct tst_test test = {
	...
#ifdef __GLIBC__
	.test_variants = 2,
#else
	.test_variants = 1,
#endif
	...

Not sure if it should be testeed also on android, i.e:
#if defined(__GLIBC__) || defined(__ANDROID__)

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/C-Test-API#130-testing-similar-syscalls-in-one-test

> Green build:
> https://github.com/Teo-CD/ltp/actions/runs/3563193507

> This was discovered in the context of the Morello project[0].
> [0]: https://www.morello-project.org/

> Teo Couprie Diaz (1):
>   syscalls/brk: use direct syscall

>  testcases/kernel/syscalls/brk/brk01.c | 15 ++++++---------
>  testcases/kernel/syscalls/brk/brk02.c | 14 ++++++--------
>  2 files changed, 12 insertions(+), 17 deletions(-)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
