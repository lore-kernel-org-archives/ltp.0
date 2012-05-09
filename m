Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SS71d-0001c2-7e
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 13:33:53 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SS71X-0008Ca-CU
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 13:33:53 +0000
Date: Wed, 09 May 2012 09:33:30 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <32d00f4f-1cc6-480b-a4b8-48824cbe23b1@zmail13.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4FAA67FF.6090808@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] mm: move_pages syscall can't return ENOENT when pages are
	not present
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
To: gaowanlong@cn.fujitsu.com
Cc: Xiaotian Feng <xtfeng@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, LTP List <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Xiaotian Feng" <xtfeng@gmail.com>
> Cc: "Zhouping Liu" <zliu@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "LTP List"
> <ltp-list@lists.sourceforge.net>
> Sent: Wednesday, May 9, 2012 8:50:07 PM
> Subject: Re: mm: move_pages syscall can't return ENOENT when pages are not present
> 
> On 05/09/2012 05:28 PM, Xiaotian Feng wrote:
> 
> > On Wed, May 9, 2012 at 4:58 PM, Zhouping Liu <zliu@redhat.com>
> > wrote:
> >> hi, all
> >>
> >> Recently, I found an error in move_pages syscall:
> >>
> >> depending on move_pages(2), when page is not present,
> >> it should fail with ENOENT, in fact, it's ok without
> >> any errno.
> >>
> >> the following reproducer can easily reproduce
> >> the issue, suggest you get more details by strace.
> >> inside reproducer, I try to move a non-exist page from
> >> node 1 to node 0.
> >>
> >> I have tested it on the latest kernel 3.4-rc5 with 2 and 4 numa
> >> nodes.
> >> [zliu@ZhoupingLiu ~]$ gcc -o reproducer reproducer.c -lnuma
> >> [zliu@ZhoupingLiu ~]$ ./reproducer
> >> from_node is 1, to_node is 0
> >> ERROR: move_pages expected FAIL.
> >>
> > 
> > " If nodes is not NULL, move_pages returns the number of valid
> > migration requests which could not currently be performed.
> >  Otherwise
> > it returns 0."
> 
> 
> FYI, actually,
> commit e78bbfa8262424417a29349a8064a535053912b9
> Author: Brice Goglin <Brice.Goglin@inria.fr>
> Date:   Sat Oct 18 20:27:15 2008 -0700
> 
>     mm: stop returning -ENOENT from sys_move_pages() if nothing got
>     migrated

maybe you missed my thought :(
if I'm wrong, please correct me.

IMO, the issue is different with the patch.
apparently, in the case(reproducer), I tried to move 4 pages from node 1 to node 0,
and the 4th page is an invalid page(absent and not aligned)
     pages[TEST_PAGES - 1] = pages[TEST_PAGES - 2] - onepage * 4 + 1;
but the reproducer passed with any errors, I think it's not common.

in the case, numa_free() return EINVAL, but we can't catch the err:
[root@ZhoupingLiu zliu]# strace ./reproducer 
...
move_pages(0, 4, {0x7f029c459000, 0x7f029c458000, 0x7f029c457000, 0x7f029c453001}, {0, 0, 0, 0}, {0xfffffffe, 0xfffffffe, 0xfffffffe, 0xfffffff2}, MPOL_MF_MOVE) = 0
write(1, "ERROR: move_pages expected FAIL."..., 33ERROR: move_pages expected FAIL.
) = 33
munmap(0x7f029c459000, 4096)            = 0
munmap(0x7f029c458000, 4096)            = 0
munmap(0x7f029c457000, 4096)            = 0
munmap(0x7f029c453001, 4096)            = -1 EINVAL (Invalid argument)
...

so I suggest we check pages' validity before move pages, if they are invalid, it should return
relevant error number to userspace, maybe it's other errno, not ENOENT, correct?

I'm trying to make a patch, but I'm a newer to the part :(

> 
> this commit changed the behaviour.
> 
> And the LTP has fixed to be consistent with this,
> https://github.com/linux-test-project/ltp/commit/338299da1ff27c7815183c1b07eb91e705f117ce
> 
> 
> Thanks,
> Wanlong Gao
> 
> > 
> >> I'm not in mail list, please CC me.
> >>
> >> /*
> >>  * Copyright (C) 2012  Red Hat, Inc.
> >>  *
> >>  * This work is licensed under the terms of the GNU GPL, version
> >>  2. See
> >>  * the COPYING file in the top-level directory.
> >>  *
> >>  * Compiled: gcc -o reproducer reproducer.c -lnuma
> >>  * Description:
> >>  * it's designed to check move_pages syscall, when
> >>  * page is not present, it should fail with ENOENT.
> >>  */
> >>
> >> #include <sys/mman.h>
> >> #include <sys/types.h>
> >> #include <sys/wait.h>
> >> #include <stdio.h>
> >> #include <unistd.h>
> >> #include <errno.h>
> >> #include <numa.h>
> >> #include <numaif.h>
> >>
> >> #define TEST_PAGES 4
> >>
> >> int main(int argc, char **argv)
> >> {
> >>        void *pages[TEST_PAGES];
> >>        int onepage;
> >>        int nodes[TEST_PAGES];
> >>        int status, ret;
> >>        int i, from_node = 1, to_node = 0;
> >>
> >>        onepage = getpagesize();
> >>
> >>        for (i = 0; i < TEST_PAGES - 1; i++) {
> >>                pages[i] = numa_alloc_onnode(onepage, from_node);
> >>                nodes[i] = to_node;
> >>        }
> >>
> >>        nodes[TEST_PAGES - 1] = to_node;
> >>
> >>        /*
> >>         * the follow page is not available, also not aligned,
> >>         * depend on move_pages(2), it can't be moved, and should
> >>         * return ENOENT errno.
> >>         */
> >>        pages[TEST_PAGES - 1] = pages[TEST_PAGES - 2] - onepage * 4
> >>        + 1;
> >>
> >>        printf("from_node is %u, to_node is %u\n", from_node,
> >>        to_node);
> >>        ret = move_pages(0, TEST_PAGES, pages, nodes, &status,
> >>        MPOL_MF_MOVE);
> >>        if (ret == -1) {
> >>                if (errno != ENOENT)
> >>                        perror("move_pages expected ENOENT errno,
> >>                        but it's");
> >>                else
> >>                        printf("Succeed\n");
> >>        } else {
> >>                printf("ERROR: move_pages expected FAIL.\n");
> >>        }
> >>
> >>        for (i = 0; i < TEST_PAGES; i++)
> >>                numa_free(pages[i], onepage);
> >>
> >>        return 0;
> >> }
> >>
> >> --
> >> Thanks,
> >> Zhouping
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe
> >> linux-kernel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> Please read the FAQ at  http://www.tux.org/lkml/
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
> 

-- 
Thanks,
Zhouping

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
