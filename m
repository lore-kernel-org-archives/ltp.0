From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 May 2016 13:55:55 +0200
Subject: [LTP] [PATCH] kernel/numa: sleep 2s in test01 for waiting
 numastat updating
In-Reply-To: <CAAUgArBQ_D+wY+48YO6VYPWYM70hxr98YshcRRkXDYSoz2VZQg@mail.gmail.com>
References: <CAAUgArBQ_D+wY+48YO6VYPWYM70hxr98YshcRRkXDYSoz2VZQg@mail.gmail.com>
Message-ID: <20160530115554.GB6079@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Without this patch always get the below error with kernel 4.6.0:
> "ltpapicmd.c:193: Test #1: NUMA hit and localnode increase in node0 is
> less than expected"
> 
> numastat's "local_node" might take some to update even though we malloc
> the local memory for each node.
> 
> So this patch in targets to sleep for 2 seconds until "local_node" get
> updated.

I've seen this failure as well and also the test 3, test 5 and test 6
two of them have sleep 2s already, hence adding sleep 2 is not good
enough it only makes the race condition less probable.

What we should do instead is to get the new stastistic in loop with a
short (~0.1s) sleep util we get the expected value or until timeout has
been reached (~10s). And this should be done ideally as a function
called from each of the numa tests.

-- 
Cyril Hrubis
chrubis@suse.cz
