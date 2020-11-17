From: =?unknown-8bit?q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>
Date: Tue, 17 Nov 2020 09:33:06 +0100
Subject: [LTP] [PATCH] net/host: update to new api
In-Reply-To: <20201116184825.GB171432@pevik>
References: <20201116101840.15433-1-kory.maincent@bootlin.com>
 <20201116184143.GA171432@pevik> <20201116184825.GB171432@pevik>
Message-ID: <20201117093306.15a64998@kmaincent-XPS-13-7390>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

On Mon, 16 Nov 2020 19:48:25 +0100
Petr Vorel <pvorel@suse.cz> wrote:

> > > +            EXPECT_PASS host $rhost_addr \>/dev/null 2>&1  
> > We need to redirect also second > and &:
> > EXPECT_PASS host $rhost_addr \>/dev/null 2\>\&1  
> 
> BTW 2>&1 does not make sense in this context (it's a redirection of error
> message of EXPECT_PASS function, which would be to stdout.
> I also noticed this part of traceroute01.sh is also wrong:
> EXPECT_PASS traceroute $ip $bytes -n -m 2 $opts \>out.log 2>&1
> 
> It should be:
> EXPECT_PASS traceroute $ip $bytes -n -m 2 $opts \>out.log 2\>\&1
> 
> But IMHO it'd be better in both cases to keep stderr not redirected
> (don't hide problems). Therefore, unless you're against it, I'll remove
> redirection from traceroute01.sh.

Yes, your right.
I am new to LTP so I still make some obvious mistakes, thank you for taking
time to correct me.
The simplified variant without stderr redirection seems okay to me.

Regards,

K?ry


-- 
K?ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
