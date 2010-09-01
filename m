Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Oqb08-0004jI-GK
	for ltp-list@lists.sourceforge.net; Wed, 01 Sep 2010 00:16:28 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oqb07-0004qf-GY
	for ltp-list@lists.sourceforge.net; Wed, 01 Sep 2010 00:16:28 +0000
Received: by bwz12 with SMTP id 12so6321574bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 31 Aug 2010 17:16:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTikan_6LjsZeG0E2pohutyxmx+WtKM6M-J3e=A4=@mail.gmail.com>
References: <AANLkTikan_6LjsZeG0E2pohutyxmx+WtKM6M-J3e=A4=@mail.gmail.com>
Date: Tue, 31 Aug 2010 17:16:21 -0700
Message-ID: <AANLkTimiTWpkR70c1aoH_AS34StmgebeB6Vvx7JPSiya@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] [commands] apply relevant fixes from at_deny01 to
 at_allow01 script
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Aug 31, 2010 at 4:57 PM, Henry Yei <hyei@mvista.com> wrote:
> I've prepared a patch for at_allow01 that essentially duplicates the
> fixes that were checked in for at_deny01. This fixes the script to
> actually run the test when the at utility in stead of returning TCONF,
> correcting test environment, and let the script run normally without
> changing the password. See commit
> a589d12b0b49287d10f43b1a1fb72950819588eb for more details.
>
> Signed-off-by: Henry Yei <hyei@mvista.com>

Sorry for screwing up the signed-off-by line -_-...
-Garrett

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
