From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 21 Aug 2020 08:50:24 +0200
Subject: [LTP] [LTP PATCH 0/2] ltp: fix af_alg02 to specify control data
In-Reply-To: <20200820181918.404758-1-ebiggers@kernel.org>
References: <20200820181918.404758-1-ebiggers@kernel.org>
Message-ID: <20200821065024.GA11908@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Eric,

> It isn't clearly defined what happens if you read from an AF_ALG request
> socket without previously sending the control data to begin an
> encryption or decryption operation.  On some kernels the read will
> return 0, while on others it will block.

> Testing this corner case isn't the purpose of af_alg02; it just wants to
> try to encrypt a zero-length message.  So, change it to explicitly send
> a zero-length message with control data.

> This fixes the test failure reported at
> https://lkml.kernel.org/r/CA+G9fYtebf78TH-XpqArunHc1L6s9mHdLEbpY1EY9tSyDjp=sg@mail.gmail.com

> Fixing the test in this way was also previously suggested at
> https://lkml.kernel.org/r/20200702033221.GA19367@gondor.apana.org.au

> Note, this patch doesn't change the fact that the read() still blocks on
> pre-4.14 kernels (which is a kernel bug), and thus the timeout logic in
> the test is still needed.

Thanks for the fix, merged!

Kind regards,
Petr
