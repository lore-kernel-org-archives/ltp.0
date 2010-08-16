Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Ol13Y-00050O-Q4
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 14:52:56 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ol13W-0004Zb-CU
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 14:52:56 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7GEbedn011321
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 10:37:40 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7GEqQa1827628
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 10:52:26 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o7GEqPlr021901
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 11:52:25 -0300
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20100805014358.GA14122@us.ibm.com>
References: <20100804235206.GA1388@us.ibm.com>
	<AANLkTin5Eyx=SgLNRDzzBe+LAW35FCz=vVxgwun0BGNk@mail.gmail.com>
	<20100805014358.GA14122@us.ibm.com>
Date: Mon, 16 Aug 2010 20:22:21 +0530
Message-Id: <1281970341.5120.18.camel@subratamodak.linux.ibm.com>
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
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net


On Wed, 2010-08-04 at 18:43 -0700, Sukadev Bhattiprolu wrote: 
> Garrett Cooper [yanegomi@gmail.com] wrote:
> | On Wed, Aug 4, 2010 at 4:52 PM, Sukadev Bhattiprolu
> | <sukadev@linux.vnet.ibm.com> wrote:
> | >
> | > pidns31: mq_open() fails with EACCESS.
> | >
> | > pidns31 test case fails with EACCESS - due to the leading '/' in
> | > mqname. See comments in the patch below for details.
> | >
> | > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> | > ---
> | > Index: testcases/kernel/containers/pidns/pidns31.c
> | > ===================================================================
> | > RCS file: /cvsroot/ltp/ltp/testcases/kernel/containers/pidns/pidns31.c,v
> | > retrieving revision 1.6
> | > diff -u -p -r1.6 pidns31.c
> | > --- testcases/kernel/containers/pidns/pidns31.c 14 Nov 2009 23:58:26 -0000      1.6
> | > +++ testcases/kernel/containers/pidns/pidns31.c 4 Aug 2010 23:24:54 -0000
> | > @@ -61,7 +61,14 @@
> | >  char *TCID = "pidns31";
> | >  int TST_TOTAL = 1;
> | >
> | > -char *mqname = "/mq1";
> | > +
> | > +/*
> | > + * NOTE: The mq_open() interface in glibc requires mqname to start with a '/'
> | > + *      and the glibc call skips the leading '/' when invoking the system
> | > + *      call. Since we bypass the glibc mq_open() (and use syscall()) we
> | > + *      define mqname without the leading '/'.
> | > + */
> | > +char *mqname = "mq1";
> | >  int result = TFAIL;
> | >
> | >  int errno;
> | > @@ -264,6 +271,7 @@ int main(int argc, char *argv[])
> | >        }
> | >
> | >        syscall(__NR_mq_unlink, mqname);
> | > +
> | >        mqd = syscall(__NR_mq_open, mqname, O_RDWR|O_CREAT|O_EXCL, 0777, NULL);
> | >        if (mqd == (mqd_t)-1) {
> | >                tst_resm(TBROK, "parent: mq_open() failed (%s)",
> | 
> | Did Linux become non-POSIX compliant :) (from
> | <http://www.opengroup.org/onlinepubs/000095399/functions/mq_open.html>)?
> 
> Heh. Good question but I think the mq_open() from glibc is compliant
> with this. I am just not sure if the call via syscall() needs to be
> compliant.
> 
> But if that is a concern, we need a separate a test case for that -
> pidns31 is using mq_* to test an unrelated feature. I think would
> make sense to apply this fix, allowing LTP to test the feature even
> on older distros.
> 
> Or pidns31 can go back to using the library interface and we could
> skip the test on old distros.

I would prefer this.

Regards--
Subrata

> 
> Sukadev.


------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
