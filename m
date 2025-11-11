Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFF5CCFA1A
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 11:15:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B85343CF653
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 12:15:06 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BC773CD14C
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 12:14:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EF8AC600934
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 12:14:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EAB0721D36;
 Tue, 11 Nov 2025 11:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762859689;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G7l35EcfsPDprTxIr3Ss+dc63w+QZV8QJF+N5OjLCB4=;
 b=dGWL2lx/fR8xcNOSo7n7pEdp9Dqd2Gq9gXayaBlNJYmjafVbh4jhjQTzzVGKTs8IDG/Whu
 UdNJeVSXIIrZd3jXCp/pgBpZompGUeY4AJGquVYu1Mf7QhYw7HrOzZBu4Kd7QnLi8Llg3b
 P/9glgoYwRGuOXVXGUbyJw7UbbKCGB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762859689;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G7l35EcfsPDprTxIr3Ss+dc63w+QZV8QJF+N5OjLCB4=;
 b=RgjFZdfF+IhYX2Iirrck0QvxHuoKyOMv91zE7a4hgPAJxhw/qNExHmVTUnCDaBYuwerHCx
 LkrQXhlI/kXdCNCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762859687;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G7l35EcfsPDprTxIr3Ss+dc63w+QZV8QJF+N5OjLCB4=;
 b=Rqt6V5jb/E2ZWI9hgqfKQyxHOzQcJ1DMTriFJ8xj+/r8FjyNQWIil4qok9nE/08pIJPZdr
 tLmtdZgdl9+QUi+AAjhVnAC+nyjxNYly2ID60kxfUvAG+h2rnsy+3dYurJQesw6G0/Em7Y
 3uITT14N1uFL9tm2dtxtmNvqaflwkNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762859687;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G7l35EcfsPDprTxIr3Ss+dc63w+QZV8QJF+N5OjLCB4=;
 b=pr6MoG5H0Pvz6YwvjKxjaC0dmQc40k4zJAbb+ZI2ZicDlWBwxti5d9PaTyAMXJGCQx79yA
 pBfFV7ruIXxXuEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E4F814916;
 Tue, 11 Nov 2025 11:14:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lfbeEKcaE2lMWgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Nov 2025 11:14:47 +0000
Date: Tue, 11 Nov 2025 12:14:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251111111437.GB42156@pevik>
References: <20251107003041.28929-1-wegao@suse.com>
 <20251110024805.31070-1-wegao@suse.com>
 <20251110024805.31070-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251110024805.31070-3-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/3] ioctl_loop01.c: Add new support .needs_cmds
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> @@ -78,23 +78,6 @@ static void check_loop_value(int set_flag, int get_flag, int autoclear_field)

>  static void verify_ioctl_loop(void)
>  {
> -	int ret;
> -	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
> -					"primary", "ext4", "1M", "10M", NULL};
> -
> -	tst_fill_file("test.img", 0, 1024 * 1024, 10);
> -	tst_attach_device(dev_path, "test.img");
> -
> -	ret = tst_cmd(cmd_parted, NULL, NULL, TST_CMD_PASS_RETVAL);
> -	if (!ret)
> -		parted_sup = 1;
> -	else if (ret == 255)
> -		tst_res(TCONF, "parted binary not installed or failed");
> -	else
> -		tst_res(TCONF, "parted exited with %i", ret);
> -
> -	attach_flag = 1;
> -
>  	TST_ASSERT_INT(partscan_path, 0);
>  	TST_ASSERT_INT(autoclear_path, 0);
>  	TST_ASSERT_STR(backing_path, backing_file_path);
> @@ -113,10 +96,23 @@ static void verify_ioctl_loop(void)

>  static void setup(void)
>  {
> +	parted_sup = tst_cmd_present("parted");
> +
> +	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
> +	                                  "primary", "ext4", "1M", "10M", NULL};

FYI unfortunately I'm still able to trigger loop failure on SLES 5.14 based kernel
when looping ioctl_loop01 and ioctl_ficlone02 for a while on both current master
and with this patch (which does not handle the problem).

dmesg:
[ 1101.501003] ioctl_loop01
[ 1101.519346] loop0: detected capacity change from 0 to 20480
[ 1101.664879] loop_reread_partitions: partition scan of loop0 () failed (rc=-16)
[ 1101.705931] blk_update_request: I/O error, dev loop0, sector 20352 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[ 1101.710398] blk_update_request: I/O error, dev loop0, sector 20352 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 1101.710423] __loop_clr_fd: partition scan of loop0 failed (rc=-16)
[ 1101.713612] Buffer I/O error on dev loop0p1, logical block 2288, async page read
[ 1101.774843] blk_update_request: I/O error, dev loop0, sector 20352 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[ 1101.783014] blk_update_request: I/O error, dev loop0, sector 20352 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 1101.787585] Buffer I/O error on dev loop0p1, logical block 2288, async page read
[ 1101.824974] ioctl_ficlone02
[ 1101.827315] loop0: detected capacity change from 0 to 614400
[ 1101.861851] /dev/zero: Can't open blockdev
[ 1101.968916] EXT4-fs (loop0): mounting ext2 file system using the ext4 subsystem
[ 1101.975954] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null). Quota mode: none.
[ 1102.156957] EXT4-fs (loop0): mounting ext3 file system using the ext4 subsystem
[ 1102.163452] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[ 1102.268502] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.

Fortunately Martin is working on a patch for LTP library that'll check for
leftover partitions after loop device release and clear them, with appropriate
TWARN message.

Kind regards,
Petr

> +
>  	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
>  	if (dev_num < 0)
>  		tst_brk(TBROK, "Failed to find free loop device");

> +	tst_fill_file("test.img", 0, 1024 * 1024, 10);
> +
> +	tst_attach_device(dev_path, "test.img");
> +	attach_flag = 1;
> +
> +	if (parted_sup)
> +		SAFE_CMD(cmd_parted, NULL, NULL);
> +
>  	sprintf(partscan_path, "/sys/block/loop%d/loop/partscan", dev_num);
>  	sprintf(autoclear_path, "/sys/block/loop%d/loop/autoclear", dev_num);
>  	sprintf(backing_path, "/sys/block/loop%d/loop/backing_file", dev_num);
> @@ -148,5 +144,9 @@ static struct tst_test test = {
>  		{"linux-git", "6ac92fb5cdff"},
>  		{}
>  	},
> +	.needs_cmds = (struct tst_cmd[]) {
> +		{.cmd = "parted", .optional = 1},
> +		{}
> +	},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
