Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <michal.simek@petalogix.com>) id 1R85Ch-0007ZH-I2
	for ltp-list@lists.sourceforge.net; Mon, 26 Sep 2011 07:02:15 +0000
Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1R85Cg-0000MM-JV
	for ltp-list@lists.sourceforge.net; Mon, 26 Sep 2011 07:02:15 +0000
Received: by eya25 with SMTP id 25so4293397eya.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Sep 2011 00:02:08 -0700 (PDT)
Message-ID: <4E801D5B.1030206@petalogix.com>
Date: Mon, 26 Sep 2011 08:36:11 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <1316084942-24319-1-git-send-email-monstr@monstr.eu>
In-Reply-To: <1316084942-24319-1-git-send-email-monstr@monstr.eu>
Subject: Re: [LTP] [PATCH] creat08: Fix test to be able to run on NFS
Reply-To: michal.simek@petalogix.com
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
Cc: ltp-list@lists.sourceforge.net

Michal Simek wrote:
> NFS creates temporary .nfsXXX files for every open/created file.
> Based on this rmdir syscall failed because directory is not empty.
> The solution is to close all open/created files. They are also unlink
> in cleanup.
> 
> Error log:
> creat08     5  TBROK  :  rmdir testdir.A.167 failed: errno=???(39): Directory not empty
> creat08     6  TBROK  :  Remaining cases broken
> 
> Example of created files(listed by readdir):
> testdir.A.155
> .nfs00000000070201f60000007d
> ..
> .nfs00000000070201f70000007c
> .
> 
> testdir.B.155
> .nfs00000000000dc13c0000007f
> .nfs00000000000dc1050000007e
> ..
> .
> .nfs00000000000dc0f600000080
> 
> Signed-off-by: Michal Simek <monstr@monstr.eu>
> ---
>  testcases/kernel/syscalls/creat/creat08.c |   23 +++++++++++++++++------
>  1 files changed, 17 insertions(+), 6 deletions(-)


Can someone review it or apply it to git?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
