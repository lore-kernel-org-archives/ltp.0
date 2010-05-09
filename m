Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1OBCwq-0002KQ-Ti
	for ltp-list@lists.sourceforge.net; Sun, 09 May 2010 20:18:00 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OBCwo-0004K1-KX
	for ltp-list@lists.sourceforge.net; Sun, 09 May 2010 20:18:00 +0000
Date: Sun, 9 May 2010 15:17:48 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100509201748.GB15769@us.ibm.com>
References: <1273430222.16443.2.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1273430222.16443.2.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [RFC] New Test Cases has dried up
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
> Hello everybody,
> 
> We completed 4 months of 2010, but, i do not find major activity in
> creating/writing/contributing new tests to LTP. Can we restart
> contributing new tests to LTP ? I am sure that somebody definitely has
> something to offer. Expecting your wishes.

I've got a draft of the securebits testcases sitting around
somewhere, but I think I was waiting for selinux+filecaps+etc
to calm down before adding new tests.  (Oh yeah, and also for
/usr/include/linux/securebits.h to magically spread around.)

-serge

------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
