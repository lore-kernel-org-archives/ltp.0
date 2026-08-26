Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1E8C61DBE
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 11:00:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C7463CDAF9
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 13:00:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B5E43C2603
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 13:00:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C54A0600B24
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 13:00:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5186C87395;
 Wed, 26 Aug 2026 11:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787742015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RYWscoC8qHM/zyAcE3y9/ND3iidMune6W/vshYeJ3TU=;
 b=yObAKwskf4GM6zEPFlyuBMMFuIkLtpxnFrXzSfigYzPUwdJCSRFhgs/52IXyauR/BqOLmM
 JSLTWAp2VJTjQ9QYQ5tX9Jqnl5SAfry/prjsJfv4aL9NtgmzXEGfh5j2SBYc70dY1G4OIl
 JfQKw7fM+cNsA8uIQeBPGWYRXcg7uZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787742015;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RYWscoC8qHM/zyAcE3y9/ND3iidMune6W/vshYeJ3TU=;
 b=xjV0Sbg4fHzG4Spel9i0ge0FEO9j1XNfdqZCCM8tGh0d1qTY8OBKzYM+VfStLnsU/xFLzx
 oy9eUGqp29NnrqBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787742011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RYWscoC8qHM/zyAcE3y9/ND3iidMune6W/vshYeJ3TU=;
 b=uL32o3LcnKeJOCJNgEFjCA+rnAqezzCli4pqqxPFv5LmEMxapQaZycLihqQohd8jEAlJzQ
 N6akgL0e51zdO7PGgxC4410SAhwh4G0Po96HGwclVahTuhTkMJBK36n7Mc7aU9vdtMYOFb
 IVwtlgl0ccJgqR2ewuuQYHMYrhSE5g0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787742011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RYWscoC8qHM/zyAcE3y9/ND3iidMune6W/vshYeJ3TU=;
 b=Ko4ivAN5pBbERM3oVbGZAkdT2q6KZHbKbvTaRAaslrbVcx0G1p8FSeZt8QJaOxdK3PQHUI
 mhtlOc8u9KEigsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38AD813533;
 Wed, 26 Aug 2026 11:00:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7kxLDTvHjmoMTAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 26 Aug 2026 11:00:11 +0000
Date: Wed, 26 Aug 2026 13:00:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ao7HQbIt34iRZ2RV@yuki.lan>
References: <20260807-convert_fallocate_suite-v2-0-3761f7b74b1f@suse.com>
 <20260807-convert_fallocate_suite-v2-1-3761f7b74b1f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260807-convert_fallocate_suite-v2-1-3761f7b74b1f@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] fallocate01: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> -int main(int ac, char **av)
> +static void run(unsigned int n)
>  {
> -	loff_t expected_size;
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> +	struct tcase *tc = &tcases[n];
> +	struct stat file_stat;
> +	loff_t offset, len, pos, write_offset, expected_size;
>  
> -	setup();
> +	/* Reset the backing file to a pristine 12-block state per run. */
> +	SAFE_FTRUNCATE(fd, 0);
> +	SAFE_LSEEK(fd, 0, SEEK_SET);
> +	populate_file();
>  
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> +	offset = SAFE_LSEEK(fd, 0, SEEK_END);
> +	len = block_size;
> +	expected_size = (loff_t)tc->expected_blocks * block_size;
>  
> -		expected_size = BLOCKS_WRITTEN * block_size + block_size;
> -		runtest(0, fd_mode1, expected_size);
> +	TEST(fallocate(fd, tc->mode, offset, len));
> +	if (TST_RET != 0) {
> +		if (TST_ERR == EOPNOTSUPP || TST_ERR == ENOSYS)
> +			tst_brk(TCONF, "fallocate() not supported");
>  
> -		expected_size = BLOCKS_WRITTEN * block_size;
> -		runtest(FALLOC_FL_KEEP_SIZE, fd_mode2, expected_size);
> +		tst_res(TFAIL | TTERRNO, "fallocate(%s, %lld, %lld) failed",
> +			tc->desc, (long long)offset, (long long)len);
> +		return;
>  	}
> +	tst_res(TPASS, "fallocate(%s, %lld, %lld) succeeded",
> +		tc->desc, (long long)offset, (long long)len);

Can we do a dummy call to fallocate in the test setup and check for the
EOPNOTSUPP and ENOSYS so that we can use TST_EXP_PASS() here instead?

> -	cleanup();
> -	tst_exit();
> -}
> -
> -/*****************************************************************************
> - * Calls the system call, with appropriate parameters and writes data
> - ******************************************************************************/
> -void runtest(int mode, int fd, loff_t expected_size)
> -{
> -	loff_t offset;
> -	loff_t len = block_size;
> -	loff_t write_offset, lseek_offset;
> -	offset = lseek(fd, 0, SEEK_END);
> -	struct stat file_stat;
> -	errno = 0;
> -
> -	TEST(fallocate(fd, mode, offset, len));
> -	/* check return code */
> -	if (TEST_RETURN != 0) {
> -		if (TEST_ERRNO == EOPNOTSUPP || TEST_ERRNO == ENOSYS) {
> -			tst_brkm(TCONF, cleanup,
> -				 "fallocate system call is not implemented");
> -		}
> -		tst_resm(TFAIL | TTERRNO,
> -			 "fallocate(%d, %d, %" PRId64 ", %" PRId64 ") failed",
> -			 fd, mode, offset, len);
> -		return;
> +	SAFE_FSTAT(fd, &file_stat);
> +	if (file_stat.st_size != expected_size) {
> +		tst_res(TFAIL, "file size is %lld, expected %lld",
> +			(long long)file_stat.st_size, (long long)expected_size);
>  	} else {
> -		tst_resm(TPASS,
> -			 "fallocate(%d, %d, %" PRId64 ", %" PRId64
> -			 ") returned %ld", fd, mode, offset, len,
> -			 TEST_RETURN);
> +		tst_res(TPASS, "file size is %lld as expected",
> +			(long long)expected_size);
>  	}

Can we use TST_EXP_EQ macro here?

> -	if (fstat(fd, &file_stat) < 0)
> -		tst_resm(TFAIL | TERRNO, "fstat failed after fallocate()");
> -
> -	if (file_stat.st_size != expected_size)
> -		tst_resm(TFAIL | TERRNO,
> -			 "fstat test fails on fallocate (%d, %d, %" PRId64 ", %"
> -			 PRId64 ") Failed on mode", fd, mode, offset, len);
> -
> -	write_offset = random() % len;
> -	lseek_offset = lseek(fd, write_offset, SEEK_CUR);
> -	if (lseek_offset != offset + write_offset) {
> -		tst_resm(TFAIL | TERRNO,
> -			 "lseek fails in fallocate(%d, %d, %" PRId64 ", %"
> -			 PRId64 ") failed on mode", fd, mode, offset, len);
> +	write_offset = len / 2;
> +	pos = SAFE_LSEEK(fd, write_offset, SEEK_CUR);
> +	if (pos != offset + write_offset) {
> +		tst_res(TFAIL, "lseek returned %lld, expected %lld",
> +			(long long)pos, (long long)(offset + write_offset));
>  		return;
>  	}


And here?

> -	//Write a character to file at random location
> -	TEST(write(fd, "A", 1));
> -	/* check return code */
> -	if (TEST_RETURN == -1) {
> -		tst_resm(TFAIL | TTERRNO,
> -			 "write fails in fallocate(%d, %d, %" PRId64 ", %"
> -			 PRId64 ") failed", fd, mode, offset, len);
> -	} else {
> -		tst_resm(TPASS,
> -			 "write operation on fallocated(%d, %d, %"
> -			 PRId64 ", %" PRId64 ") returned %ld", fd, mode,
> -			 offset, len, TEST_RETURN);
> -	}
> +
> +	TST_EXP_POSITIVE(write(fd, "A", 1),
> +			 "write into the newly allocated region");
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd != -1)
> +		SAFE_CLOSE(fd);
>  }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.needs_tmpdir = 1,
> +};

I guess that it would make sense to enable the test for all_filesystems
here.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
