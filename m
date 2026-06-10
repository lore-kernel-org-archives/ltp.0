Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25910CD8CB9
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 16:08:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A87E3E6E90
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 18:08:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 981EA3C1B73
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 18:08:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AB1ED1400434
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 18:08:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BCF7D6ABCA;
 Wed, 10 Jun 2026 16:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781107703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=exSSQRF8NGnngPFDVNgqDr1Mlw2n2BSaEXa/35pVgqU=;
 b=h7Zng0j8vVE13UOP1MvRbXe6oSxf8Q2GMLix/RPPLN2XjW1WELOS2vxmwnFa1lyvPxMP+N
 q2esopN5GrEp6dv8Z2Jiv8PcR4vZ8jbBEYA8oZrS5BVHsJ366RA+EZzuYMiJSCK92u9us9
 KSKoi1JZdrKuQn3BRJKTx8VSLMRS+Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781107703;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=exSSQRF8NGnngPFDVNgqDr1Mlw2n2BSaEXa/35pVgqU=;
 b=pYIydPgpmCtDvOrvkZay5s1VUtRKFlXUuGBNoQ/1s3YNXzje9BFIcJctflqdmi9nLBtfVg
 oYJbppST/FUSSJAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781107703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=exSSQRF8NGnngPFDVNgqDr1Mlw2n2BSaEXa/35pVgqU=;
 b=h7Zng0j8vVE13UOP1MvRbXe6oSxf8Q2GMLix/RPPLN2XjW1WELOS2vxmwnFa1lyvPxMP+N
 q2esopN5GrEp6dv8Z2Jiv8PcR4vZ8jbBEYA8oZrS5BVHsJ366RA+EZzuYMiJSCK92u9us9
 KSKoi1JZdrKuQn3BRJKTx8VSLMRS+Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781107703;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=exSSQRF8NGnngPFDVNgqDr1Mlw2n2BSaEXa/35pVgqU=;
 b=pYIydPgpmCtDvOrvkZay5s1VUtRKFlXUuGBNoQ/1s3YNXzje9BFIcJctflqdmi9nLBtfVg
 oYJbppST/FUSSJAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA02F779A7;
 Wed, 10 Jun 2026 16:08:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fsK5KPeLKWr6SAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Wed, 10 Jun 2026 16:08:23 +0000
Message-ID: <c78da4ef-c229-4712-9486-867c366557d8@suse.cz>
Date: Wed, 10 Jun 2026 18:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sebastian Chlad <sebastianchlad@gmail.com>, ltp@lists.linux.it
References: <20260608143652.6356-1-sebastian.chlad@suse.com>
 <20260608143652.6356-2-sebastian.chlad@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20260608143652.6356-2-sebastian.chlad@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,lists.linux.it];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] io_uring: Redesign common helpers to follow
 liburing API conventions
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
as the AI review said, this patch should be split into two parts:
1) add the new helpers first
2) remove old helpers after all tests have been ported to the new ones

The other two patches updating tests look good. Two notes below.

On 6/8/26 16:36, Sebastian Chlad wrote:
> Replace coupled submit and wait helpers with a proper liburing-style API:
> - io_uring_get_sqe(): get next SQE slot from the submission ring
> - io_uring_prep_rw(): generic SQE fill for read/write perations
> - io_uring_prep_read/write/readv/writev(): operation-specific prep helpers
> - io_uring_sqe_set_data64(): set user_data explicitly on the SQE
> - io_uring_submit(): submit all pending SQEs to the kernel
> - io_uring_wait_cqe(): wait for next CQE, return pointer without consuming it
> - io_uring_cqe_seen(): advance the CQ head to mark a CQE as consumed
> 
> The old io_uring_do_io_op() and io_uring_do_vec_io_op() helpers are
> removed. They coupled SQE submission with an immediate CQE wait, making
> tests effectively synchronous, and emitted tst_res(TPASS) from inside
> the helper, hiding where test results came from. They also set user_data
> to the opcode value, which is meaningless as a per-request tag and would
> cause spurious passes in any test with multiple in-flight SQEs of the
> same opcode.
> 
> With the new API, each test controls SQE preparation, user_data
> assignment, submission, CQE validation and result reporting explicitly
> in its own body, matching how real io_uring applications are written.
> 
> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> ---
>   .../syscalls/io_uring/io_uring_common.h       | 193 ++++++++----------
>   1 file changed, 85 insertions(+), 108 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/io_uring/io_uring_common.h b/testcases/kernel/syscalls/io_uring/io_uring_common.h
> index aa31339fb..18fdfc9b6 100644
> --- a/testcases/kernel/syscalls/io_uring/io_uring_common.h
> +++ b/testcases/kernel/syscalls/io_uring/io_uring_common.h
> @@ -3,6 +3,8 @@
>    * Copyright (C) 2026 IBM
>    * Author: Sachin Sant <sachinp@linux.ibm.com>
>    *
> + * Copyright (C) 2026 Sebastian Chlad <sebastian.chlad@suse.com>
> + *
>    * Common definitions and helper functions for io_uring tests
>    */
>   
> @@ -43,6 +45,7 @@ struct io_uring_submit {
>   	size_t sq_ptr_size;
>   	void *cq_ptr;
>   	size_t cq_ptr_size;
> +	unsigned int sq_pending;
>   };
>   
>   /*
> @@ -117,162 +120,136 @@ static inline void io_uring_cleanup_queue(struct io_uring_submit *s,
>   }
>   
>   /*
> - * Internal helper to submit a single SQE to the submission queue
> - * Used by both vectored and non-vectored I/O operations
> + * Get the next available SQE slot from the submission ring.
> + * The SQE is zeroed and tracked as pending until io_uring_submit() is called.
>    */
> -static inline void io_uring_submit_sqe_internal(struct io_uring_submit *s,
> -						int fd, int opcode,
> -						unsigned long addr,
> -						unsigned int len,
> -						off_t offset,
> -						unsigned long long user_data)
> +static inline struct io_uring_sqe *io_uring_get_sqe(struct io_uring_submit *s)
>   {
>   	struct io_sq_ring *sring = &s->sq_ring;
> -	unsigned int tail, index;
> -	struct io_uring_sqe *sqe;
> -
> -	tail = *sring->tail;
> -	index = tail & *sring->ring_mask;
> -	sqe = &s->sqes[index];
> +	unsigned int index = (*sring->tail + s->sq_pending) & *sring->ring_mask;
> +	struct io_uring_sqe *sqe = &s->sqes[index];
>   
>   	memset(sqe, 0, sizeof(*sqe));
> +	sring->array[index] = index;
> +	s->sq_pending++;
> +
> +	return sqe;
> +}
> +
> +/*
> + * Generic SQE fill for read/write family operations.
> + * Does not touch user_data - caller sets it via io_uring_sqe_set_data64().
> + */
> +static inline void io_uring_prep_rw(struct io_uring_sqe *sqe, int opcode,
> +				    int fd, const void *addr, unsigned int len,
> +				    off_t offset)
> +{
>   	sqe->opcode = opcode;
>   	sqe->fd = fd;
> -	sqe->addr = addr;
> +	sqe->addr = (unsigned long)addr;
>   	sqe->len = len;
>   	sqe->off = offset;
> -	sqe->user_data = user_data;
> +}
>   
> -	sring->array[index] = index;
> -	tail++;
> +static inline void io_uring_prep_read(struct io_uring_sqe *sqe, int fd,
> +				      void *buf, size_t len, off_t offset)
> +{
> +	io_uring_prep_rw(sqe, IORING_OP_READ, fd, buf, len, offset);
> +}
>   
> -	*sring->tail = tail;
> +static inline void io_uring_prep_write(struct io_uring_sqe *sqe, int fd,
> +				       const void *buf, size_t len, off_t offset)
> +{
> +	io_uring_prep_rw(sqe, IORING_OP_WRITE, fd, buf, len, offset);
>   }
>   
> -/*
> - * Submit a single SQE to the submission queue
> - * For basic read/write operations (non-vectored)
> - */
> -static inline void io_uring_submit_sqe(struct io_uring_submit *s, int fd,
> -				       int opcode, void *buf, size_t len,
> +static inline void io_uring_prep_readv(struct io_uring_sqe *sqe, int fd,
> +				       struct iovec *iovs, int nr_vecs,
>   				       off_t offset)
>   {
> -	io_uring_submit_sqe_internal(s, fd, opcode, (unsigned long)buf,
> -				     len, offset, opcode);
> +	io_uring_prep_rw(sqe, IORING_OP_READV, fd, iovs, nr_vecs, offset);
> +}
> +
> +static inline void io_uring_prep_writev(struct io_uring_sqe *sqe, int fd,
> +					struct iovec *iovs, int nr_vecs,
> +					off_t offset)
> +{
> +	io_uring_prep_rw(sqe, IORING_OP_WRITEV, fd, iovs, nr_vecs, offset);
>   }
>   
>   /*
> - * Submit a vectored SQE to the submission queue
> - * For readv/writev operations
> + * Set the user_data field of an SQE. user_data is returned verbatim in the
> + * corresponding CQE and must be unique per in-flight request to allow correct
> + * correlation of completions.
>    */
> -static inline void io_uring_submit_sqe_vec(struct io_uring_submit *s, int fd,
> -					   int opcode, struct iovec *iovs,
> -					   int nr_vecs, off_t offset)
> +static inline void io_uring_sqe_set_data64(struct io_uring_sqe *sqe,
> +					   uint64_t data)
>   {
> -	io_uring_submit_sqe_internal(s, fd, opcode, (unsigned long)iovs,
> -				     nr_vecs, offset, opcode);
> +	sqe->user_data = data;
>   }
>   
>   /*
> - * Map io_uring operation code to human-readable name
> + * Submit all pending SQEs to the kernel.
>    */
> -static inline const char *ioring_op_name(int op)
> +static inline void io_uring_submit(struct io_uring_submit *s)
>   {
> -	switch (op) {
> -	case IORING_OP_READV:
> -		return "IORING_OP_READV";
> -	case IORING_OP_WRITEV:
> -		return "IORING_OP_WRITEV";
> -	case IORING_OP_READ:
> -		return "IORING_OP_READ";
> -	case IORING_OP_WRITE:
> -		return "IORING_OP_WRITE";
> -	default:
> -		return "UNKNOWN";
> -	}
> +	unsigned int pending = s->sq_pending;
> +
> +	if (!pending)
> +		return;
> +
> +	*s->sq_ring.tail += pending;

I think that updating submission ring tail should be done using atomic 
operations, otherwise the kernel may see inconsistent value.

> +	s->sq_pending = 0;
> +
> +	if (io_uring_enter(s->ring_fd, pending, 0, 0, NULL) < 0)
> +		tst_brk(TBROK | TERRNO, "io_uring_enter() failed");
>   }
>   
>   /*
> - * Wait for and validate a completion queue entry
> - * Aborts test on failure using tst_brk()
> + * Wait for the next CQE and return a pointer to it.
> + * Does not advance the CQ head - call io_uring_cqe_seen() when done.
>    */
> -static inline void io_uring_wait_cqe(struct io_uring_submit *s,
> -				     int expected_res, int expected_opcode,
> -				     sigset_t *sig)
> +static inline struct io_uring_cqe *io_uring_wait_cqe(struct io_uring_submit *s,
> +						      sigset_t *sig)
>   {
>   	struct io_cq_ring *cring = &s->cq_ring;
> -	struct io_uring_cqe *cqe;
> -	unsigned int head;
>   	int ret;
>   
> -	ret = io_uring_enter(s->ring_fd, 1, 1, IORING_ENTER_GETEVENTS, sig);
> +	ret = io_uring_enter(s->ring_fd, 0, 1, IORING_ENTER_GETEVENTS, sig);
>   	if (ret < 0)
>   		tst_brk(TBROK | TERRNO, "io_uring_enter() failed");
>   
> -	head = *cring->head;
> -	if (head == *cring->tail)
> +	if (*cring->head == *cring->tail)

Reading the completion queue tail should also be done atomically. 
Imagine you submit multiple I/O requests and then wait for the first one 
to finish. The kernel may update the tail value while you're trying to 
read it and a non-atomic read may produce nonsensical value.

>   		tst_brk(TBROK, "No completion event received");
>   
> -	cqe = &cring->cqes[head & *cring->ring_mask];
> -
> -	if (cqe->user_data != (uint64_t)expected_opcode) {
> -		*cring->head = head + 1;
> -		tst_brk(TBROK, "Unexpected user_data: got %llu, expected %d",
> -			(unsigned long long)cqe->user_data, expected_opcode);
> -	}
> -
> -	if (cqe->res != expected_res) {
> -		*cring->head = head + 1;
> -		tst_brk(TBROK, "Operation failed: res=%d, expected=%d",
> -			cqe->res, expected_res);
> -	}
> -
> -	*cring->head = head + 1;
> +	return &cring->cqes[*cring->head & *cring->ring_mask];
>   }
>   
>   /*
> - * Initialize buffer with a repeating character pattern
> - * Useful for creating test data with predictable patterns
> + * Mark the current CQE as consumed, advancing the CQ head.
>    */
> -static inline void io_uring_init_buffer_pattern(char *buf, size_t size,
> -						char pattern)
> +static inline void io_uring_cqe_seen(struct io_uring_submit *s)
>   {
> -	size_t i;
> -
> -	for (i = 0; i < size; i++)
> -		buf[i] = pattern;
> +	(*s->cq_ring.head)++;
>   }
>   
>   /*
> - * Submit and wait for a non-vectored I/O operation
> - * Combines io_uring_submit_sqe() and io_uring_wait_cqe() with result reporting
> - */
> -static inline void io_uring_do_io_op(struct io_uring_submit *s, int fd,
> -				     int op, void *buf, size_t len,
> -				     off_t offset, sigset_t *sig)
> -{
> -	io_uring_submit_sqe(s, fd, op, buf, len, offset);
> -	io_uring_wait_cqe(s, len, op, sig);
> -	tst_res(TPASS, "OP=%s (%02x) fd=%i buf=%p len=%zu offset=%jd",
> -		ioring_op_name(op), op, fd, buf, len, (intmax_t)offset);
> -}
> -
> -/*
> - * Submit and wait for a vectored I/O operation
> - * Combines io_uring_submit_sqe_vec() and io_uring_wait_cqe() with
> - * result reporting
> + * Map io_uring operation code to human-readable name
>    */
> -static inline void io_uring_do_vec_io_op(struct io_uring_submit *s, int fd,
> -					 int op, struct iovec *iovs,
> -					 int nvecs, off_t offset,
> -					 int expected_size, sigset_t *sig)
> +static inline const char *ioring_op_name(int op)
>   {
> -	io_uring_submit_sqe_vec(s, fd, op, iovs, nvecs, offset);
> -	io_uring_wait_cqe(s, expected_size, op, sig);
> -	tst_res(TPASS, "OP=%s (%02x) fd=%i iovs=%p nvecs=%i offset=%jd "
> -		"expected_size=%i",
> -		ioring_op_name(op), op, fd, iovs, nvecs, (intmax_t)offset,
> -		expected_size);
> +	switch (op) {
> +	case IORING_OP_READV:
> +		return "IORING_OP_READV";
> +	case IORING_OP_WRITEV:
> +		return "IORING_OP_WRITEV";
> +	case IORING_OP_READ:
> +		return "IORING_OP_READ";
> +	case IORING_OP_WRITE:
> +		return "IORING_OP_WRITE";
> +	default:
> +		return "UNKNOWN";
> +	}
>   }
>   
>   #endif /* IO_URING_COMMON_H */


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
