Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0C6C02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 11:37:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9031C3C9392
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 12:37:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4ECE63C9365
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 12:37:35 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8ED6A266BDA
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 12:37:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BF06921161;
 Fri,  7 Feb 2025 11:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738928251;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L/p/8YHc9wqmWwO61ZVqi9bpniMFil3DKA8NCjFlakU=;
 b=C0LclXwenwQnd4nbymf4+LhE++1GHJJz2BynQeeLvRLDtJcOebZZgu4oWIn5fV2SNlUWd4
 sorfaMGjw6A8t3cJ3yj8bfl7JGZvxLxjzqNiZHwQ6aJE1PUUvZ7bdXmkQ8E7lTtJX3xNHX
 UpbdVJVyhQN2tnp0Wo/xhHlDbQq74l4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738928251;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L/p/8YHc9wqmWwO61ZVqi9bpniMFil3DKA8NCjFlakU=;
 b=f+3rBtcKNRxW0lGgOQ7ZWXWgDHaugzmrTGboJY8CfPZTjVqVCdjhnb0W32e9snWhL8fFFF
 pGfS+arIPvLSF9Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738928251;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L/p/8YHc9wqmWwO61ZVqi9bpniMFil3DKA8NCjFlakU=;
 b=C0LclXwenwQnd4nbymf4+LhE++1GHJJz2BynQeeLvRLDtJcOebZZgu4oWIn5fV2SNlUWd4
 sorfaMGjw6A8t3cJ3yj8bfl7JGZvxLxjzqNiZHwQ6aJE1PUUvZ7bdXmkQ8E7lTtJX3xNHX
 UpbdVJVyhQN2tnp0Wo/xhHlDbQq74l4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738928251;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L/p/8YHc9wqmWwO61ZVqi9bpniMFil3DKA8NCjFlakU=;
 b=f+3rBtcKNRxW0lGgOQ7ZWXWgDHaugzmrTGboJY8CfPZTjVqVCdjhnb0W32e9snWhL8fFFF
 pGfS+arIPvLSF9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A80313694;
 Fri,  7 Feb 2025 11:37:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yG68InvwpWeWBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Feb 2025 11:37:31 +0000
Date: Fri, 7 Feb 2025 12:37:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID: <20250207113726.GB1739723@pevik>
References: <20250203220903.399544-1-jmoyer@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250203220903.399544-1-jmoyer@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] tst_device: add support for overlayfs
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

Hi Jeff, all,

NOTE: 'rm -fv lib/libltp.a' is required to apply the patchset.

Besides it, it does not compile yet:
/usr/bin/ld: cannot find -lltp: No such file or directory
https://lore.kernel.org/ltp/20250207112353.GA1739723@pevik/

> When running ltp-aiodio on an overlay file system, the following error
> occurs:

> tst_tmpdir.c:316: TINFO: Using /mnt/fstests/TEST_DIR/ovl-mnt/ltp-hSHEHy5M0s/LTP_aio4q4GMW as tmpdir (overlayfs filesystem)
> tst_test.c:1888: TINFO: LTP version: 20220121-2271-g91a10df22
> tst_test.c:1892: TINFO: Tested kernel: vendor kernel
> tst_test.c:1723: TINFO: Timeout per run is 0h 40m 00s
> aiocp.c:211: TINFO: Maximum AIO blocks: 65536
> tst_device.c:551: TINFO: Use BTRFS specific strategy
> tst_device.c:569: TBROK: BTRFS ioctl failed. Is . on a tmpfs?: ENOTTY (25)

> The issue is that stat(2) on an overlayfs mount point will return a
> major device number of 0.  The code assumes this is btrfs, and tries
> to issue a btrfs-specific ioctl.  When that fails, the final message is
> printed that suggests this might be tmpfs.

> I modified the code to use statfs(2) to get the file system type, and
> use that to determine which file system specific code to call.  Finally, I
> added code to parse out the upper directory from the overlayfs mount options
> using libmount.  libmount is part of util-linux, so it should be fairly

We try to avoid external libraries to help testing kernel on some minimal
embedded devices. @Cyril: is it ok to drag libmount-devel?

@Jeff: would it be too hard to parse /proc/self/mountinfo (I suppose
/proc/self/mounts is not enough)? I'm looking into libmount code E.e.
mnt_fs_get_option() [1]. Or do you think it would be too fragile to parse it
without libmount?

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/libmount/src/fs.c#n1568

> ubiquitous.  stat(2) is then called on the upper directory to get to the
> underlying device node.

> Review of the series is greatly appreciated.

> Thanks in advance!
> Jeff

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
