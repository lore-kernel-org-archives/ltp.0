Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A977C5AC82
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 12:02:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11BA83CF78E
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 14:02:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0162F3C0224
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 14:02:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0F9731A00375
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 14:02:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA7DB3E04;
 Mon, 10 Aug 2026 12:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786363338;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p2dqE6yZjQghQAddsn+b97vMQ77/G9dcBxg7KRKDnIY=;
 b=UIJH7uJfH34pKBBgBcjgq4zWLKsZzTQ/09fdPEJ34vSTjQqGwdeGWrLlv39943v62djsFD
 11rFvwzFKGSK5lYPX2lYFXKizKhE8iDLbDMhqMfWoKGgD3Xn58CvXtDOBIAuJALV4OnKJ3
 EB38CNcGfs7pMtX6BQ1L+E9r/OczObQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786363338;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p2dqE6yZjQghQAddsn+b97vMQ77/G9dcBxg7KRKDnIY=;
 b=VTL1kS0h74ARtssE5MUtCHi0u+AGZOIhmwJKLHTN/jHGnxLC7Xy9UxxUwaGRmaflUPyo3D
 hBkgFGGVufytVYCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="zClN9f/S";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1cMLWN+4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786363334;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p2dqE6yZjQghQAddsn+b97vMQ77/G9dcBxg7KRKDnIY=;
 b=zClN9f/SLa4LqR/Xsiuj/Rv0ns/+LI2zUdlMAXJVyFwEQDYbc6V12fTp4aqui0NAKhzTP/
 UOhey4sDxiW0RrqIfWjGHUxA+19EV3uI803s9q2xonRusnmfW0n/6adt0LnEbPLIWMHN/x
 oJ1lcJ/li4x3vUEnxpcxajQUXja7PyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786363334;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p2dqE6yZjQghQAddsn+b97vMQ77/G9dcBxg7KRKDnIY=;
 b=1cMLWN+40euaSK9mytZXqDXloqvJxfmTCQPXKIH9C2Rw5GwEeYRiJIWzhi5oWQp1LThMgN
 Drih5dkhLaNHKyBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67E4A779B2;
 Mon, 10 Aug 2026 12:02:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7YnFFMa9eWriQAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 12:02:14 +0000
Date: Mon, 10 Aug 2026 14:02:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260810120208.GE918586@pevik>
References: <20260805151451.648990-2-pvorel@suse.cz>
 <20260805173540.9276-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260805173540.9276-1-linuxtestproject.agent@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AA7DB3E04
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; DKIM_TRACE(0.00)[suse.cz:+];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_kvercmp: Factor out error handling
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

Hi all,

> Hi Petr,

> On Aug 5, 2026, Petr Vorel wrote:
> > tst_kvercmp: Factor out error handling

> --- [PATCH 1/9] ---

> > static int _tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)

> Could this be renamed to parse_kver? File-scope identifiers beginning with an
> underscore are reserved by C, and LTP's coding rules prohibit such names.

I thought this is wrong, because we have functions with underscore, but it's
trailing underscore, not the leading one.

=> I'll rename to tst_parse_kver_().

Also, agent does not know about LTP rule to have functions in lib with leading
tst_.

> --- [PATCH 2/9] ---

> > This is a preparation for struct tst_test max_kver member in the next
> > commit.

> Could the motivation be stated without referring to the next patch? Each
> commit message should stand on its own rather than depend on series position.

Well, we try to split code into commits to be easily revieweable. With that
sometimes is hard to avoid referring to commits. Preparation for other changes
separated into it's own commit helps is an explanation itself.

=> Consider as irrelevant.

> --- [PATCH 4/9] ---

> > 	if (TST_RET != -1) {
> > 		tst_res(TFAIL, "creat() succeeded unexpectedly");
> > 		return;
> > 	}

> Could this path kill and reap pid before returning? Removing the version gate
> makes it reachable on affected 6.11 and 6.12 kernels, but the child remains
> paused indefinitely. The framework then blocks in tst_reap_children() until
> the watchdog terminates the test instead of returning the intended TFAIL.

=> Indeed, this is bug for creat07.c, at least on SLE16 kernel which is based on 6.12,
where test hangs until timeouts on:

creat07.c:43: TFAIL: creat() succeeded unexpectedly

I guess I'll simply use goto to do the needed cleanup:

+++ testcases/kernel/syscalls/creat/creat07.c
@@ -41,7 +41,7 @@ static void verify_creat(void)

        if (TST_RET != -1) {
                tst_res(TFAIL, "creat() succeeded unexpectedly");
-               return;
+               goto kill;
        }

        if (TST_ERR == ETXTBSY)
@@ -49,6 +49,7 @@ static void verify_creat(void)
        else
                tst_res(TFAIL | TTERRNO, "creat() failed unexpectedly");

+kill:
        SAFE_KILL(pid, SIGKILL);
        SAFE_WAITPID(pid, NULL, 0);
 }
---

execve04.c simply fails on that kernel which is IMHO correct (not hiding bugs):
execve_child.c:27: TFAIL: execve_child shouldn't be executed

> > 	TEST(execve(TEST_APP, argv, environ));

> How is the writer child released when execve() succeeds on an affected
> kernel? The test process is replaced by execve_child, which reports TFAIL and
> exits, while the writer remains blocked in TST_CHECKPOINT_WAKE_AND_WAIT(0) and
> becomes an orphan.

I hope the above patch fixes that. Shouldn't be this fixed separately
(regardless on a removed .min_kver), it can be problematic on any kernel
version.

> --- [PATCH 5/9] ---

> > 	.max_kver = "7.1",

> Could the test keep running and only adjust the expected result of
> FAN_REPORT_PIDFD | FAN_REPORT_TID on kernels supporting thread pidfds? This
> test-wide limit also removes the
> FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME case on 7.2 and all
> newer kernels, and that exact combination is not tested elsewhere in LTP.

No, we agreed, this is ok (I'm explaining this second time and I suppose I will
have to do it on all patchset versions I'll send).

> --- [PATCH 6/9] ---

> > 	.min_kver = "4.4",
> > 	.max_kver = "5.0",

> How can this exercise do_test() on current CI kernels? The current kernel must
> lie between the bounds; min_kver being less than max_kver is not sufficient.
> With this maximum, including on stable 7.2, the self-test only reports TCONF
> and never tests the new success path.

I deliberately wanted to get TCONF on the current kernel, i.e. the fact than
using both will result in TCONF not in TBROK. Also, it does not matter if the
test TCONF due old version or run and then TPASS, it's about testing library
setup() run with .min_kver and .max_kver (test itself does nothing). Also any
kernel version will sooner later be old and thus TCONF, why not to do it now?
Not it's also a test that any old version will just TCONF not TBROK. I try to
document it better in the test.

> --- [PATCH 7/9] ---

> > int tst_kver_cmp(int a1, int a2, int a3, int b1, int b2, int b3);

> Could the new public function's kernel-doc include a Return: section
> describing the comparison result?

Commit will be removed in the next version.

> > This will be heavily used in metaparse.c (speedup of metadata
> > generation) in the next commit.

> Could this motivation be stated without referring to the next patch? Each
> commit message should stand on its own.

> --- [PATCH 8/9] ---

> > Will be used for metadata.c in the next commit.

> Could the commit message instead explain why host targets need access to
> MAKE_DEPS without depending on a later patch?

Commit will be removed in the next version.

> --- [PATCH 9/9] ---

> > metaparse: HOST_LDLIBS		+= -lltp

> How can this work for a cross-compilation? metaparse is built with HOSTCC, but
> -lltp resolves to lib/libltp.a built with the target CC, so the host linker
> cannot consume the archive. Could the version helper be compiled with HOSTCC,
> or moved into an architecture-independent host library?

Commit will be removed in the next version.

> Verdict - Needs revision

> ---
> Note:

> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.

> Regards,
> LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
