Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SzfjH-0003rj-3T
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 03:17:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SzfjE-0001rE-Fz
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 03:17:39 +0000
Message-ID: <50247C2C.5000104@redhat.com>
Date: Fri, 10 Aug 2012 11:12:44 +0800
From: Zhouping Liu <zliu@redhat.com>
MIME-Version: 1.0
References: <cover.1344492473.git.caspar@casparzhang.com>
In-Reply-To: <cover.1344492473.git.caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH resend 0/6] NUMA and follow-up fix
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0045803360883140080=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--===============0045803360883140080==
Content-Type: multipart/alternative;
	boundary="------------000903010100030003000806"

This is a multi-part message in MIME format.
--------------000903010100030003000806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 08/09/2012 02:15 PM, Caspar Zhang wrote:
> Resending the whole patch series (including Jan's 2 patches) for easier
> reviewing.

Caspar, after applying the patch set, I met the bellow compiling error 
when do  'make install':

... snip ...
make[4]: Leaving directory `/root/ltp_new/testcases/kernel/syscalls/umask'
make[3]: Leaving directory `/root/ltp_new/testcases/kernel/syscalls'
make[3]: Entering directory `/root/ltp_new/testcases/kernel/lib'
../../../include/mk/env_post.mk:94: warning: overriding recipe for 
target `/opt/ltp/lib'
../../../include/mk/env_post.mk:94: warning: ignoring old recipe for 
target `/opt/ltp/lib'
../../../include/mk/env_post.mk:96: warning: overriding recipe for 
target `/opt/ltp/lib/libkerntest.a'
../../../include/mk/env_post.mk:96: warning: ignoring old recipe for 
target `/opt/ltp/lib/libkerntest.a'
../../../include/mk/generic_trunk_target.inc:89: CURDIR is: 
/root/ltp_new/testcases/kernel/lib
../../../include/mk/generic_trunk_target.inc:89: *** SUBDIRS empty -- 
did you want generic_leaf_target instead?.  Stop.
make[3]: Leaving directory `/root/ltp_new/testcases/kernel/lib'
make[2]: *** [install] Error 2
make[2]: Leaving directory `/root/ltp_new/testcases/kernel'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/root/ltp_new/testcases'
make: *** [testcases-install] Error 2

Thanks,
Zhouping

>
> updates:
>     syscalls/numa: check syscall availability
>       remove TEST() macro and use syscall() directly.
>     numa_helper: move to libkerntest
>       merged the library cleaning fix to this one.
>     mm: use new numa_helper
>       the same as previous V3 version, which already has Jan's reivew.
>
> Caspar Zhang (4):
>    syscalls/numa: check syscall availability
>    numa_helper: move to libkerntest
>    mm: use new numa_helper
>    mm: add common Makefile include: libmem.mk
>
> Jan Stancek (2):
>    numa_helper: add flag to get_allowed_nodes()
>    update testcases to use flag for get_allowed_nodes()
>
>   testcases/kernel/Makefile                          |    4 +
>   testcases/kernel/include/lib.mk                    |   37 +++
>   testcases/kernel/include/numa_helper.h             |   37 +++
>   testcases/kernel/lib/Makefile                      |   29 +++
>   testcases/kernel/lib/numa_helper.c                 |  266 ++++++++++++++++++++
>   testcases/kernel/mem/cpuset/Makefile               |   22 +--
>   testcases/kernel/mem/cpuset/cpuset01.c             |   16 +-
>   testcases/kernel/mem/hugetlb/Makefile.inc          |   18 +-
>   testcases/kernel/mem/hugetlb/hugemmap/Makefile     |   12 +-
>   testcases/kernel/mem/include/libmem.mk             |   40 +++
>   testcases/kernel/mem/include/mem.h                 |    2 +-
>   testcases/kernel/mem/ksm/Makefile                  |   22 +--
>   testcases/kernel/mem/ksm/ksm02.c                   |    9 +-
>   testcases/kernel/mem/ksm/ksm04.c                   |    9 +-
>   testcases/kernel/mem/lib/Makefile                  |    1 +
>   testcases/kernel/mem/lib/mem.c                     |   50 +++--
>   testcases/kernel/mem/oom/Makefile                  |   22 +--
>   testcases/kernel/mem/oom/oom02.c                   |    4 -
>   testcases/kernel/mem/oom/oom04.c                   |    4 -
>   testcases/kernel/mem/swapping/Makefile             |   22 +--
>   testcases/kernel/mem/thp/Makefile                  |   22 +--
>   testcases/kernel/mem/tunable/Makefile              |   22 +--
>   testcases/kernel/mem/vma/Makefile                  |    4 +-
>   testcases/kernel/mem/vma/vma02.c                   |   19 +-
>   testcases/kernel/mem/vma/vma04.c                   |   11 +-
>   testcases/kernel/syscalls/get_mempolicy/Makefile   |    2 +-
>   .../syscalls/get_mempolicy/get_mempolicy01.c       |   15 +-
>   testcases/kernel/syscalls/mbind/Makefile           |    2 +-
>   testcases/kernel/syscalls/mbind/mbind01.c          |   14 +-
>   testcases/kernel/syscalls/move_pages/Makefile      |    2 +-
>   .../kernel/syscalls/move_pages/move_pages02.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages03.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages04.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages05.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages06.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages07.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages08.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages09.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages10.c      |    5 +-
>   .../kernel/syscalls/move_pages/move_pages11.c      |    5 +-
>   .../syscalls/move_pages/move_pages_support.c       |    8 +-
>   testcases/kernel/syscalls/numa/Makefile            |   22 --
>   testcases/kernel/syscalls/numa/Makefile.inc        |   27 --
>   testcases/kernel/syscalls/numa/lib/Makefile        |   26 --
>   testcases/kernel/syscalls/numa/lib/numa_helper.c   |  165 ------------
>   testcases/kernel/syscalls/numa/lib/numa_helper.h   |   33 ---
>   46 files changed, 562 insertions(+), 508 deletions(-)
>   create mode 100644 testcases/kernel/include/lib.mk
>   create mode 100644 testcases/kernel/include/numa_helper.h
>   create mode 100644 testcases/kernel/lib/Makefile
>   create mode 100644 testcases/kernel/lib/numa_helper.c
>   create mode 100644 testcases/kernel/mem/include/libmem.mk
>   delete mode 100644 testcases/kernel/syscalls/numa/Makefile
>   delete mode 100644 testcases/kernel/syscalls/numa/Makefile.inc
>   delete mode 100644 testcases/kernel/syscalls/numa/lib/Makefile
>   delete mode 100644 testcases/kernel/syscalls/numa/lib/numa_helper.c
>   delete mode 100644 testcases/kernel/syscalls/numa/lib/numa_helper.h
>
>
>
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


--------------000903010100030003000806
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi,<br>
      <br>
      On 08/09/2012 02:15 PM, Caspar Zhang wrote:<br>
    </div>
    <blockquote cite="mid:cover.1344492473.git.caspar@casparzhang.com"
      type="cite">
      <pre wrap="">
Resending the whole patch series (including Jan's 2 patches) for easier 
reviewing.</pre>
    </blockquote>
    <br>
    Caspar, after applying the patch set, I met the bellow compiling
    error when do&nbsp; 'make install':<br>
    <br>
    ... snip ...<br>
    make[4]: Leaving directory
    `/root/ltp_new/testcases/kernel/syscalls/umask'<br>
    make[3]: Leaving directory `/root/ltp_new/testcases/kernel/syscalls'<br>
    make[3]: Entering directory `/root/ltp_new/testcases/kernel/lib'<br>
    ../../../include/mk/env_post.mk:94: warning: overriding recipe for
    target `/opt/ltp/lib'<br>
    ../../../include/mk/env_post.mk:94: warning: ignoring old recipe for
    target `/opt/ltp/lib'<br>
    ../../../include/mk/env_post.mk:96: warning: overriding recipe for
    target `/opt/ltp/lib/libkerntest.a'<br>
    ../../../include/mk/env_post.mk:96: warning: ignoring old recipe for
    target `/opt/ltp/lib/libkerntest.a'<br>
    ../../../include/mk/generic_trunk_target.inc:89: CURDIR is:
    /root/ltp_new/testcases/kernel/lib<br>
    ../../../include/mk/generic_trunk_target.inc:89: *** SUBDIRS empty
    -- did you want generic_leaf_target instead?.&nbsp; Stop.<br>
    make[3]: Leaving directory `/root/ltp_new/testcases/kernel/lib'<br>
    make[2]: *** [install] Error 2<br>
    make[2]: Leaving directory `/root/ltp_new/testcases/kernel'<br>
    make[1]: *** [install] Error 2<br>
    make[1]: Leaving directory `/root/ltp_new/testcases'<br>
    make: *** [testcases-install] Error 2<br>
    <br>
    Thanks,<br>
    Zhouping <br>
    <br>
    <blockquote cite="mid:cover.1344492473.git.caspar@casparzhang.com"
      type="cite">
      <pre wrap="">

updates:
   syscalls/numa: check syscall availability
     remove TEST() macro and use syscall() directly.
   numa_helper: move to libkerntest
     merged the library cleaning fix to this one.
   mm: use new numa_helper
     the same as previous V3 version, which already has Jan's reivew.

Caspar Zhang (4):
  syscalls/numa: check syscall availability
  numa_helper: move to libkerntest
  mm: use new numa_helper
  mm: add common Makefile include: libmem.mk

Jan Stancek (2):
  numa_helper: add flag to get_allowed_nodes()
  update testcases to use flag for get_allowed_nodes()

 testcases/kernel/Makefile                          |    4 +
 testcases/kernel/include/lib.mk                    |   37 +++
 testcases/kernel/include/numa_helper.h             |   37 +++
 testcases/kernel/lib/Makefile                      |   29 +++
 testcases/kernel/lib/numa_helper.c                 |  266 ++++++++++++++++++++
 testcases/kernel/mem/cpuset/Makefile               |   22 +--
 testcases/kernel/mem/cpuset/cpuset01.c             |   16 +-
 testcases/kernel/mem/hugetlb/Makefile.inc          |   18 +-
 testcases/kernel/mem/hugetlb/hugemmap/Makefile     |   12 +-
 testcases/kernel/mem/include/libmem.mk             |   40 +++
 testcases/kernel/mem/include/mem.h                 |    2 +-
 testcases/kernel/mem/ksm/Makefile                  |   22 +--
 testcases/kernel/mem/ksm/ksm02.c                   |    9 +-
 testcases/kernel/mem/ksm/ksm04.c                   |    9 +-
 testcases/kernel/mem/lib/Makefile                  |    1 +
 testcases/kernel/mem/lib/mem.c                     |   50 +++--
 testcases/kernel/mem/oom/Makefile                  |   22 +--
 testcases/kernel/mem/oom/oom02.c                   |    4 -
 testcases/kernel/mem/oom/oom04.c                   |    4 -
 testcases/kernel/mem/swapping/Makefile             |   22 +--
 testcases/kernel/mem/thp/Makefile                  |   22 +--
 testcases/kernel/mem/tunable/Makefile              |   22 +--
 testcases/kernel/mem/vma/Makefile                  |    4 +-
 testcases/kernel/mem/vma/vma02.c                   |   19 +-
 testcases/kernel/mem/vma/vma04.c                   |   11 +-
 testcases/kernel/syscalls/get_mempolicy/Makefile   |    2 +-
 .../syscalls/get_mempolicy/get_mempolicy01.c       |   15 +-
 testcases/kernel/syscalls/mbind/Makefile           |    2 +-
 testcases/kernel/syscalls/mbind/mbind01.c          |   14 +-
 testcases/kernel/syscalls/move_pages/Makefile      |    2 +-
 .../kernel/syscalls/move_pages/move_pages02.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages03.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages04.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages05.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages06.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages07.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages08.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages09.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages10.c      |    5 +-
 .../kernel/syscalls/move_pages/move_pages11.c      |    5 +-
 .../syscalls/move_pages/move_pages_support.c       |    8 +-
 testcases/kernel/syscalls/numa/Makefile            |   22 --
 testcases/kernel/syscalls/numa/Makefile.inc        |   27 --
 testcases/kernel/syscalls/numa/lib/Makefile        |   26 --
 testcases/kernel/syscalls/numa/lib/numa_helper.c   |  165 ------------
 testcases/kernel/syscalls/numa/lib/numa_helper.h   |   33 ---
 46 files changed, 562 insertions(+), 508 deletions(-)
 create mode 100644 testcases/kernel/include/lib.mk
 create mode 100644 testcases/kernel/include/numa_helper.h
 create mode 100644 testcases/kernel/lib/Makefile
 create mode 100644 testcases/kernel/lib/numa_helper.c
 create mode 100644 testcases/kernel/mem/include/libmem.mk
 delete mode 100644 testcases/kernel/syscalls/numa/Makefile
 delete mode 100644 testcases/kernel/syscalls/numa/Makefile.inc
 delete mode 100644 testcases/kernel/syscalls/numa/lib/Makefile
 delete mode 100644 testcases/kernel/syscalls/numa/lib/numa_helper.c
 delete mode 100644 testcases/kernel/syscalls/numa/lib/numa_helper.h

</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. <a class="moz-txt-link-freetext" href="http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/">http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/</a></pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------000903010100030003000806--


--===============0045803360883140080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============0045803360883140080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0045803360883140080==--

