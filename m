Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C43C3DA4A
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 05:43:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2148B3D1F21
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 07:43:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A1D73D1EC1
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 07:42:54 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1508C601238
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 07:42:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2EEB1F460;
 Fri,  2 Aug 2024 05:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722577373;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZNYV5JrO2+4rUxmerNibhdblvntIxcZs6a8SNQn2bMY=;
 b=G0DHrjAyW30CBLn2iWSp5IRPFauuzXj/2gOprCvJ86PReSqKrGDR/eSoniJe6Cdr+E65pb
 7h/l0WELCv9b0B7s0p7QG+/fsavy8O/nADHyVplPxrVTD8/P+MThR8FNxyr3lU9oT2+al4
 vv10wJnDYwiaODIXLStlLoOQXc+nMCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722577373;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZNYV5JrO2+4rUxmerNibhdblvntIxcZs6a8SNQn2bMY=;
 b=Ep/AGNQgtl7/bjifSYL2tdTTHqjVaYoozGOcpr36WhtqUg789xVXQyn2HyOmnAmOKfEt3V
 Iv8leMGvlFiSzQDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722577371;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZNYV5JrO2+4rUxmerNibhdblvntIxcZs6a8SNQn2bMY=;
 b=xIj8gYV3BMg1qeMnluj+0wOrI3t1C3+UiazVWt8Zz2pxP2LPlI5oGaFimehtkURAWbjS+H
 tujZ6OgmTmhVNrJpaR33lJeS4FYnA3w9kmygzWoKkco4OQLGomLGgr42THOFFLDeDTOY7o
 Nd0WJLndvDo8ynxV4/HJj2D+vIgXG2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722577371;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZNYV5JrO2+4rUxmerNibhdblvntIxcZs6a8SNQn2bMY=;
 b=4+fEd71Wf2Asgaw0KtiS5/rV94YdZSBmL975dQBLrHdf26kn9OkY26JOxdwrbnu8E/+90u
 xA2w25281Nnm5gBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D03A13998;
 Fri,  2 Aug 2024 05:42:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a1RjIdtxrGZBagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 02 Aug 2024 05:42:51 +0000
Date: Fri, 2 Aug 2024 07:42:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Aleksa Sarai <cyphar@cyphar.com>
Message-ID: <20240802054252.GA1582980@pevik>
References: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
 <20240801165756.GA1526142@pevik>
 <20240802.011554-broke.flocks.valiant.camp-sk9TjsxvPYf@cyphar.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240802.011554-broke.flocks.valiant.camp-sk9TjsxvPYf@cyphar.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[phoronix.com:url,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/5] Add fchmodat2 testing suite
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
Cc: Christian Brauner <brauner@kernel.org>,
 =?iso-8859-2?Q?Ga=EBl?= PORTAY <gael.portay@rtone.fr>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 2024-08-01, Petr Vorel <pvorel@suse.cz> wrote:
> > Hi all,

> > > This is a patch-set that implements fchmodat2() syscall coverage.
> > > fchmodat2() has been added in kernel 6.6 in order to support
> > > AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH in fchmodat().
> > > There's no man pages yet, so please take the following links as
> > > main documentation along with kernel source code:

> > I would hope that it'd be at least Christian's fork [1], but it's not there.
> > I suppose nobody is working on the man page.

> > > https://www.phoronix.com/news/fchmodat2-For-Linux-6.6
> > > https://lore.kernel.org/lkml/20230824-frohlocken-vorabend-725f6fdaad50@brauner/

> > > ***********
> > > * WARNING *
> > > ***********

> > > fchmodat2_02 fails with EOPNOTSUPP because of missing feature.

> > For a record, it's fchmodat2_01.c (from this patchset) which is failing (on
> > 6.10.1-1.g4c78d6f-default Tumbleweed and 6.6.21-0-lts Alpine, both x86_64 VMs).

> > Andrea, I would personally just skip test on EOPNOTSUPP (that's what we do in
> > LTP on EOPNOTSUPP). The question why is not supported and whether is going to be
> > fixed.

> > Looking into glibc change 65341f7bbe ("linux: Use fchmodat2 on fchmod for flags
> > different than 0 (BZ 26401)") one year old change from glibc-2.39 [2] it looks
> > just accepted behavior (glibc returns EOPNOTSUPP on symlink):

> > +  /* Some Linux versions with some file systems can actually
> > +     change symbolic link permissions via /proc, but this is not
> > +     intentional, and it gives inconsistent results (e.g., error
> > +     return despite mode change).  The expected behavior is that
> > +     symbolic link modes cannot be changed at all, and this check
> > +     enforces that.  */
> > +  if (S_ISLNK (st.st_mode))
> > +    {
> >        __close_nocancel (pathfd);
> > -      return ret;
> > +      __set_errno (EOPNOTSUPP);
> > +      return -1;
> > +    }

> > Also musl also behaves the same on his fallback on old kernels [3]
> > (it started 10 years ago on 0dc48244 ("work around linux's lack of flags
> > argument to fchmodat syscall") when SYS_fchmodat was used and kept when this
> > year SYS_fchmodat2 started to be used in d0ed307e):

> > 	int ret = __syscall(SYS_fchmodat2, fd, path, mode, flag);
> > 	if (ret != -ENOSYS) return __syscall_ret(ret);

> > 	if (flag != AT_SYMLINK_NOFOLLOW)
> > 		return __syscall_ret(-EINVAL);

> > 	struct stat st;
> > 	int fd2;
> > 	char proc[15+3*sizeof(int)];

> > 	if (fstatat(fd, path, &st, flag))
> > 		return -1;
> > 	if (S_ISLNK(st.st_mode))
> > 		return __syscall_ret(-EOPNOTSUPP);


> > > According to documentation, the feature has been implemented in
> > > kernel 6.6, but __in reality__ AT_SYMLINK_NOFOLLOW is not working
> > > on symbolic files. Also kselftests, which are meant to test the
> > > functionality, are not working and they are treating fchmodat2()
> > > syscall failure as SKIP. Please take a look at the following code
> > > before reviewing:

> > > https://github.com/torvalds/linux/blob/8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6/tools/testing/selftests/fchmodat2/fchmodat2_test.c#L123

> > I see there is a kselftest workaround in 4859c257d295 ("selftests: Add fchmodat2
> > selftest") [4], where fchmodat2 failure on symlink is simply skipped.

> > Aleksa, you're probably aware of this fchmodat2() failure on symlinks. Does
> > anybody work or plan to work on fixing it? LTP has policy to not cover kernel
> > bugs, if it's not expected to be working we might just skip the test as well.

> If I understand the bug report, the issue is that fchmodat2() doesn't
> work on symlinks?

Yes.

> This is intentional -- Christian fixed a tree-wide bug a while ago[1]
> where some filesystems would change the mode of symlinks despite
> returning an error (usually EOPNOTSUPP) and IIRC a few others would
> happily change the mode of symlinks.

Ah, I've seen this in the past. Thanks a lot for reminding me.

> The current intended behaviour is to always return EOPNOTSUPP, and AFAIK
> there is no plan to re-enable the changing of symlink modes. EOPNOTSUPP
> was chosen because that's what filesystems were already returning.
> (While this is a little confusing, VFS syscalls return EINVAL for an
> unsupported flag, not EOPNOTSUPP.)

> The benefit of an AT_SYMLINK_NOFOLLOW flag is not just to to allow a
> syscall to operate on symlinks, it also allows programs to safely
> operate on path components without worrying about symlinks being
> followed (this is relevant for container runtimes, where we are
> operating on untrusted filesystem roots -- though in the case of
> fchmodat2(2) you would probably just use AT_EMPTY_PATH in practice). So
> an error here is actually what you want as a program that uses
> AT_SYMLINK_NOFOLLOW (since the actual operation is intentionally not
> supported by filesystems).

Thanks a lot for explaining the background!

> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d1f903f75a80daa4dfb3d84e114ec8ecbf29956

> > I see a RFC UAPI related patchset [5] which touches include/uapi/linux/fcntl.h,
> > but AFAIK it's not related to this problem.

> Yeah this is unrelated, that patch is about clarifying how AT_* flags
> are allocated, not syscall behaviour.

Thanks!

> > Kind regards,
> > Petr

@Andrea, I guess we want something like this:

+++ testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
@@ -43,9 +43,10 @@ static void test_symbolic_link(void)
 	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
 	verify_mode(fd_dir, SNAME, S_IFLNK | 0777);
 
-	TST_EXP_PASS(fchmodat2(fd_dir, SNAME, 0640, AT_SYMLINK_NOFOLLOW));
-	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
-	verify_mode(fd_dir, SNAME, S_IFLNK | 0640);
+	if (tst_kvercmp(6, 6, 0) >= 0) {
+		TST_EXP_FAIL(tst_syscall(__NR_fchmodat2, fd_dir, SNAME, 0640,
+					 AT_SYMLINK_NOFOLLOW), EOPNOTSUPP);
+	}
 }
 
 static void test_empty_folder(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
