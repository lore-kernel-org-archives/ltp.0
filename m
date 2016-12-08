From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 8 Dec 2016 18:32:28 +0100
Subject: [LTP] Invoking networking tests
In-Reply-To: <58494350.80404@oracle.com>
References: <20161207141855.lvyrqs4cxhy4wr2c@dell5510>
 <58494350.80404@oracle.com>
Message-ID: <20161208173228.jixqv2xd6jqptz5i@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thanks for info!

> Please also see the recent patch:
> 5f8ca6c ("network: test_net.sh: allow to run network tests on a single
> machine")
Noticed, I was waiting for pushing it to master :-). Looks interesting, I'll give it a try.

Can it be "dangerous" to run tests "natively", i.e. without ltp-pan? It'd be run by
automation (no cancel ctrl+c), so cleanup children is unlike. Or is it also for cleanup
when some test misbehave and it's being killed by kernel?


Kind regards,
Petr
