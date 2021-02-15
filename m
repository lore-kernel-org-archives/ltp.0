From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 15 Feb 2021 12:31:18 +0100
Subject: [LTP] [COMMITTED] [PATCH] mq_timedreceive_5-3: Initialize
 maxmsg properly
In-Reply-To: <YCpTHC2FLaC5vzVH@yuki.lan>
References: <20210212151525.20112-1-chrubis@suse.cz>
 <853a0890-6426-5708-88a8-692885b9dd6f@jv-coder.de>
 <YCpTHC2FLaC5vzVH@yuki.lan>
Message-ID: <20de105c-086d-0116-c8a2-bc4c68684b31@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 2/15/2021 11:55 AM, Cyril Hrubis wrote:
> Feel free to send a patch for the rest :-).
Don't want to many open patches at the same time ;)
> Looking at the rest of the tests I guess the original author either did
> not care that much or was clueless since it does not really make sense
> to set mq_maxmsg to the same number as mq_msgsize in tests that send
> just one or two message.
>
> So we should either set it to 2 in all tests, or set it to 1 or 2
> depending on how many messages test sends.
Couldn't agree more

J?rg
