Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1O7JQi-0008CR-4W
	for ltp-list@lists.sourceforge.net; Thu, 29 Apr 2010 02:24:44 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O7JQf-0005K2-Sr
	for ltp-list@lists.sourceforge.net; Thu, 29 Apr 2010 02:24:44 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3T2CAxT024433
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 22:12:10 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3T2NoSl1708154
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 22:23:50 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3T2NnVQ011128
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 23:23:50 -0300
Date: Wed, 28 Apr 2010 19:29:08 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100429002908.GB3923@us.ibm.com>
References: <20100428210906.GA20572@us.ibm.com>
	<z2v364299f41004281604g2e044ff2g1c50413684753640@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <z2v364299f41004281604g2e044ff2g1c50413684753640@mail.gmail.com>
Subject: Re: [LTP] [PATCH 1/4] mqns: strip leading / from mq names
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

Quoting Garrett Cooper (yanegomi@gmail.com):
> On Wed, Apr 28, 2010 at 2:09 PM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> > So the tests can pass
> >
> > Signed-off-by: Serge Hallyn <serue@us.ibm.com>
> > ---
> > =A0testcases/kernel/containers/mqns/mqns.h =A0 =A0| =A0 =A02 ++
> > =A0testcases/kernel/containers/mqns/mqns_01.c | =A0 =A08 ++++----
> > =A0testcases/kernel/containers/mqns/mqns_02.c | =A0 =A08 ++++----
> > =A0testcases/kernel/containers/mqns/mqns_03.c | =A0 =A02 +-
> > =A0testcases/kernel/containers/mqns/mqns_04.c | =A0 =A02 +-
> > =A05 files changed, 12 insertions(+), 10 deletions(-)
> =

>     Are the SLASH_* equivalents used anywhere still?
> Thanks,
> -Garrett

I don't think so.

thanks,
-serge

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
