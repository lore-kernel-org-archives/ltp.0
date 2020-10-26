From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Oct 2020 07:46:25 +0100
Subject: [LTP] [PATCH 2/5] lib/tst_net: calc mean in tst_netload()
In-Reply-To: <711809cc-28c3-a51d-72a2-6d3f64db0a1c@oracle.com>
References: <20201015122056.20715-1-alexey.kodanev@oracle.com>
 <20201015122056.20715-2-alexey.kodanev@oracle.com>
 <20201020143940.GB23197@dell5510>
 <711809cc-28c3-a51d-72a2-6d3f64db0a1c@oracle.com>
Message-ID: <20201026064625.GB21306@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

...
> >> +	if [ "$run_cnt" -lt 2 ]; then
> > maybe: if [ "$run_cnt" -lt 1 ]; then

> > BTW we should also check all numeric variables (TST_NETLOAD_CLN_REQUESTS, ...)
> > with tst_is_int (but don't bother with it now).

> >> +		run_cnt=1
> >> +		was_failure=1
> > Hm, $was_failure set before loop. Shouldn't it be inside for i in $(seq 1
> > $run_cnt); do loop? And updated on each failure (be a error counter, not boolean)?


> It is set to 1 for the special case, i.e. when run_cnt is 1, in that case
> we should tbrok the test at once. I don't see how the error counter will be
> better?

I'm sorry, I just misinterpret the code, please ignore my comment.


Kind regards,
Petr
