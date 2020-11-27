From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 27 Nov 2020 11:54:47 +0300
Subject: [LTP] [PATCH] netstress: explicitly set a thread stack size
In-Reply-To: <OF47EE0279.8BED1D35-ONC125862C.0051B56D-C125862C.0051B570@avm.de>
References: <edf96c93-8f16-6545-629a-be727d4c8eb2@oracle.com>
 <OFCE604BCE.4F62924B-ONC125862B.004801C0-C125862B.0048027B@avm.de>
 <OF47EE0279.8BED1D35-ONC125862C.0051B56D-C125862C.0051B570@avm.de>
Message-ID: <9c761b66-89c6-9121-88bb-44e98b9a64cb@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 26.11.2020 17:52, Johannes Nixdorf via ltp wrote:
> Hi Alexey,
> 
> On Thu, Nov 26, 2020 at 05:05:14PM +0300, Alexey Kodanev wrote:
>>> +		tst_brk(TBROK | TERRNO, "pthread_attr_init failed");
>>> +
>>> +	errno = pthread_attr_setstacksize(&attr, 128*1024 + 2*max_msg_len);
>>
>> Since max_msg_len is 65535, the result won't be even 4 bytes aligned,
>> perhaps using just 256 * 1024?
> 
> The function pthread_attr_setstacksize does not have any alignment
> requirements specified and only sets the minimum stack size. This means
> the libc is required to over-allocate and suitably align the stack to
> match platform requirements. Is this broken on any libraries the LTP
> project cares about?

It doesn't mean you should intentionally pass unaligned size.

And on it's man-page [1], in errors section, there is a note that it might
return EINVAL for some systems if the stack size not multiple of page size.

[1] https://man7.org/linux/man-pages/man3/pthread_attr_setstacksize.3.html

> 
> Note that this is different from pthread_attr_setstack, as there the
> memory region is provided by the caller and the libc can't change the
> alignment later on.
> 
> I'm reluctant to use a static value here as max_msg_len may be modified
> by command line arguments.

max_msg_len is const.

