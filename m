Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WHxwK-00062U-Je
	for ltp-list@lists.sourceforge.net; Mon, 24 Feb 2014 15:59:32 +0000
Date: Mon, 24 Feb 2014 16:59:18 +0100
From: chrubis@suse.cz
Message-ID: <20140224155918.GB30419@rei>
References: <1393236325-30766-1-git-send-email-penght@cn.fujitsu.com>
	<1393236527-30874-1-git-send-email-penght@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1393236527-30874-1-git-send-email-penght@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 2/2] open_posix_testsuite: Update document
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>  testcases/open_posix_testsuite/Documentation/HOWTO_RunTests | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/open_posix_testsuite/Documentation/HOWTO_RunTests b/testcases/open_posix_testsuite/Documentation/HOWTO_RunTests
> index 7b346ed..74c35da 100644
> --- a/testcases/open_posix_testsuite/Documentation/HOWTO_RunTests
> +++ b/testcases/open_posix_testsuite/Documentation/HOWTO_RunTests
> @@ -49,6 +49,11 @@ From there, execute:
>  
>  This will build all of the conformance, functional, and stress tests.
>  
> +From there, execute:
> +    # make all filter-broken
> +
> +This will build all of the conformance, functional, and stress tests except some broken tests. Now, the filter-broken target will disable sigaction_16-1.run-test on the Linux kernel less than 2.6.22.
> +

Now this is completly wrong for several reasons:

1) The filter-broken target is available only on Linux

2) It provides too detailed information about which tests are skipped

3) It talks about broken tests, these are known failures not broken
   tests


It should look more like:

...

 To run conformance tests for a specific directory, just cd to the directory
 and run make all test.
 
+To disable known failures on Linux do make filter-known-fails.
+
 Example:
     # cd conformance/definitions/time_h ; make all test
 
@@ -77,6 +79,10 @@ To make only functional tests, run:
 To make only stress tests, run:
     # make stress-all
 
+To skip known failures on Linux
+    # make filter-known-fails
+    # make test
+
 4. Running POSIX Option Group Feature Tests
 -----------------------------------------------------

...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
