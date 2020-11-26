From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 26 Nov 2020 17:05:14 +0300
Subject: [LTP] [PATCH] netstress: explicitly set a thread stack size
In-Reply-To: <OFCE604BCE.4F62924B-ONC125862B.004801C0-C125862B.0048027B@avm.de>
References: <OFCE604BCE.4F62924B-ONC125862B.004801C0-C125862B.0048027B@avm.de>
Message-ID: <edf96c93-8f16-6545-629a-be727d4c8eb2@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 25.11.2020 16:06, Johannes Nixdorf via ltp wrote:
> Musl libc uses a relatively small thread stack size (128k [1]). This
> gets used up on 2 local buffers sized max_msg_len (64k by default),
> which causes a segfault due to a stack overflow in the error reporting
> path.
> 
> Set the stack size to 128kB + 2*max_msg_len instead, which is enough for
> both buffers with an additional allowance for the remaining stack usage
> by netstress and called libc or ltp helper functions.
> 
> [1]: https://urldefense.com/v3/__https://wiki.musl-libc.org/functional-differences-from-glibc.html*Thread_stack_size__;Iw!!GqivPVa7Brio!JiKwkv8uMgJNgh9ARntUpseI9zZW6h6u3Pm6AeF_sgqVyDcsHIQ_MyJWVVKbh_rVk-8u$ 
> 

Hi Johannes,

> +	errno = pthread_attr_init(&attr);
> +	if (errno != 0)

if (errno = pthread_attr_init(&attr))

> +		tst_brk(TBROK | TERRNO, "pthread_attr_init failed");
> +
> +	errno = pthread_attr_setstacksize(&attr, 128*1024 + 2*max_msg_len);

Since max_msg_len is 65535, the result won't be even 4 bytes aligned,
perhaps using just 256 * 1024?


> +	if (errno != 0)
> +		tst_brk(TBROK | TERRNO, "pthread_attr_setstacksize failed");

In case of error, it would be good to print the used stack size.
