Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1Szk0e-0005l2-CP
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 07:51:52 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Szk0b-0001y3-WD
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 07:51:52 +0000
Message-ID: <5024BC6F.7010408@redhat.com>
Date: Fri, 10 Aug 2012 15:46:55 +0800
From: Zhouping Liu <zliu@redhat.com>
MIME-Version: 1.0
References: <cover.1344492473.git.caspar@casparzhang.com>
	<c34d8829b21a0e2cd2d5b1241ea751e61b993348.1344492473.git.caspar@casparzhang.com>
In-Reply-To: <c34d8829b21a0e2cd2d5b1241ea751e61b993348.1344492473.git.caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH resend 3/6] syscalls/numa: check syscall
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
Content-Type: multipart/mixed; boundary="===============4080319092246863929=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--===============4080319092246863929==
Content-Type: multipart/alternative;
	boundary="------------020709020805050204040607"

This is a multi-part message in MIME format.
--------------020709020805050204040607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2012 02:15 PM, Caspar Zhang wrote:
> some NUMA related syscalls: mbind, get_mempolicy are not supported on
> some arches (e.g. i386), this patch checks the syscalls' availability in
> setup() function, if the syscall is not implemented on the system, a
> TCONF message will be given like this:
>
> get_mempolicy01    1  TCONF  : syscall __NR_get_mempolicy01 not supported on your arch
>
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>

Reviewed-by: Zhouping Liu <zliu@redhat.com>

Thanks,
Zhouping

> ---
>   .../syscalls/get_mempolicy/get_mempolicy01.c       |   10 ++++++++++
>   testcases/kernel/syscalls/mbind/mbind01.c          |    9 +++++++++
>   2 files changed, 19 insertions(+), 0 deletions(-)
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


--------------020709020805050204040607
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 08/09/2012 02:15 PM, Caspar Zhang
      wrote:<br>
    </div>
    <blockquote
cite="mid:c34d8829b21a0e2cd2d5b1241ea751e61b993348.1344492473.git.caspar@casparzhang.com"
      type="cite">
      <pre wrap="">
some NUMA related syscalls: mbind, get_mempolicy are not supported on
some arches (e.g. i386), this patch checks the syscalls' availability in
setup() function, if the syscall is not implemented on the system, a
TCONF message will be given like this:

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
cite="mid:c34d8829b21a0e2cd2d5b1241ea751e61b993348.1344492473.git.caspar@casparzhang.com"
      type="cite">
      <pre wrap="">
---
 .../syscalls/get_mempolicy/get_mempolicy01.c       |   10 ++++++++++
 testcases/kernel/syscalls/mbind/mbind01.c          |    9 +++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

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

--------------020709020805050204040607--


--===============4080319092246863929==
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
--===============4080319092246863929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4080319092246863929==--

