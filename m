Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OvOJo-00037u-HF
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 05:44:36 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OvOJl-00047L-Ix
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 05:44:36 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8E5PY1u017031
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 01:25:34 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8E5iN8n458578
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 01:44:24 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8E5iN6I003878
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 23:44:23 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <000001cb50aa$ddf34080$99d9c180$@co.jp>
References: <000001cb50aa$ddf34080$99d9c180$@co.jp>
Date: Tue, 14 Sep 2010 11:14:20 +0530
Message-Id: <1284443060.5001.6.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] About "pthread_attr_setstack/2-1"
	and	"pthread_attr_setstacksize/2-1" testsets
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

I see the following commits already:

414747ced26d943a22a3f767deb7f5b4658adb6e
	Date:   Sun Aug 29 03:32:18 2010 -0700

and

228b250d23f36ddc95cb25179441420bea9b8bdd
	Date:   Sun Aug 22 15:02:43 2010 -0700

Regards--
Subrata

On Fri, 2010-09-10 at 14:41 +0900, Mitani wrote:
> Hi,
> 
> I sent patches of two POSIX testsets "pthread_attr_setstack/2-1.c" and 
> "pthread_attr_setstacksize/2-1.c" to mailing-list last month, but I 
> have no information of their situations.
> I am glad if I can get some information about the patch.
> 
>     http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10551.html
> 
> 
> 
> 
> Thank you--
> 
> -Tomonori Mitani
> 
> 
> 
> ------------------------------------------------------------------------------
> Automate Storage Tiering Simply
> Optimize IT performance and efficiency through flexible, powerful, 
> automated storage tiering capabilities. View this brief to learn how
> you can reduce costs and improve performance. 
> http://p.sf.net/sfu/dell-sfdev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
