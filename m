Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB44DC48297
	for <ltp@archiver.kernel.org>; Tue,  6 Feb 2024 18:54:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 700A23CF5EC
	for <ltp@archiver.kernel.org>; Tue,  6 Feb 2024 19:53:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD4EE3CB5FB
 for <ltp@lists.linux.it>; Tue,  6 Feb 2024 19:53:42 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9A57E6025DD
 for <ltp@lists.linux.it>; Tue,  6 Feb 2024 19:53:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 38ABC221BF;
 Tue,  6 Feb 2024 18:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707245618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gx+IkI9RycCqSobq27BN0DddmwGKii+d9K38WXdVViI=;
 b=kbAIEs3wTFW0QUE5ELbeHNS9hRh/vQIua/3cmnj25ioOiY8QtuNPqO5stR2qx1Vhcwd0rk
 oWTK1y4XYKfp47DberB1VMHyG4ApGkscMioVqsW9sScJueSiuzHsz6dX4qTVv6RI5p6UNc
 SbMNZ0U4D6h15SzXyxlUmcraMXEPxJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707245618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gx+IkI9RycCqSobq27BN0DddmwGKii+d9K38WXdVViI=;
 b=CPG6OjyX2pH4ZMI8mQqMBHDL4iKigxFYMwOLsRTOvw26ANi4uEiwlRkdPfjaNoYpizGyEr
 df4Eewx+upOSnqCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707245618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gx+IkI9RycCqSobq27BN0DddmwGKii+d9K38WXdVViI=;
 b=kbAIEs3wTFW0QUE5ELbeHNS9hRh/vQIua/3cmnj25ioOiY8QtuNPqO5stR2qx1Vhcwd0rk
 oWTK1y4XYKfp47DberB1VMHyG4ApGkscMioVqsW9sScJueSiuzHsz6dX4qTVv6RI5p6UNc
 SbMNZ0U4D6h15SzXyxlUmcraMXEPxJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707245618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gx+IkI9RycCqSobq27BN0DddmwGKii+d9K38WXdVViI=;
 b=CPG6OjyX2pH4ZMI8mQqMBHDL4iKigxFYMwOLsRTOvw26ANi4uEiwlRkdPfjaNoYpizGyEr
 df4Eewx+upOSnqCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9521C139D8;
 Tue,  6 Feb 2024 18:53:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1BwZFzGAwmWAGQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 06 Feb 2024 18:53:37 +0000
Date: Tue, 6 Feb 2024 19:53:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Message-ID: <20240206185335.GA51648@pevik>
References: <20240201101603.GA78772@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240201101603.GA78772@pevik>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [5.80 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3]; BAYES_SPAM(5.10)[100.00%];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] TMPDIR minimal size requirement
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

> Hi all,

> recent LTP change 3626124a4 ("fallocate06: Increase test loop device size to
> 1GB") [1] increased requirement on TMPDIR size for syscalls. That hits the size
> of tmpfs we use in openSUSE Tumbleweed on /tmp. While we can workaround easily
> this in openQA framework we use for LTP testing (use TMPDIR=/var/tmp for
> fallocate06 or even for whole runtest syscalls), I wonder if we should have some
> LTP upstream fix.

FYI I see the problem also on fallocate05 on bcachefs, although here it might be
a bug in fallocate05 or in bcachefs, because the test somehow works with ENOTSUP
(there is a code before which checks on ENOTSUP). And I was not able to
reproduce it on similar VM outside of our openQA test framework, it could be our
bug in openQA runner as well.

Kind regards,
Petr

fallocate05.c:136: TPASS: write()
tst_test.c:1701: TINFO: === Testing on bcachefs ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with bcachefs opts='' extra opts=''
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_falBnQfVp/mntpoint fstyp=bcachefs flags=0
tst_fill_fs.c:36: TINFO: Creating file mntpoint/file0 size 21710183
tst_fill_fs.c:36: TINFO: Creating file mntpoint/file1 size 8070086
tst_fill_fs.c:36: TINFO: Creating file mntpoint/file2 size 3971177
tst_fill_fs.c:36: TINFO: Creating file mntpoint/file3 size 36915315
tst_fill_fs.c:36: TINFO: Creating file mntpoint/file4 size 70310993
tst_fill_fs.c:36: TINFO: Creating file mntpoint/file5 size 4807935
tst_fill_fs.c:36: TINFO: Creating file mntpoint/file6 size 90739786
tst_fill_fs.c:36: TINFO: Creating file mntpoint/file7 size 76896492
tst_fill_fs.c:63: TINFO: write(): ENOSPC (28)
fallocate05.c:81: TPASS: write() wrote 131072 bytes
fallocate05.c:102: TINFO: fallocate()d 0 extra blocks on full FS
fallocate05.c:114: TPASS: fallocate() on full FS
fallocate05.c:130: TPASS: fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)
fallocate05.c:134: TFAIL: write(): ENOSPC (28)

> What comes to mi mind, we could use as TMPDIR default /var/tmp (only if it does
> not exists, we would fallback to /tmp). We could also warn against tmpfs use.
> Or at least document on README that although many tests need 300 MB for a block
> device, some tests require more and suggest to use /var/tmp.

> Also, Cyril asked for a patch with minimal device size per filesystem (IMHO
> still would be done). At least for Btrfs and XFS some people complains 300
> MB is not a real testing scenario, therefore if we implement it and use 1 GB
> e.g. for Btrfs and XFS we will hit limits on "low resource" devices.

> Kind regards,
> Petr

> [1] https://github.com/linux-test-project/ltp/commit/3626124a42adfe536af2abff63213fa1ccc63795

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
