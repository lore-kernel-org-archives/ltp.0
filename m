Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C744EC54E49
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 13:38:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 320D03D03BC
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 14:38:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 680323CD0CB
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 14:38:32 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5E040600D05
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 14:38:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7408E22125;
 Mon, 26 Feb 2024 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708954710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MqtWz13vrLW9v2qSlebV0/Cu8FMwWH1LhRvEMKq8cjQ=;
 b=AGTEd22vUk1QfAilXXiyCgkVJAwcFEUKodBglAOUeljvf5bhEGlSpbf2eWM3yWzBvrhPjc
 vtS30Xz4UBhJI6aZd+ocJiLL4G5Gghz0pCkxBPe4/O63Q3mrR6JCoSX6xl6NBCDlA7WIf1
 l4bc9iydSOWOEbcFepGOA7wGOzMUbZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708954710;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MqtWz13vrLW9v2qSlebV0/Cu8FMwWH1LhRvEMKq8cjQ=;
 b=6oBdr9TJ192wyYeqwZWTxWkpHhu3jWN8vFOAGEPKBvOgOagsSISSlr2KqOd+0b+BW7VYDM
 csCXfoQaaBiryjCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708954710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MqtWz13vrLW9v2qSlebV0/Cu8FMwWH1LhRvEMKq8cjQ=;
 b=AGTEd22vUk1QfAilXXiyCgkVJAwcFEUKodBglAOUeljvf5bhEGlSpbf2eWM3yWzBvrhPjc
 vtS30Xz4UBhJI6aZd+ocJiLL4G5Gghz0pCkxBPe4/O63Q3mrR6JCoSX6xl6NBCDlA7WIf1
 l4bc9iydSOWOEbcFepGOA7wGOzMUbZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708954710;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MqtWz13vrLW9v2qSlebV0/Cu8FMwWH1LhRvEMKq8cjQ=;
 b=6oBdr9TJ192wyYeqwZWTxWkpHhu3jWN8vFOAGEPKBvOgOagsSISSlr2KqOd+0b+BW7VYDM
 csCXfoQaaBiryjCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 599E413A3A;
 Mon, 26 Feb 2024 13:38:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jVhPFVaU3GU1YQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 26 Feb 2024 13:38:30 +0000
Date: Mon, 26 Feb 2024 14:37:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZdyUD_rhoMTKMHFD@yuki>
References: <20231009112047.2359-1-wegao@suse.com>
 <20231227130555.29035-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231227130555.29035-1-wegao@suse.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[41.15%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] open15: allow restricted O_CREAT of FIFOs and
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
Cc: s.mesoraca16@gmail.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +/*\
> + * [Description]
> + *
> + * Verify disallows open of FIFOs or regular files not owned by the user in world
> + * writable sticky directories
> + *
> + * commit 30aba6656f61ed44cba445a3c0d38b296fa9e8f5
> + * Author: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> + * Date:   Thu Aug 23 17:00:35 2018 -0700
> + *     namei: allow restricted O_CREAT of FIFOs and regular files
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
> +
> +static int dir_fd;
> +
> +static void run(void)
> +{
> +	int pid;
> +
> +	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 0);
> +	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 0);
> +
> +	pid = SAFE_FORK();

No need to store the pid if we are not using it. We can do instead just:

	if (!SAFE_FORK()) {

> +	if (pid == 0) {
> +		SAFE_SETUID(LTP_USR_UID1);
> +
> +		int fd = TST_EXP_FD(openat(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777));
> +
> +		SAFE_CLOSE(fd);
> +		fd = SAFE_MKFIFO(CONCAT(DIR, TEST_FIFO), 0777);
> +		SAFE_CLOSE(fd);

This part has to be done in the test setup() otherwise the test will
fail with EEXIST with -i 2.

> +		exit(0);
> +	}
> +
> +	tst_reap_children();
> +
> +	pid = SAFE_FORK();
> +
> +	if (pid == 0) {
> +		SAFE_SETUID(LTP_USR_UID2);
> +
> +		int fd = TST_EXP_FD(openat(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777));
> +
> +		tst_res(TPASS, "check protect_regural == 0 pass");

The TST_EXP_FD() should print TPASS message, there is no point in adding
another.


> +		SAFE_CLOSE(fd);

This should be closed only if the fd is valid.

> +		fd = SAFE_OPEN(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT);
> +		tst_res(TPASS, "check protect_fifos == 0 pass");
> +		SAFE_CLOSE(fd);

Again this should be TST_EXP_FD().

> +		exit(0);
> +	}
> +
> +	tst_reap_children();
> +
> +	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 1);
> +	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 1);
> +
> +	pid = SAFE_FORK();
> +
> +	if (pid == 0) {
> +		SAFE_SETUID(LTP_USR_UID2);
> +
> +		TST_EXP_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777), EACCES);
> +
> +		TST_EXP_FAIL(open(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT, 0777), EACCES);
> +
> +		exit(0);
> +	}
> +
> +	tst_reap_children();
> +
> +	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 2);
> +	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 2);
> +	SAFE_CHMOD(DIR, 0020 | S_ISVTX);

I suppose that this will break the test with -i 2 as well, you need to
chmod the directory back at the end of the test.

> +	pid = SAFE_FORK();
> +
> +	if (pid == 0) {
> +		SAFE_SETUID(LTP_USR_UID2);
> +
> +		TST_EXP_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777), EACCES);
> +
> +		TST_EXP_FAIL(open(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT, 0777), EACCES);
> +
> +		exit(0);
> +	}
> +
> +	tst_reap_children();
> +}
> +
> +static void setup(void)
> +{
> +	umask(0);
> +	SAFE_MKDIR(DIR, 0777 | S_ISVTX);
> +
> +	dir_fd = SAFE_OPEN(DIR, O_DIRECTORY);
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_CLOSE(dir_fd);
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
> +	.needs_checkpoints = 1,

This should have been removed.

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
