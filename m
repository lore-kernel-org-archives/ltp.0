Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA243C47DB3
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 19:01:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F8B93CF922
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 20:01:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 682923CC765
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 20:01:26 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 66CB01BBCF1D
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 20:01:25 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C4E51F7E1;
 Wed, 31 Jan 2024 19:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706727684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7HtKSXOid3ks6UJ1TFN7LXfWmwvaYO+t7QqIIGQyHVk=;
 b=EQ4OHSkVamOOncNv5JtNOVkPKK94lK+UFNz2p5eaB7mU7sG/h8uKPThx/AgVwK0VP79ygM
 sZ0eqqBQjtP3WEONPrFBManA0yPCWTWOUR0n1ZduMYmZNOjLIyn/CerI5+UmB7PYNk8SUI
 h+XtBdpt1/1OjArobkRO7k/nJXQZ3QU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706727684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7HtKSXOid3ks6UJ1TFN7LXfWmwvaYO+t7QqIIGQyHVk=;
 b=/Cyav8NxzZaUqZQsILdFDKM1aI/EveBqPVZGNsUBjgMLfCCucOCqMIiKUU+KmxdqS+T+r1
 Z7rcaVhbaJXtG5AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706727684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7HtKSXOid3ks6UJ1TFN7LXfWmwvaYO+t7QqIIGQyHVk=;
 b=EQ4OHSkVamOOncNv5JtNOVkPKK94lK+UFNz2p5eaB7mU7sG/h8uKPThx/AgVwK0VP79ygM
 sZ0eqqBQjtP3WEONPrFBManA0yPCWTWOUR0n1ZduMYmZNOjLIyn/CerI5+UmB7PYNk8SUI
 h+XtBdpt1/1OjArobkRO7k/nJXQZ3QU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706727684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7HtKSXOid3ks6UJ1TFN7LXfWmwvaYO+t7QqIIGQyHVk=;
 b=/Cyav8NxzZaUqZQsILdFDKM1aI/EveBqPVZGNsUBjgMLfCCucOCqMIiKUU+KmxdqS+T+r1
 Z7rcaVhbaJXtG5AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 38B49132FA;
 Wed, 31 Jan 2024 19:01:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id Ti0+CwSZumWdLQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 19:01:24 +0000
Date: Wed, 31 Jan 2024 20:01:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
Message-ID: <20240131190122.GB30901@pevik>
References: <20240131102514.2739270-1-liwang@redhat.com>
 <20240131102514.2739270-8-liwang@redhat.com>
 <20240131173840.GA18869@pevik> <20240131185310.GA30901@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240131185310.GA30901@pevik>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EQ4OHSkV;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/Cyav8Nx"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 6C4E51F7E1
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Patch v6 7/8] swapon/off: enable all_filesystem in swap
 test
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

Hi Li,

also I got failures on ppc64le in our CI

* swapoff01 6.7.2 and other versions up to 4.12 based kernels on ppc64le
...
tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
tst_test.c:1701: TINFO: === Testing on ext2 ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swazu2fTl/mntpoint fstyp=ext2 flags=0
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
libswap.c:146: TBROK: Failed to create swapfile

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0
### TEST swapoff01 COMPLETE >>> 2.

* swapon03 on 6.7.2 on ppc64le
...
tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
tst_test.c:1701: TINFO: === Testing on ext2 ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaT8ZD57/mntpoint fstyp=ext2 flags=0
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
Failed to create swapfile: swapfile02
swapon03.c:180: TFAIL: Failed to setup swaps

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0

* swapon03 on very old kernels (>= 4.4)
...
tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
tst_test.c:1701: TINFO: === Testing on ext2 ===
tst_test.c:1118: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.42.11 (09-Jul-2014)
tst_test.c:1132: TINFO: Mounting /dev/loop0 to /tmp/LTP_swahOeodw/mntpoint fstyp=ext2 flags=0
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
libswap.c:37: TINFO: FS_NOCOW_FL attribute set on swapfile02
Failed to create swapfile: swapfile02
swapon03.c:180: TFAIL: Failed to setup swaps

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0

All other tests are working.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
