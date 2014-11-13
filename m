Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1Xp65t-0003Xw-7T
	for ltp-list@lists.sourceforge.net; Fri, 14 Nov 2014 01:54:37 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xp65s-0001fn-3P
	for ltp-list@lists.sourceforge.net; Fri, 14 Nov 2014 01:54:37 +0000
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Thu, 13 Nov 2014 20:54:30 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
	[9.57.198.28])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D08F86E8028
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Nov 2014 20:46:22 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	sAE1sRWN23396456
	for <ltp-list@lists.sourceforge.net>; Fri, 14 Nov 2014 01:54:27 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	sAE1sQYQ022365
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Nov 2014 20:54:26 -0500
Received: from localhost.localdomain ([9.77.182.67])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	sAE1sPWh022297
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Nov 2014 20:54:26 -0500
Date: Thu, 13 Nov 2014 15:57:47 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20141113075747.GA19392@localhost.localdomain>
References: <20141031133917.GA3195@localhost.localdomain>
	<54608048.4000201@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54608048.4000201@oracle.com>
Subject: Re: [LTP] chown and 16 bit syscall testing
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
To: ltp-list@lists.sourceforge.net

On Mon, Nov 10, 2014 at 12:07:20PM +0300, Stanislav Kholmanskikh wrote:
> Hi!
> 
> On 10/31/2014 04:39 PM, Han Pingtian wrote:
> >Hey there,
> >
> >I found that looks like all chown test cases will be compiled to 16 bit
> >compat test case, but they just call chown() something like
> >
> >     TEST(chown(fname, uid, gid));
> >
> >which won't test if there is a 16 bit chown() syscall. I think maybe we
> >should change it to something like below:
> >
> >     TEST(CHOWN(fname, uid, guid));
> >
> >then define CHOWN like this
> >
> >     UID_T CHOWN(void (cleanup)(void))
> >     {
> >             LTP_CREATE_SYSCALL(chown, cleanup);
> >     }
> >
> >?
> 
> I think, this is a good idea.
> 
> And there are more such test cases, which are not fixed for the 16-bit
> compat case. For example, setresuid.
> 
> So if it's possible, fixing them will be good as well;)
> 
Looks like those cases need to be fixed for the 16-bit compat, right?

chown0[1-5] fchown0[1-5] lchown03 setresgid0[1-4] setresuid0[1-3,5]


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
