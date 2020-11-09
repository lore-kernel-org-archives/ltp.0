From: =?unknown-8bit?q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>
Date: Mon, 9 Nov 2020 19:27:53 +0100
Subject: [LTP] [PATCH v2] tcp_cmds/ping/ping02: Make it compatible with
 Busybox
In-Reply-To: <5de346c3-ccd6-743e-c83c-e16c592c7ac5@oracle.com>
References: <20201106143605.27230-1-kory.maincent@bootlin.com>
 <5de346c3-ccd6-743e-c83c-e16c592c7ac5@oracle.com>
Message-ID: <20201109192753.70167ef1@kmaincent-XPS-13-7390>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Alexey,

Thank for your feedback.

On Mon, 9 Nov 2020 14:09:24 +0300
Alexey Kodanev <alexey.kodanev@oracle.com> wrote:

> On 06.11.2020 17:36, Kory Maincent wrote:
> > The ping from busybox does not have -f parameter, use -i parameter instead.
> > BusyBox does not accept pattern longer than 2 bytes.
> > 
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >  testcases/network/tcp_cmds/ping/ping02.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/testcases/network/tcp_cmds/ping/ping02.sh
> > b/testcases/network/tcp_cmds/ping/ping02.sh index e0a63c5f6..2784c8160
> > 100755 --- a/testcases/network/tcp_cmds/ping/ping02.sh
> > +++ b/testcases/network/tcp_cmds/ping/ping02.sh
> > @@ -20,7 +20,7 @@ do_setup()
> >  
> >  do_test()
> >  {
> > -	local pat="000102030405060708090a0b0c0d0e0f"
> > +	local pat="aa"
> >    
> 
> Hi Kory,
> 
> I think we should replace the options only if ping doesn't support
> '-f', i.e. something like in the first version and this patch:
> 
> local ping_opts="-f -p 000102030405060708090a0b0c0d0e0f"
> local ipaddr=$(tst_ipaddr rhost)
> local s
> 
> $PING -h 2>&1 | grep -q '[-]f' || ping_opts="-i 0.01 -p aa"

The grep in parameter is not working for all cases.
For example the ping usage of my Ubuntu laptop is:
Usage: ping [-aAbBdDfhLnOqrRUvV64] [-c count] [-i interval] [-I interface]
            [-m mark] [-M pmtudisc_option] [-l preload] [-p pattern] [-Q tos]
            [-s packetsize] [-S sndbuf] [-t ttl] [-T timestamp_option]
            [-w deadline] [-W timeout] [hop1 ...] destination


I may use test like this:
$PING -c 1 -f $ipaddr >/dev/null 2>&1 || ping_opts="-i 0.01 -p aa"

What do you think?

Regards,

> 
> for s in $PACKETSIZES; do
> 	EXPECT_PASS $PING -c $COUNT -s $s $ipaddr $ping_opts \>/dev/null
> done
> 
> 
> >  	tst_res TINFO "flood $PING: ICMP packets filled with pattern
> > '$pat'" 
> > @@ -28,7 +28,7 @@ do_test()
> >  	local s
> >  
> >  	for s in $PACKETSIZES; do
> > -		EXPECT_PASS $PING -c $COUNT -f -s $s $ipaddr -p "$pat"
> > \>/dev/null
> > +		EXPECT_PASS $PING -c $COUNT -i 0.001 -s $s $ipaddr -p
> > "$pat" \>/dev/null done
> >  }
> >  
> >   
> 



-- 
K?ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
