Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UDWA6-0004g7-7z
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:26:50 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UDWA2-0004Sb-3y
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:26:50 +0000
Message-ID: <51384EC8.3070608@redhat.com>
Date: Thu, 07 Mar 2013 16:24:40 +0800
From: Zhouping Liu <zliu@redhat.com>
MIME-Version: 1.0
References: <499128d9e24439238b64dc1740ee9e7217ec953f.1362641893.git.caspar@casparzhang.com>
	<0da7f15cb693ea31f3f5cb1512713ae0562b4f17.1362641893.git.caspar@casparzhang.com>
In-Reply-To: <0da7f15cb693ea31f3f5cb1512713ae0562b4f17.1362641893.git.caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH 3/3] syscalls/madvise02: fix madvise case due to
 kernel change
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4476723135542481952=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--===============4476723135542481952==
Content-Type: multipart/alternative;
	boundary="------------010904010301050004070807"

This is a multi-part message in MIME format.
--------------010904010301050004070807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2013 03:38 PM, Caspar Zhang wrote:
> since kernel commit 1998cc0 (after kernel-3.8 released),
> madvise(MADV_WILLNEED) to anonymous memory doesn't return -EBADF now, as
> now we support swap prefetch. Thus the 5th testcase in madvise02 will
> not pass. This patch fixes this by adding a tst_kvercmp() condition, and
> will give a pass if kernel is >=3.9 (including the RCs).
>
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>

met the issue on 3.9.0-rc1+, and the patch looks good for me,
so Reviewed-by: Zhouping Liu <zliu@redhat.com>

> ---
>   testcases/kernel/syscalls/madvise/madvise02.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
>
>
> ------------------------------------------------------------------------------
> Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester
> Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the
> endpoint security space. For insight on selecting the right partner to
> tackle endpoint security challenges, access the full report.
> http://p.sf.net/sfu/symantec-dev2dev
>
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


--------------010904010301050004070807
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 03/07/2013 03:38 PM, Caspar Zhang
      wrote:<br>
    </div>
    <blockquote
cite="mid:0da7f15cb693ea31f3f5cb1512713ae0562b4f17.1362641893.git.caspar@casparzhang.com"
      type="cite">
      <pre wrap="">
since kernel commit 1998cc0 (after kernel-3.8 released),
madvise(MADV_WILLNEED) to anonymous memory doesn't return -EBADF now, as
now we support swap prefetch. Thus the 5th testcase in madvise02 will
not pass. This patch fixes this by adding a tst_kvercmp() condition, and
will give a pass if kernel is &gt;=3.9 (including the RCs).

Signed-off-by: Caspar Zhang <a class="moz-txt-link-rfc2396E" href="mailto:caspar@casparzhang.com">&lt;caspar@casparzhang.com&gt;</a></pre>
    </blockquote>
    <br>
    met the issue on 3.9.0-rc1+, and the patch looks good for me,<br>
    so Reviewed-by: Zhouping Liu <a class="moz-txt-link-rfc2396E" href="mailto:zliu@redhat.com">&lt;zliu@redhat.com&gt;</a><br>
    <br>
    <blockquote
cite="mid:0da7f15cb693ea31f3f5cb1512713ae0562b4f17.1362641893.git.caspar@casparzhang.com"
      type="cite">
      <pre wrap="">
---
 testcases/kernel/syscalls/madvise/madvise02.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
<a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/symantec-dev2dev">http://p.sf.net/sfu/symantec-dev2dev</a></pre>
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

--------------010904010301050004070807--


--===============4476723135542481952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
--===============4476723135542481952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4476723135542481952==--

