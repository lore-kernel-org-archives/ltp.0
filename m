From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 8 Feb 2021 10:37:23 +0100
Subject: [LTP] [PATCH v2 4/4] Add test for CVE 2020-29373
In-Reply-To: <YB13HM7so0YBwO8v@pevik>
References: <20210204110342.11821-1-mdoucha@suse.cz>
 <20210204110342.11821-4-mdoucha@suse.cz> <YB13HM7so0YBwO8v@pevik>
Message-ID: <9a49f90c-7467-ae65-84be-2f559a8771dd@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05. 02. 21 17:49, Petr Vorel wrote:
> Hi Martin,
> 
>> Fixes #770
> 
> Nice port thanks!
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Few questions below.
> 
> ...
>> +static void run(void)
>> +{
>> +	uint32_t i, count, tail;
>> +	int beef_found = 0;
>> +	struct io_uring_sqe *sqe_ptr;
>> +	const struct io_uring_cqe *cqe_ptr;
>> +
>> +	SAFE_SOCKETPAIR(AF_UNIX, SOCK_DGRAM, 0, sockpair);
>> +	SAFE_SETSOCKOPT_INT(sockpair[0], SOL_SOCKET, SO_SNDBUF,
>> +		32+sizeof(buf));
>> +	SAFE_FCNTL(sockpair[0], F_SETFL, O_NONBLOCK);
>> +
>> +	SAFE_IO_URING_INIT(512, &params, &uring);
>> +	sqe_ptr = uring.sqr_entries;
>> +
>> +	/* Add spam requests to force async processing of the real test */
>> +	for (i = 0, tail = *uring.sqr_tail; i < 255; i++, tail++, sqe_ptr++) {
>> +		memset(sqe_ptr, 0, sizeof(*sqe_ptr));
>> +		sqe_ptr->opcode = IORING_OP_SENDMSG;
>> +		sqe_ptr->flags = IOSQE_IO_DRAIN;
>> +		sqe_ptr->fd = sockpair[0];
>> +		sqe_ptr->addr = (__u64)&spam_header;
>> +		sqe_ptr->user_data = SPAM_MARK;
> Interesting, original reproducer uses here i
> 
>> +		uring.sqr_array[tail & *uring.sqr_mask] = i;
>> +	}
>> +
>> +	/* Add the real test to queue */
>> +	memset(sqe_ptr, 0, sizeof(*sqe_ptr));
>> +	sqe_ptr->opcode = IORING_OP_SENDMSG;
>> +	sqe_ptr->flags = IOSQE_IO_DRAIN;
>> +	sqe_ptr->fd = sendsock;
>> +	sqe_ptr->addr = (__u64)&beef_header;
>> +	sqe_ptr->user_data = BEEF_MARK;
> and here also 255, you use much higher 0xbeef.
> 
> You probably have a good reason to use here 0xfa7 (higher value). But maybe
> explaining why?

The good reason is that I like puns. sqe_ptr->user_data is not processed
by the kernel in any way except for copying the value into the
completion queue when the I/O request finishes. And we don't care
whether we can tell apart the spam request results from one another so
giving them all the same marker is good enough.

>> +	uring.sqr_array[tail & *uring.sqr_mask] = i;
>> +	count = ++i;
>> +	tail++;
>> +
>> +	__atomic_store(uring.sqr_tail, &tail, __ATOMIC_RELEASE);
>> +	SAFE_IO_URING_ENTER(1, uring.fd, count, count, IORING_ENTER_GETEVENTS,
>> +		NULL);
>> +
>> +	/* Check test results */
>> +	__atomic_load(uring.cqr_tail, &tail, __ATOMIC_ACQUIRE);
>> +
>> +	for (i = *uring.cqr_head; i != tail; i++, count--) {
>> +		cqe_ptr = uring.cqr_entries + (i & *uring.cqr_mask);
>> +		TST_ERR = -cqe_ptr->res;
>> +
>> +		if (cqe_ptr->user_data == SPAM_MARK) {
>> +			if (cqe_ptr->res >= 0 || cqe_ptr->res == -EAGAIN)
>> +				continue;
>> +
>> +			tst_res(TFAIL | TTERRNO,
>> +				"Spam request failed unexpectedly");
> I'm sorry, I'm lost to which TEST*() call this TTERRNO refers (there are mostly
> SAFE_*() macros.

I'm setting TST_ERR manually 6 lines above the tst_res() call. The errno
value is in cqe_ptr->res.


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
