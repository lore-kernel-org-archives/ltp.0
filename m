Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Wei.Yang@windriver.com>) id 1RfR0W-0001Tw-JE
	for ltp-list@lists.sourceforge.net; Tue, 27 Dec 2011 06:59:32 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RfR0V-0005qY-Is
	for ltp-list@lists.sourceforge.net; Tue, 27 Dec 2011 06:59:32 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pBR6xPL3026372
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Dec 2011 22:59:25 -0800 (PST)
Message-ID: <4EF96CC5.4090604@windriver.com>
Date: Tue, 27 Dec 2011 14:59:17 +0800
From: wyang1 <Wei.Yang@windriver.com>
MIME-Version: 1.0
References: <1324968340-14847-1-git-send-email-Wei.Yang@windriver.com>
In-Reply-To: <1324968340-14847-1-git-send-email-Wei.Yang@windriver.com>
Subject: Re: [LTP] [PATCH 1/:] For mips architecture,
 SHMLBA is not equal to PAGE_SIZE base_addr is not available address
 for process after base_addr is aligned to next SHMLBA address. so we should
 probe a bigger available virtual address space for ensuring that a wide
 range from base_addr aligned to next SHMLBA to base_addr + INT_SIZE always
 is available
Reply-To: Wei.Yang@windriver.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7886645185889229765=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7886645185889229765==
Content-Type: multipart/alternative;
	boundary="------------020604000300090106080207"

--------------020604000300090106080207
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Cyril

  Please ignore this patch. I am so sorry for my fault.:-[ I will resend 
it.

thanks
wei
On 12/27/2011 02:45 PM, Wei.Yang@windriver.com wrote:
> From: Wei Yang<Wei.Yang@windriver.com>
>
>
> Signed-off-by: Wei Yang<Wei.Yang@windriver.com>
> ---
>   testcases/kernel/syscalls/ipc/shmat/shmat01.c |   27 +++++++++++++++++++++++-
>   1 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> index 7c68459..344ad3f 100644
> --- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> +++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> @@ -65,6 +65,9 @@ void check_functionality(int);
>   #define CASE1		20	/* memory location.                */
>
>   int shm_id_1 = -1;
> +#if defined(__mips__) || defined(__mips64)
> +int shm_id_2 = -1;
> +#endif
>
>   void *base_addr;		/* By probing this address first, we can make
>   				 * non-aligned addresses from it for different
> @@ -262,14 +265,34 @@ void setup(void)
>   		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
>   			 "resource 1 in setup()");
>   	}
> -
>   	/* Probe an available linear address for attachment */
> +#if defined(__mips__) || defined(__mips64)
> +	/*
> +	 * For mips architecture, SHMLBA is not equal to PAGE_SIZE
> +	 * base_addr is not available address for process after
> +	 * base_addr is aligned to next SHMLBA address
> +	 */
> +	if ((shm_id_2 = shmget(shmkey++, SHMLBA, SHM_RW | IPC_CREAT | IPC_EXCL)) == -1) {
> +		tst_brkm(TBROK, cleanup, "Failed to create shared memory ");
> +	}
> +	if ((base_addr = shmat(shm_id_2, NULL, 0)) == (void *) -1) {
> +		rm_shm(shm_id_2);
> +		tst_brkm(TBROK, cleanup, "Couldn't attach shared memory");
> +	}
> +	if (shmdt((const void *)base_addr) == -1) {
> +		rm_shm(shm_id_2);
> +		tst_brkm(TBROK, cleanup, "Couldn't detach shared memory");
> +	}
> +	rm_shm(shm_id_2);
> +#else
>   	if ((base_addr = shmat(shm_id_1, NULL, 0)) == (void *)-1) {
>   		tst_brkm(TBROK, cleanup, "Couldn't attach shared memory");
>   	}
>   	if (shmdt((const void *)base_addr) == -1) {
>   		tst_brkm(TBROK, cleanup, "Couldn't detach shared memory");
>   	}
> +#endif
> +	
>
>   	/* some architectures (e.g. parisc) are strange, so better always align to
>   	 * next SHMLBA address. */
> @@ -299,4 +322,4 @@ void cleanup(void)
>   	 */
>   	TEST_CLEANUP;
>
> -}
> \ No newline at end of file
> +}


--------------020604000300090106080207
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    Hi Cyril<br>
    <br>
    &nbsp;Please ignore this patch. I am so sorry for my fault.<span
      class="moz-smiley-s6"><span> :-[ </span></span> I will resend it.
    <br>
    <br>
    thanks<br>
    wei<br>
    <span style="color: rgb(85, 85, 85); font-family:
      arial,helvetica,clean,sans-serif; font-size: 12px; font-style:
      normal; font-variant: normal; font-weight: normal; letter-spacing:
      normal; line-height: 18px; orphans: 2; text-align: left;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; background-color: rgb(234, 236,
      239); display: inline ! important; float: none;"></span>On
    12/27/2011 02:45 PM, <a class="moz-txt-link-abbreviated" href="mailto:Wei.Yang@windriver.com">Wei.Yang@windriver.com</a> wrote:
    <blockquote
      cite="mid:1324968340-14847-1-git-send-email-Wei.Yang@windriver.com"
      type="cite">
      <pre wrap="">From: Wei Yang <a class="moz-txt-link-rfc2396E" href="mailto:Wei.Yang@windriver.com">&lt;Wei.Yang@windriver.com&gt;</a>


Signed-off-by: Wei Yang <a class="moz-txt-link-rfc2396E" href="mailto:Wei.Yang@windriver.com">&lt;Wei.Yang@windriver.com&gt;</a>
---
 testcases/kernel/syscalls/ipc/shmat/shmat01.c |   27 +++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index 7c68459..344ad3f 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -65,6 +65,9 @@ void check_functionality(int);
 #define CASE1		20	/* memory location.                */
 
 int shm_id_1 = -1;
+#if defined(__mips__) || defined(__mips64)
+int shm_id_2 = -1;
+#endif
 
 void *base_addr;		/* By probing this address first, we can make
 				 * non-aligned addresses from it for different
@@ -262,14 +265,34 @@ void setup(void)
 		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
 			 "resource 1 in setup()");
 	}
-
 	/* Probe an available linear address for attachment */
+#if defined(__mips__) || defined(__mips64)
+	/*
+	 * For mips architecture, SHMLBA is not equal to PAGE_SIZE
+	 * base_addr is not available address for process after 
+	 * base_addr is aligned to next SHMLBA address
+	 */
+	if ((shm_id_2 = shmget(shmkey++, SHMLBA, SHM_RW | IPC_CREAT | IPC_EXCL)) == -1) {
+		tst_brkm(TBROK, cleanup, "Failed to create shared memory ");
+	}
+	if ((base_addr = shmat(shm_id_2, NULL, 0)) == (void *) -1) {
+		rm_shm(shm_id_2);
+		tst_brkm(TBROK, cleanup, "Couldn't attach shared memory");
+	}
+	if (shmdt((const void *)base_addr) == -1) {
+		rm_shm(shm_id_2);
+		tst_brkm(TBROK, cleanup, "Couldn't detach shared memory");
+	}
+	rm_shm(shm_id_2);
+#else
 	if ((base_addr = shmat(shm_id_1, NULL, 0)) == (void *)-1) {
 		tst_brkm(TBROK, cleanup, "Couldn't attach shared memory");
 	}
 	if (shmdt((const void *)base_addr) == -1) {
 		tst_brkm(TBROK, cleanup, "Couldn't detach shared memory");
 	}
+#endif
+	
 
 	/* some architectures (e.g. parisc) are strange, so better always align to
 	 * next SHMLBA address. */
@@ -299,4 +322,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
-}
\ No newline at end of file
+}
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------020604000300090106080207--


--===============7886645185889229765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--===============7886645185889229765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7886645185889229765==--

