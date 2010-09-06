Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OsgiR-0007Ou-Lh
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 18:46:51 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OsgiQ-00080j-PO
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 18:46:51 +0000
Received: by bwz12 with SMTP id 12so4598518bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Sep 2010 11:46:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1283789822.4947.24.camel@subratamodak.linux.ibm.com>
References: <AANLkTimbmgK15xY-3d-S4GHpKVMEjXpzbkUdMS-aTGZn@mail.gmail.com>
	<AANLkTik8Vy691CGvtyK-MEwdFxLeNotdkpXkgOVP51W6@mail.gmail.com>
	<1283789822.4947.24.camel@subratamodak.linux.ibm.com>
Date: Mon, 6 Sep 2010 11:46:44 -0700
Message-ID: <AANLkTikE__kaRzC06ybmcfBARcKbdFMX9oSNqN33GHWO@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] {kernel/syscalls] fix signalfd4 tests to use
 SIGSETSIZE instead of 8
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

On Mon, Sep 6, 2010 at 9:17 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Fri, 2010-08-27 at 19:49 -0700, Henry Yei wrote:
>> Please ignore the last patch. I attached an earlier incomplete version).
>> Here is an updated patch which has the necessary =A0ltp_signal.h include
>> file for the SIGSETSIZE definition.
>
> Garret,
>
> Can you please review and apply this as well ?

Committed.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
