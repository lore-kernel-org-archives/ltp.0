From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 27 Nov 2020 12:15:02 +0300
Subject: [LTP] [PATCH] netstress: explicitly set a thread stack size
In-Reply-To: <20201126150349.GB4646@yuki.lan>
References: <edf96c93-8f16-6545-629a-be727d4c8eb2@oracle.com>
 <OFCE604BCE.4F62924B-ONC125862B.004801C0-C125862B.0048027B@avm.de>
 <OF47EE0279.8BED1D35-ONC125862C.0051B56D-C125862C.0051B570@avm.de>
 <20201126150349.GB4646@yuki.lan>
Message-ID: <e971647d-6cac-fa39-9dad-7e993375fd21@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 26.11.2020 18:03, Cyril Hrubis wrote:
> Hi!
>> I'm reluctant to use a static value here as max_msg_len may be modified
>> by command line arguments.
> 
> Wouldn't it be easier to use malloc() instead of putting large data
> structures on the stack and working around that by increasing the
> limits?

In the current server implementation it would hurt performance, so
I assume it would also require to make a memory/thread-pool...
