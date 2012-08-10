Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SzkNe-0005Yr-2q
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 08:15:38 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SzkNZ-0002po-Om
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 08:15:38 +0000
Message-ID: <5024C1FF.6010301@redhat.com>
Date: Fri, 10 Aug 2012 16:10:39 +0800
From: Zhouping Liu <zliu@redhat.com>
MIME-Version: 1.0
References: <cover.1344492473.git.caspar@casparzhang.com>
	<953f8552c3db0f5f4caa7997d7468af5cee0a851.1344508300.git.caspar@casparzhang.com>
In-Reply-To: <953f8552c3db0f5f4caa7997d7468af5cee0a851.1344508300.git.caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH resend v2 3/6] syscalls/numa: check syscall
	availability
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7594567115931303706=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--===============7594567115931303706==
Content-Type: multipart/alternative;
	boundary="------------020908050804020307000906"

This is a multi-part message in MIME format.
--------------020908050804020307000906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2012 06:31 PM, Caspar Zhang wrote:
> some NUMA related syscalls: mbind, get_mempolicy are not supported on
> some arches (e.g. i386), this patch checks the syscalls' availability in
> setup() function by using the macro syscall() implemented in
> linux_syscall_numbers.h, if the syscall is not implemented on the
> system, a TCONF message will be given like this:
>
> get_mempolicy01    1  TCONF  : syscall __NR_get_mempolicy01 not supported on your arch
>
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>

Reviewed-by: Zhouping Liu <zliu@redhat.com>

Thanks,
Zhouping

> ---
>   .../syscalls/get_mempolicy/get_mempolicy01.c       |    3 +++
>   testcases/kernel/syscalls/mbind/mbind01.c          |    3 +++
>   2 files changed, 6 insertions(+), 0 deletions(-)
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


--------------020908050804020307000906
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 08/09/2012 06:31 PM, Caspar Zhang
      wrote:<br>
    </div>
    <blockquote
cite="mid:953f8552c3db0f5f4caa7997d7468af5cee0a851.1344508300.git.caspar@casparzhang.com"
      type="cite">
      <pre wrap="">
some NUMA related syscalls: mbind, get_mempolicy are not supported on
some arches (e.g. i386), this patch checks the syscalls' availability in
setup() function by using the macro syscall() implemented in
linux_syscall_numbers.h, if the syscall is not implemented on the
system, a TCONF message will be given like this:

get_mempolicy01    1  TCONF  : syscall __NR_get_mempolicy01 not supported on your arch

Signed-off-by: Caspar Zhang <a class="moz-txt-link-rfc2396E" href="mailto:caspar@casparzhang.com">&lt;caspar@casparzhang.com&gt;</a></pre>
    </blockquote>
    <br>
    Reviewed-by: Zhouping Liu <a class="moz-txt-link-rfc2396E" href="mailto:zliu@redhat.com">&lt;zliu@redhat.com&gt;</a><br>
    <br>
    Thanks,<br>
    Zhouping<br>
    <br>
    <blockquote
cite="mid:953f8552c3db0f5f4caa7997d7468af5cee0a851.1344508300.git.caspar@casparzhang.com"
      type="cite">
      <pre wrap="">
---
 .../syscalls/get_mempolicy/get_mempolicy01.c       |    3 +++
 testcases/kernel/syscalls/mbind/mbind01.c          |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

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

--------------020908050804020307000906--


--===============7594567115931303706==
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
--===============7594567115931303706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7594567115931303706==--

