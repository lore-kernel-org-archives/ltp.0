Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yaneurabeya@gmail.com>) id 1Oao61-0000Gi-GE
	for ltp-list@lists.sourceforge.net; Mon, 19 Jul 2010 11:01:17 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oao5x-00034P-P2
	for ltp-list@lists.sourceforge.net; Mon, 19 Jul 2010 11:01:16 +0000
Received: by pwi10 with SMTP id 10so1874698pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 19 Jul 2010 04:01:08 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1081)
From: Garrett Cooper <yaneurabeya@gmail.com>
In-Reply-To: <1736556680.530871279536912040.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Mon, 19 Jul 2010 04:01:05 -0700
Message-Id: <6A78C8A0-85A2-4985-9E37-2B55BA569961@gmail.com>
References: <1736556680.530871279536912040.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] Fix utimensat01 testcase
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Jul 19, 2010, at 3:55 AM, Caspar Zhang wrote:

> Hi all,
>   I tested this case for many times in RHEL6 on all archs but
>   always got a failure. The error message was:
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   open: Permission denied 
>   FAILED (bad test setup)
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   when the testcase tried to execute ./utimensat01 <params,...>.
> 
>   After investigation, I found that the following two parts
>   maybe have wrong RW parameter:
> 
>   a) Testing read-only file, owned by nobody(self).
>   Since the perm is 400, the user `nobody' itself doesn't have
>   write permission to the testfile, thus, if program executes
>   ./utimensat01 with -w param, `Permission deined' error will
>   occur. So we need to add -W in run_test param to avoid trying
>   writing test.
> 
>   b) Testing read-only file, owned by root.
>   Since root owns the test file and the perm is still 400,
>   the user `nobody' has neither writing nor reading permission
>   to this file, so -RW param should be both set to run_test
>   function to avoid trying reading & writing test.
> 
>   Signed-off-by: Caspar Zhang <czhang@redhat.com>
> 
> diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> index 4246d1a..a861d61 100644
> --- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> +++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
> @@ -288,22 +288,22 @@ echo "Testing read-only file, owned by self"
> echo
> 
> echo "***** Testing times==NULL case *****"
> -run_test "" 400 "" "" SUCCESS y y
> +run_test -W "" 400 "" "" SUCCESS y y
> 
> echo "***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****"
> -run_test "" 400 "" "0 n 0 n" SUCCESS y y
> +run_test -W "" 400 "" "0 n 0 n" SUCCESS y y
> 
> echo "***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****"
> -run_test "" 400 "" "0 o 0 o" SUCCESS n n
> +run_test -W "" 400 "" "0 o 0 o" SUCCESS n n
> 
> echo "***** Testing times=={ UTIME_NOW, UTIME_OMIT } case *****"
> -run_test "" 400 "" "0 n 0 o" SUCCESS y n
> +run_test -W "" 400 "" "0 n 0 o" SUCCESS y n
> 
> echo "***** Testing times=={ UTIME_OMIT, UTIME_NOW } case *****"
> -run_test "" 400 "" "0 o 0 n" SUCCESS n y
> +run_test -W "" 400 "" "0 o 0 n" SUCCESS n y
> 
> echo "***** Testing times=={ x, y } case *****"
> -run_test "" 400 "" "1 1 1 1" SUCCESS y y
> +run_test -W "" 400 "" "1 1 1 1" SUCCESS y y
> 
> echo "============================================================"
> 
> @@ -312,22 +312,22 @@ echo "Testing read-only file, not owned by self"
> echo
> 
> echo "***** Testing times==NULL case *****"
> -run_test root 400 "" "" EACCES
> +run_test -RW root 400 "" "" EACCES
> 
> echo "***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****"
> -run_test root 400 "" "0 n 0 n" EACCES
> +run_test -RW root 400 "" "0 n 0 n" EACCES
> 
> echo "***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****"
> -run_test root 400 "" "0 o 0 o" SUCCESS n n
> +run_test -RW root 400 "" "0 o 0 o" SUCCESS n n
> 
> echo "***** Testing times=={ UTIME_NOW, UTIME_OMIT } case *****"
> -run_test root 400 "" "0 n 0 o" EPERM
> +run_test -RW root 400 "" "0 n 0 o" EPERM
> 
> echo "***** Testing times=={ UTIME_OMIT, UTIME_NOW } case *****"
> -run_test root 400 "" "0 o 0 n" EPERM
> +run_test -RW root 400 "" "0 o 0 n" EPERM
> 
> echo "***** Testing times=={ x, y } case *****"
> -run_test root 400 "" "1 1 1 1" EPERM
> +run_test -RW root 400 "" "1 1 1 1" EPERM
> 
> echo "============================================================"

	ACK.
Thanks!
-Garrett
------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
