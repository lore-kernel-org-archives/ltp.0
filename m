From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 27 Apr 2021 16:14:01 +0200
Subject: [LTP] [PATCH 3/4] RFC: Add rtnetlink helper library
In-Reply-To: <YIgUcqIhXVgiqaMu@yuki>
References: <20210426111918.4304-1-mdoucha@suse.cz>
 <20210426111918.4304-4-mdoucha@suse.cz> <YIgUcqIhXVgiqaMu@yuki>
Message-ID: <ceb5f5b5-2efd-beaf-e617-7fa0b28c0ff2@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 27. 04. 21 15:41, Cyril Hrubis wrote:
> Hi!
>> +static int tst_rtnl_grow_buffer(const char *file, const int lineno,
>> +	struct tst_rtnl_context *ctx, size_t size)
>> +{
>> +	size_t needed, offset, curlen = NLMSG_ALIGN(ctx->datalen);
>> +	char *buf;
>> +
>> +	if (ctx->bufsize - curlen >= size)
>> +		return 1;
>> +
>> +	needed = size - (ctx->bufsize - curlen);
>> +	size = ctx->bufsize + (ctx->bufsize > needed ? ctx->bufsize : needed);
>> +	size = NLMSG_ALIGN(size);
>> +	buf = safe_realloc(file, lineno, ctx->buffer, size);
>> +
>> +	if (!buf)
>> +		return 0;
> 
> You are calling safe_realloc() here yet you check the return value. And
> it's the same for safe_malloc(), safe_bind(), safe_socket() and a few
> more in the code.
> 
> So either we get rid of the error checks and of the error
> propagation or we avoid using safe_ variants.

Both rtnetlink and netdevice management functions will be called in
cleanup() so I have to assume that the safe functions will only print a
warning instead of terminating the program. But I still want to use the
error reporting code in the safe functions.

> Other than that the code looks sane but it's hard to review the API
> without an example that would excersize it. What about adding something
> simple in newlib_tests?

There are short examples for both rtnetlink and netdevice management in
the cover letter. The netdevice library itself is also a detailed
example for the rtnetlink API. The final patchset will include the
SADDNS CVE test which will use most of the netdevice management
functions in setup().

>> +void tst_rtnl_free_context(const char *file, const int lineno,
>> +	struct tst_rtnl_context *ctx)
> 
> This should be probably called destroy_context() but that is very minor.

OK, why not.

>> +int tst_rtnl_wait(struct tst_rtnl_context *ctx)
>> +{
>> +	fd_set fdlist;
>> +	struct timeval timeout = {0};
>> +
>> +	FD_ZERO(&fdlist);
>> +	FD_SET(ctx->socket, &fdlist);
>> +	timeout.tv_sec = 1;
>> +
>> +	return select(ctx->socket + 1, &fdlist, NULL, NULL, &timeout);
> 
> I find the poll() syscall to have a bit saner API than this.

I'll have a look at it.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
