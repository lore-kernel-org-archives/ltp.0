Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0369EF483CC
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 16:23:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AD9C3E5CD0
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 17:23:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 972E03E1410
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 17:23:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BD41A1400DD3
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 17:23:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED6CD4D365;
 Mon, 23 Mar 2026 16:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774282978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xEvzEDBfsnkqtnKu/ITWthzCqomL86eziIBv4mRY3A=;
 b=oFbEKXJXNfvGUO7NyheqGd6CUtCrhzwoDo1MnKkRs+8LPjdWvcgp14+GBlOXgOJLCrznU9
 M9oY8DK3XQcy+o2kZRNBqHYBNrUlq5t68XwIJZ79ShdsXe70Pk926+lDghNrGQdAFHoIyx
 sgtSMBBgiDQTQEKppC95nmUgNY3/JRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774282978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xEvzEDBfsnkqtnKu/ITWthzCqomL86eziIBv4mRY3A=;
 b=UHhMHla80mZXFpskjxoaDAZZLJmyyB5JvpGBwYbhXPLj8kJN8X+wJonU2STqeAtYHPd9M7
 YqkriEygxPt9kZCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oFbEKXJX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UHhMHla8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774282978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xEvzEDBfsnkqtnKu/ITWthzCqomL86eziIBv4mRY3A=;
 b=oFbEKXJXNfvGUO7NyheqGd6CUtCrhzwoDo1MnKkRs+8LPjdWvcgp14+GBlOXgOJLCrznU9
 M9oY8DK3XQcy+o2kZRNBqHYBNrUlq5t68XwIJZ79ShdsXe70Pk926+lDghNrGQdAFHoIyx
 sgtSMBBgiDQTQEKppC95nmUgNY3/JRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774282978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xEvzEDBfsnkqtnKu/ITWthzCqomL86eziIBv4mRY3A=;
 b=UHhMHla80mZXFpskjxoaDAZZLJmyyB5JvpGBwYbhXPLj8kJN8X+wJonU2STqeAtYHPd9M7
 YqkriEygxPt9kZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA3C24397B;
 Mon, 23 Mar 2026 16:22:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +RdkNOFowWksGQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 23 Mar 2026 16:22:57 +0000
Date: Mon, 23 Mar 2026 17:22:58 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Sachin Sant <sachinp@linux.ibm.com>
Message-ID: <acFo4gfmugdfiOwI@yuki.lan>
References: <20260320124742.75946-1-sachinp@linux.ibm.com>
 <20260320124742.75946-3-sachinp@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260320124742.75946-3-sachinp@linux.ibm.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,yuki.lan:mid];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: ED6CD4D365
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] io_uring: Test READV and WRITEV operations
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
> +#define TEST_FILE "io_uring_test_file"
> +#define QUEUE_DEPTH 2
> +#define NUM_VECS 4
> +#define VEC_SIZE 1024
> +
> +static char write_bufs[NUM_VECS][VEC_SIZE];
> +static char read_bufs[NUM_VECS][VEC_SIZE];
> +static struct iovec write_iovs[NUM_VECS];
> +static struct iovec read_iovs[NUM_VECS];

The guarded buffers can allocate iovec for you as well. Have a look at
readv01.c test how to do that in the tst_test structure.

> +static struct io_uring_submit s;
> +static sigset_t sig;
> +
> +static void prepare_write_buffers(void)
> +{
> +	size_t i, j;
> +
> +	for (i = 0; i < NUM_VECS; i++) {
> +		for (j = 0; j < VEC_SIZE; j++) {
> +			/* Each vector has a different pattern */
> +			write_bufs[i][j] = 'A' + i + (j % 26);
> +		}
> +		write_iovs[i].iov_base = write_bufs[i];
> +		write_iovs[i].iov_len = VEC_SIZE;
> +	}
> +}
> +
> +static void prepare_read_buffers(void)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < NUM_VECS; i++) {
> +		memset(read_bufs[i], 0, VEC_SIZE);
> +		read_iovs[i].iov_base = read_bufs[i];
> +		read_iovs[i].iov_len = VEC_SIZE;
> +	}
> +}
> +
> +static void verify_vector_data(char write_bufs[][VEC_SIZE],
> +			       char read_bufs[][VEC_SIZE],
> +			       size_t num_vecs, const char *test_name)
> +{
> +	size_t i, j;
> +
> +	for (i = 0; i < num_vecs; i++) {
> +		if (memcmp(write_bufs[i], read_bufs[i], VEC_SIZE) != 0) {
> +			tst_res(TFAIL, "%s: data mismatch in vector %zu",
> +				test_name, i);
> +			for (j = 0; j < VEC_SIZE && j < 64; j++) {
> +				if (write_bufs[i][j] != read_bufs[i][j]) {
> +					tst_res(TINFO, "Vector %zu: first mismatch at "
> +						"offset %zu: wrote 0x%02x, read 0x%02x",
> +						i, j, write_bufs[i][j], read_bufs[i][j]);
> +					break;
> +				}
> +			}
> +			return;
> +		}
> +	}
> +
> +	tst_res(TPASS, "%s: data integrity verified across %zu vectors",
> +		test_name, num_vecs);
> +}
> +
> +static void test_writev_readv(void)
> +{
> +	int fd;
> +	int total_size = NUM_VECS * VEC_SIZE;
> +
> +	tst_res(TINFO, "Testing IORING_OP_WRITEV and IORING_OP_READV");
> +
> +	prepare_write_buffers();
> +	prepare_read_buffers();
> +
> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
> +
> +	tst_res(TINFO, "Writing %d bytes using %d vectors", total_size, NUM_VECS);
> +	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, write_iovs, NUM_VECS,
> +			      0, total_size, &sig,
> +			      "IORING_OP_WRITEV completed successfully");
> +
> +	SAFE_FSYNC(fd);
> +
> +	tst_res(TINFO, "Reading %d bytes using %d vectors", total_size, NUM_VECS);
> +	io_uring_do_vec_io_op(&s, fd, IORING_OP_READV, read_iovs, NUM_VECS,
> +			      0, total_size, &sig,
> +			      "IORING_OP_READV completed successfully");
> +
> +	verify_vector_data(write_bufs, read_bufs, NUM_VECS, "Basic vectored I/O");
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void test_partial_vectors(void)
> +{
> +	int fd;
> +	struct iovec partial_write[2];
> +	struct iovec partial_read[2];
> +	int expected_size;
> +
> +	tst_res(TINFO, "Testing partial vector operations");
> +
> +	prepare_write_buffers();

The write buffers can be initialized once in the test setup.

> +	prepare_read_buffers();
> +
> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
> +
> +	/* Write using only 2 vectors */
> +	partial_write[0] = write_iovs[0];
> +	partial_write[1] = write_iovs[1];
> +	expected_size = 2 * VEC_SIZE;

We do not need to copy the pointers here, we can just pass the
write_iovs to the function and kernel will the write as long as we pass
iovcnt = 2.

> +	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, partial_write, 2, 0,
> +			      expected_size, &sig,
> +			      "Partial IORING_OP_WRITEV (2 vectors) succeeded");

And I do not think this is that useful since we do not write the second
half with an offset as we do in the first test.

It would make much more sense if we wrote the second half with the
offset here and check that the file was pieced together correctly as we
do in the previous test.

> +	SAFE_FSYNC(fd);
> +
> +	/* Read back using 2 vectors */
> +	partial_read[0] = read_iovs[0];
> +	partial_read[1] = read_iovs[1];
> +
> +	io_uring_do_vec_io_op(&s, fd, IORING_OP_READV, partial_read, 2, 0,
> +			      expected_size, &sig,
> +			      "Partial IORING_OP_READV (2 vectors) succeeded");
> +
> +	verify_vector_data(write_bufs, read_bufs, 2, "Partial vector I/O");
> +
> +	SAFE_CLOSE(fd);
> +
> +}
> +
> +static void test_varying_sizes(void)
> +{
> +	int fd;
> +	struct iovec var_write[3];
> +	struct iovec var_read[3];
> +	char buf1[512], buf2[1024], buf3[256];
> +	char rbuf1[512], rbuf2[1024], rbuf3[256];
> +	int expected_size = 512 + 1024 + 256;
> +
> +	tst_res(TINFO, "Testing vectors with varying sizes");
> +
> +	io_uring_init_buffer_pattern(buf1, 512, 'X');
> +	io_uring_init_buffer_pattern(buf2, 1024, 'Y');
> +	io_uring_init_buffer_pattern(buf3, 256, 'Z');
> +
> +	var_write[0].iov_base = buf1;
> +	var_write[0].iov_len = 512;
> +	var_write[1].iov_base = buf2;
> +	var_write[1].iov_len = 1024;
> +	var_write[2].iov_base = buf3;
> +	var_write[2].iov_len = 256;

First off all can we please allocate this with the guarded buffers.

> +	memset(rbuf1, 0, 512);
> +	memset(rbuf2, 0, 1024);
> +	memset(rbuf3, 0, 256);

We could use the generic clearing fucntions if we used the len argument
from the iovec instead of hardcoded buffer size. We just need to pass
the iovec lenght to the prepare_read_buffers(), loop over the array and
pass len to the memset. With that we can clear any iovec.

> +	var_read[0].iov_base = rbuf1;
> +	var_read[0].iov_len = 512;
> +	var_read[1].iov_base = rbuf2;
> +	var_read[1].iov_len = 1024;
> +	var_read[2].iov_base = rbuf3;
> +	var_read[2].iov_len = 256;

This as well.

> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
> +
> +	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, var_write, 3, 0,
> +			      expected_size, &sig,
> +			      "IORING_OP_WRITEV with varying sizes succeeded");
> +
> +	SAFE_FSYNC(fd);
> +
> +	io_uring_do_vec_io_op(&s, fd, IORING_OP_READV, var_read, 3, 0,
> +			      expected_size, &sig,
> +			      "IORING_OP_READV with varying sizes succeeded");
> +
> +	/* Verify each buffer */

Obvious comment.

> +	if (memcmp(buf1, rbuf1, 512) == 0 &&
> +	    memcmp(buf2, rbuf2, 1024) == 0 &&
> +	    memcmp(buf3, rbuf3, 256) == 0) {
> +		tst_res(TPASS, "Varying size vector data integrity verified");
> +	} else {
> +		tst_res(TFAIL, "Varying size vector data mismatch");
> +	}

This is very ugly code. Moreover you could easily use the common
function to check for the buffers if you haven't hardcoded the sizes
there and uses lenght from the iovec.

> +	SAFE_CLOSE(fd);
> +}
> +
> +static void run(void)
> +{
> +	io_uring_setup_queue(&s, QUEUE_DEPTH);
> +	test_writev_readv();
> +	test_partial_vectors();
> +	test_varying_sizes();
> +	io_uring_cleanup_queue(&s, QUEUE_DEPTH);

Here as well setup and cleanup of the queue should be done once in the
test setup/cleanup so that we do not do that again and again with the -i
parameter.

> +}

And we are missing some interesting testcases. We can, for instance,
have a buffer size 0 in the middle of the iovec and things should work
fine. We should do that in the variable sized test.

> +static void setup(void)
> +{
> +	io_uring_setup_supported_by_kernel();
> +	sigemptyset(&sig);
> +	memset(&s, 0, sizeof(s));
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_tmpdir = 1,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/proc/sys/kernel/io_uring_disabled", "0",
> +			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
> +		{}
> +	}
> +};
> -- 
> 2.39.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
