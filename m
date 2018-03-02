From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 2 Mar 2018 10:12:25 +0100
Subject: [LTP] [RFC PATCH v2 2/2] tst_netload: Exit with TCONF when
 netstress exit with CONF
In-Reply-To: <20180301184222.GA16992@x230>
References: <20180301105943.5487-1-pvorel@suse.cz>
 <20180301105943.5487-2-pvorel@suse.cz>
 <65377935-590d-6623-dafb-db85899e8f0c@oracle.com>
 <20180301184222.GA16992@x230>
Message-ID: <20180302091224.xxl2al3ymivx5oig@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > > diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> > > index 95e13ee03..db9bb028d 100644
> > > --- a/testcases/lib/test_net.sh
> > > +++ b/testcases/lib/test_net.sh
> > > @@ -453,7 +453,9 @@ tst_netload()
> > >  	tst_rhost_run -c "netstress $s_opts" > tst_netload.log 2>&1
> > >  	if [ $? -ne 0 ]; then
> > >  		cat tst_netload.log
> > > -		tst_brkm TFAIL "server failed"
> > > +		local ttype="TFAIL"
> > > +		grep -e 'CONF:' tst_netload.log && ttype="TCONF"


> > What about using the returned status instead of grep?
> Sure, that's much better solution, thanks!

Actually, this would not work - we need to get info from:
	tst_rhost_run -c "netstress $s_opts" > tst_netload.log 2>&1

But tst_rhost_run return only 1 on failure:

	local ret=0
	...
	'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
	...
	echo "$output" | grep -q 'RTERR$' && ret=1

So I'd leave it using grep unless we want to change tst_rhost_run to return the exit code
of the last command (this would work for ssh and netns, and I guess for rsh as well).

Another thing in tst_netload(), on client side:
	netstress -l $c_opts > tst_netload.log 2>&1 || ret=1
	tst_rhost_run -c "pkill -9 netstress\$"

	if [ "$expect_ret" -ne "$ret" ]; then
		tst_dump_rhost_cmd
		cat tst_netload.log
		tst_brkm TFAIL "expected '$expect_res' but ret: '$ret'"
	fi

There are 3 netstress usages expecting to fail (via virt_compare_netperf "fail").
So far we don't report TCONF for client, so this code is correct. But if not we can have
TCONF and result will be TPASS as we don't distinguish between TCONF and TFAIL when
running netstress on client side either.

Kind regards,
Petr
