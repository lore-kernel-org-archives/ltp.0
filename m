From: =?unknown-8bit?q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>
Date: Fri, 6 Nov 2020 14:42:13 +0100
Subject: [LTP] [PATCH] tcp_cmds/ping: TCONF on unknown -f parameter
In-Reply-To: <87d525b8-b48b-980e-f606-9ea16ef6f246@oracle.com>
References: <20201106103748.20241-1-kory.maincent@bootlin.com>
 <87d525b8-b48b-980e-f606-9ea16ef6f246@oracle.com>
Message-ID: <20201106144213.5404e769@kmaincent-XPS-13-7390>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Alexey,

On Fri, 6 Nov 2020 14:38:33 +0300
Alexey Kodanev <alexey.kodanev@oracle.com> wrote:

> On 06.11.2020 13:37, Kory Maincent wrote:
> > The ping from busybox does not have -f parameter.
> > Return TCONF in that case.
> > 
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >  testcases/network/tcp_cmds/ping/ping02.sh | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/testcases/network/tcp_cmds/ping/ping02.sh
> > b/testcases/network/tcp_cmds/ping/ping02.sh index
> > e0a63c5f6..6daf22635 100755 ---
> > a/testcases/network/tcp_cmds/ping/ping02.sh +++
> > b/testcases/network/tcp_cmds/ping/ping02.sh @@ -27,6 +27,10 @@
> > do_test() local ipaddr=$(tst_ipaddr rhost)
> >  	local s
> >  
> > +	if ! $PING -c 1 -f $ipaddr >/dev/null; then
> > +		tst_brk TCONF "$PING: invalid option -- 'f'"  
> 
> Hi Kory,
> 
> If it's not supported, what about replacing it with '-i 0'?

Ah yes good idea, thanks.

Regards,

> 
> 
> > +	fi
> > +
> >  	for s in $PACKETSIZES; do
> >  		EXPECT_PASS $PING -c $COUNT -f -s $s $ipaddr -p
> > "$pat" \>/dev/null done
> >   
> 



-- 
K?ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
