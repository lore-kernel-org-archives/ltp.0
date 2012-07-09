Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1So3N1-0005BL-74
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 02:06:39 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1So3Mz-0001c2-TS
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 02:06:39 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q6926VJB023541
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Sun, 8 Jul 2012 19:06:31 -0700 (PDT)
Message-ID: <4FFA3CA6.8000404@windriver.com>
Date: Mon, 9 Jul 2012 10:06:30 +0800
From: Kang Kai <Kai.Kang@windriver.com>
MIME-Version: 1.0
References: <1341309599-10008-1-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1341309599-10008-1-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH] pthread_cond_signal/1-1: fails on routerstation
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4525918092145005998=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4525918092145005998==
Content-Type: multipart/alternative;
	boundary="------------040300000706030505010006"

--------------040300000706030505010006
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 2012?07?03? 17:59, Kang Kai wrote:
> Case pthread_cond_signal/1-1 fails on routerstation. The OS is Yocto
> linux 1.2 with kernel 3.0.24, and c library is eglibc 2.15.
>
> The fail log:
>    [Thread 0x0x2c56d4b0] started and locked the mutex
>    [Thread 0x0x2c56d4b0] is waiting for the cond
>    [Thread 0x0x2bd6d4b0] started and locked the mutex
>    [Thread 0x0x2bd6d4b0] is waiting for the cond
>    [Thread 0x0x2b56d4b0] started and locked the mutex
>    [Thread 0x0x2b56d4b0] is waiting for the cond
>    [Main thread] signals a condition
>    [Thread 0x0x2c56d4b0] was wakened and acquired the mutex again
>    [Thread 0x0x2c56d4b0] released the mutex
>    [Main thread] 1 waiters were wakened
>    [Main thread] signals to wake up the next thread
>    [Thread 0x0x2bd6d4b0] was wakened and acquired the mutex again
>    [Thread 0x0x2bd6d4b0] released the mutex
>    [Main thread] signals to wake up the next thread
>    [Main thread] signals to wake up the next thread
>    [Main thread] signals to wake up the next thread
>    [Main thread] signals to wake up the next thread
>    [Main thread] signals to wake up the next thread
>    [Thread 0x0x2b56d4b0] was wakened and acquired the mutex again
>    [Main thread] had to signal the condition 7 times
>    [Main thread] to wake up 3 threads
>    . Test FAILED.
>
> The main thread call pthread_cond_signal try to signal the child threads
> those are waiting on the condition, then call usleep(100) to relinquish
> the cpu. But 100 useconds is not enough and the main thread continue to
> run. So the case fails.
>
> Increase the sleep timeto 1000 useconds to make the case pass.
>
> Signed-off-by: Kang Kai<kai.kang@windriver.com>
> ---
>   .../interfaces/pthread_cond_signal/1-1.c           |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
> index bf55b31..910931d 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
> @@ -142,7 +142,7 @@ int main()
>   			fprintf(stderr,"Main failed to signal the condition\n");
>   			exit(PTS_UNRESOLVED);
>   		}
> -		usleep(100);
> +		usleep(1000);
>   	}
>
>   	if (i>= THREAD_NUM) {
> @@ -160,4 +160,4 @@ int main()
>   	}
>   	printf("Test PASSED\n");
>   	return PTS_PASS;
> -}
> \ No newline at end of file
> +}
Hi,

Could anyone help me to review this patch?
Thanks a lot.

Regards,
Kai

--------------040300000706030505010006
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    On 2012&#24180;07&#26376;03&#26085; 17:59, Kang Kai wrote:
    <blockquote
      cite="mid:1341309599-10008-1-git-send-email-kai.kang@windriver.com"
      type="cite">
      <pre wrap="">Case pthread_cond_signal/1-1 fails on routerstation. The OS is Yocto
linux 1.2 with kernel 3.0.24, and c library is eglibc 2.15.

The fail log:
  [Thread 0x0x2c56d4b0] started and locked the mutex
  [Thread 0x0x2c56d4b0] is waiting for the cond
  [Thread 0x0x2bd6d4b0] started and locked the mutex
  [Thread 0x0x2bd6d4b0] is waiting for the cond
  [Thread 0x0x2b56d4b0] started and locked the mutex
  [Thread 0x0x2b56d4b0] is waiting for the cond
  [Main thread] signals a condition
  [Thread 0x0x2c56d4b0] was wakened and acquired the mutex again
  [Thread 0x0x2c56d4b0] released the mutex
  [Main thread] 1 waiters were wakened
  [Main thread] signals to wake up the next thread
  [Thread 0x0x2bd6d4b0] was wakened and acquired the mutex again
  [Thread 0x0x2bd6d4b0] released the mutex
  [Main thread] signals to wake up the next thread
  [Main thread] signals to wake up the next thread
  [Main thread] signals to wake up the next thread
  [Main thread] signals to wake up the next thread
  [Main thread] signals to wake up the next thread
  [Thread 0x0x2b56d4b0] was wakened and acquired the mutex again
  [Main thread] had to signal the condition 7 times
  [Main thread] to wake up 3 threads
  . Test FAILED.

The main thread call pthread_cond_signal try to signal the child threads
those are waiting on the condition, then call usleep(100) to relinquish
the cpu. But 100 useconds is not enough and the main thread continue to
run. So the case fails.

Increase the sleep timeto 1000 useconds to make the case pass.

Signed-off-by: Kang Kai <a class="moz-txt-link-rfc2396E" href="mailto:kai.kang@windriver.com">&lt;kai.kang@windriver.com&gt;</a>
---
 .../interfaces/pthread_cond_signal/1-1.c           |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
index bf55b31..910931d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
@@ -142,7 +142,7 @@ int main()
 			fprintf(stderr,"Main failed to signal the condition\n");
 			exit(PTS_UNRESOLVED);
 		}
-		usleep(100);
+		usleep(1000);
 	}
 
 	if (i &gt;= THREAD_NUM) {
@@ -160,4 +160,4 @@ int main()
 	}
 	printf("Test PASSED\n");
 	return PTS_PASS;
-}
\ No newline at end of file
+}
</pre>
    </blockquote>
    <font size="+1">Hi,<br>
      <br>
      Could anyone help me to review this patch?<br>
      Thanks a lot.<br>
      <br>
      Regards,<br>
      Kai<br>
    </font>
  </body>
</html>

--------------040300000706030505010006--


--===============4525918092145005998==
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
--===============4525918092145005998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4525918092145005998==--

