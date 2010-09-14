Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <romansc@us.ibm.com>) id 1OvZ1o-00066q-UQ
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 17:10:44 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OvZ1n-0004dP-UC
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 17:10:44 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8EGoxOt029489
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 12:50:59 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8EHAcFb316872
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 13:10:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8EHAbu0027700
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 14:10:37 -0300
In-Reply-To: <AANLkTimGFWgvZcinBK-SHkY2H-Ew6D+x=L2EyedRQKn4@mail.gmail.com>
References: <OFD6B689AE.1AE38E72-ON8525779D.0054A722-8525779E.0049DA86@us.ibm.com>
	<AANLkTimGFWgvZcinBK-SHkY2H-Ew6D+x=L2EyedRQKn4@mail.gmail.com>
Message-ID: <OFC53D59D5.2022C102-ON8525779E.005D5AC2-8525779E.005E5AC9@us.ibm.com>
From: Scott Romanowski <romansc@us.ibm.com>
Date: Tue, 14 Sep 2010 13:10:35 -0400
MIME-Version: 1.0
Subject: Re: [LTP] 20100831 release hugetlb tests bug and patch (re-post
 with sign-off line)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5174358748498247637=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============5174358748498247637==
Content-type: multipart/alternative; 
	Boundary="0__=0ABBFD0DDFCEDC528f9e8a93df938690918c0ABBFD0DDFCEDC52"
Content-Disposition: inline

--0__=0ABBFD0DDFCEDC528f9e8a93df938690918c0ABBFD0DDFCEDC52
Content-type: text/plain; charset=US-ASCII

Garrett Cooper <yanegomi@gmail.com> wrote on 09/14/2010 12:43:47 PM:
> 1. It doesn't make sense why you're doing this, unless you're
> purposely trying to impose a limit to get the consumer to fail on the
> next round. What happens if you make this 0 instead?

You're right; this should be 0.  I foolishly just copied the structure from
the functions above.

> 2. Also, have you tried inverting the logic to test out whether or not
> this case functions as expected (i.e. #ifndef __linux__ ... #else
> return (size_t) -1; #endif)?
> 3. This also exposes type bugs in the tests; example:

I didn't test the LTP on a non-Linux platform.  I'm new to this, sorry.

> diff -r 90778db5a87c lib/system_specific_hugepages_info.c
> --- a/lib/system_specific_hugepages_info.c Mon Sep 13 11:19:49 2010 -0400
> +++ b/lib/system_specific_hugepages_info.c Mon Sep 13 14:51:14 2010 -0400
> @@ -26,8 +26,10 @@
> */
>
> #include <fcntl.h>
> +#include <linux/shm.h>
> #include <sys/types.h>
> #include <test.h>
> +#include "usctest.h"
>
> #define BUFSIZE 512
>
> @@ -76,3 +78,29 @@
> #endif
> }
>
> +/* Calculate how much memory to allocate based on the available huge
memory
> and
> + how many parallel processes are going to allocate it.
> +*/
> +size_t calculate_huge_pages_shm_to_be_allocated( double fraction )
> +{
> +#ifdef __linux__
> + size_t bytes_to_allocate;
> +
> + bytes_to_allocate = (size_t)(fraction * (double)get_no_of_hugepages() *
> (double)hugepages_size() * 1024.0);
> +
> + /* Now divide that up amongst the processes */
> + if( STD_COPIES > 1 )
> + bytes_to_allocate /= (size_t)STD_COPIES;
> + /* and limit to SHMMAX */
> + if( bytes_to_allocate > SHMMAX )
> + bytes_to_allocate = (size_t)SHMMAX;
> +
> + #ifdef DEBUG
> + printf( "calculate_huge_pages_shm_to_be_allocated(%lf) returns %lu\n",
> divider, (unsigned long)bytes_to_allocate );
> + #endif
> +
> + return bytes_to_allocate;
> +#else
> + return 0;
> +#endif
> +}

--
Scott Romanowski

--0__=0ABBFD0DDFCEDC528f9e8a93df938690918c0ABBFD0DDFCEDC52
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>Garrett Cooper &lt;yanegomi@gmail.com&gt; wrote on 09/14/2010 12:43:47 PM:<br>
&gt; 1. It doesn't make sense why you're doing this, unless you're<br>
&gt; purposely trying to impose a limit to get the consumer to fail on the<br>
&gt; next round. What happens if you make this 0 instead?</tt><br>
<br>
<tt>You're right; this should be 0. &nbsp;I foolishly just copied the structure from the functions above.</tt><br>
<tt><br>
&gt; 2. Also, have you tried inverting the logic to test out whether or not<br>
&gt; this case functions as expected (i.e. #ifndef __linux__ ... #else<br>
&gt; return (size_t) -1; #endif)?<br>
&gt; 3. This also exposes type bugs in the tests; example:<br>
</tt><br>
<tt>I didn't test the LTP on a non-Linux platform. &nbsp;I'm new to this, sorry.<br>
</tt><br>
<tt>&gt; diff -r 90778db5a87c lib/system_specific_hugepages_info.c<br>
&gt; --- a/lib/system_specific_hugepages_info.c Mon Sep 13 11:19:49 2010 -0400<br>
&gt; +++ b/lib/system_specific_hugepages_info.c Mon Sep 13 14:51:14 2010 -0400<br>
&gt; @@ -26,8 +26,10 @@<br>
&gt; */<br>
&gt;<br>
&gt; #include &lt;fcntl.h&gt;<br>
&gt; +#include &lt;linux/shm.h&gt;<br>
&gt; #include &lt;sys/types.h&gt;<br>
&gt; #include &lt;test.h&gt;<br>
&gt; +#include &quot;usctest.h&quot;<br>
&gt;<br>
&gt; #define BUFSIZE 512<br>
&gt;<br>
&gt; @@ -76,3 +78,29 @@<br>
&gt; #endif<br>
&gt; }<br>
&gt;<br>
&gt; +/* Calculate how much memory to allocate based on the available huge memory<br>
&gt; and<br>
&gt; + how many parallel processes are going to allocate it.<br>
&gt; +*/<br>
&gt; +size_t calculate_huge_pages_shm_to_be_allocated( double fraction )<br>
&gt; +{<br>
&gt; +#ifdef __linux__<br>
&gt; + size_t bytes_to_allocate;<br>
&gt; +<br>
&gt; + bytes_to_allocate = (size_t)(fraction * (double)get_no_of_hugepages() *<br>
&gt; (double)hugepages_size() * 1024.0);<br>
&gt; +<br>
&gt; + /* Now divide that up amongst the processes */<br>
&gt; + if( STD_COPIES &gt; 1 )<br>
&gt; + bytes_to_allocate /= (size_t)STD_COPIES;<br>
&gt; + /* and limit to SHMMAX */<br>
&gt; + if( bytes_to_allocate &gt; SHMMAX )<br>
&gt; + bytes_to_allocate = (size_t)SHMMAX;<br>
&gt; +<br>
&gt; + #ifdef DEBUG<br>
&gt; + printf( &quot;calculate_huge_pages_shm_to_be_allocated(%lf) returns %lu\n&quot;,<br>
&gt; divider, (unsigned long)bytes_to_allocate );<br>
&gt; + #endif<br>
&gt; +<br>
&gt; + return bytes_to_allocate;<br>
&gt; +#else<br>
&gt; + return 0;<br>
&gt; +#endif<br>
&gt; +}<br>
</tt><br>
--<br>
Scott Romanowski<br>
<br>
</body></html>
--0__=0ABBFD0DDFCEDC528f9e8a93df938690918c0ABBFD0DDFCEDC52--



--===============5174358748498247637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
--===============5174358748498247637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5174358748498247637==--


