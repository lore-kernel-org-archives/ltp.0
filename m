From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 27 Jun 2018 14:47:11 +0300
Subject: [LTP] [PATCH 2/2] network/route: Rewrite route-change-gw into
 new API
In-Reply-To: <20180625140158.rvjasl7jq2m4blbc@dell5510>
References: <20180517103527.23542-1-pvorel@suse.cz>
 <20180517103527.23542-2-pvorel@suse.cz>
 <cfa4f035-9052-147b-4d6d-2b6ecfe4cf31@oracle.com>
 <20180518110110.zeabusjbiq2lq263@dell5510>
 <20180625140158.rvjasl7jq2m4blbc@dell5510>
Message-ID: <a5ed562e-4135-581c-aff0-65d7db4f210f@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 25.06.2018 17:01, Petr Vorel wrote:
> Hi Alexey,
> 
>>> don't remember why the rewritten test is
>>> not using background traffic and not changing gateway anymore?
>> The current implementation was based on your suggestion for route-change-dst [1] (I'll
>> mention that in commit message), which uses ns-udpsender.  The other patch [2] is
>> changing gateway.
> 
>> Tests used ns-udpsender in previous implementation and we decided to keep it as  use
>> background traffic isn't sufficient enough [3].
> 
>> But ns-udpsender isn't good enough, as it doesn't check whether destination receive it [4].
>> And indeed you can pass it to any destination and it will not fail, e.g.:
>> ns-udpsender -f 4 -D 1.2.3.4 -p 1 -o -s 1472
> 
>> I guess we need to write another helper, which will listen for packets on remote side.
>> Any recommendations/ideas on it?
> 

It would be good to have this helper in order to extend the tests.
Not sure if it can be used other than here...

The other option is to configure a host on the other end as well,
so that we get responses, and use the standard tools.

> Ping, please.
> I suppose we want these gateway tests do the real client server communication even it's
> done on localhost, via tst_ipaddr_un().
> 
> I guess we want to keep UDP, as it's faster than TCP.
> So I'll create some server, which listens the packets, counts them and reports
> it.
> 
> 
> Kind regards,
> Petr
> 
> 
>> Kind regards,
>> Petr
> 
>> [1] http://lists.linux.it/pipermail/ltp/2017-August/005367.html
>> [2] https://lists.linux.it/pipermail/ltp/2018-May/008152.html
>> [3] http://lists.linux.it/pipermail/ltp/2017-July/005125.html
>> [4] http://lists.linux.it/pipermail/ltp/2017-August/005336.html

