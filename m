Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914D0606A324
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=ARJ1q+gC;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gZG9MnmF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792511882; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=cbxr0ga4OLwfWlCaAwGW2MGdL5jEuhTe/kzFnH/b8pg=;
 b=ARJ1q+gC+fhZVpMDBv6kQHNx5Suww40TGBy2eWAqSCIrloT25fm/ptq7NrRfBsCoRPee8
 yQB8FpqptVzZrhM6HCSlxMag78aRiHgUXmy+lVq+rObklUxmawU8IsdpNdy9QlE5Cp+2uOH
 giGyIaYAdMkSWzs58w6uud0L9+DtDO4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37B893EAF78
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 17:58:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F9C73E9C8A
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 17:57:43 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B576760012D
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 17:57:42 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso2309379f8f.0
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792511862; x=1793116662; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9cWstJcRL6Lnyx5J+/bwMUhYN/aXT4WY3/5hw+SfxO0=;
 b=gZG9MnmFnTyw617nl7JxA80IsYgG+ElTXgUqPN0b2dzAdDBnp9915X7VHP8z4nwT7j
 JAfYoEBWDG3zB//nzhxAG7K6Glj0okcNnfdccAvek8IFhJ+t6g6HI7Fk8VwYy5JS4/FW
 bxX0xzaR0v+Xr6ttJ67Cb86UVM8Qk3WwkSsPdavjdpeNFSDsmWU4aZoWCTrmB1eEwRVa
 lL4NF4wFZvp5XK0VoZzGnf5udx2Ny3bapwLl7pgpF2qLurUWyAQwRHoqSZdYOUcpzNYy
 8eTNBkyWorIUjS6RIw9P82k6h8C51cgt0h29AquSzc3pkeiC7+y3/uqWZLkfFnajLnNB
 iUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792511862; x=1793116662;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9cWstJcRL6Lnyx5J+/bwMUhYN/aXT4WY3/5hw+SfxO0=;
 b=M90jnKiKd+7m4ihj+FAqxN4bwlZ+fWIS0xzRW99UsrSONGask2pqJMP1XrKTC6vDAF
 DpCf9DavU1yXY9m9t5iHxuVqF3UY4kIAzRmoCCiAWWVd6VXgOkJ0r5jEl48A127wCeHh
 EiME9tcZFAnXi/7GP2tXHNBjWYQwbvY4itPqrYP1MoTpvh595rjpbn44VQkmjvArRmz8
 itQZBw7LygJiRUSeOKMUPOgQQYTYDFib/bgYzNrXaapSejmGw74cT+iPkaLTEnNX2ccq
 Rx5Njt3TZQs9Yu/7eGDPdnkO+4N4bpnti8c8YdC8kSgtB/IOOo90DjjvF4IUXU7dWlzu
 s4vg==
X-Forwarded-Encrypted: i=1;
 AKwUvBylCHZovD3VXcyTzWl7I4EmEa/tBGVP/8gJmNR6sLyNg0iD8wOyz8335Lp3f/IW750PrVQ=@lists.linux.it
X-Gm-Message-State: AFq9FYILsBr6VssUvda5q8gGv3BBoGSSxY9SSY7ojDQmPFT/bGqeRuOJ
 xIikQ8goiqeckGlaxxM9b4Uij2f1rqEPFrMwvgBzgH7Zza09IEItUDEGjY09ffnBxvs=
X-Gm-Gg: AYBFou1uwPhItJ2QeKuDkIPTbv6DFt2HSObRf0A3ffLfT/+zyOWfJxP687tBt1U9Fc7
 WVSctF1MdGsrOVUsWP8vOYlQEO7CCCtzkWGl26mF4TGCaTRKsMT2A/kGGUUt582C++V/BuQFhOw
 YOiAfVenit08DuCwdYsdYxdxSs2wH9JA1q5ld412VdDSX9YdLKkwGBaYfs4oTffZX6+Xkl50j08
 rRVdT1YJP9A3Uvi5CDDFXLrRLFI37Q2cCbDloTgf8FNUMCt5hfL3Kr1eirV5jujEIQJk4ZRd+CY
 4bgbYEFNopBMOtxWu9XsoEqwjZ9THcHmeIHozWXuUkgfTVJOIJx1AdjRGkZNcTcfJzSxzJyb+BP
 3plgaR7xZTIoD10/aVArFeGVu3zm4FNMPqbMMWkGpzm7edvuE4yPzJR0SGB6eaRem6wcrr7ElLV
 kpt6z+xGD/as+9/4wA+xPGChpEv0jYQxFMba2ujeDzFr4ZWACdwWYqzhjkwtE3cEONBgpk4LWqs
 UFgWaMZGlNgy9ZGAWO//JkZQaVfluTTbzRGwB6DlPAWDuY=
X-Received: by 2002:a05:6000:2611:b0:48d:f388:e655 with SMTP id
 ffacd0b85a97d-48e07fbadc7mr25932519f8f.50.1792511861877; 
 Tue, 20 Oct 2026 08:57:41 -0700 (PDT)
Received: from localhost.localdomain (p50918b5c.dip0.t-ipconnect.de.
 [80.145.139.92]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d817d8bsm6255072f8f.24.2026.10.20.08.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:57:41 -0700 (PDT)
Message-ID: <MRK5cObusXaqJv4jNKTdu8wUg2a3NYP1ZRXg@localhost.localdomain>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20261020145301.10110-1-linuxtestproject.agent@gmail.com>
Date: Tue, 20 Oct 2026 15:57:40 +0000
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: fallback fchroot() parameters
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Andrea,
> 
> On 2026-10-20, Andrea Cervesato wrote:
> > lapi: fallback fchroot() parameters
> 
> --- [PATCH 5/14] ---
> 
> > diff --git a/testcases/kernel/syscalls/fchroot/fchroot04.c b/testcases/kernel/syscalls/fchroot/fchroot04.c
> > +	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
> > +		"fchroot() with the FD_FAILFS_ROOT sentinel");
> 
> High: Stop the child if this expectation fails; TST_EXP_PASS records a
> failure but continues execution. For example, root without CAP_SYS_CHROOT
> and without no_new_privs gets EPERM, then mkdir("/foo") can create a
> directory in the real root that tmpdir cleanup never removes. Check
> TST_PASS and exit before executing the absolute-path operations.

Valid

> 
> --- [PATCH 6/14] ---
> 
> > diff --git a/testcases/kernel/syscalls/fchroot/fchroot05.c b/testcases/kernel/syscalls/fchroot/fchroot05.c
> > +	len = readlinkat(procfd, "self/root", buf, sizeof(buf) - 1);
> > +	if (len < 0) {
> > +		tst_res(TFAIL | TTERRNO, "readlinkat() of /proc/self/root");
> 
> Low: TTERRNO still reads the preceding fstatat() error from TST_ERR,
> not readlinkat()'s errno. Wrap readlinkat() in TEST() or
> TST_EXP_POSITIVE() so a failure reports the actual error.
> 

Valid

> --- [PATCH 8/14] ---
> 
> > diff --git a/testcases/kernel/syscalls/fchroot/fchroot07.c b/testcases/kernel/syscalls/fchroot/fchroot07.c
> > +	SAFE_WAIT(NULL);
> 
> High: A successfully executed helper can fail in tst_reinit() while
> reopening its absolute IPC pathname under failfs, before it can publish
> TFAIL through shared memory. SAFE_WAIT(NULL) discards that nonzero exit,
> leaving only the earlier fchroot TPASS and a false pass. Use
> tst_reap_children() to retain child-failure detection.
> 
> > +	if (tst_get_path(CHILD_EXEC, child_path, sizeof(child_path)))
> > +		tst_brk(TCONF, "Couldn't find %s in $PATH", CHILD_EXEC);
> 
> Medium: Make child_path absolute before entering failfs. Despite its API
> comment, tst_get_path() returns ./fchroot07_child when the helper is found
> through an empty or relative PATH component, including the empty component
> inserted by the framework when running from the build directory. This
> tests relative execution and, for a dynamic binary, its interpreter lookup
> rather than the claimed absolute executable lookup.

All failfs assumptions don't make any sense, let's skip these.

> 
> --- [PATCH 12/14] ---
> 
> > diff --git a/testcases/kernel/syscalls/fchroot/fchroot11.c b/testcases/kernel/syscalls/fchroot/fchroot11.c
> > +	.needs_kconfigs = (const char *[]) {
> > +		"CONFIG_USER_NS=y",
> > +		NULL,
> > +	}
> 
> Medium: Gate only the user-namespace subcase, not the entire test.
> Unprivileged failfs entry with no_new_privs works without CONFIG_USER_NS,
> but this descriptor skips its success and lookup checks as well. Keep
> those checks enabled and report TCONF only for the unavailable namespace
> subcase.

Valid

> 
> Verdict - Needs revision
> 
> Pre-existing issue: include/tst_fs.h documents tst_get_path() as returning
> an absolute path, but lib/get_path.c preserves relative PATH entries.

This is a documentation bug

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
