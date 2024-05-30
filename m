Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1854AC25B78
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 08:39:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 694653D0729
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 10:39:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D54433C279D
 for <ltp@lists.linux.it>; Thu, 30 May 2024 10:39:41 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9F2BE100C20D
 for <ltp@lists.linux.it>; Thu, 30 May 2024 10:39:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C2A42074D;
 Thu, 30 May 2024 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717058379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4C6C6U/Rljzn1l0t559OBfsfRVfMYDBWs6fr4+B7xCY=;
 b=NYDSfwpUHYgOhPXnxVWxbX9mDlaLW5tS4E/fZ7bbGHyrJlzoJA9BcflvA1BN11teJyhu3P
 vS8KmSsEe8kpD8tMA2vDe5E54WoaNB7u3cH6sIwdipsvlPDwIquYhUFLj/K6OcPL6sXaHP
 8pGgSgHyucTuy59B+Y6Q2DFkebS04R0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717058379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4C6C6U/Rljzn1l0t559OBfsfRVfMYDBWs6fr4+B7xCY=;
 b=VeCgmU/lXM2aQUxi9XXBySIN6HXh3dp81jjEE74zqUaVEzJn26VHRpVO7fhR2Ytl+Unw0q
 c7AlfTYsGXBTHwBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NYDSfwpU;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="VeCgmU/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717058379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4C6C6U/Rljzn1l0t559OBfsfRVfMYDBWs6fr4+B7xCY=;
 b=NYDSfwpUHYgOhPXnxVWxbX9mDlaLW5tS4E/fZ7bbGHyrJlzoJA9BcflvA1BN11teJyhu3P
 vS8KmSsEe8kpD8tMA2vDe5E54WoaNB7u3cH6sIwdipsvlPDwIquYhUFLj/K6OcPL6sXaHP
 8pGgSgHyucTuy59B+Y6Q2DFkebS04R0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717058379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4C6C6U/Rljzn1l0t559OBfsfRVfMYDBWs6fr4+B7xCY=;
 b=VeCgmU/lXM2aQUxi9XXBySIN6HXh3dp81jjEE74zqUaVEzJn26VHRpVO7fhR2Ytl+Unw0q
 c7AlfTYsGXBTHwBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6328213A42;
 Thu, 30 May 2024 08:39:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fu0wGEs7WGZtEAAAD6G6ig
 (envelope-from <jack@suse.cz>); Thu, 30 May 2024 08:39:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 11D53A0841; Thu, 30 May 2024 10:39:39 +0200 (CEST)
Date: Thu, 30 May 2024 10:39:39 +0200
From: Jan Kara <jack@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240530083939.daxia45vntjkveo4@quack3>
References: <20240530044029.15474-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240530044029.15474-1-wegao@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6C2A42074D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_THREE(0.00)[3];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_LAST(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] msync04.c: Use direct IO to verify the data is
 stored on disk
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu 30-05-24 00:40:29, Wei Gao wrote:
> Signed-off-by: Wei Gao <wegao@suse.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Looks good to me! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  testcases/kernel/syscalls/msync/msync04.c | 56 +++++++++++++----------
>  1 file changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
> index 1718bd7dc..c0580d1b0 100644
> --- a/testcases/kernel/syscalls/msync/msync04.c
> +++ b/testcases/kernel/syscalls/msync/msync04.c
> @@ -11,6 +11,7 @@
>   * is no longer dirty after msync() call.
>   */
>  
> +#define _GNU_SOURCE
>  #include <errno.h>
>  #include "tst_test.h"
>  
> @@ -43,10 +44,35 @@ static uint64_t get_dirty_bit(void *data)
>  	return pageflag_entry & (1ULL << 4);
>  }
>  
> -static void test_msync(void)
> +static void verify_mmaped(void)
> +{
> +	void *buffer = SAFE_MEMALIGN(getpagesize(), getpagesize());
> +
> +	tst_res(TINFO, "Not see dirty bit so we check content of file instead");
> +	test_fd = SAFE_OPEN("msync04/testfile", O_RDONLY | O_DIRECT);
> +	SAFE_READ(0, test_fd, buffer, getpagesize());
> +
> +	char *char_buffer = (char *)buffer;
> +
> +	if (char_buffer[8] == 'B')
> +		tst_res(TCONF, "write file ok but msync couldn't be tested"
> +				" because the storage was written to too quickly");
> +	else
> +		tst_res(TFAIL, "write file failed");
> +}
> +
> +static void verify_dirty(void)
>  {
> -	char buffer[20];
> +	TST_EXP_PASS_SILENT(msync(mmaped_area, pagesize, MS_SYNC));
> +
> +	if (TST_RET == 0 && !get_dirty_bit(mmaped_area))
> +		tst_res(TPASS, "msync() verify dirty page ok");
> +	else
> +		tst_res(TFAIL, "msync() verify dirty page failed");
> +}
>  
> +static void test_msync(void)
> +{
>  	test_fd = SAFE_OPEN("msync04/testfile", O_CREAT | O_TRUNC | O_RDWR,
>  		0644);
>  	SAFE_WRITE(SAFE_WRITE_ANY, test_fd, STRING_TO_WRITE, sizeof(STRING_TO_WRITE) - 1);
> @@ -55,27 +81,11 @@ static void test_msync(void)
>  	SAFE_CLOSE(test_fd);
>  	mmaped_area[8] = 'B';
>  
> -	if (!get_dirty_bit(mmaped_area)) {
> -		tst_res(TINFO, "Not see dirty bit so we check content of file instead");
> -		test_fd = SAFE_OPEN("msync04/testfile", O_RDONLY);
> -		SAFE_READ(0, test_fd, buffer, 9);
> -		if (buffer[8] == 'B')
> -			tst_res(TCONF, "write file ok but msync couldn't be tested"
> -				" because the storage was written to too quickly");
> -		else
> -			tst_res(TFAIL, "write file failed");
> -	} else {
> -		if (msync(mmaped_area, pagesize, MS_SYNC) < 0) {
> -			tst_res(TFAIL | TERRNO, "msync() failed");
> -			goto clean;
> -		}
> -		if (get_dirty_bit(mmaped_area))
> -			tst_res(TFAIL, "msync() failed to write dirty page despite succeeding");
> -		else
> -			tst_res(TPASS, "msync() working correctly");
> -	}
> -
> -clean:
> +	if (!get_dirty_bit(mmaped_area))
> +		verify_mmaped();
> +	else
> +		verify_dirty();
> +
>  	SAFE_MUNMAP(mmaped_area, pagesize);
>  	mmaped_area = NULL;
>  }
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
