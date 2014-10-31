Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1XkCQN-0002Wh-E5
	for ltp-list@lists.sourceforge.net; Fri, 31 Oct 2014 13:39:31 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XkCQM-0000Bj-Cr
	for ltp-list@lists.sourceforge.net; Fri, 31 Oct 2014 13:39:31 +0000
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Fri, 31 Oct 2014 09:39:24 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
	[9.57.198.26])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2455B6E8040
	for <ltp-list@lists.sourceforge.net>;
	Fri, 31 Oct 2014 09:39:21 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	s9VDdMhl57016348
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Oct 2014 13:39:22 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	s9VDdL0q003244
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Oct 2014 09:39:21 -0400
Received: from localhost.localdomain ([9.78.171.132])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	s9VDdKpt003180
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Oct 2014 09:39:20 -0400
Date: Fri, 31 Oct 2014 21:39:17 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20141031133917.GA3195@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] chown and 16 bit syscall testing
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

Hey there,

I found that looks like all chown test cases will be compiled to 16 bit
compat test case, but they just call chown() something like

    TEST(chown(fname, uid, gid));

which won't test if there is a 16 bit chown() syscall. I think maybe we
should change it to something like below:

    TEST(CHOWN(fname, uid, guid));

then define CHOWN like this

    UID_T CHOWN(void (cleanup)(void))
    {
            LTP_CREATE_SYSCALL(chown, cleanup);
    }

?

Thanks in advance!


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
