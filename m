From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Apr 2021 17:44:35 +0200
Subject: [LTP] [PATCH 3/4] RFC: Add rtnetlink helper library
In-Reply-To: <20210426111918.4304-4-mdoucha@suse.cz>
References: <20210426111918.4304-1-mdoucha@suse.cz>
 <20210426111918.4304-4-mdoucha@suse.cz>
Message-ID: <YIgxY4R+z+JFJT7l@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This library provides simple interface for creating arbitrary rtnetlink
> messages with complex attributes, sending requests and receiving results.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  include/tst_rtnetlink.h | 105 +++++++++++
>  lib/tst_rtnetlink.c     | 399 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 504 insertions(+)
>  create mode 100644 include/tst_rtnetlink.h
>  create mode 100644 lib/tst_rtnetlink.c
> 
> diff --git a/include/tst_rtnetlink.h b/include/tst_rtnetlink.h
> new file mode 100644
> index 000000000..3b307fbec
> --- /dev/null
> +++ b/include/tst_rtnetlink.h
> @@ -0,0 +1,105 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (c) 2021 Linux Test Project
> + */
> +
> +#ifndef TST_RTNETLINK_H
> +#define TST_RTNETLINK_H
> +
> +struct tst_rtnl_context;
> +
> +struct tst_rtnl_attr_list {
> +	unsigned short type;
> +	const void *data;
> +	ssize_t len;
> +	const struct tst_rtnl_attr_list *sublist;
> +};
> +
> +struct tst_rtnl_message {
> +	struct nlmsghdr *header;
> +	struct nlmsgerr *err;
> +	void *payload;
> +	size_t payload_size;
> +};
> +
> +/* Open a netlink socket */
> +struct tst_rtnl_context *tst_rtnl_create_context(const char *file,
> +	const int lineno);
> +#define RTNL_CREATE_CONTEXT() tst_rtnl_create_context(__FILE__, __LINE__)
> +
> +/* Free a tst_rtnl_message array returned by tst_rtnl_recv() */
> +void tst_rtnl_free_message(struct tst_rtnl_message *msg);
> +#define RTNL_FREE_MESSAGE tst_rtnl_free_message
> +
> +/* Close netlink socket */
> +void tst_rtnl_free_context(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx);
> +#define RTNL_FREE_CONTEXT(ctx) tst_rtnl_free_context(__FILE__, __LINE__, (ctx))
> +
> +/* Send all messages in given buffer */
> +int tst_rtnl_send(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx);
> +#define RTNL_SEND(ctx) tst_rtnl_send(__FILE__, __LINE__, (ctx))
> +
> +/* Send all messages in given buffer and validate kernel response */
> +int tst_rtnl_send_validate(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx);
> +#define RTNL_SEND_VALIDATE(ctx) \
> +	tst_rtnl_send_validate(__FILE__, __LINE__, (ctx))
> +
> +/* Wait until data is available for reading from the netlink socket */
> +int tst_rtnl_wait(struct tst_rtnl_context *ctx);
> +#define RTNL_WAIT tst_rtnl_wait
> +
> +/*
> + * Read from netlink socket and return an array of partially parsed messages.
> + * header == NULL indicates end of array.
> + */
> +struct tst_rtnl_message *tst_rtnl_recv(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx);
> +#define RTNL_RECV(ctx) tst_rtnl_recv(__FILE__, __LINE__, (ctx))
> +
> +/* Add new message to buffer */
> +int tst_rtnl_add_message(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx, const struct nlmsghdr *header,
> +	const void *payload, size_t payload_size);
> +#define RTNL_ADD_MESSAGE(ctx, header, payload, psize) \
> +	tst_rtnl_add_message(__FILE__, __LINE__, (ctx), (header), (payload), \
> +		(psize))
> +
> +/* Add arbitrary attribute to last message */
> +int tst_rtnl_add_attr(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx, unsigned short type, const void *data,
> +	unsigned short len);
> +#define RTNL_ADD_ATTR(ctx, type, data, len) \
> +	tst_rtnl_add_attr(__FILE__, __LINE__, (ctx), (type), (data), (len))
> +
> +/* Add string attribute to last message */
> +int tst_rtnl_add_attr_string(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx, unsigned short type, const char *data);
> +#define RTNL_ADD_ATTR_STRING(ctx, type, data) \
> +	tst_rtnl_add_attr_string(__FILE__, __LINE__, (ctx), (type), (data))
> +
> +/*
> + * Add list of arbitrary attributes to last message. The list is terminated
> + * by attribute with negative length. Nested sublists are supported.
> + */
> +int tst_rtnl_add_attr_list(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx, const struct tst_rtnl_attr_list *list);
> +#define RTNL_ADD_ATTR_LIST(ctx, list) \
> +	tst_rtnl_add_attr_list(__FILE__, __LINE__, (ctx), (list))
> +
> +/* Check that all sent messages with NLM_F_ACK flag have been acked without
> + * error. Usage:
> + *
> + * tst_rtnl_send(ctx);
> + * tst_rtnl_wait(ctx);
> + * response = tst_rtnl_recv(ctx);
> + * if (!tst_rtnl_check_acks(ctx, response)) { ... }
> + * tst_rtnl_free_message(response);
> + */
> +int tst_rtnl_check_acks(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx, struct tst_rtnl_message *response);
> +#define RTNL_CHECK_ACKS(ctx, response) \
> +	tst_rtnl_context(__FILE__, __LINE__, (ctx), (response))
> +
> +#endif /* TST_RTNETLINK_H */
> diff --git a/lib/tst_rtnetlink.c b/lib/tst_rtnetlink.c
> new file mode 100644
> index 000000000..bb6116d57
> --- /dev/null
> +++ b/lib/tst_rtnetlink.c
> @@ -0,0 +1,399 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Linux Test Project
> + */
> +
> +#include <stdlib.h>
> +#include <limits.h>
> +#include <asm/types.h>
> +#include <linux/netlink.h>
> +#include <linux/rtnetlink.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <sys/select.h>
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_rtnetlink.h"
> +
> +struct tst_rtnl_context {
> +	int socket;
> +	pid_t pid;
> +	uint32_t seq;
> +	size_t bufsize, datalen;
> +	char *buffer;
> +	struct nlmsghdr *curmsg;
> +};
> +
> +static int tst_rtnl_grow_buffer(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx, size_t size)
> +{
> +	size_t needed, offset, curlen = NLMSG_ALIGN(ctx->datalen);
> +	char *buf;
> +
> +	if (ctx->bufsize - curlen >= size)
> +		return 1;
> +
> +	needed = size - (ctx->bufsize - curlen);
> +	size = ctx->bufsize + (ctx->bufsize > needed ? ctx->bufsize : needed);
> +	size = NLMSG_ALIGN(size);
> +	buf = safe_realloc(file, lineno, ctx->buffer, size);
> +
> +	if (!buf)
> +		return 0;
> +
> +	memset(buf + ctx->bufsize, 0, size - ctx->bufsize);
> +	offset = ((char *)ctx->curmsg) - ctx->buffer;
> +	ctx->buffer = buf;
> +	ctx->curmsg = (struct nlmsghdr *)(buf + offset);
> +	ctx->bufsize = size;
> +	return 1;
> +}
> +
> +struct tst_rtnl_context *tst_rtnl_create_context(const char *file,
> +	const int lineno)
> +{
> +	struct tst_rtnl_context *ctx;
> +	struct sockaddr_nl addr = {0};
> +
> +	ctx = safe_malloc(file, lineno, NULL, sizeof(struct tst_rtnl_context));
> +
> +	if (!ctx)
> +		return NULL;
> +
> +	ctx->pid = 0;
> +	ctx->seq = 0;
> +	ctx->bufsize = 1024;
> +	ctx->datalen = 0;
> +	ctx->curmsg = NULL;
> +	ctx->socket = safe_socket(file, lineno, NULL, AF_NETLINK,
> +		SOCK_DGRAM | SOCK_CLOEXEC, NETLINK_ROUTE);
> +	addr.nl_family = AF_NETLINK;
> +
> +	if (ctx->socket < 0) {
> +		free(ctx);
> +		return NULL;
> +	}
> +
> +	if (safe_bind(file, lineno, NULL, ctx->socket, (struct sockaddr *)&addr,
> +		sizeof(addr))) {

safe_close() is missing here.

Also why don't we use the kernel style goto error handling here, that
would be probably easier to write. I.e.

	if (ctx->socket < 0)
		goto err0;

	if (safe_bind(...))
		goto err1;

	...

	return ctx;
err1:
	safe_close(file, lineno, NULL, ctx->socket);
err0:
	free(ctx);
	return NULL;

> +		free(ctx);
> +		return NULL;
> +	}
> +
> +	ctx->buffer = safe_malloc(file, lineno, NULL, ctx->bufsize);
> +
> +	if (!ctx->buffer) {
> +		safe_close(file, lineno, NULL, ctx->socket);
> +		free(ctx);
> +		return NULL;
> +	}
> +
> +	memset(ctx->buffer, 0, ctx->bufsize);
> +	return ctx;
> +}
> +
> +void tst_rtnl_free_message(struct tst_rtnl_message *msg)
> +{
> +	if (!msg)
> +		return;
> +
> +	// all ptr->header and ptr->info pointers point to the same buffer
> +	// msg->header is the start of the buffer
> +	free(msg->header);
> +	free(msg);
> +}
> +
> +void tst_rtnl_free_context(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx)
> +{
> +	safe_close(file, lineno, NULL, ctx->socket);
> +	free(ctx->buffer);
> +	free(ctx);
> +}
> +
> +int tst_rtnl_send(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx)
> +{
> +	struct sockaddr_nl addr = {0};
> +	struct iovec iov;
> +	struct msghdr msg = {0};
> +	int ret;
> +
> +	if (!ctx->curmsg) {
> +		tst_brk_(file, lineno, TBROK, "%s(): No message to send",
> +			__func__);
> +		return 0;
> +	}
> +
> +	if (ctx->curmsg->nlmsg_flags & NLM_F_MULTI) {
> +		size_t size = NLMSG_ALIGN(ctx->curmsg->nlmsg_len);
> +
> +		if (!tst_rtnl_grow_buffer(file, lineno, ctx, NLMSG_SPACE(0)))
> +			return 0;
> +
> +		ctx->curmsg = NLMSG_NEXT(ctx->curmsg, size);
> +		memset(ctx->curmsg, 0, sizeof(struct nlmsghdr));
> +		ctx->curmsg->nlmsg_len = NLMSG_LENGTH(0);
> +		ctx->curmsg->nlmsg_type = NLMSG_DONE;
> +		ctx->curmsg->nlmsg_flags = 0;
> +		ctx->curmsg->nlmsg_seq = ctx->seq++;
> +		ctx->curmsg->nlmsg_pid = ctx->pid;
> +		ctx->datalen = NLMSG_ALIGN(ctx->datalen) + NLMSG_LENGTH(0);

If we add one if (lenth) before the memcpy() we can just call
tst_rtnl_add_message(file, lineno, ctx, &header, NULL, 0) here instead.

> +	}
> +	addr.nl_family = AF_NETLINK;
> +	iov.iov_base = ctx->buffer;
> +	iov.iov_len = ctx->datalen;
> +	msg.msg_name = &addr;
> +	msg.msg_namelen = sizeof(addr);
> +	msg.msg_iov = &iov;
> +	msg.msg_iovlen = 1;
> +
> +	ret = safe_sendmsg(file, lineno, ctx->datalen, ctx->socket, &msg, 0);
> +
> +	if (ret > 0)
> +		ctx->curmsg = NULL;
> +
> +	return ret;
> +}
> +
> +int tst_rtnl_wait(struct tst_rtnl_context *ctx)
> +{
> +	fd_set fdlist;
> +	struct timeval timeout = {0};
> +
> +	FD_ZERO(&fdlist);
> +	FD_SET(ctx->socket, &fdlist);
> +	timeout.tv_sec = 1;
> +
> +	return select(ctx->socket + 1, &fdlist, NULL, NULL, &timeout);
> +}
> +
> +struct tst_rtnl_message *tst_rtnl_recv(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx)
> +{
> +	char *buffer, tmp;
> +	struct tst_rtnl_message *ret;
> +	struct nlmsghdr *ptr;
> +	ssize_t size;
> +	int i, size_left, msgcount;
> +
> +	errno = 0;
> +	size = recv(ctx->socket, &tmp, 1, MSG_DONTWAIT | MSG_PEEK | MSG_TRUNC);
> +
> +	if (size <= 0) {
> +		if (errno != EAGAIN)
> +			tst_brk_(file, lineno, TBROK | TERRNO, "recv() failed");
> +		return NULL;
> +	}
> +
> +	buffer = safe_malloc(file, lineno, NULL, size);
> +
> +	if (!buffer)
> +		return NULL;
> +
> +	size = safe_recv(file, lineno, size, ctx->socket, buffer, size, 0);
> +
> +	if (size <= 0) {
> +		free(buffer);
> +		return NULL;
> +	}
> +
> +	ptr = (struct nlmsghdr *)buffer;
> +	size_left = size;
> +	msgcount = 0;
> +
> +	for (; size_left > 0 && NLMSG_OK(ptr, size_left); msgcount++)
> +		ptr = NLMSG_NEXT(ptr, size_left);
> +
> +	ret = safe_malloc(file, lineno, NULL,
> +		(msgcount + 1) * sizeof(struct tst_rtnl_message));
                     ^
		     Maybe store this size to a variable so that we
		     don't have to repeat it for the memset()?
> +
> +	if (!ret) {
> +		free(buffer);
> +		return NULL;
> +	}
> +
> +	memset(ret, 0, (msgcount + 1) * sizeof(struct tst_rtnl_message));
> +	ptr = (struct nlmsghdr *)buffer;
> +	size_left = size;
> +
> +	for (i = 0; i < msgcount; i++, ptr = NLMSG_NEXT(ptr, size_left)) {
> +		ret[i].header = ptr;
> +		ret[i].payload = NLMSG_DATA(ptr);
> +		ret[i].payload_size = NLMSG_PAYLOAD(ptr, 0);
> +
> +		if (ptr->nlmsg_type == NLMSG_ERROR)
> +			ret[i].err = NLMSG_DATA(ptr);
> +	}
> +
> +	return ret;
> +}
> +
> +int tst_rtnl_add_message(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx, const struct nlmsghdr *header,
> +	const void *payload, size_t payload_size)
> +{
> +	size_t size;
> +	unsigned int extra_flags = 0;
> +
> +	if (!tst_rtnl_grow_buffer(file, lineno, ctx, NLMSG_SPACE(payload_size)))
> +		return 0;
> +
> +	if (!ctx->curmsg) {
> +		/*
> +		 * datalen may hold the size of last sent message for ACK
> +		 * checking, reset it back to 0 here
> +		 */
> +		ctx->datalen = 0;
> +		ctx->curmsg = (struct nlmsghdr *)ctx->buffer;
> +	} else {
> +		size = NLMSG_ALIGN(ctx->curmsg->nlmsg_len);
> +
> +		extra_flags = NLM_F_MULTI;
> +		ctx->curmsg->nlmsg_flags |= extra_flags;
> +		ctx->curmsg = NLMSG_NEXT(ctx->curmsg, size);
> +		ctx->datalen = NLMSG_ALIGN(ctx->datalen);
> +	}
> +
> +	*ctx->curmsg = *header;
> +	ctx->curmsg->nlmsg_len = NLMSG_LENGTH(payload_size);
> +	ctx->curmsg->nlmsg_flags |= extra_flags;
> +	ctx->curmsg->nlmsg_seq = ctx->seq++;
> +	ctx->curmsg->nlmsg_pid = ctx->pid;
> +	memcpy(NLMSG_DATA(ctx->curmsg), payload, payload_size);
> +	ctx->datalen += ctx->curmsg->nlmsg_len;
> +	return 1;
> +}
> +
> +int tst_rtnl_add_attr(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx, unsigned short type,
> +	const void *data, unsigned short len)
> +{
> +	size_t size;
> +	struct rtattr *attr;
> +
> +	if (!ctx->curmsg) {
> +		tst_brk_(file, lineno, TBROK,
> +			"%s(): No message to add attributes to", __func__);
> +		return 0;
> +	}
> +
> +	if (!tst_rtnl_grow_buffer(file, lineno, ctx, RTA_SPACE(len)))
> +		return 0;
> +
> +	size = NLMSG_ALIGN(ctx->curmsg->nlmsg_len);
> +	attr = (struct rtattr *)(((char *)ctx->curmsg) + size);
> +	attr->rta_type = type;
> +	attr->rta_len = RTA_LENGTH(len);
> +	memcpy(RTA_DATA(attr), data, len);
> +	ctx->curmsg->nlmsg_len = size + attr->rta_len;
> +	ctx->datalen = NLMSG_ALIGN(ctx->datalen) + attr->rta_len;
> +	return 1;
> +}
> +
> +int tst_rtnl_add_attr_string(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx, unsigned short type,
> +	const char *data)
> +{
> +	return tst_rtnl_add_attr(file, lineno, ctx, type, data,
> +		strlen(data) + 1);
> +}
> +
> +int tst_rtnl_add_attr_list(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx,
> +	const struct tst_rtnl_attr_list *list)
> +{
> +	int i, ret;
> +	size_t offset;
> +
> +	for (i = 0; list[i].len >= 0; i++) {
> +		if (list[i].len > USHRT_MAX) {
> +			tst_brk_(file, lineno, TBROK,
> +				"%s(): Attribute value too long", __func__);
> +			return -1;
> +		}
> +
> +		offset = NLMSG_ALIGN(ctx->datalen);
> +		ret = tst_rtnl_add_attr(file, lineno, ctx, list[i].type,
> +			list[i].data, list[i].len);
> +
> +		if (!ret)
> +			return -1;
> +
> +		if (list[i].sublist) {
> +			struct rtattr *attr;
> +
> +			ret = tst_rtnl_add_attr_list(file, lineno, ctx,
> +				list[i].sublist);
> +
> +			if (ret < 0)
> +				return ret;
> +
> +			attr = (struct rtattr *)(ctx->buffer + offset);
> +
> +			if (ctx->datalen - offset > USHRT_MAX) {
> +				tst_brk_(file, lineno, TBROK,
> +					"%s(): Sublist too long", __func__);
> +				return -1;
> +			}
> +
> +			attr->rta_len = ctx->datalen - offset;
> +		}
> +	}
> +
> +	return i;
> +}
> +
> +int tst_rtnl_check_acks(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx, struct tst_rtnl_message *res)
> +{
> +	struct nlmsghdr *msg = (struct nlmsghdr *)ctx->buffer;
> +	int size_left = ctx->datalen;
> +
> +	for (; size_left > 0 && NLMSG_OK(msg, size_left);
> +		msg = NLMSG_NEXT(msg, size_left)) {
> +
> +		if (!(msg->nlmsg_flags & NLM_F_ACK))
> +			continue;
> +
> +		while (res->header && res->header->nlmsg_seq != msg->nlmsg_seq)
> +			res++;
> +
> +		if (!res->err || res->header->nlmsg_seq != msg->nlmsg_seq) {
> +			tst_brk_(file, lineno, TBROK,
> +				"No ACK found for Netlink message %u",
> +				msg->nlmsg_seq);
> +			return 0;
> +		}
> +
> +		if (res->err->error) {
> +			TST_ERR = -res->err->error;
> +			return 0;
> +		}
> +	}
> +
> +	return 1;
> +}
> +
> +int tst_rtnl_send_validate(const char *file, const int lineno,
> +	struct tst_rtnl_context *ctx)
> +{
> +	struct tst_rtnl_message *response;
> +	int ret;
> +
> +	TST_ERR = 0;
> +
> +	if (tst_rtnl_send(file, lineno, ctx) <= 0)
> +		return 0;
> +
> +	tst_rtnl_wait(ctx);
> +	response = tst_rtnl_recv(file, lineno, ctx);
> +
> +	if (!response)
> +		return 0;
> +
> +	ret = tst_rtnl_check_acks(file, lineno, ctx, response);
> +	tst_rtnl_free_message(response);
> +	return ret;
> +}

I had a closer look at the library and minus a few minor things it looks
good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
