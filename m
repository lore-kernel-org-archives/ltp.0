From: =?unknown-8bit?q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>
Date: Wed, 16 Dec 2020 11:55:58 +0100
Subject: [LTP] [PATCH] ipsec_lib.sh: test xfrm_user driver locally
 before rhost
In-Reply-To: <6abb1c7a-47d7-97dd-96c2-665c1030a554@oracle.com>
References: <20201216094037.5886-1-kory.maincent@bootlin.com>
 <6abb1c7a-47d7-97dd-96c2-665c1030a554@oracle.com>
Message-ID: <20201216115558.2964253d@kmaincent-XPS-13-7390>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Alexey,

On Wed, 16 Dec 2020 13:31:36 +0300
Alexey Kodanev <alexey.kodanev@oracle.com> wrote:

> On 16.12.2020 12:40, Kory Maincent wrote:
> > First, test the presence of the driver locally to avoid a misleading TWARN
> > from tst_net_run in case of driver not present.
> > 
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >  testcases/network/stress/ipsec/ipsec_lib.sh | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh
> > b/testcases/network/stress/ipsec/ipsec_lib.sh index 198c9315d..1db5fc6af
> > 100644 --- a/testcases/network/stress/ipsec/ipsec_lib.sh
> > +++ b/testcases/network/stress/ipsec/ipsec_lib.sh
> > @@ -83,8 +83,9 @@ ipsec_lib_setup()
> >  	ALGR=
> >  
> >  	if [ -n "$IPSEC_MODE" ]; then
> > -		tst_net_run "tst_check_drivers xfrm_user" || \
> > -			tst_brk TCONF "xfrm_user driver not available on
> > lhost or rhost"
> > +		tst_check_drivers xfrm_user || tst_brk TCONF "xfrm_user
> > driver not available"
> > +		tst_rhost_run -c "tst_check_drivers xfrm_user" || \
> > +			tst_brk TCONF "xfrm_user driver not available on
> > rhost"  
> 
> Hi Kory,
> 
> tst_net_run() checks the driver locally first, so I don't
> quite understand why do exactly the same what tst_net_run()
> supposed to do?

Indeed but it returns a TWARN because the command "tst_check_drivers xfrm_user"
not end properly, but in fact it should return a TCONF due to the missing
xfrm_drivers.
In the final result file we got a FAIL error with the value 36 in place of a
CONF with value 32 which should be the right message.

Regards,
