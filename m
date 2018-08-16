From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Aug 2018 13:16:56 +0200
Subject: [LTP] [RFC PATCH 2/2] netstress: Update help for -m behavior
In-Reply-To: <1533828226-24753-4-git-send-email-alexey.kodanev@oracle.com>
References: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
 <1533828226-24753-4-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180816111655.GA13716@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> >> Hi Petr,

> >> Since the server waits for requests from the client, the timeout
> >> value for UDP/DCCP is the same as for the other protocols. Also the
> >> server starts earlier than the client, so it should wait some time
> >> to get the client requests.

> >> I've changed the client side only because either request from the
> >> client or reply from the server might be lost.

> > Thanks for your explanation.
> > I mean: UDP itself is the only protocol which don't support listen() so
> > netstress server using UDP timeouts after some time. The default is 100ms.

> Hmm, for the server the default should be 60 sec. Does it timeout earlier?
Yes. The timeout is affected by value of -m. Thats' what I meant by my previous:
$ date +"%T.%3N"; testcases/network/netstress/netstress -m 1 -T udp; date +"%T.%3N"
15:52:34.501
tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
The timeout is actually 1ms. Try it with -m 1000 and it'll be indeed 1s
netstress.c:917: INFO: max requests '3'
netstress.c:944: INFO: using UDP
netstress.c:676: INFO: assigning a name to the server socket...
netstress.c:683: INFO: bind to port 47728
netstress.c:575: FAIL: recv failed, sock '3'
netstress.c:642: BROK: Server closed
...
15:52:34.516


This is caused by udp/udp_lite not using listen(), but maybe is should be at
least mentioned in help (if wanted behavior).

Kind regards,
Petr
