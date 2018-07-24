From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Jul 2018 16:14:32 +0200
Subject: [LTP] [RFC PATCH 2/2] netstress: Update help for -m behavior
In-Reply-To: <20180719125358.948-2-pvorel@suse.cz>
References: <20180719125358.948-1-pvorel@suse.cz>
 <20180719125358.948-2-pvorel@suse.cz>
Message-ID: <20180724141432.GA31915@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Hi Petr,

> Since the server waits for requests from the client, the timeout
> value for UDP/DCCP is the same as for the other protocols. Also the
> server starts earlier than the client, so it should wait some time
> to get the client requests.

> I've changed the client side only because either request from the
> client or reply from the server might be lost.

Thanks for your explanation.
I mean: UDP itself is the only protocol which don't support listen() so
netstress server using UDP timeouts after some time. The default is 100ms.
But due obvious return before listen() for UDP in server_init() -m parameter
affects behavior of the server in UDP (how quickly it timeouts):

$ date +"%T.%3N"; testcases/network/netstress/netstress -m 1 -T udp; date +"%T.%3N"
15:52:34.501
tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
netstress.c:917: INFO: max requests '3'
netstress.c:944: INFO: using UDP
netstress.c:676: INFO: assigning a name to the server socket...
netstress.c:683: INFO: bind to port 47728
netstress.c:575: FAIL: recv failed, sock '3'
netstress.c:642: BROK: Server closed
...
15:52:34.516

$ date +"%T.%3N"; testcases/network/netstress/netstress -m 1000 -T udp; date +"%T.%3N"
16:01:27.064
...
16:01:28.079

date +"%T.%3N"; testcases/network/netstress/netstress -m 10000 -T udp; date +"%T.%3N"
16:00:39.647
...
16:00:49.672

I just wonder if we want to document it (or at least don't state -m as "client only config").

> > -	{"m:", &Targ, "-m x     Reply timeout in microsec."},
> > +	{"m:", &Targ, "-m x     Reply timeout in microsec (only for tcp and sctp, also affects server on udp and udp_lite)."},
> What about dccp?
Yes, I left it, thanks!
> May be "Receive timeout in milliseconds (not affects UDP/DCCP client)"?
Yes, this is better.


Kind regards,
Petr

