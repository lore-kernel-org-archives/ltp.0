Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SXxkg-0007xy-4D
	for ltp-list@lists.sourceforge.net; Fri, 25 May 2012 16:52:34 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SXxkf-0005Bp-Jv
	for ltp-list@lists.sourceforge.net; Fri, 25 May 2012 16:52:34 +0000
Received: by yenl13 with SMTP id l13so602528yen.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 25 May 2012 09:52:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FBF4CF3.1020905@redhat.com>
References: <4FBF4CF3.1020905@redhat.com>
Date: Fri, 25 May 2012 09:52:28 -0700
Message-ID: <CAGH67wRVCnjtseVvFFdu8ibJtVoWor_seiiiHHVzVzsrVVekyg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 1/2] move_pages_support: use only allowed nodes
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

On Fri, May 25, 2012 at 2:12 AM, Jan Stancek <jstancek@redhat.com> wrote:
>
> Some setups can lack memory on arbitrary nodes, use only nodes
> returned by get_mempolicy(..., MPOL_F_MEMS_ALLOWED).
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
> =A0.../syscalls/move_pages/move_pages_support.c =A0 =A0 =A0 | =A0 74 ++++=
++++++++++++----
> =A0.../syscalls/move_pages/move_pages_support.h =A0 =A0 =A0 | =A0 =A01 +
> =A02 files changed, 62 insertions(+), 13 deletions(-)

+	if (syscall(__NR_get_mempolicy, NULL, allowed_nodemask->maskp,
+		allowed_nodemask->size, 0, MPOL_F_MEMS_ALLOWED) < 0)
+		tst_resm(TFAIL|TERRNO, "get_mempolicy: MPOL_F_MEMS_ALLOWED");
+

Would tst_brkm be better here? Also, what happens in the negative case
(HAVE_NUMA_H is not defined)? Wouldn't that segfault accessing random
memory or something along those lines?

I think it would be better to design the API (get_allowed_nodes) to
return an integer value to denote success or failure, then test for
that in main and report errors there.

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
