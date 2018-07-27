From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 27 Jul 2018 13:24:15 +0300
Subject: [LTP] [RFC PATCH 2/2] netstress: Update help for -m behavior
In-Reply-To: <20180724141432.GA31915@dell5510>
References: <20180719125358.948-1-pvorel@suse.cz>
 <20180719125358.948-2-pvorel@suse.cz> <20180724141432.GA31915@dell5510>
Message-ID: <e31b2915-84e3-5601-7502-5336fd0c3b3a@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/24/2018 05:14 PM, Petr Vorel wrote:
> Hi Alexey,
> 
>> Hi Petr,
> 
>> Since the server waits for requests from the client, the timeout
>> value for UDP/DCCP is the same as for the other protocols. Also the
>> server starts earlier than the client, so it should wait some time
>> to get the client requests.
> 
>> I've changed the client side only because either request from the
>> client or reply from the server might be lost.
> 
> Thanks for your explanation.
> I mean: UDP itself is the only protocol which don't support listen() so
> netstress server using UDP timeouts after some time. The default is 100ms.

Hmm, for the server the default should be 60 sec. Does it timeout earlier?

It is more than enough for the tests to start the client on the other end
and start sending requests. If it hasn't happened during this time period
there is no reason to have it running there.

> But due obvious return before listen() for UDP in server_init() -m parameter
> affects behavior of the server in UDP (how quickly it timeouts):
> 

And with listen() it won't wait forever either, it will be killed by LTP
timeout per test run...

> $ date +"%T.%3N"; testcases/network/netstress/netstress -m 1 -T udp; date +"%T.%3N"
> 15:52:34.501
 > tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
> netstress.c:917: INFO: max requests '3'
> netstress.c:944: INFO: using UDP
> netstress.c:676: INFO: assigning a name to the server socket...
> netstress.c:683: INFO: bind to port 47728
> netstress.c:575: FAIL: recv failed, sock '3'
> netstress.c:642: BROK: Server closed
> ...
> 15:52:34.516

Thanks,
Alexey
