Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NV44S-0001ul-V4
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 14:19:40 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NV44S-0006oN-0S
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 14:19:40 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0DE79aN003659
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Jan 2010 09:07:09 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0DEJXrt109240
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Jan 2010 09:19:33 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0DEJX8N016652
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Jan 2010 12:19:33 -0200
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4B471F8D.7010907@teldevice.co.jp>
References: <4B46D5F0.3090801@teldevice.co.jp>
	<20100108112534.GA333981@medusa.sis.pasteur.fr>
	<4B471F8D.7010907@teldevice.co.jp>
Date: Wed, 13 Jan 2010 19:49:22 +0530
Message-Id: <1263392362.5591.27.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] LTP installation  configure Error
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
Cc: ltp-list@lists.sourceforge.net, TED ITC Agarwal Ashish <ashish.g@teldevice.co.jp>

Garrett,

On Fri, 2010-01-08 at 21:05 +0900, TED ITC Agarwal Ashish wrote: 
> Hello Nicholas,
> 
> Cc: All
> 
> Thanks a lot Dear,
> 
> Yes it seems to me too pretty good to tackle this as Warning not the Error condition.
> but after that too it didn't work the system Fedora Core 3(i checked quickly, not debug at my level).
> but i didn't go well, it is as as before.
> Also tried after "$make clean" & "$./configure".
> 
> Because in the mean while i updated my Fedora3 to Fedora5 (kernel 2.6.15-1.2054-FC5).
> 
> For this new configuration i were able to complete the "$./configure" & "$make all" part.
> but when i tried to "make install" i had an another compiler error as below:
> 
> """""
> internal compiler error: in merge_alias_info, at tree-ssa-copy.c:235
> Please submit a full bug report,
> """""
> 
> So i hang around gOOgliNg and found that it is a GCC compiler problem.
> The compiler over FC5 were 4.1.0.
> I thought it were again challenging to update the compiler so for the very first time i just updated this to Fc7 system, where i had GCC 4.1.2.
> The flow went great and i were able to do the test primarily.
> 
> ============================
> FYI: the LTP-Full-20091231 installs the LTP over /opt/LTP location.
> Don't try to run it over the directory we make install this.
> * (i had 15 minutes fight for this conclusion,
>     because there were no msg of it over installations time)
> ============================
> 
> 
> ????????????????????????????????????????
> 
> Now 2 more question added to this queue is: The requirement specification of LTP.
> 
> Q2. Gcc -> ? (which version)
> Kernel -> ?
> 
> Q3. I will search further now on, but i want to ask is the same LTP is valid for the other CPU's as well.
> My AIM to check for the i.MX17 device (ARM Core) Embedded Linux. (kernel 2.6.19.2-xx)
> 
> ????????????????????????????????????????
> 
> --
> Ashish Agarwal
> '? =?'
> When others working for an Impossible task, It is better to be quite though.
> Let the others proceed  ...... !!
> 
> Nicolas Joly ????????:
> > On Fri, Jan 08, 2010 at 03:51:28PM +0900, TED ITC Agarwal Ashish wrote:
> >> Hello All
> >>
> >> I am novice for the LTP, just last week i heard something LTP
> >> and feel curious about it so started searching and installations.
> >>
> >> "./configure " generates Error to me as written below.
> >>
> >> configure: error: Couldn't find functional copy of quota v2 - are you running 2.4.x?
> > 
> > Hi,
> > 
> > I do see the same with an old 2006.0 Gentoo base (actually in a
> > chroot) ... I worked around it by making it a warning instead of an
> > error.
> > 
> > IMHO, lacking some features should not prevent building/running LTP.
> > 
> > 
> > Index: m4/ltp-quota.m4
> > ===================================================================
> > RCS file: /cvsroot/ltp/ltp/m4/ltp-quota.m4,v
> > retrieving revision 1.4
> > diff -u -p -r1.4 ltp-quota.m4
> > --- m4/ltp-quota.m4	20 Dec 2009 00:36:35 -0000	1.4
> > +++ m4/ltp-quota.m4	8 Jan 2010 11:24:14 -0000
> > @@ -37,7 +37,7 @@ dnl}],[has_24_quotactl="yes"],
> >  #include <unistd.h>],[
> >  int main(void) {
> >  	return quotactl(Q_GETINFO, (const char *)NULL, geteuid(), (caddr_t)NULL);
> > -}],[has_quotav2="yes"],[AC_MSG_ERROR([Couldn't find functional copy of quota v2 - are you running 2.4.x?])])
> > +}],[has_quotav2="yes"],[AC_MSG_WARN([Couldn't find functional copy of quota v2 - are you running 2.4.x?])])
> >  dnl if test "x$has_24_quotactl" = "xyes"; then
> >  dnl	AC_DEFINE(HAS_24_QUOTACTL,1,[Define to 1 if you have the 2.4.x version of quotactl, e.g. require linux/quota.h instead of sys/quota.h])
> >  dnl elif test "x$has_new_26_quotactl" = "xyes"; then

Please see this patch and kindly make changes accordingly.

Regards--
Subrata

> > 
> 
> ------------------------------------------------------------------------------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev 
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
