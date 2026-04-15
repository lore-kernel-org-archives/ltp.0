Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD11F41987
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 09:59:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D03D3E5B7F
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 11:59:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4F563E2660
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 11:59:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0F087200A00
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 11:59:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2BD7D6A7E3;
 Wed, 15 Apr 2026 09:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776247143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LGZf3ZWn6AZkDMOOLJ7WafJkMDYsIpk62g76Fnxo/Y4=;
 b=thdIP84TqDo836+Vwi0Jr4yrLRHcn+zcED8MY8/VAVgriNZ1YYpL39MdkZJVRzVenn9+JS
 FuhAWqb6YvfYmxQA4ruUPKmMg4lNf3Q3gjGzxuLnPZwm2ySExpTQCev5rlfAhmOwtbxcPG
 1qRCP820gw1lCXQOG2uby+0KDAoa46g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776247143;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LGZf3ZWn6AZkDMOOLJ7WafJkMDYsIpk62g76Fnxo/Y4=;
 b=fKPRncCXp+rLr5f5DYfw3eNbNDiGzhnhh8b4gdxRIQh3TSgAIGDSEUxCQaCV+lbKz+ZTLC
 a8TGKoC2oUmb9KAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=thdIP84T;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fKPRncCX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776247143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LGZf3ZWn6AZkDMOOLJ7WafJkMDYsIpk62g76Fnxo/Y4=;
 b=thdIP84TqDo836+Vwi0Jr4yrLRHcn+zcED8MY8/VAVgriNZ1YYpL39MdkZJVRzVenn9+JS
 FuhAWqb6YvfYmxQA4ruUPKmMg4lNf3Q3gjGzxuLnPZwm2ySExpTQCev5rlfAhmOwtbxcPG
 1qRCP820gw1lCXQOG2uby+0KDAoa46g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776247143;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LGZf3ZWn6AZkDMOOLJ7WafJkMDYsIpk62g76Fnxo/Y4=;
 b=fKPRncCXp+rLr5f5DYfw3eNbNDiGzhnhh8b4gdxRIQh3TSgAIGDSEUxCQaCV+lbKz+ZTLC
 a8TGKoC2oUmb9KAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1831D4B950;
 Wed, 15 Apr 2026 09:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S/J+BGdh32kiFQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 15 Apr 2026 09:59:03 +0000
Date: Wed, 15 Apr 2026 11:59:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sachin Sant <sachinp@linux.ibm.com>
Message-ID: <ad9hdOxg9CYxgNBb@yuki.lan>
References: <20260324052241.21455-1-sachinp@linux.ibm.com>
 <20260324052241.21455-3-sachinp@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260324052241.21455-3-sachinp@linux.ibm.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, yuki.lan:mid]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2BD7D6A7E3
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] io_uring: Test READV and WRITEV operations
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
> +#include "io_uring_common.h"
> +
> +#define TEST_FILE "io_uring_test_file"
> +#define QUEUE_DEPTH 2
> +#define NUM_VECS 4
> +#define VEC_SIZE 1024
> +#define VAR_BUF1_SIZE 512
> +#define VAR_BUF2_SIZE 1024
> +#define VAR_BUF3_SIZE 256
> +
> +static struct iovec *write_iovs, *read_iovs;
> +static struct iovec *var_write_iovs, *var_read_iovs;
> +static struct io_uring_submit s;
> +static sigset_t sig;
> +
> +static void prepare_write_buffers(void)
> +{
> +	size_t i, j;
> +	char *buf;
> +
> +	for (i = 0; i < NUM_VECS; i++) {
> +		buf = (char *)write_iovs[i].iov_base;
> +		for (j = 0; j < write_iovs[i].iov_len; j++) {
> +			/* Each vector has a different pattern */
> +			buf[j] = 'A' + i + (j % 26);
> +		}
> +	}
> +}
> +
> +static void prepare_read_buffers(void)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < NUM_VECS; i++)
> +		memset(read_iovs[i].iov_base, 0, read_iovs[i].iov_len);
> +}
> +
> +static void clear_iovec_buffers(struct iovec *iovs, int nvecs)
> +{
> +	int i;
> +
> +	for (i = 0; i < nvecs; i++)
> +		memset(iovs[i].iov_base, 0, iovs[i].iov_len);
> +}

These two functions are nearly identical, we really need only one
function to clear the buffers.

> +static void verify_iovec_data(struct iovec *write_iovs, struct iovec *read_iovs,
> +			      int nvecs, const char *test_name)
> +{
> +	int i;
> +	size_t j;
> +
> +	for (i = 0; i < nvecs; i++) {
> +		if (write_iovs[i].iov_len != read_iovs[i].iov_len) {
> +			tst_res(TFAIL, "%s: iovec %d length mismatch: write=%zu read=%zu",
> +				test_name, i, write_iovs[i].iov_len, read_iovs[i].iov_len);
> +			return;
> +		}
> +
> +		if (memcmp(write_iovs[i].iov_base, read_iovs[i].iov_base,
> +			   write_iovs[i].iov_len) != 0) {
> +			tst_res(TFAIL, "%s: data mismatch in vector %d", test_name, i);
> +			for (j = 0; j < write_iovs[i].iov_len && j < 64; j++) {
> +				char *wbuf = (char *)write_iovs[i].iov_base;
> +				char *rbuf = (char *)read_iovs[i].iov_base;
> +				if (wbuf[j] != rbuf[j]) {
> +					tst_res(TINFO, "Vector %d: first mismatch at "
> +						"offset %zu: wrote 0x%02x, read 0x%02x",
> +						i, j, wbuf[j], rbuf[j]);
> +					break;
> +				}
> +			}
> +			return;
> +		}
> +	}
> +
> +	tst_res(TPASS, "%s: data integrity verified across %d vectors",
> +		test_name, nvecs);
> +}
> +
> +
> +static void test_writev_readv(void)
> +{
> +	int fd;
> +	int total_size = NUM_VECS * VEC_SIZE;
> +
> +	tst_res(TINFO, "Testing IORING_OP_WRITEV and IORING_OP_READV");
> +
> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
> +
> +	tst_res(TINFO, "Writing %d bytes using %d vectors", total_size, NUM_VECS);
> +	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, write_iovs, NUM_VECS,
> +			      0, total_size, &sig);
> +
> +	SAFE_FSYNC(fd);
> +
> +	tst_res(TINFO, "Reading %d bytes using %d vectors", total_size, NUM_VECS);
> +	io_uring_do_vec_io_op(&s, fd, IORING_OP_READV, read_iovs, NUM_VECS,
> +			      0, total_size, &sig);
> +
> +	verify_iovec_data(write_iovs, read_iovs, NUM_VECS, "Basic vectored I/O");
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void test_partial_vectors(void)
> +{
> +	int fd;
> +	int half_size = 2 * VEC_SIZE;
> +
> +	tst_res(TINFO, "Testing partial vector operations");
> +
> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
> +
> +	/* Write first half using first 2 vectors at offset 0 */
> +	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, write_iovs, 2, 0,
> +			      half_size, &sig);
> +
> +	/* Write second half using next 2 vectors at offset half_size */
> +	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, &write_iovs[2], 2,
> +			      half_size, half_size, &sig);
> +
> +	SAFE_FSYNC(fd);
> +
> +	/* Read back entire file using all 4 vectors */
> +	io_uring_do_vec_io_op(&s, fd, IORING_OP_READV, read_iovs, NUM_VECS, 0,
> +			      NUM_VECS * VEC_SIZE, &sig);
> +
> +	verify_iovec_data(write_iovs, read_iovs, NUM_VECS, "Partial vector I/O");
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void test_varying_sizes(void)
> +{
> +	int fd;
> +	int expected_size = VAR_BUF1_SIZE + VAR_BUF2_SIZE + VAR_BUF3_SIZE;
> +
> +	tst_res(TINFO, "Testing vectors with varying sizes including zero-length buffer");
> +
> +	io_uring_init_buffer_pattern(var_write_iovs[0].iov_base, VAR_BUF1_SIZE, 'X');
> +	io_uring_init_buffer_pattern(var_write_iovs[2].iov_base, VAR_BUF2_SIZE, 'Y');
> +	io_uring_init_buffer_pattern(var_write_iovs[3].iov_base, VAR_BUF3_SIZE, 'Z');

Can we handle this with the prepare_write_buffers() as well?

> +	clear_iovec_buffers(var_read_iovs, 4);
> +
> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
> +
> +	io_uring_do_vec_io_op(&s, fd, IORING_OP_WRITEV, var_write_iovs, 4, 0,
> +			      expected_size, &sig);
> +
> +	SAFE_FSYNC(fd);
> +
> +	io_uring_do_vec_io_op(&s, fd, IORING_OP_READV, var_read_iovs, 4, 0,
> +			      expected_size, &sig);
> +
> +	verify_iovec_data(var_write_iovs, var_read_iovs, 4, "Varying size vector I/O with zero-length buffer");
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void run(void)
> +{
> +	test_writev_readv();
> +	test_partial_vectors();
> +	test_varying_sizes();
> +}
> +
> +static void setup(void)
> +{
> +	io_uring_setup_supported_by_kernel();
> +	sigemptyset(&sig);
> +	memset(&s, 0, sizeof(s));
> +	io_uring_setup_queue(&s, QUEUE_DEPTH, 0);
> +	prepare_write_buffers();
> +	prepare_read_buffers();
> +}
> +
> +static void cleanup(void)
> +{
> +	io_uring_cleanup_queue(&s, QUEUE_DEPTH);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.bufs = (struct tst_buffers []) {
> +		{&write_iovs, .iov_sizes = (int[]){VEC_SIZE, VEC_SIZE, VEC_SIZE, VEC_SIZE, -1}},
> +		{&read_iovs, .iov_sizes = (int[]){VEC_SIZE, VEC_SIZE, VEC_SIZE, VEC_SIZE, -1}},
> +		{&var_write_iovs, .iov_sizes = (int[]){VAR_BUF1_SIZE, 0, VAR_BUF2_SIZE, VAR_BUF3_SIZE, -1}},
> +		{&var_read_iovs, .iov_sizes = (int[]){VAR_BUF1_SIZE, 0, VAR_BUF2_SIZE, VAR_BUF3_SIZE, -1}},
> +		{}
> +	},
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
