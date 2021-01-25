From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Jan 2021 10:10:27 +0100
Subject: [LTP] [PATCH v3 6/7] can: Remove obsolete test wrapper script
In-Reply-To: <20210120143723.26483-7-rpalethorpe@suse.com>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-7-rpalethorpe@suse.com>
Message-ID: <YA6LA4rSb9obia6k@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

>  2) To Run the tests from this directory, do:
> -$ ./run_ltp-can_tests.sh
> +$ ./can_filter
> +$ ./can_rcv_own_msgs
>  3) To let LTP run the tests from $LTPROOT, execute:
>  $ ./runltp -f can

You also need to update runtest/can (which can be done during merge).

diff --git runtest/can runtest/can
index 6aa2ae9f5..b637183c6 100644
--- runtest/can
+++ runtest/can
@@ -1,2 +1,2 @@
-can_filter can_run_tests.sh can_filter
-can_rcv_own_msgs can_run_tests.sh can_rcv_own_msgs
+can_filter can_filter
+can_rcv_own_msgs can_rcv_own_msgs

Whole patchset LGTM, thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
