From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 May 2018 16:41:03 +0200
Subject: [LTP] [PATCH 1/1] ipneigh01: Replace TCONF error message with
 TINFO
In-Reply-To: <2943ea0b-0487-0136-bd1c-6d90bf80385f@oracle.com>
References: <20180503113637.21573-1-asmorodskyi@suse.com>
 <2943ea0b-0487-0136-bd1c-6d90bf80385f@oracle.com>
Message-ID: <20180504144103.mglidc376gvtb25z@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Anton, Alexey,

> On 03.05.2018 14:36, Anton Smorodskyi wrote:
> > When test case catch that arp command not support ipv6
> > it is more appropriate to send this as TINFO message
> Hi Anton,

> And why it is more appropriate? TCONF is not an error message.

> > @@ -76,7 +76,7 @@ rhost=$(tst_ipaddr rhost)
> >  if [ -z "$TST_IPV6" ]; then
> >  	do_test "arp -a" "arp -d $rhost"
> >  else
> > -	tst_resm TCONF "'arp cmd doesn't support IPv6, skipping test-case"
> > +	tst_resm TINFO "'arp cmd doesn't support IPv6, skipping test-case"
> >  fi


> TCONF here, only to make sure that the test results are consistent with
> 'TST_TOTAL=2', regardless whether we use '-6' option or not.
Alexey, thanks for a clarification.
So TST_TOTAL could be set according to $TST_IPV6.


Kind regards,
Petr
