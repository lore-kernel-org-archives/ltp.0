From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 6 Apr 2018 14:20:18 +0200
Subject: [LTP] [PATCH v2 2/3] lib: Add tst_crypto and tst_netlink libs
In-Reply-To: <20180321143927.12156-3-rpalethorpe@suse.com>
References: <20180321143927.12156-1-rpalethorpe@suse.com>
 <20180321143927.12156-3-rpalethorpe@suse.com>
Message-ID: <20180406122016.GA6328@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ---
>  include/tst_crypto.h     | 135 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/tst_netlink.h    |  63 ++++++++++++++++++++++
>  include/tst_netlink_fn.h |  35 ++++++++++++
>  lib/tst_crypto.c         | 122 ++++++++++++++++++++++++++++++++++++++++++
>  lib/tst_netlink.c        |  63 ++++++++++++++++++++++

Is there a reason to split the netlink header into two?

We do that for safe_macros that are used both by the old library and the
new library where the split is easier than ifdefing all the macro
definitions to choose between newlib and oldlib...

And given that the netlink functions are simple wrappers that only
pack/unpack parameters I would be inclined to put them into the header
as static inline functions as well so that we would end up with one
netlink header that combines all the content from tst_netlink.h
tst_netlink_fn.h and tst_netlink.c.

> diff --git a/include/tst_crypto.h b/include/tst_crypto.h
> new file mode 100644
> index 000000000..3ed4a81f1
> --- /dev/null
> +++ b/include/tst_crypto.h
> @@ -0,0 +1,135 @@
> +/*
> + * Copyright (c) 2018 Richard Palethorpe <rpalethorpe@suse.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef TST_CRYPTO_H
> +#define TST_CRYPTO_H
> +
> +/* Taken from linux/crypto.h */
> +#define CRYPTO_MAX_ALG_NAME		64
> +#define CRYPTO_MAX_NAME CRYPTO_MAX_ALG_NAME
> +
> +#define CRYPTO_ALG_TYPE_MASK		0x0000000f
> +#define CRYPTO_ALG_TYPE_CIPHER		0x00000001
> +#define CRYPTO_ALG_TYPE_COMPRESS	0x00000002
> +#define CRYPTO_ALG_TYPE_AEAD		0x00000003
> +#define CRYPTO_ALG_TYPE_BLKCIPHER	0x00000004
> +#define CRYPTO_ALG_TYPE_ABLKCIPHER	0x00000005
> +#define CRYPTO_ALG_TYPE_SKCIPHER	0x00000005
> +#define CRYPTO_ALG_TYPE_GIVCIPHER	0x00000006
> +#define CRYPTO_ALG_TYPE_KPP		0x00000008
> +#define CRYPTO_ALG_TYPE_ACOMPRESS	0x0000000a
> +#define CRYPTO_ALG_TYPE_SCOMPRESS	0x0000000b
> +#define CRYPTO_ALG_TYPE_RNG		0x0000000c
> +#define CRYPTO_ALG_TYPE_AKCIPHER	0x0000000d
> +#define CRYPTO_ALG_TYPE_DIGEST		0x0000000e
> +#define CRYPTO_ALG_TYPE_HASH		0x0000000e
> +#define CRYPTO_ALG_TYPE_SHASH		0x0000000e
> +#define CRYPTO_ALG_TYPE_AHASH		0x0000000f
> +
> +#define CRYPTO_ALG_TYPE_HASH_MASK	0x0000000e
> +#define CRYPTO_ALG_TYPE_AHASH_MASK	0x0000000e
> +#define CRYPTO_ALG_TYPE_BLKCIPHER_MASK	0x0000000c
> +#define CRYPTO_ALG_TYPE_ACOMPRESS_MASK	0x0000000e
> +
> +/* Taken from linux/uapi/crypto_user.h */
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
> +/**
> + * struct tst_crypto_session
> + * @fd: File descriptor for the netlink socket.
> + * @seq_num: A sequence number used to identify responses from the kernel.
> + *
> + * Holds state relevant to a netlink crypto connection. The @seq_num is used
> + * to tag each message sent to the netlink layer and is automatically
> + * incremented by the tst_crypto_ functions. When the netlink layer sends a
> + * response (ack) it will use the sequences number from the request.
> + */
> +struct tst_crypto_session {
> +	int fd;
> +	uint32_t seq_num;
> +};

These definitions would be probably better to be put into lapi/crypto.h
and we have a rule to use the system defined ones whenever possible, it
looks like we can make use of the CRYPTO_MSG_* and crylto_user_alg from
the /usr/include/linux/cryptouser.h.


> +/**
> + * tst_crypto_open()
> + * @ses: Session structure to use, it can be uninitialized.
> + *
> + * Creates a crypto session. If some necessary feature is missing then it will
> + * call tst_brk() with %TCONF, for any other error it will use %TBROK.
> + */
> +void tst_crypto_open(struct tst_crypto_session *ses);
> +
> +/**
> + * tst_crypto_close()
> + * @ses: The session to close.
> + */
> +void tst_crypto_close(struct tst_crypto_session *ses);
> +
> +/**
> + * tst_crypto_add_alg()
> + * @ses: An open session.
> + * @alg: The crypto algorithm or module to add.
> + *
> + * This requests a new crypto algorithm/engine/module to be initialized by the
> + * kernel. It sends the request contained in @alg and then waits for a
> + * response. If sending the message or receiving the ack fails at the netlink
> + * level then tst_brk() with %TBROK will be called.
> + *
> + * Return: On success it will return 0 otherwise it will return an inverted
> + *         error code from the crypto layer. If the type of encryption you want
> + *         is not configured then the crypto layer will probably return %ENOENT.
> + */
> +int tst_crypto_add_alg(struct tst_crypto_session *ses,
> +		       const struct crypto_user_alg *alg);
> +
> +/**
> + * tst_crypto_del_alg()
> + * @ses: An open session.
> + * @alg: The crypto algorithm to delete.
> + * @retries: How many times the request should be repeated if %EBUSY is returned.
> + *           It can be set to zero for no retries.
> + *
> + * Request that the kernel remove an existing crypto algorithm. This behaves
> + * in a similar way to tst_crypto_add_alg() except that it is the inverse
> + * operation and that it is not unusual for this to return %EBUSY. To avoid
> + * needing to deal with %EBUSY you can set the retries to an appropriate value
> + * like 1000.
> + *
> + * Return: Either 0 or an inverted error code from the crypto layer.
> + */
> +int tst_crypto_del_alg(struct tst_crypto_session *ses,
> +		       const struct crypto_user_alg *alg,
> +		       unsigned int retries);


Do we really need to expose the retries here to the user of the library?
I do not like when we have random constants hardcoded all over the
codebase...

> +#endif	/* TST_CRYPTO_H */
> diff --git a/include/tst_netlink.h b/include/tst_netlink.h
> new file mode 100644
> index 000000000..8349644cc
> --- /dev/null
> +++ b/include/tst_netlink.h
> @@ -0,0 +1,63 @@
> +/*
> + * Copyright (c) 2018 Richard Palethorpe <rpalethorpe@suse.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef TST_NETLINK_H
> +#define TST_NETLINK_H
> +
> +#include "tst_netlink_fn.h"
> +
> +/**
> + * SAFE_NETLINK_SEND() / tst_safe_netlink_send()
> + * @fd: netlink socket file descriptor.
> + * @nl_header: netlink header structure describing the message.
> + * @payload: an opaque object containing the message data.
> + * @payload_len: the @payload length only.
> + *
> + * Sends a netlink message using safe_sendmsg(). You should set the message
> + * type and flags to appropriate values within the @nl_header object. However
> + * you do not need to set the message length within @nl_header
> + * (nlmsg_len), if you do it will be overwritten.
> + *
> + * Netlink messages must be aligned correctly which may require padding. This
> + * function will add padding if necessary so that you do not need to pad the
> + * payload or header structure.
> + *
> + * See lib/tst_crypto.c for an example.
> + *
> + * Return: The number of bytes sent.
> + */
> +#define SAFE_NETLINK_SEND(fd, nl_header, payload, payload_len)		\
> +	tst_safe_netlink_send(__FILE__, __LINE__,			\
> +			      fd, nl_header, payload, payload_len)

Given that the safe_ prefix is used all over the library we can drop the
tst_ prefix from the function names here, and maybe update documentation
that safe_ prefix is reserved for the test library as well...

...

> diff --git a/lib/tst_crypto.c b/lib/tst_crypto.c
> new file mode 100644
> index 000000000..dbe7f32b7
> --- /dev/null
> +++ b/lib/tst_crypto.c
> @@ -0,0 +1,122 @@
> +/*
> + * Copyright (c) 2018 Richard Palethorpe <rpalethorpe@suse.com>
> + *                    Nicolai Stange <nstange@suse.de>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <errno.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_crypto.h"
> +#include "tst_netlink.h"
> +
> +#define RETRY_DELAY_NSEC 1000000 /* For operations which can fail with EBUSY. */
> +
> +void tst_crypto_open(struct tst_crypto_session *ses)
> +{
> +	TEST(socket(AF_NETLINK, SOCK_DGRAM, NETLINK_CRYPTO));
> +	if (TEST_RETURN < 0 && TEST_ERRNO == EPROTONOSUPPORT) {
> +		tst_res(TCONF | TTERRNO, "NETLINK_CRYPTO is probably disabled");
                    ^
		The comment in the header says that it will tst_brk()
		here, or am I mistaken?

> +	} else if (TEST_RETURN < 0) {
> +		tst_brk(TBROK | TTERRNO,
> +			"socket(AF_NETLINK, SOCK_DGRAM, NETLINK_CRYPTO)");
> +	}
> +
> +	ses->fd = TEST_RETURN;
> +	ses->seq_num = 0;
> +}
> +
> +void tst_crypto_close(struct tst_crypto_session *ses)
> +{
> +	SAFE_CLOSE(ses->fd);
> +}
> +
> +static int tst_crypto_recv_ack(struct tst_crypto_session *ses)
> +{
> +	int len;
> +	char buf[8196];
> +	struct nlmsghdr *nh;
> +
> +	len = SAFE_NETLINK_RECV(ses->fd, buf, sizeof(buf));
> +
> +	for (nh = (struct nlmsghdr *) buf;
> +	     NLMSG_OK(nh, len);
> +	     nh = NLMSG_NEXT(nh, len)) {
> +		if (nh->nlmsg_seq != ses->seq_num) {
> +			tst_brk(TBROK,
> +				"Message out of sequence; type=0%hx, seq_num=%u (not %u)",
> +				nh->nlmsg_type, nh->nlmsg_seq, ses->seq_num);
> +		}
> +
> +		/* Acks use the error message type with error number set to
> +		 * zero. Ofcourse we could also receive an actual error.
> +		 */
> +		if (nh->nlmsg_type == NLMSG_ERROR)
> +			return ((struct nlmsgerr *)NLMSG_DATA(nh))->error;
> +
> +		tst_brk(TBROK, "Unexpected message type; type=0x%hx, seq_num=%u",
> +			nh->nlmsg_type, nh->nlmsg_seq);
> +	}
> +
> +	tst_brk(TBROK, "Empty message from netlink socket?");
> +
> +	return 0;
          ^

	  Not that it matters, since unless we call this function from
	  test cleanup the tst_brk() will exit the test, but this should
	  be probably non-zero.

> +}
> +
> +int tst_crypto_add_alg(struct tst_crypto_session *ses,
> +		       const struct crypto_user_alg *alg)
> +{
> +	struct nlmsghdr nh = {
> +		.nlmsg_type = CRYPTO_MSG_NEWALG,
> +		.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
> +		.nlmsg_seq = ++(ses->seq_num),
> +		.nlmsg_pid = 0,
> +	};
> +
> +	SAFE_NETLINK_SEND(ses->fd, &nh, alg, sizeof(*alg));
> +
> +	return tst_crypto_recv_ack(ses);
> +}
> +
> +int tst_crypto_del_alg(struct tst_crypto_session *ses,
> +		       const struct crypto_user_alg *alg,
> +		       unsigned int retries)
> +{
> +	unsigned int i = 0;
> +	struct timespec delay = { .tv_nsec = RETRY_DELAY_NSEC };
> +	struct nlmsghdr nh = {
> +		.nlmsg_type = CRYPTO_MSG_DELALG,
> +		.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
> +		.nlmsg_pid = 0,
> +	};
> +
> +	while (1) {
> +		nh.nlmsg_seq = ++(ses->seq_num);
> +
> +		SAFE_NETLINK_SEND(ses->fd, &nh, alg, sizeof(*alg));
> +
> +		TEST(tst_crypto_recv_ack(ses));
> +		if (TEST_RETURN != -EBUSY || i >= retries)
> +			break;
> +
> +		if (nanosleep(&delay, NULL) && errno != EINTR)
> +			tst_brk(TBROK | TERRNO, "nanosleep");

We may as well do usleep(1) here instead of the nanosleep()

> +		++i;
> +	}
> +
> +	return TEST_RETURN;
> +}

-- 
Cyril Hrubis
chrubis@suse.cz
