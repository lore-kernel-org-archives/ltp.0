Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B3ECA5FC5
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 13:46:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AC883E5688
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 15:46:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 772D63C5493
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 15:45:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DCCB11400156
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 15:45:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EEE4321E24;
 Wed, 30 Sep 2026 13:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790775940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KDPKJNY4nGDcQrm8QFqs9dc1CXKXS9kyEdggy/OK2bQ=;
 b=fS5W2SRggj92/OiiNTU44nU/hH8c2pCWh/GQYZOqjD77D042H0rLDlQlhI4NbE524ZSd4a
 6ftNHtE9Do17OeU2Q++SCk0TNJgQW4AuqqSEtdwU1LMYV5ueGbDxt7et7XcPClPJ5nv+n6
 EuP3X/WboeRZqkqqHEUjOVgYtrgo2Yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790775940;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KDPKJNY4nGDcQrm8QFqs9dc1CXKXS9kyEdggy/OK2bQ=;
 b=MSyvrlFytpIh0F7BBYjXUaFr/bbMp4sNuWGvPzbkGw2PNsBc9ZRsiyZrVrvFmR+5h8PCua
 4Tl1Y1uQcsEIjGCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ssxY/9zI";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="iyMVvw/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790775936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KDPKJNY4nGDcQrm8QFqs9dc1CXKXS9kyEdggy/OK2bQ=;
 b=ssxY/9zI+lnUGH9+thrasspwaDk24lv4vBEdnk7OLnqmYDAZO4Pf3VjPh6xowWTDSGdkES
 +WkhBUfKCugxpL9oMjVfBn05sYk2xsLuczfK+NPt/0+Lx1S8cE4FJWZZ0EukxcjPLX9vWv
 fSm/ZE0h+jdZohVcTEC1hD3cE8HoBE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790775936;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KDPKJNY4nGDcQrm8QFqs9dc1CXKXS9kyEdggy/OK2bQ=;
 b=iyMVvw/HcCNOL3KUnm1WVotr71wsna8B8brYl21cY60YjVRMB3Hx9Fv8k3a/tUkVIqIz2V
 7obFfW+gGeTSGxCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF9FD13722;
 Wed, 30 Sep 2026 13:45:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e03EJX8SvWqFRwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Wed, 30 Sep 2026 13:45:35 +0000
Message-ID: <8055a421-c46e-4566-bc42-d1e1a08b4d2b@suse.cz>
Date: Wed, 30 Sep 2026 15:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260930-fix_epoll_bpf-v2-1-c1ac22e73b8c@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20260930-fix_epoll_bpf-v2-1-c1ac22e73b8c@suse.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EEE4321E24
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:email,suse.cz:dkim,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] epoll_ctl06: Fix BPF map on old kernels
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
look good to me.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 9/30/26 09:23, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> BPF map file descriptors gained a poll callback in upstream kernel
> 5.8. Without that callback, EPOLL_CTL_ADD fails with EPERM, while the
> test expected it to succeed.
> 
> Detect BPF map poll support at runtime so that older kernels with
> backported support are handled correctly as well.
> 
> Fixes: c4c0ca4c749e ("syscalls: Add epoll_ctl06")
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> tst_tmpdir.c:309: TINFO: Using /var/tmp/LTP_epoXsyHnT as tmpdir (btrfs filesystem)
> tst_test.c:2067: TINFO: LTP version: 20260529
> tst_test.c:2070: TINFO: Tested kernel: 4.4.140-491.1.TDC.gedc1884-default #1 SMP Wed Sep 23 11:06:41 UTC 2026 (edc1884) x86_64
> tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:760: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
> tst_test.c:1897: TINFO: Overall timeout per run is 0h 02m 00s
> epoll_ctl06.c:57: TPASS: epoll_ctl() on file : EPERM (1)
> epoll_ctl06.c:57: TPASS: epoll_ctl() on O_PATH file : EBADF (9)
> epoll_ctl06.c:57: TPASS: epoll_ctl() on directory : EPERM (1)
> epoll_ctl06.c:57: TPASS: epoll_ctl() on /dev/zero : EPERM (1)
> epoll_ctl06.c:57: TPASS: epoll_ctl() on /proc/self/maps : EPERM (1)
> epoll_ctl06.c:57: TPASS: epoll_ctl() on pipe read end passed
> epoll_ctl06.c:57: TPASS: epoll_ctl() on pipe write end passed
> epoll_ctl06.c:57: TPASS: epoll_ctl() on unix socket passed
> epoll_ctl06.c:57: TPASS: epoll_ctl() on inet socket passed
> epoll_ctl06.c:57: TPASS: epoll_ctl() on epoll passed
> epoll_ctl06.c:57: TPASS: epoll_ctl() on eventfd passed
> epoll_ctl06.c:57: TPASS: epoll_ctl() on signalfd passed
> epoll_ctl06.c:57: TPASS: epoll_ctl() on timerfd passed
> tst_fd.c:144: TCONF: pidfd_open(): ENOSYS (38)
> epoll_ctl06.c:57: TPASS: epoll_ctl() on fanotify passed
> epoll_ctl06.c:57: TPASS: epoll_ctl() on inotify passed
> epoll_ctl06.c:57: TPASS: epoll_ctl() on userfaultfd passed
> epoll_ctl06.c:57: TPASS: epoll_ctl() on perf event passed
> tst_fd.c:200: TCONF: Skipping io uring: ENOSYS (38)
> epoll_ctl06.c:57: TFAIL: epoll_ctl() on bpf map failed: EPERM (1)
> tst_fd.c:225: TCONF: Skipping fsopen: ENOSYS (38)
> tst_fd.c:234: TCONF: Skipping fspick: ENOSYS (38)
> tst_fd.c:243: TCONF: Skipping open_tree: ENOSYS (38)
> epoll_ctl06.c:57: TPASS: epoll_ctl() on memfd : EPERM (1)
> tst_fd.c:261: TCONF: Skipping memfd secret: ENOSYS (38)
> 
> Summary:
> passed   18
> failed   1
> broken   0
> skipped  6
> warnings 0
> ---
> Changes in v2:
> - skip after 5.8 kernel
> - Link to v1: https://lore.kernel.org/20260929-fix_epoll_bpf-v1-1-39b19ab043c7@suse.com
> ---
>   testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c
> index 69321582f..9c6cd2460 100644
> --- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c
> +++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c
> @@ -12,19 +12,23 @@
>    * poll file operation are expected to succeed. The rest must fail with:
>    *
>    * - EPERM for fds that are valid but lack poll support (regular files,
> - *   directories, /dev/zero, /proc files, memfd).
> + *   directories, /dev/zero, /proc files, memfd and BPF maps on kernels
> + *   without BPF map poll support).
>    * - EBADF for fds that are not usable for I/O (O_PATH, open_tree).
>    */
>   
> +#include <poll.h>
>   #include <sys/epoll.h>
>   
>   #include "tst_test.h"
>   #include "tst_epoll.h"
>   #include "tst_fd.h"
>   
> -static int exp_errno(enum tst_fd_type type)
> +static int exp_errno(struct tst_fd *fd)
>   {
> -	switch (type) {
> +	struct pollfd pfd = {.fd = fd->fd, .events = POLLIN};
> +
> +	switch (fd->type) {
>   	case TST_FD_FILE:
>   	case TST_FD_DIR:
>   	case TST_FD_DEV_ZERO:
> @@ -37,6 +41,16 @@ static int exp_errno(enum tst_fd_type type)
>   	case TST_FD_PATH:
>   	case TST_FD_OPEN_TREE:
>   		return EBADF;
> +	case TST_FD_BPF_MAP:
> +		if (tst_kvercmp(5, 8, 0) >= 0)
> +			return 0;
> +
> +		/*
> +		 * The BPF poll callback returns POLLERR for array maps. Without
> +		 * the callback, poll() returns the default readiness mask.
> +		 */
> +		SAFE_POLL(&pfd, 1, 0);
> +		return pfd.revents & POLLERR ? 0 : EPERM;
>   	default:
>   		return 0;
>   	}
> @@ -50,7 +64,7 @@ static void run(void)
>   	TST_FD_FOREACH(fd) {
>   		efd = SAFE_EPOLL_CREATE1(0);
>   		ev.data.fd = fd.fd;
> -		err = exp_errno(fd.type);
> +		err = exp_errno(&fd);
>   
>   		TST_EXP_PASS_OR_FAIL(epoll_ctl(efd, EPOLL_CTL_ADD,
>   				 fd.fd, &ev), err,
> 
> ---
> base-commit: 1cbe713ca9d55bed7e4d52c6f2216ba3e2089346
> change-id: 20260929-fix_epoll_bpf-5e472da8e63c
> 
> Best regards,
> --
> Andrea Cervesato <andrea.cervesato@suse.com>
> 
> 


-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
