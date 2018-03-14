From: Eric Biggers <ebiggers3@gmail.com>
Date: Wed, 14 Mar 2018 15:58:49 -0700
Subject: [LTP] [PATCH 2/2] Add CVE-2017-18075,
 pcrypt mishandles freeing instances
In-Reply-To: <20180314145427.2738-2-rpalethorpe@suse.com>
References: <20180314145427.2738-1-rpalethorpe@suse.com>
 <20180314145427.2738-2-rpalethorpe@suse.com>
Message-ID: <20180314225849.GD183724@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

On Wed, Mar 14, 2018 at 03:54:27PM +0100, Richard Palethorpe wrote:
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
> 
> I can not find the original reproducer posted upstream. I assume it was
> created by syzkaller.
> 
> This patch will not display error messages correctly without the previous
> TRERRNO patch I posted.
> 
>  runtest/cve                    |   1 +
>  testcases/cve/.gitignore       |   1 +
>  testcases/cve/cve-2017-18075.c | 201 +++++++++++++++++++++++++++++++++++++++++

Thanks for writing an LTP test for this!

Just my 2 cents, but I think it is insane to be naming tests after CVE numbers
instead of putting them in an appropriate place, like a crypto/ directory for
this one.  People aren't going to remember what "CVE-2017-18075" is.  I'm even
the person who fixed this bug and requested this CVE, and I still didn't
recognize the CVE number; this patch only drew my attention because the subject
line mentioned pcrypt.  (And now I see that I missed the recent test for the
modify_ldt() use-after-free bug because the patch subject line and description
only mentioned "CVE-2017-17053".)

Note that you can still put the test in the "cve" runtest file even if the test
is not in the cve/ directory.

(More comments below)

> diff --git a/testcases/cve/cve-2017-18075.c b/testcases/cve/cve-2017-18075.c
[...]
> +
> +#define ATTEMPTS 10000
> +
> +enum {
> +	CRYPTO_MSG_BASE = 0x10,
> +	CRYPTO_MSG_NEWALG = 0x10,
> +	CRYPTO_MSG_DELALG,
> +	CRYPTO_MSG_UPDATEALG,
> +	CRYPTO_MSG_GETALG,
> +	CRYPTO_MSG_DELRNG,
> +	__CRYPTO_MSG_MAX
> +};
> +
> +#define CRYPTO_MAX_ALG_NAME		64
> +#define CRYPTO_MAX_NAME CRYPTO_MAX_ALG_NAME
> +
> +#define CRYPTO_ALG_TYPE_MASK		0x0000000f
> +#define CRYPTO_ALG_TYPE_AEAD		0x00000003
> +
> +#ifndef NETLINK_CRYPTO
> +#define NETLINK_CRYPTO 21
> +#endif
> +
> +struct crypto_user_alg {
> +	char cru_name[CRYPTO_MAX_ALG_NAME];
> +	char cru_driver_name[CRYPTO_MAX_ALG_NAME];
> +	char cru_module_name[CRYPTO_MAX_ALG_NAME];
> +	uint32_t cru_type;
> +	uint32_t cru_mask;
> +	uint32_t cru_refcnt;
> +	uint32_t cru_flags;
> +};
> +
> +static void send_nl_msg(int fd, struct nlmsghdr *nh, void *payload)
> +{
> +	static unsigned int sequence_number;
> +	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
> +	struct iovec iov[2] = {
> +		{nh, sizeof(*nh)},
> +		{payload, nh->nlmsg_len - sizeof(*nh)}
> +	};
> +	struct msghdr msg = {
> +		.msg_name = &sa,
> +		.msg_namelen = sizeof(sa),
> +		.msg_iov = iov,
> +		.msg_iovlen = 2
> +	};
> +
> +	nh->nlmsg_pid = 0;
> +	nh->nlmsg_seq = ++sequence_number;
> +	/* Request an ack from kernel by setting NLM_F_ACK */
> +	nh->nlmsg_flags |= NLM_F_ACK;
> +
> +	SAFE_SENDMSG(nh->nlmsg_len, fd, &msg, 0);
> +}
> +
> +static int read_reply(int fd)
> +{
> +	int len;
> +	char buf[4096];
> +	struct iovec iov = { buf, sizeof(buf) };
> +	struct sockaddr_nl sa;
> +	struct msghdr msg = {
> +		.msg_name = &sa,
> +		.msg_namelen = sizeof(sa),
> +		.msg_iov = &iov,
> +		.msg_iovlen = 1
> +	};
> +	struct nlmsghdr *nh;
> +
> +	len = SAFE_RECVMSG(0, fd, &msg, 0);
> +
> +	for (nh = (struct nlmsghdr *) buf;
> +	     NLMSG_OK(nh, len);
> +	     nh = NLMSG_NEXT(nh, len)) {
> +		/* The end of multipart message. */
> +		if (nh->nlmsg_type == NLMSG_DONE)
> +			return 0;
> +
> +		if (nh->nlmsg_type == NLMSG_ERROR)
> +			return ((struct nlmsgerr *)NLMSG_DATA(nh))->error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int add_alg(int fd, struct crypto_user_alg *a)
> +{
> +	int r;
> +	struct nlmsghdr nh = {
> +		.nlmsg_len = sizeof(struct nlmsghdr) + sizeof(*a),
> +		.nlmsg_type = CRYPTO_MSG_NEWALG,
> +		.nlmsg_flags = NLM_F_REQUEST,
> +	};
> +
> +	send_nl_msg(fd, &nh, a);
> +
> +	r = read_reply(fd);
> +	if (r == -EEXIST)
> +		return 0;
> +	return r;
> +}
> +
> +static int del_alg(int fd, struct crypto_user_alg *a)
> +{
> +	int i;
> +	struct timespec delay = { .tv_nsec = 1000000 };
> +	struct nlmsghdr nh = {
> +		.nlmsg_len = sizeof(struct nlmsghdr) + sizeof(*a),
> +		.nlmsg_type = CRYPTO_MSG_DELALG,
> +		.nlmsg_flags = NLM_F_REQUEST,
> +	};
> +
> +	for (i = 0; i < 1000; i++) {
> +		send_nl_msg(fd, &nh, a);
> +
> +		TEST(read_reply(fd));
> +		if (TEST_RETURN != -EBUSY)
> +			break;
> +
> +		if (nanosleep(&delay, NULL) && errno != EINTR)
> +			tst_brk(TBROK | TERRNO, "nanosleep");
> +	}
> +
> +	return TEST_RETURN;
> +}

I suggest putting this NETLINK_CRYPTO stuff in a common location that can be
used by other tests too.  This will not be the last crypto API bug.  The
definitions for AF_ALG probably should be there too; though AF_ALG isn't used by
this test, many crypto bugs I've fixed or seen fixed recently are accessible
through it.  (E.g. see commit ecaaab564978, "crypto: salsa20 - fix
blkcipher_walk API usage" or commit e57121d08c38, "crypto: chacha20poly1305 -
validate the digest size".  Sorry, I was a bit lazy by just putting reproducers
in the commit messages and not writing "real" tests.)  It would be great to have
helper functions in LTP for testing the crypto API, so that they don't have to
be repeated in every test.

> +
> +void setup(void)
> +{
> +	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
> +}
> +
> +void run(void)
> +{
> +	int fd, i;
> +	struct crypto_user_alg a = {
> +		.cru_driver_name = "pcrypt(authenc(hmac(sha256-generic),cbc(aes-generic)))",
> +		.cru_type = CRYPTO_ALG_TYPE_AEAD,
> +		.cru_mask = CRYPTO_ALG_TYPE_MASK,
> +	};
> +
> +	fd = SAFE_SOCKET(AF_NETLINK, SOCK_DGRAM, NETLINK_CRYPTO);

Does this test get correctly skipped if the needed crypto modules are not
enabled?  There are several cases:

- NETLINK_CRYPTO unsupported (CONFIG_CRYPTO_USER not set)
- pcrypt unsupported (CONFIG_CRYPTO_PCRYPT not set)
- underlying algorithms unsupported (CONFIG_CRYPTO_AUTHENC, CONFIG_CRYPTO_HMAC,
  CONFIG_CRYPTO_SHA256, CONFIG_CRYPTO_CBC, or CONFIG_CRYPTO_AES not set)

> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.min_kver = "4.2.0",
> +};

Why is a minimum kernel version needed?

- Eric
