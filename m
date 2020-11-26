From: j.nixdorf@avm.de <j.nixdorf@avm.de>
Date: Thu, 26 Nov 2020 15:52:28 +0100
Subject: [LTP] [PATCH] netstress: explicitly set a thread stack size
In-Reply-To: <edf96c93-8f16-6545-629a-be727d4c8eb2@oracle.com>
References: <edf96c93-8f16-6545-629a-be727d4c8eb2@oracle.com>,
 <OFCE604BCE.4F62924B-ONC125862B.004801C0-C125862B.0048027B@avm.de>
Message-ID: <OF47EE0279.8BED1D35-ONC125862C.0051B56D-C125862C.0051B570@avm.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

On Thu, Nov 26, 2020 at 05:05:14PM +0300, Alexey Kodanev wrote:
> > +		tst_brk(TBROK | TERRNO, "pthread_attr_init failed");
> > +
> > +	errno = pthread_attr_setstacksize(&attr, 128*1024 + 2*max_msg_len);
> 
> Since max_msg_len is 65535, the result won't be even 4 bytes aligned,
> perhaps using just 256 * 1024?

The function pthread_attr_setstacksize does not have any alignment
requirements specified and only sets the minimum stack size. This means
the libc is required to over-allocate and suitably align the stack to
match platform requirements. Is this broken on any libraries the LTP
project cares about?

Note that this is different from pthread_attr_setstack, as there the
memory region is provided by the caller and the libc can't change the
alignment later on.

I'm reluctant to use a static value here as max_msg_len may be modified
by command line arguments.

Regards,
Johannes
