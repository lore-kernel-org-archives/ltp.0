From: j.nixdorf@avm.de <j.nixdorf@avm.de>
Date: Fri, 27 Nov 2020 11:58:57 +0100
Subject: [LTP] [PATCH] netstress: explicitly set a thread stack size
In-Reply-To: <9c761b66-89c6-9121-88bb-44e98b9a64cb@oracle.com>
References: <9c761b66-89c6-9121-88bb-44e98b9a64cb@oracle.com>,
 <edf96c93-8f16-6545-629a-be727d4c8eb2@oracle.com>
 <OFCE604BCE.4F62924B-ONC125862B.004801C0-C125862B.0048027B@avm.de>
 <OF47EE0279.8BED1D35-ONC125862C.0051B56D-C125862C.0051B570@avm.de>
Message-ID: <OF67F47D3A.085506A0-ONC125862D.003BE9A0-C125862D.003C5457@avm.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

-----"Alexey Kodanev" <alexey.kodanev@oracle.com> wrote: -----
>On 26.11.2020 17:52, Johannes Nixdorf via ltp wrote:
>It doesn't mean you should intentionally pass unaligned size.
>
>And on it's man-page [1], in errors section, there is a note that it
>might
>return EINVAL for some systems if the stack size not multiple of page
>size.

Ok. I was going by the POSIX man page [1], which doesn't mention
that practice.

[1]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/pthread_attr_setstacksize.html

>max_msg_len is const.

It seems like I was misreading [2] to mean it sets max_msg_len
instead of using it as a limit.

[2]: https://github.com/linux-test-project/ltp/blob/master/testcases/network/netstress/netstress.c#L854

Thanks for the review, I'll change it to go with your proposed
static limit.

Regards,
Johannes
