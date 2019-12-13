From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Dec 2019 16:40:28 +0100
Subject: [LTP] [PATCH 3/3] Split SCTP initmsg test into two test cases
In-Reply-To: <20191126120241.5460-4-mdoucha@suse.cz>
References: <20191126120241.5460-1-mdoucha@suse.cz>
 <20191126120241.5460-4-mdoucha@suse.cz>
Message-ID: <20191213154028.GC8241@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> The original test allocates 65535 output streams which may fail on older
> kernels due to lack of memory. Split the test into two test cases:
> - allocate 10 output streams and accept no errors (functional test)
> - allocate 65535 output streams and accept ENOMEM (stress test)

> Also clean up some unnecessary code and check that the test message is
> transferred correctly.

Great idea, thanks for implementing it.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
