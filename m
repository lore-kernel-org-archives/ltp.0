Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180CFF46102
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 12:47:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 542F33E5571
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 13:47:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 398EC3E2B05
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 13:46:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 34C52600736
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 13:46:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE8A34D2F4;
 Mon, 23 Mar 2026 12:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774270015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V0MOb4QZENoDDiWXG+ZqR5/eoQJW6yAMESQ1P5BXjpw=;
 b=oDVMdP1ZjdMDKlBsn41608bwf6em55h210rs36609lTxg4ZIL+FwSGl+Xkrq7lKckZg8nD
 kGO63FdELIt7mraZaq5QiabZyV4QYrT/X1xexjOeMCiibuwA7phW+/ZCZsI6m2VZ+SICFG
 XqEW2lFCYC41giegKO84a3gLlvXus8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774270015;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V0MOb4QZENoDDiWXG+ZqR5/eoQJW6yAMESQ1P5BXjpw=;
 b=HXbP23Z8tRtrLD/jg6yhUIbEpchnQVRybQYhGgVcAdmt7uH05gwGFDn2MO6+WMvgwoUSQB
 Gj+IH9Uqc/vC6XDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Qbh5jqFJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RNvVjugZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774270014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V0MOb4QZENoDDiWXG+ZqR5/eoQJW6yAMESQ1P5BXjpw=;
 b=Qbh5jqFJQ/SMCoO6phxmVUcv2DKsNJcA1uNmF2bfvPha9oBwuYA9jN3jQ9PzrjSFKGDwhM
 vM9AQmSssgJZmqU5G7Gf11TNSAfk7Thn/GNm2A9gE4j/yNMvFgy6Xay7vclk91yxM913sN
 trxzxsIH0gqBvbg7bnNju3oV/tbaO9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774270014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V0MOb4QZENoDDiWXG+ZqR5/eoQJW6yAMESQ1P5BXjpw=;
 b=RNvVjugZDTtNeVvf/xvFrEIL1+0Y5ygGvQHelivs05T10YUuAcri98ZkVGWjVaF1/iG2nr
 y1Jqxo8/yy3z9hCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4D12438A3;
 Mon, 23 Mar 2026 12:46:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EaoQKz42wWnUMQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 23 Mar 2026 12:46:54 +0000
Date: Mon, 23 Mar 2026 13:46:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Sachin Sant <sachinp@linux.ibm.com>
Message-ID: <acE2O3kN3OQWuEqR@yuki.lan>
References: <20260320124742.75946-1-sachinp@linux.ibm.com>
 <20260320124742.75946-2-sachinp@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260320124742.75946-2-sachinp@linux.ibm.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: CE8A34D2F4
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] io_uring: Test IORING READ and WRITE
 operations
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
> Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
> ---
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/io_uring/.gitignore |   1 +
>  .../kernel/syscalls/io_uring/io_uring03.c     | 130 +++++++++
>  .../syscalls/io_uring/io_uring_common.h       | 265 ++++++++++++++++++
>  4 files changed, 397 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/io_uring/io_uring03.c
>  create mode 100644 testcases/kernel/syscalls/io_uring/io_uring_common.h
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 2179e007c..7dc80fe29 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1898,6 +1898,7 @@ membarrier01 membarrier01
>  
>  io_uring01 io_uring01
>  io_uring02 io_uring02
> +io_uring03 io_uring03
>  
>  # Tests below may cause kernel memory leak
>  perf_event_open03 perf_event_open03
> diff --git a/testcases/kernel/syscalls/io_uring/.gitignore b/testcases/kernel/syscalls/io_uring/.gitignore
> index 749db17db..9382ae413 100644
> --- a/testcases/kernel/syscalls/io_uring/.gitignore
> +++ b/testcases/kernel/syscalls/io_uring/.gitignore
> @@ -1,2 +1,3 @@
>  /io_uring01
>  /io_uring02
> +/io_uring03
> diff --git a/testcases/kernel/syscalls/io_uring/io_uring03.c b/testcases/kernel/syscalls/io_uring/io_uring03.c
> new file mode 100644
> index 000000000..0a73a331a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/io_uring/io_uring03.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 IBM
> + * Author: Sachin Sant <sachinp@linux.ibm.com>
> + */
> +/*
> + * Test IORING_OP_READ and IORING_OP_WRITE operations.
> + *
> + * This test validates basic read and write operations using io_uring.
> + * It tests:
> + * 1. IORING_OP_WRITE - Writing data to a file
> + * 2. IORING_OP_READ - Reading data from a file
> + * 3. Data integrity verification
> + */
> +
> +#include "io_uring_common.h"
> +
> +#define TEST_FILE "io_uring_test_file"
> +#define QUEUE_DEPTH 2
> +#define BLOCK_SZ 4096
> +
> +static char write_buf[BLOCK_SZ];
> +static char read_buf[BLOCK_SZ];

Can we please allocate these as a guarded buffers?

https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#guarded-buffers

> +static struct io_uring_submit s;
> +static sigset_t sig;
> +
> +static void init_buffer(char start_char)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < BLOCK_SZ; i++)
> +		write_buf[i] = start_char + (i % 26);
> +}
> +
> +static void verify_data_integrity(const char *test_name)
> +{
> +	size_t i;
> +
> +	if (memcmp(write_buf, read_buf, BLOCK_SZ) == 0) {
> +		tst_res(TPASS, "%s data integrity verified", test_name);
> +	} else {
> +		tst_res(TFAIL, "%s data mismatch", test_name);
> +		for (i = 0; i < BLOCK_SZ && i < 64; i++) {
> +			if (write_buf[i] != read_buf[i]) {
> +				tst_res(TINFO, "First mismatch at offset %zu: "
> +					"wrote 0x%02x, read 0x%02x",
> +					i, write_buf[i], read_buf[i]);
> +				break;
> +			}
> +		}
> +	}
> +}
> +
> +static void test_write_read(void)
> +{
> +	int fd;
> +
> +	init_buffer('A');
> +
> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
> +
> +	tst_res(TINFO, "Testing IORING_OP_WRITE");
> +	io_uring_do_io_op(&s, fd, IORING_OP_WRITE, write_buf, BLOCK_SZ, 0,
> +			  &sig, "IORING_OP_WRITE completed successfully");
> +
> +	SAFE_FSYNC(fd);
> +
> +	tst_res(TINFO, "Testing IORING_OP_READ");
> +	memset(read_buf, 0, BLOCK_SZ);
> +	io_uring_do_io_op(&s, fd, IORING_OP_READ, read_buf, BLOCK_SZ, 0,
> +			  &sig, "IORING_OP_READ completed successfully");
> +
> +	verify_data_integrity("Basic I/O");
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void test_partial_io(void)
> +{
> +	int fd;
> +	size_t half = BLOCK_SZ / 2;
> +
> +	tst_res(TINFO, "Testing partial I/O operations");
> +
> +	init_buffer('a');
> +
> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
> +
> +	io_uring_do_io_op(&s, fd, IORING_OP_WRITE, write_buf, half, 0,
> +			  &sig, "Partial write (first half) succeeded");
> +
> +	io_uring_do_io_op(&s, fd, IORING_OP_WRITE, write_buf + half, half,
> +			  half, &sig, "Partial write (second half) succeeded");
> +
> +	SAFE_FSYNC(fd);
> +
> +	memset(read_buf, 0, BLOCK_SZ);
> +	io_uring_do_io_op(&s, fd, IORING_OP_READ, read_buf, BLOCK_SZ, 0,
> +			  &sig, "Full read after partial writes succeeded");
> +
> +	verify_data_integrity("Partial I/O");
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void run(void)
> +{
> +	io_uring_setup_queue(&s, QUEUE_DEPTH);
> +	test_write_read();
> +	test_partial_io();
> +	io_uring_cleanup_queue(&s, QUEUE_DEPTH);

I suppose that we need to setup and cleanup the queue only once in test
setup() and cleanup() functions (when the test is executed with -i 2 on
command line).

> +}
> +
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
> diff --git a/testcases/kernel/syscalls/io_uring/io_uring_common.h b/testcases/kernel/syscalls/io_uring/io_uring_common.h
> new file mode 100644
> index 000000000..4162b5571
> --- /dev/null
> +++ b/testcases/kernel/syscalls/io_uring/io_uring_common.h
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 IBM
> + * Author: Sachin Sant <sachinp@linux.ibm.com>
> + *
> + * Common definitions and helper functions for io_uring tests
> + */
> +
> +#ifndef IO_URING_COMMON_H
> +#define IO_URING_COMMON_H
> +
> +#include <stdlib.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include "config.h"
> +#include "tst_test.h"
> +#include "lapi/io_uring.h"
> +
> +/* Common structures for io_uring ring management */
> +struct io_sq_ring {
> +	unsigned int *head;
> +	unsigned int *tail;
> +	unsigned int *ring_mask;
> +	unsigned int *ring_entries;
> +	unsigned int *flags;
> +	unsigned int *array;
> +};
> +
> +struct io_cq_ring {
> +	unsigned int *head;
> +	unsigned int *tail;
> +	unsigned int *ring_mask;
> +	unsigned int *ring_entries;
> +	struct io_uring_cqe *cqes;
> +};
> +
> +struct io_uring_submit {
> +	int ring_fd;
> +	struct io_sq_ring sq_ring;
> +	struct io_uring_sqe *sqes;
> +	struct io_cq_ring cq_ring;
> +	void *sq_ptr;
> +	size_t sq_ptr_size;
> +	void *cq_ptr;
> +	size_t cq_ptr_size;
> +};
> +
> +/*
> + * Setup io_uring instance with specified queue depth
> + * Returns 0 on success, -1 on failure
> + */
> +static inline int io_uring_setup_queue(struct io_uring_submit *s,
> +				       unsigned int queue_depth)
> +{
> +	struct io_sq_ring *sring = &s->sq_ring;
> +	struct io_cq_ring *cring = &s->cq_ring;
> +	struct io_uring_params p;
> +
> +	memset(&p, 0, sizeof(p));
> +	s->ring_fd = io_uring_setup(queue_depth, &p);
> +	if (s->ring_fd < 0) {
> +		tst_brk(TBROK | TERRNO, "io_uring_setup() failed");
> +		return -1;
> +	}
> +
> +	s->sq_ptr_size = p.sq_off.array + p.sq_entries * sizeof(unsigned int);
> +
> +	/* Map submission queue ring buffer */
> +	s->sq_ptr = SAFE_MMAP(0, s->sq_ptr_size, PROT_READ | PROT_WRITE,
> +			      MAP_SHARED | MAP_POPULATE, s->ring_fd,
> +			      IORING_OFF_SQ_RING);
> +
> +	/* Save submission queue pointers */
> +	sring->head = s->sq_ptr + p.sq_off.head;
> +	sring->tail = s->sq_ptr + p.sq_off.tail;
> +	sring->ring_mask = s->sq_ptr + p.sq_off.ring_mask;
> +	sring->ring_entries = s->sq_ptr + p.sq_off.ring_entries;
> +	sring->flags = s->sq_ptr + p.sq_off.flags;
> +	sring->array = s->sq_ptr + p.sq_off.array;
> +
> +	/* Map submission queue entries */
> +	s->sqes = SAFE_MMAP(0, p.sq_entries * sizeof(struct io_uring_sqe),
> +			    PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE,
> +			    s->ring_fd, IORING_OFF_SQES);
> +
> +	s->cq_ptr_size = p.cq_off.cqes +
> +			 p.cq_entries * sizeof(struct io_uring_cqe);
> +
> +	s->cq_ptr = SAFE_MMAP(0, s->cq_ptr_size, PROT_READ | PROT_WRITE,
> +			      MAP_SHARED | MAP_POPULATE, s->ring_fd,
> +			      IORING_OFF_CQ_RING);
> +
> +	/* Save completion queue pointers */
> +	cring->head = s->cq_ptr + p.cq_off.head;
> +	cring->tail = s->cq_ptr + p.cq_off.tail;
> +	cring->ring_mask = s->cq_ptr + p.cq_off.ring_mask;
> +	cring->ring_entries = s->cq_ptr + p.cq_off.ring_entries;
> +	cring->cqes = s->cq_ptr + p.cq_off.cqes;
> +
> +	return 0;
> +}
> +
> +/*
> + * Cleanup io_uring instance and unmap all memory regions
> + */
> +static inline void io_uring_cleanup_queue(struct io_uring_submit *s,
> +					  unsigned int queue_depth)
> +{
> +	if (s->sqes)
> +		SAFE_MUNMAP(s->sqes, queue_depth * sizeof(struct io_uring_sqe));
> +	if (s->cq_ptr)
> +		SAFE_MUNMAP(s->cq_ptr, s->cq_ptr_size);
> +	if (s->sq_ptr)
> +		SAFE_MUNMAP(s->sq_ptr, s->sq_ptr_size);
> +	if (s->ring_fd > 0)
> +		SAFE_CLOSE(s->ring_fd);
> +}
> +
> +/*
> + * Internal helper to submit a single SQE to the submission queue
> + * Used by both vectored and non-vectored I/O operations
> + */
> +static inline void io_uring_submit_sqe_internal(struct io_uring_submit *s,
> +						int fd, int opcode,
> +						unsigned long addr,
> +						unsigned int len,
> +						off_t offset)
> +{
> +	struct io_sq_ring *sring = &s->sq_ring;
> +	unsigned int tail, index;
> +	struct io_uring_sqe *sqe;
> +
> +	tail = *sring->tail;
> +	index = tail & *sring->ring_mask;
> +	sqe = &s->sqes[index];
> +
> +	memset(sqe, 0, sizeof(*sqe));
> +	sqe->opcode = opcode;
> +	sqe->fd = fd;
> +	sqe->addr = addr;
> +	sqe->len = len;
> +	sqe->off = offset;
> +	sqe->user_data = opcode;
> +
> +	sring->array[index] = index;
> +	tail++;
> +
> +	*sring->tail = tail;
> +}
> +
> +/*
> + * Submit a single SQE to the submission queue
> + * For basic read/write operations (non-vectored)
> + */
> +static inline void io_uring_submit_sqe(struct io_uring_submit *s, int fd,
> +				       int opcode, void *buf, size_t len,
> +				       off_t offset)
> +{
> +	io_uring_submit_sqe_internal(s, fd, opcode, (unsigned long)buf,
> +				     len, offset);
> +}
> +
> +/*
> + * Submit a vectored SQE to the submission queue
> + * For readv/writev operations
> + */
> +static inline void io_uring_submit_sqe_vec(struct io_uring_submit *s, int fd,
> +					   int opcode, struct iovec *iovs,
> +					   int nr_vecs, off_t offset)
> +{
> +	io_uring_submit_sqe_internal(s, fd, opcode, (unsigned long)iovs,
> +				     nr_vecs, offset);
> +}
> +
> +/*
> + * Wait for and validate a completion queue entry
> + * Returns 0 on success, -1 on failure
> + */
> +static inline int io_uring_wait_cqe(struct io_uring_submit *s,
> +				    int expected_res, int expected_opcode,
> +				    sigset_t *sig)
> +{
> +	struct io_cq_ring *cring = &s->cq_ring;
> +	struct io_uring_cqe *cqe;
> +	unsigned int head;
> +	int ret;
> +
> +	ret = io_uring_enter(s->ring_fd, 1, 1, IORING_ENTER_GETEVENTS, sig);
> +	if (ret < 0) {
> +		tst_res(TFAIL | TERRNO, "io_uring_enter() failed");
> +		return -1;
> +	}
> +
> +	head = *cring->head;
> +	if (head == *cring->tail) {
> +		tst_res(TFAIL, "No completion event received");
> +		return -1;
> +	}
> +
> +	cqe = &cring->cqes[head & *cring->ring_mask];
> +
> +	if (cqe->user_data != (uint64_t)expected_opcode) {
> +		tst_res(TFAIL, "Unexpected user_data: got %llu, expected %d",
> +			(unsigned long long)cqe->user_data, expected_opcode);
> +		*cring->head = head + 1;
> +		return -1;
> +	}
> +
> +	if (cqe->res != expected_res) {
> +		tst_res(TFAIL, "Operation failed: res=%d, expected=%d",
> +			cqe->res, expected_res);
> +		*cring->head = head + 1;
> +		return -1;
> +	}
> +
> +	*cring->head = head + 1;
> +	return 0;
> +}
> +
> +/*
> + * Initialize buffer with a repeating character pattern
> + * Useful for creating test data with predictable patterns
> + */
> +static inline void io_uring_init_buffer_pattern(char *buf, size_t size,
> +						char pattern)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < size; i++)
> +		buf[i] = pattern;
> +}
> +
> +/*
> + * Submit and wait for a non-vectored I/O operation
> + * Combines io_uring_submit_sqe() and io_uring_wait_cqe() with result reporting
> + */
> +static inline void io_uring_do_io_op(struct io_uring_submit *s, int fd,
> +				     int op, void *buf, size_t len,
> +				     off_t offset, sigset_t *sig,
> +				     const char *msg)
> +{
> +	io_uring_submit_sqe(s, fd, op, buf, len, offset);
> +
> +	if (io_uring_wait_cqe(s, len, op, sig) == 0)
> +		tst_res(TPASS, "%s", msg);

Rather than passing the description passed from the caller I would print
the parameters passed to the function, something as:

		tst_res(TPASS, "OP=%2x fd=%i buf=%p len=%zu offset=%jd",
		        op, fd, buf, len, (intmax_t)offset);

And we can add a function to map the OP to the enum name if we want to
have fancy messages:

static const char *ioring_op_name(int op)
{
	switch (op) {
	case IORING_READ:
		return "IORING_READ";
	...
	defaut:
		return "UNKNOWN"
}

Then we can print the OP as:

tst_res(TPASS, "OP=%s (%2x) ...", ioring_op_name(op), op, ...);

With this approach we will avoid copy&paste mistakes, it's way too easy
for messages and parameters written manually to get out of sync.

Also we should either propagate the failure to the test by returning
non-zero from this function if waiting for completion failed (so that
the test can abort) or call tst_brk(TBROK, ...) in the
io_uring_wait_cqe() which will abort the test when something fails
automatically.

> +}
> +
> +/*
> + * Submit and wait for a vectored I/O operation
> + * Combines io_uring_submit_sqe_vec() and io_uring_wait_cqe() with
> + * result reporting
> + */
> +static inline void io_uring_do_vec_io_op(struct io_uring_submit *s, int fd,
> +					 int op, struct iovec *iovs,
> +					 int nvecs, off_t offset,
> +					 int expected_size, sigset_t *sig,
> +					 const char *msg)
> +{
> +	io_uring_submit_sqe_vec(s, fd, op, iovs, nvecs, offset);
> +
> +	if (io_uring_wait_cqe(s, expected_size, op, sig) == 0)
> +		tst_res(TPASS, "%s", msg);

And here as well, I would rather see the message generated from the
parameters and we should handle the failure somehow too.

> +}
> +
> +#endif /* IO_URING_COMMON_H */
> -- 
> 2.39.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
