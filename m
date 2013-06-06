Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UkZ4r-0003Oy-NC
	for ltp-list@lists.sourceforge.net; Thu, 06 Jun 2013 12:14:01 +0000
Date: Thu, 6 Jun 2013 14:15:20 +0200
From: chrubis@suse.cz
Message-ID: <20130606121520.GC23876@rei>
References: <1370384252.14316.YahooMailClassic@web120802.mail.ne1.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1370384252.14316.YahooMailClassic@web120802.mail.ne1.yahoo.com>
Subject: Re: [LTP] Test suite for the t-core kernel patch
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
To: C Nandi <ccnandi@yahoo.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Is this test suite for t-core kernel patch still valid?
> If yes, can we avoid invoking following function, and go with the following patch? I believe "/proc/sys/kernel/core_dumps_threads" file will not get created by latest kernel.
> 
> File: testcases/misc/tcore_patch_test_suites/tcore.sh
> 
> check_install()
> {
>         if [ -f /proc/sys/kernel/core_dumps_threads ];then
>                 pass=`expr $pass + 1`
>                 return 0
>         else
>                 fail=`expr $fail + 1`
>                 return 1
>         fi
> }
> 
> =========
> 

I did a little bit of archeology and it seems that patch which
introduced this file never got accepted into mainline linux kernel.
(Found some discussion about it around linux 2.4 and 2.5 development.)

So it looks like this test was never working.

> 
> diff -urN org/tcore.exp mod/tcore.exp
> --- org/tcore.exp       2013-05-17 15:08:09.000000000 -0600
> +++ mod/tcore.exp       2013-05-17 14:07:37.000000000 -0600
> @@ -39,7 +39,7 @@
>      set istrue 0
>      send "info threads\n"
>      expect {
> -               -re " \[0-9\]+ process .*(gdb)" {
> +               -re " \[0-9\]+ Thread .*(gdb)" {
>         set buf $expect_out(0,string)
>         }
>         timeout {
> @@ -47,7 +47,7 @@
>                 return 1
>         }
>      }
> -    set curr_thread [check_buf $buf "process"]
> +    set curr_thread [check_buf $buf "Thread"]
>      if { $curr_thread == 0 } {
>         send_user "check_threads (no current thread)\n"
>         return 1
> @@ -76,7 +76,7 @@
>                                   return 1
>                          }
>                  }
> -                set number1 [check_buf $buf "(process"]
> +                set number1 [check_buf $buf "(Thread"]
>                  send "bt\n"
>                  expect {
>                          -re  " bt.*#\[0-9\]+ .*(gdb)" {
> @@ -101,13 +101,13 @@
>  }

This part of the test is quite fragile. This will break if LANG is not
set to English language. Moreover this change will break the older gdb,
do you know in which gdb version were these messages changed?

>  proc check_fpu {num} {
> +       exp_internal 1
>         global expect_out
>         global pass
> -       send "\n"
> -       send "info register\n"
> -       send "\n"
> +       send "set pagination off\n"
> +       send "info all-register\n"
>         expect {
> -               -re "xmm$num\[\t \]+\{f \= .*\}+\[\t \]+\{f \= .*\}" {
> +               -re "xmm$num\[\t \]+\{.*f.* \= .*\}" {
>                         set buf $expect_out(0,string)
>                 }
>                 timeout {
> @@ -130,8 +130,8 @@
>         }
>  }

Aargh, even more fragile.

I doubt that this part works with anything else but the gdb version it
was written for.



Given the state of the test and the uncertain functionality I would vote
for removal. Anybody else has better idea?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
