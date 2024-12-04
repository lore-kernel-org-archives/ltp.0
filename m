Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA275E7716B
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 13:45:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D100A3DF042
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 14:45:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48D9B3C6C6F
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 14:45:14 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 490F020F5AC
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 14:45:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 386F11F365;
 Wed,  4 Dec 2024 13:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733319912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pfvsWHy7IMDtVEhFeGo77wssDV97cNxLRzQ9wykMS6Y=;
 b=JqbQWCZkPijGfT0R/xoW4bTVkus45Y0RFRuKntvvZgVDlHoOkFAL+HNRSk9svp73AZHtHQ
 tCXS4Pq63jcMonMYPJL2yQg3EEuixmF1ITazSm9qRphgXfH0rws8vRtXXLGYA2AnnuE5uz
 hsTF6DgrNXM6kcVxfSnMVAZEZDZVTrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733319912;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pfvsWHy7IMDtVEhFeGo77wssDV97cNxLRzQ9wykMS6Y=;
 b=NJRXf9KPbfGnxb5eqTZXOaKmQMIAk8GUr2DOklKVdthaTzDP52+IrycIiBul82C10fsZqg
 ruDGCQDQJGyQ3/Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733319912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pfvsWHy7IMDtVEhFeGo77wssDV97cNxLRzQ9wykMS6Y=;
 b=JqbQWCZkPijGfT0R/xoW4bTVkus45Y0RFRuKntvvZgVDlHoOkFAL+HNRSk9svp73AZHtHQ
 tCXS4Pq63jcMonMYPJL2yQg3EEuixmF1ITazSm9qRphgXfH0rws8vRtXXLGYA2AnnuE5uz
 hsTF6DgrNXM6kcVxfSnMVAZEZDZVTrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733319912;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pfvsWHy7IMDtVEhFeGo77wssDV97cNxLRzQ9wykMS6Y=;
 b=NJRXf9KPbfGnxb5eqTZXOaKmQMIAk8GUr2DOklKVdthaTzDP52+IrycIiBul82C10fsZqg
 ruDGCQDQJGyQ3/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28911139C2;
 Wed,  4 Dec 2024 13:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bwciCehcUGftPgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 04 Dec 2024 13:45:12 +0000
Date: Wed, 4 Dec 2024 14:45:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Z1Bc73oJe6ljoIxs@yuki.lan>
References: <20241101141111.104803-1-mdoucha@suse.cz>
 <20241101141111.104803-4-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241101141111.104803-4-mdoucha@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] Add test for file data integrity
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
> +static void vectorize_buffer(struct iovec *vec, size_t vec_size, char *buf,
> +	size_t buf_size, int align)
> +{
> +	size_t i, len, chunk = align ? blocksize : 1;
> +
> +	memset(vec, 0, vec_size * sizeof(struct iovec));
> +	buf_size /= chunk;
> +
> +	for (i = 0; buf_size && i < vec_size; i++) {
> +		len = 1 + rand() % (buf_size + i + 1 - vec_size);

You have 1 + ... before the rand should it be buf_size:

i - 1 - vec_size

Also since 0 sized iov_len is actually correct, it means skip the entry,
we do not have to make sure that the length is > 0 here and neither we
need to make sure that we have enough buffer saved for the rest of the
vector.


> +		vec[i].iov_base = buf;
> +		vec[i].iov_len = len * chunk;
> +		buf += vec[i].iov_len;
> +		buf_size -= len;
> +	}
> +
> +	vec[vec_size - 1].iov_len += buf_size * chunk;
> +}
> +
> +static void update_filedata(const void *buf, size_t offset, size_t size)
> +{
> +	memcpy(filedata + offset, buf, size * sizeof(char));
                                                ^
						This is 1 by definition.
> +}
> +
> +static void do_write(void *buf, size_t offset, size_t size)
> +{
> +	SAFE_LSEEK(write_fd, offset, SEEK_SET);
> +	SAFE_WRITE(1, write_fd, buf, size);
> +}
> +
> +static void do_pwrite(void *buf, size_t offset, size_t size)
> +{
> +	SAFE_PWRITE(1, write_fd, buf, size, offset);
> +}
> +
> +static void do_writev(void *buf, size_t offset, size_t size)
> +{
> +	struct iovec vec[MAX_VEC] = {};
> +
> +	vectorize_buffer(vec, MAX_VEC, buf, size, !!directwr_flag);
> +	SAFE_LSEEK(write_fd, offset, SEEK_SET);
> +	SAFE_WRITEV(1, write_fd, vec, MAX_VEC);
> +}
> +
> +static void do_pwritev(void *buf, size_t offset, size_t size)
> +{
> +	struct iovec vec[MAX_VEC] = {};
> +
> +	vectorize_buffer(vec, MAX_VEC, buf, size, !!directwr_flag);
> +	SAFE_PWRITEV(1, write_fd, vec, MAX_VEC, offset);
> +}
> +
> +static void do_read(void *buf, size_t offset, size_t size)
> +{
> +	SAFE_LSEEK(read_fd, offset, SEEK_SET);
> +	SAFE_READ(1, read_fd, buf, size);
> +}
> +
> +static void do_pread(void *buf, size_t offset, size_t size)
> +{
> +	SAFE_PREAD(1, read_fd, buf, size, offset);
> +}
> +
> +static void do_readv(void *buf, size_t offset, size_t size)
> +{
> +	struct iovec vec[MAX_VEC] = {};
> +
> +	vectorize_buffer(vec, MAX_VEC, buf, size, !!directrd_flag);
> +	SAFE_LSEEK(read_fd, offset, SEEK_SET);
> +	SAFE_READV(1, read_fd, vec, MAX_VEC);
> +}
> +
> +static void do_preadv(void *buf, size_t offset, size_t size)
> +{
> +	struct iovec vec[MAX_VEC] = {};
> +
> +	vectorize_buffer(vec, MAX_VEC, buf, size, !!directrd_flag);
> +	SAFE_PREADV(1, read_fd, vec, MAX_VEC, offset);
> +}
> +
> +static int open_testfile(int flags)
> +{
> +	if ((flags & O_WRONLY) && directwr_flag)
> +		flags |= O_DIRECT;
> +
> +	if ((flags & O_RDONLY) && directrd_flag)
> +		flags |= O_DIRECT;
> +
> +	return SAFE_OPEN(TEST_FILENAME, flags, 0644);
> +}
> +
> +static void setup(void)
> +{
> +	struct statvfs statbuf;
> +	size_t pagesize;
> +
> +	srand(time(0));
> +	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
> +
> +	if (workdir_arg)
> +		SAFE_CHDIR(workdir_arg);
> +
> +	if (tst_parse_int(loop_arg, &loop_count, 0, INT_MAX))
> +		tst_brk(TBROK, "Invalid write loop count: %s", loop_arg);
> +
> +	write_fd = open_testfile(O_WRONLY | O_CREAT | O_TRUNC);
> +	read_fd = open_testfile(O_RDONLY);
> +	TEST(fstatvfs(write_fd, &statbuf));
> +
> +	if (TST_RET == -1)
> +		tst_brk(TBROK | TTERRNO, "fstatvfs() failed");
> +	else if (TST_RET)
> +		tst_brk(TBROK | TTERRNO, "Invalid fstatvfs() return value");
> +
> +	blocksize = statbuf.f_bsize;
> +	tst_res(TINFO, "Block size: %zu", blocksize);
> +	bufsize = 4 * MAX_VEC * MAX(pagesize, blocksize);
> +	filesize = 1024 * MAX(pagesize, blocksize);
> +	writebuf = SAFE_MMAP(NULL, bufsize, PROT_READ | PROT_WRITE,
> +		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	filedata = SAFE_MALLOC(filesize);
> +
> +	tst_set_max_runtime(bufsize * loop_count / (8 * 1024 * 1024));

I think that it may be better to define the test to be time based rather
than iteration based. If we decide that the default runtime would be 5
minutes the test would do as much iterations during that time as
possible and report how many it did at the end of the test. Possibly it
may warn if minimal amount of iterations wasn't reached. That would make
the test runtime much more predictable

> +}
> +
> +static void run(void)
> +{
> +	size_t start, length;
> +	int i, f, fails = 0;
> +
> +	/* Test data consistency between random writes */
> +	for (i = 0; i < loop_count; i++) {
> +		length = fill_buffer(writebuf, bufsize);
> +		start = rand() % (filesize + 1 - length);
> +
> +		/* Align offset to blocksize if needed */
> +		if (directrd_flag || directwr_flag)
> +			start = (start + blocksize / 2) & ~(blocksize - 1);
> +
> +		update_filedata(writebuf, start, length);
> +		f = rand() % ARRAY_SIZE(write_funcs);
> +		write_funcs[f](writebuf, start, length);
> +
> +		memset(writebuf, 0, length);
> +		f = rand() % ARRAY_SIZE(read_funcs);
> +		read_funcs[f](writebuf, start, length);
> +
> +		if (memcmp(writebuf, filedata + start, length)) {
> +			tst_res(TFAIL, "Partial data mismatch at [%zu:%zu]",
> +				start, start + length);
> +			fails++;
> +		}
> +	}
> +
> +	if (!fails)
> +		tst_res(TPASS, "Partial data are consistent");
> +
> +	/* Ensure that the testfile has the expected size */
> +	do_write(writebuf, filesize - blocksize, blocksize);
> +	update_filedata(writebuf, filesize - blocksize, blocksize);
> +
> +	/* Sync the testfile and clear cache */
> +	SAFE_CLOSE(read_fd);
> +	SAFE_FSYNC(write_fd);
> +	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "1");
> +	read_fd = open_testfile(O_RDONLY);
> +
> +	/* Check final file contents */
> +	for (start = 0; start < filesize; start += bufsize) {
> +		length = MIN(bufsize, filesize - start);
> +		SAFE_READ(1, read_fd, writebuf, length);
> +
> +		if (memcmp(writebuf, filedata + start, length)) {
> +			tst_res(TFAIL, "Final data mismatch at [%zu:%zu]",
> +				start, start + length);
> +			return;
> +		}
> +	}
> +
> +	tst_res(TPASS, "Final data are consistent");
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_MUNMAP(writebuf, bufsize);
> +	free(filedata);
> +
> +	if (read_fd >= 0)
> +		SAFE_CLOSE(read_fd);
> +
> +	if (write_fd >= 0)
> +		SAFE_CLOSE(write_fd);
> +
> +	SAFE_UNLINK(TEST_FILENAME);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.options = (struct tst_option[]) {
> +		{"c:", &loop_arg, "Number of write loops (default: 4096)"},
> +		{"d:", &workdir_arg, "Path to working directory"},
> +		{"W", &directwr_flag, "Use direct I/O for writing"},
> +		{"R", &directrd_flag, "Use direct I/O for reading"},
> +		{}
> +	}
> +};
> diff --git a/testcases/misc/lvm/datafiles/runfile.tpl b/testcases/misc/lvm/datafiles/runfile.tpl
> index 4c80e9391..ee733626f 100644
> --- a/testcases/misc/lvm/datafiles/runfile.tpl
> +++ b/testcases/misc/lvm/datafiles/runfile.tpl
> @@ -29,6 +29,10 @@
>  {fsname}_gf28 growfiles -W {fsname}_gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u {tempdir}/{fsname}/gfsparse-2-$$
>  {fsname}_gf29 growfiles -W {fsname}_gf29 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -B 805306368 -C 1 -u {tempdir}/{fsname}/gfsparse-3-$$
>  {fsname}_gf30 growfiles -W {fsname}_gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 {tempdir}/{fsname}/gf-sync-$$
> +{fsname}_plough01 fsplough -d {tempdir}/{fsname}
> +{fsname}_plough02 fsplough -R -d {tempdir}/{fsname}
> +{fsname}_plough03 fsplough -W -d {tempdir}/{fsname}
> +{fsname}_plough04 fsplough -RW -d {tempdir}/{fsname}
>  {fsname}_rwtest01 rwtest -N {fsname}_rwtest01 -c -q -i 60s  -f sync 10%25000:rw-sync-$$ 500b:{tempdir}/{fsname}/rwtest01%f
>  {fsname}_rwtest02 rwtest -N {fsname}_rwtest02 -c -q -i 60s  -f buffered 10%25000:rw-buffered-$$ 500b:{tempdir}/{fsname}/rwtest02%f
>  {fsname}_rwtest03 rwtest -N {fsname}_rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$ 500b:{tempdir}/{fsname}/rwtest03%f
> -- 
> 2.46.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
