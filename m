Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OqT2x-00029E-0z
	for ltp-list@lists.sourceforge.net; Tue, 31 Aug 2010 15:46:51 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OqT2v-0006UQ-PF
	for ltp-list@lists.sourceforge.net; Tue, 31 Aug 2010 15:46:50 +0000
Received: by bwz12 with SMTP id 12so5827473bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 31 Aug 2010 08:46:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52CF90264091A14888078A031D780F430111B8E4@ism-mail03.corp.ad.wrs.com>
References: <52CF90264091A14888078A031D780F430111B8E4@ism-mail03.corp.ad.wrs.com>
Date: Tue, 31 Aug 2010 08:46:32 -0700
Message-ID: <AANLkTi=RhCp1zfX4=CcONBysQ2O04gMakYiJpXZi_9RU@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH]Modify the cacheflush01 test case
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
To: "Gao, Feng" <Feng.Gao@windriver.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

2010/8/31 Gao, Feng <Feng.Gao@windriver.com>:
> Hi,
>
> The cacheflush system call does not return EINVAL in the latest Linux
> kernel. see the link:
> A related patch about the cacheflush function:
> http://lkml.org/lkml/2009/4/9/203
> But Ralf had refused this patch:
> http://www.spinics.net/lists/linux-man/msg00906.html
> cacheflush01 testcase checks if the return value is EINVAL when the cache
> argument is not one of ICACHE, BCACHE or DCACHE. So it will fail in all
> boards.
>
> In this modification, checking return value SUCCESS will be added, instead
> of checking EINVAL

I got the first email :).

I am always hesitant committing patches like these because unless
there is documentation that clearly states "these are the requirements
for syscall/libcall foo", it can change at a later day without notice
and we'll work ourselves into this funk again.

Also, what happens when you execute this code on earlier kernels? I
hate getting emails from other users stating "the commit you did for
the test is broke my architecture foo on distro bar -- here's a patch
to fix it!".

The syscall needs to be fixed. If the cache argument is ignored, it
needs to be removed. Period. And the syscall needs to be renamed to
something else to avoid breaking backwards compatibility (which is
essentially what happened here).

FWIW we lack positive tests for this syscall, and we really should
have some (other than just nuking the entire contents of the syscall
directory).

Thanks,
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
