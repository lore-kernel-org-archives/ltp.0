Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E46C67861
	for <ltp@archiver.kernel.org>; Tue,  9 Apr 2024 10:18:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AC3D3CF66F
	for <ltp@archiver.kernel.org>; Tue,  9 Apr 2024 12:18:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B28363C00E4
 for <ltp@lists.linux.it>; Tue,  9 Apr 2024 12:18:04 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 238B9100E339
 for <ltp@lists.linux.it>; Tue,  9 Apr 2024 12:18:01 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 48BC833920;
 Tue,  9 Apr 2024 10:17:59 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2284313253;
 Tue,  9 Apr 2024 10:17:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id gU9eBtcVFWZjUQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 09 Apr 2024 10:17:59 +0000
Date: Tue, 9 Apr 2024 12:17:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: samasth.norway.ananda@oracle.com
Message-ID: <20240409101753.GA107959@pevik>
References: <20240401150015.301640-1-samasth.norway.ananda@oracle.com>
 <Zg_oLGuLcssY-rYY@yuki>
 <e2368059-647c-4d98-8c90-2cc5f3bb34a4@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e2368059-647c-4d98-8c90-2cc5f3bb34a4@oracle.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 48BC833920
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mremap06: fallocate is not supported on nfsv3
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
Cc: calum.mackay@oracle.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On 4/5/24 5:01 AM, Cyril Hrubis wrote:
> > Hi!
> > > The function fallocate() is not supported on nfsv3. Thus when we run the
> > > mremap06 test over a nfsv3 filesystem the test fails.

> > Can we rather than this just skip the test on nfsv3?

> > If we want to skip the test on nfs in generall we can just set
> > .skip_filesystems = {"nfs", NULL} in the tst_test structure.

> > I'm not sure if we can easily detect the nfs version. The test library
> > does that by checking the NFS_SUPER_MAGIC againts stat, but there is a
> > single SUPER_MAGIC for all nfs versions.

Yeah, include/uapi/linux/magic.h in kernel contains only single magic. BTW I
wonder if magic is stored to the disk or there is some other complication which
prevent to have more magic values which would allow to distinguish version.

I wonder if it makes sense to add support to detect NFS version (read vers
parameter in /proc/mounts). The only reason why to do that would be to make sure
NFS v4.2 did not lost fallocate support by bug/regression. If we don't care,
checking errno is better option (will reflect kernel changes without a need to
adapt LTP test).

> > So if we want to keep the test enabled for nfsv4 we can exit with TCONF
> > when the call fails only when we are on NFS with tst_fs_type() and check
> > that against TST_NFS_MAGIC.


> Hi Cyril,

> Wanted to mention that fallocate() is only supported over NFSv4.2 in
> particular. it's not supported over NFSv3, v4.0 or v4.1.
> I could even see on the fallocate ltp tests that it is handled the same
> manner.

Yeah, these tests have it:
testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate01.c
testcases/kernel/mem/hugetlb/hugefallocate/hugefallocate02.c
testcases/kernel/syscalls/fallocate/fallocate01.c
testcases/kernel/syscalls/fallocate/fallocate02.c
testcases/kernel/syscalls/fallocate/fallocate03.c
testcases/kernel/syscalls/fallocate/fallocate04.c

I guess we should write SAFE_FALLOCATE(). @Samasth any change you would write
it (as a separate effort).

> Thanks,
> Samasth.

> > > Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> > > ---
> > >   testcases/kernel/syscalls/mremap/mremap06.c | 8 +++++++-
> > >   1 file changed, 7 insertions(+), 1 deletion(-)

> > > diff --git a/testcases/kernel/syscalls/mremap/mremap06.c b/testcases/kernel/syscalls/mremap/mremap06.c
> > > index 3bbaf441a..362b03e19 100644
> > > --- a/testcases/kernel/syscalls/mremap/mremap06.c
> > > +++ b/testcases/kernel/syscalls/mremap/mremap06.c
> > > @@ -104,8 +104,14 @@ static void setup(void)
> > >   	fd = SAFE_OPEN("testfile", O_CREAT | O_RDWR | O_TRUNC, 0600);
> > >   	ret = fallocate(fd, 0, 0, mmap_size);
> > > -	if (ret == -1)
> > > +	if (ret != 0) {
> > > +		if (errno == EOPNOTSUPP || errno == ENOSYS) {
> > > +			tst_brk(TCONF,
> > > +				"fallocate system call is not implemented");
> > > +		}
> > >   		tst_brk(TBROK, "fallocate() failed");
> > > +		return;

I suggest to merge this now, without return (it can be removed before merge).
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
