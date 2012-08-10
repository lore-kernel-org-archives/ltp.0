Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1Szk5S-00060Q-2l
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 07:56:50 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Szk5R-0005IG-1K
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 07:56:50 +0000
Message-ID: <5024BD9A.9020104@redhat.com>
Date: Fri, 10 Aug 2012 15:51:54 +0800
From: Zhouping Liu <zliu@redhat.com>
MIME-Version: 1.0
References: <74a85e39016c9752a9948a07fe75b84e00191b1f.1344492473.git.caspar@casparzhang.com>
	<26038550c7f51ea9d7a35b87b4e780f8bb4e05a9.1344569191.git.caspar@casparzhang.com>
In-Reply-To: <26038550c7f51ea9d7a35b87b4e780f8bb4e05a9.1344569191.git.caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH resend 4/6 v2] numa_helper: move to libkerntest
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7144546274255717811=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--===============7144546274255717811==
Content-Type: multipart/alternative;
	boundary="------------030000030304060809050907"

This is a multi-part message in MIME format.
--------------030000030304060809050907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 08/10/2012 11:26 AM, Caspar Zhang wrote:
> libnuma_helper could be used by testcases both under syscalls/ and mem/,
> it's better to add a new common lib in their parent dir, so I created
> libkerntest under testcases/kernel/lib/, and put numa_helper to it. In
> the future, we can add more APIs to it.
>
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
tested on two machines with 2 & 8 nodes, and offline all cpus in one 
nodes, not found any issues.

Tested-by: Zhouping Liu <zliu@redhat.com>

Thanks,
Zhouping

> ---
>   testcases/kernel/Makefile                        |    4 +
>   testcases/kernel/include/lib.mk                  |   37 +++
>   testcases/kernel/include/numa_helper.h           |   37 +++
>   testcases/kernel/lib/Makefile                    |   28 +++
>   testcases/kernel/lib/numa_helper.c               |  266 ++++++++++++++++++++++
>   testcases/kernel/syscalls/get_mempolicy/Makefile |    2 +-
>   testcases/kernel/syscalls/mbind/Makefile         |    2 +-
>   testcases/kernel/syscalls/move_pages/Makefile    |    2 +-
>   testcases/kernel/syscalls/numa/Makefile          |   22 --
>   testcases/kernel/syscalls/numa/Makefile.inc      |   27 ---
>   testcases/kernel/syscalls/numa/lib/Makefile      |   26 --
>   testcases/kernel/syscalls/numa/lib/numa_helper.c |  266 ----------------------
>   testcases/kernel/syscalls/numa/lib/numa_helper.h |   37 ---
>   13 files changed, 375 insertions(+), 381 deletions(-)
>   create mode 100644 testcases/kernel/include/lib.mk
>   create mode 100644 testcases/kernel/include/numa_helper.h
>   create mode 100644 testcases/kernel/lib/Makefile
>   create mode 100644 testcases/kernel/lib/numa_helper.c
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


--------------030000030304060809050907
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 08/10/2012 11:26 AM, Caspar Zhang
      wrote:<br>
    </div>
    <blockquote
cite="mid:26038550c7f51ea9d7a35b87b4e780f8bb4e05a9.1344569191.git.caspar@casparzhang.com"
      type="cite">
      <pre wrap="">
libnuma_helper could be used by testcases both under syscalls/ and mem/,
it's better to add a new common lib in their parent dir, so I created
libkerntest under testcases/kernel/lib/, and put numa_helper to it. In
the future, we can add more APIs to it.

Signed-off-by: Caspar Zhang <a class="moz-txt-link-rfc2396E" href="mailto:caspar@casparzhang.com">&lt;caspar@casparzhang.com&gt;</a></pre>
    </blockquote>
    tested on two machines with 2 &amp; 8 nodes, and offline all cpus in
    one nodes, not found any issues.<br>
    <br>
    Tested-by: Zhouping Liu <a class="moz-txt-link-rfc2396E" href="mailto:zliu@redhat.com">&lt;zliu@redhat.com&gt;</a><br>
    <br>
    Thanks,<br>
    Zhouping<br>
    <br>
    <blockquote
cite="mid:26038550c7f51ea9d7a35b87b4e780f8bb4e05a9.1344569191.git.caspar@casparzhang.com"
      type="cite">
      <pre wrap="">
---
 testcases/kernel/Makefile                        |    4 +
 testcases/kernel/include/lib.mk                  |   37 +++
 testcases/kernel/include/numa_helper.h           |   37 +++
 testcases/kernel/lib/Makefile                    |   28 +++
 testcases/kernel/lib/numa_helper.c               |  266 ++++++++++++++++++++++
 testcases/kernel/syscalls/get_mempolicy/Makefile |    2 +-
 testcases/kernel/syscalls/mbind/Makefile         |    2 +-
 testcases/kernel/syscalls/move_pages/Makefile    |    2 +-
 testcases/kernel/syscalls/numa/Makefile          |   22 --
 testcases/kernel/syscalls/numa/Makefile.inc      |   27 ---
 testcases/kernel/syscalls/numa/lib/Makefile      |   26 --
 testcases/kernel/syscalls/numa/lib/numa_helper.c |  266 ----------------------
 testcases/kernel/syscalls/numa/lib/numa_helper.h |   37 ---
 13 files changed, 375 insertions(+), 381 deletions(-)
 create mode 100644 testcases/kernel/include/lib.mk
 create mode 100644 testcases/kernel/include/numa_helper.h
 create mode 100644 testcases/kernel/lib/Makefile
 create mode 100644 testcases/kernel/lib/numa_helper.c
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

--------------030000030304060809050907--


--===============7144546274255717811==
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
--===============7144546274255717811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7144546274255717811==--

