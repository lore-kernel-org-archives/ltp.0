Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B5AC02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 12:38:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E706A3C9390
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 13:38:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D74553C2F48
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 13:38:16 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D21D81BC766A
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 13:38:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A0B081F443;
 Fri,  7 Feb 2025 12:38:12 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FFEF139CB;
 Fri,  7 Feb 2025 12:38:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o28oIrT+pWfBGQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 07 Feb 2025 12:38:12 +0000
Date: Fri, 7 Feb 2025 13:38:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z6X-skb0ce8MYUnb@yuki.lan>
References: <20250203220903.399544-1-jmoyer@redhat.com>
 <20250207113726.GB1739723@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250207113726.GB1739723@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: A0B081F443
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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
Cc: Jeff Moyer <jmoyer@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > tst_tmpdir.c:316: TINFO: Using /mnt/fstests/TEST_DIR/ovl-mnt/ltp-hSHEHy5M0s/LTP_aio4q4GMW as tmpdir (overlayfs filesystem)
> > tst_test.c:1888: TINFO: LTP version: 20220121-2271-g91a10df22
> > tst_test.c:1892: TINFO: Tested kernel: vendor kernel
> > tst_test.c:1723: TINFO: Timeout per run is 0h 40m 00s
> > aiocp.c:211: TINFO: Maximum AIO blocks: 65536
> > tst_device.c:551: TINFO: Use BTRFS specific strategy
> > tst_device.c:569: TBROK: BTRFS ioctl failed. Is . on a tmpfs?: ENOTTY (25)
> 
> > The issue is that stat(2) on an overlayfs mount point will return a
> > major device number of 0.  The code assumes this is btrfs, and tries
> > to issue a btrfs-specific ioctl.  When that fails, the final message is
> > printed that suggests this might be tmpfs.
> 
> > I modified the code to use statfs(2) to get the file system type, and
> > use that to determine which file system specific code to call.  Finally, I
> > added code to parse out the upper directory from the overlayfs mount options
> > using libmount.  libmount is part of util-linux, so it should be fairly
> 
> We try to avoid external libraries to help testing kernel on some minimal
> embedded devices. @Cyril: is it ok to drag libmount-devel?

For the base LTP library? I would say no.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
