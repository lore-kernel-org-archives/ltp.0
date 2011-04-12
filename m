Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q9XLH-0003Rz-ET
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 06:44:51 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.74) id 1Q9XLG-0004yE-Q7
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 06:44:51 +0000
Received: by pvc30 with SMTP id 30so3368650pvc.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 11 Apr 2011 23:44:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9c4ca5a38da5486b9aceae69e9fc8a01b3e5ad4f.1302499207.git.czhang@redhat.com>
References: <9c4ca5a38da5486b9aceae69e9fc8a01b3e5ad4f.1302499207.git.czhang@redhat.com>
Date: Mon, 11 Apr 2011 23:44:44 -0700
Message-ID: <BANLkTi=1zEv2CVZX+YiX5vj6RSaiUKf2YQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] [hugetlb] hugemmap: some tiny fixes
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Sun, Apr 10, 2011 at 10:20 PM, Caspar Zhang <czhang@redhat.com> wrote:
>
> some tiny fixes including:
> - change 'return 1' to 'tst_exit()'
> - remove 'tst_rmdir()' from cleanup()
>
> Signed-off-by: Caspar Zhang <czhang@redhat.com>
> ---
> =A0testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c | =A0 =A04 ++--
> =A0testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c | =A0 =A03 +--
> =A0testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c | =A0 =A04 ++--
> =A03 files changed, 5 insertions(+), 6 deletions(-)

I agree with 01 and 04's changes, but not 02's change (the test
creates a temporary directory; it should also clean it up).
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
