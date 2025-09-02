Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6FDCA0FFE
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 10:44:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2D9B3CD3A8
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 12:44:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA5693CCA65
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 12:44:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2CBD020023F
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 12:44:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 878CF2118F;
 Tue,  2 Sep 2025 10:44:05 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FD1613888;
 Tue,  2 Sep 2025 10:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QLleC3XKtmiDJQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 02 Sep 2025 10:44:05 +0000
Date: Tue, 2 Sep 2025 12:44:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250902104403.GA189155@pevik>
References: <20250901074758.5094-1-wegao@suse.com>
 <20250902031236.5719-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250902031236.5719-1-wegao@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 878CF2118F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl_loop01.c: Use proper device for
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

Hi Wei,

> This is same patch used on ioctl09,the page cache of loop0 can cache old
> version of the partition table which is then used by the partitioning
> code. Fix the problem by calling parted against the loop device directly.

LGTM, thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Link: https://lore.kernel.org/ltp/20250829141932.31997-1-jack@suse.cz/
very nit: Link in kernel commits (and I use this approach) is used for the link
to the patch which was merged (kernel maintainer or here LTP maintainer adds
it).  Linking everything else I would use [1].

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  .../kernel/syscalls/ioctl/ioctl_loop01.c      | 26 +++++--------------
>  1 file changed, 7 insertions(+), 19 deletions(-)

> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> index c9137bf1e..695aaeb0b 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> @@ -78,7 +78,13 @@ static void check_loop_value(int set_flag, int get_flag, int autoclear_field)

>  static void verify_ioctl_loop(void)
>  {
> +	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
> +					"primary", "ext4", "1M", "10M", NULL};
> +
> +	tst_fill_file("test.img", 0, 1024 * 1024, 10);
>  	tst_attach_device(dev_path, "test.img");
> +	SAFE_CMD(cmd_parted, NULL, NULL);

I'll would probably keep the previous approach where the rest of the testing is
now quited:

Now:
...
tst_cmd.c:65: TCONF: Couldn't find 'parted' in $PATH at tst_cmd.c:65

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0

Previously:
ioctl_loop01.c:116: TCONF: parted binary not installed or failed
tst_buffers.c:57: TINFO: Test is using guarded buffers
ioctl_loop01.c:84: TPASS: /sys/block/loop2/loop/partscan = 0
ioctl_loop01.c:85: TPASS: /sys/block/loop2/loop/autoclear = 0
ioctl_loop01.c:86: TPASS: /sys/block/loop2/loop/backing_file = '/tmp/LTP_ioco0FWzP/test.img'
ioctl_loop01.c:56: TPASS: get expected lo_flag 12
ioctl_loop01.c:58: TPASS: /sys/block/loop2/loop/partscan = 1
ioctl_loop01.c:59: TPASS: /sys/block/loop2/loop/autoclear = 1
ioctl_loop01.c:62: TINFO: Current environment doesn't have parted disk, skip it
ioctl_loop01.c:90: TINFO: Test flag can be clear
ioctl_loop01.c:56: TPASS: get expected lo_flag 8
ioctl_loop01.c:58: TPASS: /sys/block/loop2/loop/partscan = 1
ioctl_loop01.c:59: TPASS: /sys/block/loop2/loop/autoclear = 0
ioctl_loop01.c:62: TINFO: Current environment doesn't have parted disk, skip it

Summary:
passed   9
failed   0
broken   0
skipped  1
warnings 0

My point was to add TST_CMD_TCONF_ON_MISSING to the previous call. But I was
wrong, that would work the same (skip whole testing on missing 'parted').

...
>  static void setup(void)
>  {
> -	int ret;
> -	const char *const cmd_parted[] = {"parted", "-s", "test.img", "mklabel", "msdos", "mkpart",
> -	                                  "primary", "ext4", "1M", "10M", NULL};
> -
>  	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
>  	if (dev_num < 0)
>  		tst_brk(TBROK, "Failed to find free loop device");

> -	tst_fill_file("test.img", 0, 1024 * 1024, 10);
> -
> -	ret = tst_cmd(cmd_parted, NULL, NULL, TST_CMD_PASS_RETVAL);
> -	switch (ret) {
> -	case 0:
> -		parted_sup = 1;
> -	break;
> -	case 255:
> -		tst_res(TCONF, "parted binary not installed or failed");
> -	break;
> -	default:
> -		tst_res(TCONF, "parted exited with %i", ret);
> -	break;

Therefore either keeping this, or use if/else equivalent (IMHO more readable):

	ret = tst_cmd(cmd_parted, NULL, NULL, TST_CMD_PASS_RETVAL);
	if (!ret)
		parted_sup = 1;
	else if (ret == 255)
		tst_res(TCONF, "parted binary not installed or failed");
	else
		tst_res(TCONF, "parted exited with %i", ret);

Kind regards,
Petr

> -	}
> -
>  	sprintf(partscan_path, "/sys/block/loop%d/loop/partscan", dev_num);
>  	sprintf(autoclear_path, "/sys/block/loop%d/loop/autoclear", dev_num);
>  	sprintf(backing_path, "/sys/block/loop%d/loop/backing_file", dev_num);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
