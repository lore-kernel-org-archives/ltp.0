Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC9EC83F1A
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 12:04:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB2FE3CB078
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 14:04:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 757503C2F9D
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 14:04:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5A30E200262
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 14:04:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8DEB91F38C;
 Fri, 11 Jul 2025 12:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752235448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mTTM+Q9RMy1N95U9RKuk42zJd8VbcYukjbUjdMjtyhE=;
 b=v7bZ4my8aeUmeOtkQhGk1vETKQ+c2JpGY8Wn5I8QgRdK2P08UJxrNtbWhUfL98PWOETMxw
 rPEj8PMWhtWoWACWt6d3XXCxjXPdmZVfZtC+AxMHiOIMBPiEWPHn23cM1rvg0ODihuMOih
 EmWiaacz+CSfmHP/ujZZ5iILT7qu+pM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752235448;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mTTM+Q9RMy1N95U9RKuk42zJd8VbcYukjbUjdMjtyhE=;
 b=S/PpnRiycP9wiy2U/1cI3iezVow2DYCnrvTWIldGZzVbDCcd9ACULVcfFIVj89MUQzuHtH
 9AN8Tte1TC1vcuCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wFJugbTQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IIz8OvPB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752235447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mTTM+Q9RMy1N95U9RKuk42zJd8VbcYukjbUjdMjtyhE=;
 b=wFJugbTQYCyM1xzFc1fQCcpvMzyHgrfAbfggnVxAdt7ITGqvnK9ENjH5kuHiYGyMipuKwh
 GLqSzrP/DI15XET05tsTCRk9UFJdVCivde146tC/M6OCLV3R+NeLSYSwA4LS0jllJz+WFt
 3sZzt5noIZhZmedkudxmsfSyMHd5RSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752235447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mTTM+Q9RMy1N95U9RKuk42zJd8VbcYukjbUjdMjtyhE=;
 b=IIz8OvPBSZtuYEXahA+Yb4dFarbzchRDKAS12jNBt/6GoKjkmRRlviRok/IA6yxITENh3J
 uWZeWYrt/2Gl4uBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ABEE1388B;
 Fri, 11 Jul 2025 12:04:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JVSoHLf9cGi4IAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Jul 2025 12:04:07 +0000
Date: Fri, 11 Jul 2025 14:04:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aHD93pKLTpjwz9ox@yuki.lan>
References: <20240603125514.683-1-wegao@suse.com>
 <20250319142310.30036-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250319142310.30036-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.it:url,suse.cz:email,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 8DEB91F38C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] open16: allow restricted O_CREAT of FIFOs and
 regular files
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +/*\
> + * Verify disallows open of FIFOs or regular files not owned by the user in world
> + * writable sticky directories
> + */
> +
> +#include <pwd.h>
> +#include <stdlib.h>
> +#include "tst_test.h"
> +#include "tst_safe_file_at.h"
> +
> +#define  FILENAME  "setuid04_testfile"
> +#define  DIR "ltp_tmp_check1"
> +#define  TEST_FILE "test_file_1"
> +#define  TEST_FIFO "test_fifo_1"
> +#define  LTP_USR_UID1 1000
> +#define  LTP_USR_UID2 1001
> +#define  CONCAT(dir, filename) dir "/" filename
> +#define  PROTECTED_REGULAR "/proc/sys/fs/protected_regular"
> +#define  PROTECTED_FIFOS "/proc/sys/fs/protected_fifos"
           ^
	   Just a single space?

> +
> +static int dir_fd;
> +
> +static void run(void)
> +{
> +	SAFE_CHMOD(DIR, 0777 | S_ISVTX);



> +	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 0);
> +	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 0);

Huh, why not just SAFE_FILE_PRINTF(PROTECTED_FIFOS, "0") ?

> +	if (!SAFE_FORK()) {
> +		SAFE_SETUID(LTP_USR_UID1);
> +
> +		int fd = TST_EXP_FD(openat(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777));
> +
> +		SAFE_CLOSE(fd);
                ^
		if (TST_PASS)
			SAFE_CLOSE(TST_RET);

Also this seems like a setup phase, so we should probably use just
SAFE_OPEN() instead of the TST_EXP_FD() at this point.

> +		SAFE_MKFIFO(CONCAT(DIR, TEST_FIFO), 0777);
                                  ^
We usually do this as:

#define TEST_FIFO_PATH DIR "/" TEST_FIFO

And use the TEST_FIFO_PATH instead.


Or we can just do SAFE_CHDIR(DIR) after the fork and use just the file
names.

> +		exit(0);
> +	}
> +
> +	tst_reap_children();
> +
> +	if (!SAFE_FORK()) {
> +		SAFE_SETUID(LTP_USR_UID2);
> +
> +		int fd = TST_EXP_FD(openat(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777));
> +
> +		SAFE_CLOSE(fd);

Here as well:

		if (TST_PASS)
			SAFE_CLOSE(TST_RET)

> +		fd = TST_EXP_FD(open(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT, 0777));
> +		SAFE_CLOSE(fd);

And here as well.

> +		exit(0);
> +	}
> +
> +	tst_reap_children();
> +
> +	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 1);
> +	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 1);

Here as well why the %d?

> +	if (!SAFE_FORK()) {
> +		SAFE_SETUID(LTP_USR_UID2);
> +		TST_EXP_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777), EACCES);
> +		TST_EXP_FAIL(open(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT, 0777), EACCES);
> +
> +		exit(0);
> +	}
> +
> +	tst_reap_children();
> +
> +	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 2);
> +	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 2);

And here as well.

> +	SAFE_CHMOD(DIR, 0020 | S_ISVTX);
> +
> +	if (!SAFE_FORK()) {
> +		SAFE_SETUID(LTP_USR_UID2);
> +		TST_EXP_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777), EACCES);
> +		TST_EXP_FAIL(open(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT, 0777), EACCES);
> +
> +		exit(0);
> +	}
> +
> +	tst_reap_children();
> +	SAFE_UNLINK(CONCAT(DIR, TEST_FIFO));
> +}
> +
> +static void setup(void)
> +{
> +	umask(0);
> +	SAFE_MKDIR(DIR, 0777 | S_ISVTX);
> +	dir_fd = SAFE_OPEN(DIR, O_DIRECTORY);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (dir_fd != -1)
> +		SAFE_CLOSE(dir_fd);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.test_all = run,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{PROTECTED_REGULAR, NULL, TST_SR_TCONF},
> +		{PROTECTED_FIFOS, NULL, TST_SR_TCONF},
> +		{}
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "30aba6656f61ed44cba445a3c0d38b296fa9e8f5"},
                               ^
			       We usually shorten these to just first 12
			       characters.

> +		{}
> +	}
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
