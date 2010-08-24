Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OnrHG-0005lU-Hw
	for ltp-list@lists.sourceforge.net; Tue, 24 Aug 2010 11:02:50 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OnrHE-0004fJ-C3
	for ltp-list@lists.sourceforge.net; Tue, 24 Aug 2010 11:02:50 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7OAsOV7021584
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Aug 2010 04:54:24 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7OB2g6G182568
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Aug 2010 05:02:42 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o7OB2ftP025165
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Aug 2010 05:02:42 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <AANLkTim5a5QasWWpcOarGaOnLJzJpyVKSB22HuCm6qKs@mail.gmail.com>
References: <20100804235206.GA1388@us.ibm.com>
	<AANLkTin5Eyx=SgLNRDzzBe+LAW35FCz=vVxgwun0BGNk@mail.gmail.com>
	<20100805014358.GA14122@us.ibm.com>
	<1281970341.5120.18.camel@subratamodak.linux.ibm.com>
	<AANLkTim5a5QasWWpcOarGaOnLJzJpyVKSB22HuCm6qKs@mail.gmail.com>
Date: Tue, 24 Aug 2010 16:32:41 +0530
Message-Id: <1282647761.4833.8.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] pidns31: fix EACCESS error in mq_open()
Reply-To: subrata@linux.vnet.ibm.com
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
Cc: ltp-list@lists.sourceforge.net, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

On Mon, 2010-08-16 at 16:01 -0700, Garrett Cooper wrote: 
> On Mon, Aug 16, 2010 at 7:52 AM, Subrata Modak
> <subrata@linux.vnet.ibm.com> wrote:
> >
> > On Wed, 2010-08-04 at 18:43 -0700, Sukadev Bhattiprolu wrote:
> >> Garrett Cooper [yanegomi@gmail.com] wrote:
> >> | On Wed, Aug 4, 2010 at 4:52 PM, Sukadev Bhattiprolu
> >> | <sukadev@linux.vnet.ibm.com> wrote:
> >> | >
> >> | > pidns31: mq_open() fails with EACCESS.
> >> | >
> >> | > pidns31 test case fails with EACCESS - due to the leading '/' in
> >> | > mqname. See comments in the patch below for details.
> >> | >
> >> | > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> >> | > ---
> >> | > Index: testcases/kernel/containers/pidns/pidns31.c
> >> | > ===================================================================
> >> | > RCS file: /cvsroot/ltp/ltp/testcases/kernel/containers/pidns/pidns31.c,v
> >> | > retrieving revision 1.6
> >> | > diff -u -p -r1.6 pidns31.c
> >> | > --- testcases/kernel/containers/pidns/pidns31.c 14 Nov 2009 23:58:26 -0000      1.6
> >> | > +++ testcases/kernel/containers/pidns/pidns31.c 4 Aug 2010 23:24:54 -0000
> >> | > @@ -61,7 +61,14 @@
> >> | >  char *TCID = "pidns31";
> >> | >  int TST_TOTAL = 1;
> >> | >
> >> | > -char *mqname = "/mq1";
> >> | > +
> >> | > +/*
> >> | > + * NOTE: The mq_open() interface in glibc requires mqname to start with a '/'
> >> | > + *      and the glibc call skips the leading '/' when invoking the system
> >> | > + *      call. Since we bypass the glibc mq_open() (and use syscall()) we
> >> | > + *      define mqname without the leading '/'.
> >> | > + */
> >> | > +char *mqname = "mq1";
> >> | >  int result = TFAIL;
> >> | >
> >> | >  int errno;
> >> | > @@ -264,6 +271,7 @@ int main(int argc, char *argv[])
> >> | >        }
> >> | >
> >> | >        syscall(__NR_mq_unlink, mqname);
> >> | > +
> >> | >        mqd = syscall(__NR_mq_open, mqname, O_RDWR|O_CREAT|O_EXCL, 0777, NULL);
> >> | >        if (mqd == (mqd_t)-1) {
> >> | >                tst_resm(TBROK, "parent: mq_open() failed (%s)",
> >> |
> >> | Did Linux become non-POSIX compliant :) (from
> >> | <http://www.opengroup.org/onlinepubs/000095399/functions/mq_open.html>)?
> >>
> >> Heh. Good question but I think the mq_open() from glibc is compliant
> >> with this. I am just not sure if the call via syscall() needs to be
> >> compliant.
> >>
> >> But if that is a concern, we need a separate a test case for that -
> >> pidns31 is using mq_* to test an unrelated feature. I think would
> >> make sense to apply this fix, allowing LTP to test the feature even
> >> on older distros.
> >>
> >> Or pidns31 can go back to using the library interface and we could
> >> skip the test on old distros.
> >
> > I would prefer this.
> 
> Do I hear someone volunteering to add the required autoconf tests and
> tests for this :)?

Suka ?

Regards--
Subrata



------------------------------------------------------------------------------
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users 
worldwide. Take advantage of special opportunities to increase revenue and 
speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
