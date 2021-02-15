From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 15 Feb 2021 06:35:15 +0100
Subject: [LTP] [COMMITTED] [PATCH] mq_timedreceive_5-3: Initialize
 maxmsg properly
In-Reply-To: <20210212151525.20112-1-chrubis@suse.cz>
References: <20210212151525.20112-1-chrubis@suse.cz>
Message-ID: <853a0890-6426-5708-88a8-692885b9dd6f@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On 2/12/2021 4:15 PM, Cyril Hrubis wrote:
> The test can be actually executed as non-root user but the maxmsg must
> be set to a value that is less by user limit for messages and since we
> do not send any messages we can safely initialize it to 1.
This is applies to more than only this test. I also recognized this when 
fixing the time issue, but decided not to change it, because it is not 
the only affected test.
The max message size could be up to /proc/sys/fs/mqueue/msg_max. This is 
usually 10.

J?rg
