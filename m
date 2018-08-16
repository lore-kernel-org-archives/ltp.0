From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Aug 2018 13:42:07 +0200
Subject: [LTP] [PATCH v2 1/1] network/route: Rewrite route-change-dst
 into new API
In-Reply-To: <1533828226-24753-4-git-send-email-alexey.kodanev@oracle.com>
References: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
 <1533828226-24753-4-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180816114207.GB13716@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 07/27/2018 04:01 PM, Alexey Kodanev wrote:
> ...
> >> +	tst_netload -T udp -r 1 -a 1 -H $addr

> > Unfortunately, it won't work this way. tst_netload is using requests/response
> > model for UDP. You have to make sure the server can send responses.

> > Also, netstress UDP/DCCP client allows to pass 'max_etime_cnt' (12) failed
> > requests after which it will double receive timeout, starting from 100ms up to
> > 3.2s. This is about 30 sec if there is no connection. With a single request or
> > below max_etime_cnt + 1 value it will always pass. I guess we need to set the
> > proper request parameter limit for UDP/DCCP protocol or check whether the
> > number of timeout errors is equal or greater than the number of requests.

> Applied the fix for this bug:
> 4ceb442b56ad ("netstress: handle timeout errors for a small number of requests")

Thanks for your explanation and netstress fix.

I'll try to implement it in C, using rtnetlink as we've been talking about in
the past. That should stress the system more than using user space tools.
Maybe for the start with just changing interfaces (without checking by sending
packets).


Kind regards,
Petr
