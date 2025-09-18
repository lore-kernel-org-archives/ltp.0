Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D22CA1013
	for <ltp@archiver.kernel.org>; Thu, 18 Sep 2025 14:53:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A81C93CDD33
	for <ltp@archiver.kernel.org>; Thu, 18 Sep 2025 16:53:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 974743CD8D5
 for <ltp@lists.linux.it>; Thu, 18 Sep 2025 16:53:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 07EA91000472
 for <ltp@lists.linux.it>; Thu, 18 Sep 2025 16:53:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 494D31F7E9;
 Thu, 18 Sep 2025 14:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758207217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/rxI2ByYLFmAnip0cQk72ols/WPtB5cqUmnd3HCTSU4=;
 b=OPe+RbtzqBW8/l6Qk9QBUf05kOIH99c6gWq7mMwcUz3OErAdbktVOhuLS8LSMbdEDU+oR0
 GtLORUWPdRf9+5F2yveJy/J2Q+KMsnpVycpDM8xw5RSJAdtHZbgNSPzkrS3bD9mKC0iBOr
 4KwisH89w9L3YdV7TzwkHg8Req338VY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758207217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/rxI2ByYLFmAnip0cQk72ols/WPtB5cqUmnd3HCTSU4=;
 b=ZiKsZbcLVb9mtamUmezBVUSo0i2eQbLHt/sDJYmHnNVbzVluFzcUMZCnGfl7o2o6VqDk3e
 O4ZlmL84U4V6XFAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OPe+Rbtz;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZiKsZbcL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758207217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/rxI2ByYLFmAnip0cQk72ols/WPtB5cqUmnd3HCTSU4=;
 b=OPe+RbtzqBW8/l6Qk9QBUf05kOIH99c6gWq7mMwcUz3OErAdbktVOhuLS8LSMbdEDU+oR0
 GtLORUWPdRf9+5F2yveJy/J2Q+KMsnpVycpDM8xw5RSJAdtHZbgNSPzkrS3bD9mKC0iBOr
 4KwisH89w9L3YdV7TzwkHg8Req338VY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758207217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/rxI2ByYLFmAnip0cQk72ols/WPtB5cqUmnd3HCTSU4=;
 b=ZiKsZbcLVb9mtamUmezBVUSo0i2eQbLHt/sDJYmHnNVbzVluFzcUMZCnGfl7o2o6VqDk3e
 O4ZlmL84U4V6XFAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18BA613A39;
 Thu, 18 Sep 2025 14:53:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dxQzBfEczGgbUAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Sep 2025 14:53:37 +0000
Date: Thu, 18 Sep 2025 16:53:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250918145335.GA432906@pevik>
References: <20250902031236.5719-1-wegao@suse.com>
 <20250902111809.6071-1-wegao@suse.com> <aMAUhpxi1GaDBfGF@yuki.lan>
 <aMDV1aTCZ--ElqfY@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aMDV1aTCZ--ElqfY@localhost>
X-Rspamd-Queue-Id: 494D31F7E9
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,lists.linux.it,gmail.com,redhat.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 TAGGED_RCPT(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ioctl_loop01.c: Use proper device for
 partitioning
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Tue, Sep 09, 2025 at 01:50:30PM +0200, Cyril Hrubis wrote:
> > Hi!
> > >  .../kernel/syscalls/ioctl/ioctl_loop01.c      | 34 ++++++++-----------
> > >  1 file changed, 15 insertions(+), 19 deletions(-)

> > > diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> > > index c9137bf1e..b70e9fc22 100644
> > > --- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> > > +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> > > @@ -78,7 +78,21 @@ static void check_loop_value(int set_flag, int get_flag, int autoclear_field)

> > >  static void verify_ioctl_loop(void)
> > >  {
> > > +	int ret;
> > > +	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
> > > +					"primary", "ext4", "1M", "10M", NULL};
> > > +
> > > +	tst_fill_file("test.img", 0, 1024 * 1024, 10);
> > >  	tst_attach_device(dev_path, "test.img");
> > > +
> > > +	ret = tst_cmd(cmd_parted, NULL, NULL, TST_CMD_PASS_RETVAL);
> > > +	if (!ret)
> > > +		parted_sup = 1;
> > > +	else if (ret == 255)
> > > +		tst_res(TCONF, "parted binary not installed or failed");
> > > +	else
> > > +		tst_res(TCONF, "parted exited with %i", ret);

> > The test should have needs_cmds set to parted (we do that properly in
> > ioctl09.c) then we do not have to handle the 255 exit code here since
> > the test would be skipped if it's missing.

> If we use needs_cmds all the check will be skipped in this case.

@Cyril: only single test require 'parted' as I reported in v1 [1].
Yeah, code gets slightly more complicated just because single test requires
parted. Or you would not care? IMHO it does not make sense to split test into
two (too much duplicity).

But TINFO message should be turned in TCONF so that people notice.
tst_res(TINFO, "Current environment doesn't have parted disk, skip it");

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20250901103805.GA30224@pevik/

> Current test case will still continue do some check even parted is
> missing. Such as following test log:

> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_iocxxPKhg as tmpdir (ext2/ext3/ext4 filesystem)
> tst_test.c:2004: TINFO: LTP version: 20250130-399-g47167e082
> tst_test.c:2007: TINFO: Tested kernel: 6.11.0-1027-oem #27-Ubuntu SMP PREEMPT_DYNAMIC Tue Jul 22 06:12:35 UTC 2025 x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.11.0-1027-oem/build/.config'
> tst_test.c:1825: TINFO: Overall timeout per run is 0h 00m 31s
> tst_device.c:98: TINFO: Found free device 14 '/dev/loop14'
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> ioctl_loop01.c:92: TCONF: parted binary not installed or failed
> ioctl_loop01.c:98: TPASS: /sys/block/loop14/loop/partscan = 0
> ioctl_loop01.c:99: TPASS: /sys/block/loop14/loop/autoclear = 0
> ioctl_loop01.c:100: TPASS: /sys/block/loop14/loop/backing_file = '/tmp/LTP_iocxxPKhg/test.img'
> ioctl_loop01.c:56: TPASS: get expected lo_flag 12
> ioctl_loop01.c:58: TPASS: /sys/block/loop14/loop/partscan = 1
> ioctl_loop01.c:59: TPASS: /sys/block/loop14/loop/autoclear = 1
> ioctl_loop01.c:62: TINFO: Current environment doesn't have parted disk, skip it
> ioctl_loop01.c:104: TINFO: Test flag can be clear
> ioctl_loop01.c:56: TPASS: get expected lo_flag 8
> ioctl_loop01.c:58: TPASS: /sys/block/loop14/loop/partscan = 1
> ioctl_loop01.c:59: TPASS: /sys/block/loop14/loop/autoclear = 0
> ioctl_loop01.c:62: TINFO: Current environment doesn't have parted disk, skip it

> Summary:
> passed   9
> failed   0
> broken   0
> skipped  1
> warnings 0


> > -- 
> > Cyril Hrubis
> > chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
