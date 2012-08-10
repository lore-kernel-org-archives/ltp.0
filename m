Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1Szjwv-0000Fk-6B
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 07:48:01 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Szjwt-0001rc-0g
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 07:48:01 +0000
Message-ID: <5024BB87.5070102@redhat.com>
Date: Fri, 10 Aug 2012 15:43:03 +0800
From: Zhouping Liu <zliu@redhat.com>
MIME-Version: 1.0
References: <cover.1344492473.git.caspar@casparzhang.com>
	<5e7d255d57f150875e06b3a2e42d05d9fe03d95f.1344492473.git.caspar@casparzhang.com>
In-Reply-To: <5e7d255d57f150875e06b3a2e42d05d9fe03d95f.1344492473.git.caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH resend 1/6] numa_helper: add flag to
	get_allowed_nodes()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2558326198135591699=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--===============2558326198135591699==
Content-Type: multipart/alternative;
	boundary="------------020604070700070000050007"

This is a multi-part message in MIME format.
--------------020604070700070000050007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2012 02:15 PM, Caspar Zhang wrote:
> add flag, so testcases can request nodes with available
> memory/cpus or both.
>
> Also add small debug function.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

nice code, simple & clear :)

Reviewed-by: Zhouping liu <zliu@redhat.com>

Thanks,
Zhouping
> ---
>   testcases/kernel/syscalls/numa/lib/numa_helper.c |  211 ++++++++++++++++------
>   testcases/kernel/syscalls/numa/lib/numa_helper.h |    8 +-
>   2 files changed, 162 insertions(+), 57 deletions(-)
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


--------------020604070700070000050007
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
cite="mid:5e7d255d57f150875e06b3a2e42d05d9fe03d95f.1344492473.git.caspar@casparzhang.com"
      type="cite">
      <pre wrap="">
add flag, so testcases can request nodes with available
memory/cpus or both.

Also add small debug function.

Signed-off-by: Jan Stancek <a class="moz-txt-link-rfc2396E" href="mailto:jstancek@redhat.com">&lt;jstancek@redhat.com&gt;</a></pre>
    </blockquote>
    <br>
    nice code, simple &amp; clear :)<br>
    <br>
    Reviewed-by: Zhouping liu <a class="moz-txt-link-rfc2396E" href="mailto:zliu@redhat.com">&lt;zliu@redhat.com&gt;</a><br>
    <br>
    Thanks,<br>
    Zhouping<br>
    <blockquote
cite="mid:5e7d255d57f150875e06b3a2e42d05d9fe03d95f.1344492473.git.caspar@casparzhang.com"
      type="cite">
      <pre wrap="">
---
 testcases/kernel/syscalls/numa/lib/numa_helper.c |  211 ++++++++++++++++------
 testcases/kernel/syscalls/numa/lib/numa_helper.h |    8 +-
 2 files changed, 162 insertions(+), 57 deletions(-)

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

--------------020604070700070000050007--


--===============2558326198135591699==
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
--===============2558326198135591699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2558326198135591699==--

