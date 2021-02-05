From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 5 Feb 2021 11:17:27 +0100
Subject: [LTP] [PATCH 3/3] lib/tst_net.sh: calc median instead of mean
 in tst_netload()
In-Reply-To: <20210202133454.59224-4-alexey.kodanev@oracle.com>
References: <20210202133454.59224-1-alexey.kodanev@oracle.com>
 <20210202133454.59224-4-alexey.kodanev@oracle.com>
Message-ID: <YB0bN4BMGZyVvNeA@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Sometimes the tests can get the following results on a test network:

> gre01   1 TINFO: run server 'netstress -D ltp_v0...
> gre01   1 TINFO: run client 'netstress -l -D ltp_v0... 5 times
> gre01   1 TPASS: netstress passed, mean time 4633 ms, data: 128 22627 134 142 137
> ...
> vxlan03 1 TINFO: run server 'netstress -D ltp_v0...
> vxlan03 1 TINFO: run client 'netstress -l -D ltp_v0... 5 times
> vxlan03 1 TPASS: netstress passed, mean time 4584 ms, data: 142 140 146 145 22350

> One unsuccessful run can have a huge impact on the final result,
> when using the mean time with such data.

> A more suitable solution for short runs would be to obtain a median
> time that can remove all outliers. This will lead to more consistent
> performance test results. For example, instead of the above runs, we
> would get this:

> gre01   1 TPASS: netstress passed, median time 137 ms, data: 128 22627 134 142 137
> vxlan03 1 TPASS: netstress passed, median time 145 ms, data: 142 140 146 145 22350
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
