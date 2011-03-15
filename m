Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PzSwJ-0003DD-Vj
	for ltp-list@lists.sourceforge.net; Tue, 15 Mar 2011 12:01:27 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PzSwJ-00013e-3d
	for ltp-list@lists.sourceforge.net; Tue, 15 Mar 2011 12:01:27 +0000
Received: by wyb40 with SMTP id 40so497285wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 15 Mar 2011 05:01:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4D7F49DF.9010801@redhat.com>
References: <4D7F49DF.9010801@redhat.com>
Date: Tue, 15 Mar 2011 05:01:20 -0700
Message-ID: <AANLkTinKOtnx+q0BZLVa-pG8mTwNKTCDPxrqy6qqxdw_@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] syscalls: mmap10: fix broken testcase
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Tue, Mar 15, 2011 at 4:13 AM, Caspar Zhang <czhang@redhat.com> wrote:
> current mmap10 testcase in git couldn't reproduce the upstream bug as
> expected, also it is completely broken on ppc64 system since the page
> size in ppc64 is not 4KB but 64KB. This patch fixes these issues.
>
> Some extra fix and cleaning:
>
> . if a system without MADV_MERGEABLE, it should still be able to run all
> the other mmap10 tests if only -s option not given.
>
> . Reduce the duplicated useless output to one.
>
> This patch is tested on RHEL6.0 and mmap10 now works as expected.

Committed -- thanks.
-Garrett

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
