Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ljhc@br.ibm.com>) id 1NUPYP-0006UY-ME
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 19:03:53 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NUPYO-0001f3-IX
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 19:03:53 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0BINCR3003716
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 13:23:12 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0BITC35085164
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 13:29:12 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0BITBVT021473
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 16:29:12 -0200
From: Lucio Correia <ljhc@br.ibm.com>
In-Reply-To: <2937C931-7CC9-4FCF-8B9F-7D67BDF055EA@gmail.com>
References: <000101ca79f4$7af702b0$70e50810$@co.jp>
	<2937C931-7CC9-4FCF-8B9F-7D67BDF055EA@gmail.com>
Date: Mon, 11 Jan 2010 16:29:09 -0200
Message-Id: <1263234549.18451.1.camel@lucio-t400>
Mime-Version: 1.0
Subject: Re: [LTP] Tests of "iogen01" et al. fail with ltp-2009-12-10 cvs
Reply-To: ljhc@br.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

I'm still seeing this issue with LTP-20091231.

Regards,
-  
Lucio Correia
Software Engineer
IBM LTC Brazil


On Fri, 2009-12-11 at 01:52 -0800, Garrett Cooper wrote:
> On Dec 10, 2009, at 3:57 PM, Mitani wrote:
> 
> > Hi,
> > 
> > In the following thread, "rwtest has been renamed to rwtest.sh" is
> > written.
> > http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg08896.html
> > 
> > But, I got following message when I ran tests of "rwtest{01...05}"
> > and
> > "iogen01" in my system with "ltp-2009-12-10" cvs.
> > 
> > ------------
> > sh: rwtest.sh: command not found
> > ------------
> > 
> > I think that "rwtest.sh" has been renamed to "rwtest" at about
> > 2009/11/14.
> > 
> > Here is a patch that reverts the previous patch applied to
> > runtest/fs.
> > After applied this patch, "rwtest{01...05}" and "iogen01" passed in
> > my
> > system.
> > 
> > ============
> > --- fs 2009-12-10 10:23:21.000000000 +0900
> > +++ fs.new 2009-12-10 11:23:53.000000000 +0900
> > @@ -29,15 +29,15 @@
> > gf28 growfiles -W gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u
> > gfsparse-2-$$
> > -d $TMPDIR
> > gf29 growfiles -W gf29 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C
> > 1 -u
> > gfsparse-3-$$ -d $TMPDIR
> > gf30 growfiles -W gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o
> > O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$ -d $TMPDIR
> > -rwtest01 export LTPROOT; rwtest.sh -N rwtest01 -c -q -i 60s  -f
> > sync
> > 10%25000:$TMPDIR/rw-sync-$$
> > -rwtest02 export LTPROOT; rwtest.sh -N rwtest02 -c -q -i 60s  -f
> > buffered
> > 10%25000:$TMPDIR/rw-buffered-$$
> > -rwtest03 export LTPROOT; rwtest.sh -N rwtest03 -c -q -i 60s -n 2
> >  -f
> > buffered -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$
> > -rwtest04 export LTPROOT; rwtest.sh -N rwtest04 -c -q -i 60s -n 2
> >  -f sync
> > -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-sync-$$
> > -rwtest05 export LTPROOT; rwtest.sh -N rwtest05 -c -q -i 50 -T 64b
> > 500b:$TMPDIR/rwtest01%f
> > +rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync
> > 10%25000:$TMPDIR/rw-sync-$$
> > +rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f
> > buffered
> > 10%25000:$TMPDIR/rw-buffered-$$
> > +rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f
> > buffered
> > -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$
> > +rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f
> > sync -s
> > mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-sync-$$
> > +rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b
> > 500b:$TMPDIR/rwtest01%f
> > 
> > #must be run as root
> > #iogen01 iogen -i 120s -s read,write 500b:doio.f1.$$
> > 1000b:doio.f2.$$ |
> > doio -akv -n 2
> > -iogen01 export LTPROOT; rwtest.sh -N iogen01 -i 120s -s read,write
> > -Da -Dv
> > -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$
> > +iogen01 export LTPROOT; rwtest -N iogen01 -i 120s -s read,write -Da
> > -Dv -n
> > 2 500b:doio.f1.$$ 1000b:doio.f2.$$
> > 
> > fs_inod01 fs_inod $TMP 10 10 10
> > linker01 linktest.sh 1000 1000
> > 
> 
> 
> Done -- thanks!
> -Garrett
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Return on Information:
> Google Enterprise Search pays you back
> Get the facts.
> http://p.sf.net/sfu/google-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
