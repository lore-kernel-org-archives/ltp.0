Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PFKqt-0000JX-Qi
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 06:05:11 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFKqt-0006ik-1l
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 06:05:11 +0000
Received: by wya21 with SMTP id 21so5125568wya.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 07 Nov 2010 22:05:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <957775683.1389581288853739343.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <1747284477.1389541288853682476.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<957775683.1389581288853739343.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Sun, 7 Nov 2010 22:05:04 -0800
Message-ID: <AANLkTi=4eSqeEqJz84s2ThkKd2+BMtngT4_14Fd6bX5f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v8] mmap/munmap /dev/zero: a common way of
 malloc()/free() anonymous memory on Solaris
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
To: caiqian@redhat.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Wed, Nov 3, 2010 at 11:55 PM,  <caiqian@redhat.com> wrote:
> The basic purpose of this is a to test if it is possible to map and
> unmap /dev/zero, and to read and write the mapping. Being inspired by
> two bugs in the past, the design of the test was added some variations
> based on the reproducers for them. It also accept an option to
> mmap/munmap anonymous pages.
>
> One is to trigger panic with transparent hugepage feature that
> split_huge_page is very strict in checking the rmap walk was
> perfect. Keep it strict because if page_mapcount isn't stable and just
> right, the __split_huge_page_refcount that follows the rmap walk could
> lead to erratic page_count()s for the subpages. The bug in fork lead
> to the rmap walk finding the parent huge-pmd twice instead of just
> one, because the anon_vma_chain objects of the child vma still point
> to the vma->vm_mm of the parent. That trips on the split_huge_page
> mapcount vs page_mapcount check leading to a BUG_ON.
>
> The other bug is mmap() of /dev/zero results in calling map_zero()
> which on RHEL5 maps the ZERO_PAGE in every PTE within that virtual
> address range. Since the application which maps a region from 5M to
> 16M in size is also multi-threaded the subsequent munmap() of
> /dev/zero results is TLB shootdowns to all other CPUs. When this
> happens thousands or millions of times the application performance is
> terrible. The mapping ZERO_PAGE in every pte within that virtual
> address range was an optimization to make the subsequent pagefault
> times faster on RHEL5 that has been removed/changed upstream.
>
> Signed-off-by: CAI Qian <caiqian@redhat.com>
> ---
> v8: add an option to utilize KSM; no need to open /dev/zero for
> =A0 =A0anonymous page testing.
> v7: another "(void)" fix
> v6: really use git format; check return from children; cleanup.
> v5: add an option to test anonymous pages; move open() into setup().
> v4: comment fix; code cleanup.
> v3: really mmap /dev/zero; replace _exit() with exit(); fix patch
> =A0 =A0format.
> v2: incorporate comments from Mike and Garrett.

Looks fine. Please attach the file as a patch and also add a necessary
entry in one of the runtest files. If it looks ok Subrata, please
commit.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a =

Billion" shares his insights and actions to help propel your =

business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
