Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NpDEE-000765-8b
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 04:09:02 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NpDED-0004bB-9I
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 04:09:02 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2A3wRRg013443
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Mar 2010 22:58:27 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2A48tJo167904
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Mar 2010 23:08:55 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2A48t4D025104
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Mar 2010 23:08:55 -0500
Date: Wed, 10 Mar 2010 09:38:52 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100310040852.GA2825@linux.vnet.ibm.com>
References: <E1Np2Dh-0002cm-OF@sfp-scmshell-1.v30.ch3.sourceforge.com>
	<364299f41003091247j3b7113dalc3d3e18a177731b9@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41003091247j3b7113dalc3d3e18a177731b9@mail.gmail.com>
Subject: Re: [LTP] [Git] ltp updated.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Mar 09, 2010 at 12:47:44PM -0800, Garrett Cooper wrote:
> On Tue, Mar 9, 2010 at 8:23 AM, Rishi kesh K Rajak
> <risrajak@linux.vnet.ibm.com> wrote:
> > +LIB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D -ld
> > +
> =

> Wrong. Should be: LDLIBS +=3D -ldl

oops My mistake, thanks. One good advantage of sending mail to ltp-list aut=
omatically after
each commit.

Thanks
-Rishi

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
