From: =?unknown-8bit?q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>
Date: Wed, 16 Dec 2020 15:23:29 +0100
Subject: [LTP] [PATCH] ipsec_lib.sh: test xfrm_user driver locally
 before rhost
In-Reply-To: <adc0cd36-8b6b-7323-7d08-d997f2f146e2@oracle.com>
References: <20201216094037.5886-1-kory.maincent@bootlin.com>
 <6abb1c7a-47d7-97dd-96c2-665c1030a554@oracle.com>
 <20201216115558.2964253d@kmaincent-XPS-13-7390>
 <adc0cd36-8b6b-7323-7d08-d997f2f146e2@oracle.com>
Message-ID: <20201216152329.2b35525d@kmaincent-XPS-13-7390>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

On Wed, 16 Dec 2020 14:10:34 +0300
Alexey Kodanev <alexey.kodanev@oracle.com> wrote:
> >>
> >> tst_net_run() checks the driver locally first, so I don't
> >> quite understand why do exactly the same what tst_net_run()
> >> supposed to do?  
> > 
> > Indeed but it returns a TWARN because the command "tst_check_drivers
> > xfrm_user" not end properly, but in fact it should return a TCONF due to
> > the missing xfrm_drivers.
> > In the final result file we got a FAIL error with the value 36 in place of a
> > CONF with value 32 which should be the right message.
> >   
> 
> Perhaps it needs -q option here:
> 
> tst_net_run -q "tst_check_drivers xfrm_user" ... so it skips TWARN?
> 

Ah yes, I feel stupid! ;)
Tested it, it works as expected.
Do you want me to send a v2 patch?

Regards,

K?ry
