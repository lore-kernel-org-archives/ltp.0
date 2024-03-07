Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38388C54798
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 01:44:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0D3B3D1CCF
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 02:44:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 631F13CC129
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 02:43:51 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A25B9140077F
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 02:43:49 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 414235D851;
 Thu,  7 Mar 2024 21:33:37 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 188AE132A4;
 Thu,  7 Mar 2024 21:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id oc10BLEy6mXaNQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 07 Mar 2024 21:33:37 +0000
Date: Thu, 7 Mar 2024 22:33:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240307213335.GA211890@pevik>
References: <20240306104609.17141-1-wegao@suse.com>
 <6285aaad-79ca-4d7c-8be0-6d846d165df2@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6285aaad-79ca-4d7c-8be0-6d846d165df2@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 414235D851
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] chdir01.c: set umask to 0 within setup
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

Hi Martin, all,

> Hi,
> you're trying to fix a vfat mount quirk. We should fix that in the LTP
> library instead, e.g. by setting umask(0) and then restoring the original
> value inside safe_mount().

This makes sense. FYI Wei first tried to adjust umask globally for all tests in
the do_setup() [1], which I worried it would influence tests.

Later Li fixed problem in cgroup tests [2]. This is obviously more general
solution, Wei please send a patch for it and to the commit message
Suggested-by: Martin Doucha <mdoucha@suse.cz>

While we are fixing issues caused by too restrictive umask (Wei fixed e.g.
statx07 [3]), just to let you know that some failures are kernel failures (at
least creat09 which uses all_filesystems, had bug on XFS [4], which got fixed
in the kernel).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20240219134845.22171-1-wegao@suse.com/
[2] https://github.com/linux-test-project/ltp/commit/50626b4a1d01caacd418156ec997853bd4a9fc39
[3] https://github.com/linux-test-project/ltp/commit/d95f453ac624dc159d3acddb62eadeb9a8215f0e
[4] https://lore.kernel.org/ltp/62343BF2.1020006@fujitsu.com/

> On 06. 03. 24 11:46, Wei Gao via ltp wrote:
> > When system's default umask is 0077, this will trigger following issues:
> > chdir01.c:100: TFAIL: nobody: chdir("subdir") returned unexpected value -1: EACCES (13)

> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >   testcases/kernel/syscalls/chdir/chdir01.c | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)

> > diff --git a/testcases/kernel/syscalls/chdir/chdir01.c b/testcases/kernel/syscalls/chdir/chdir01.c
> > index d50a8f50c..97a707199 100644
> > --- a/testcases/kernel/syscalls/chdir/chdir01.c
> > +++ b/testcases/kernel/syscalls/chdir/chdir01.c
> > @@ -56,12 +56,15 @@ static struct test_case {
> >   static void setup(void)
> >   {
> > +	mode_t old_umask = umask(0);
> > +
> > +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);Hi,
> > +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);
> > +
> >   	char *cwd;
> >   	int fd;
> >   	struct stat statbuf;
> > -	umask(0);
> > -
> >   	cwd = SAFE_GETCWD(NULL, 0);
> >   	workdir = SAFE_MALLOC(strlen(cwd) + strlen(MNTPOINT) + 2);
> >   	sprintf(workdir, "%s/%s", cwd, MNTPOINT);
> > @@ -89,6 +92,7 @@ static void setup(void)
> >   	if (!ltpuser)
> >   		ltpuser = SAFE_GETPWNAM(TESTUSER);
> > +	umask(old_umask);
> >   }
> >   static void check_result(const char *user, const char *name, int retval,
> > @@ -146,13 +150,14 @@ static void cleanup(void)
> >   {
> >   	SAFE_CHDIR("..");
> >   	free(workdir);
> > +	SAFE_UMOUNT(MNTPOINT);
> >   }
> >   static struct tst_test test = {
> >   	.needs_root = 1,
> > -	.mount_device = 1,
> >   	.mntpoint = MNTPOINT,
> >   	.all_filesystems = 1,
> > +	.needs_device = 1,
> >   	.test = run,
> >   	.tcnt = ARRAY_SIZE(testcase_list),
> >   	.setup = setup,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
