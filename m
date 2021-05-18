From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 18 May 2021 06:57:15 +0200
Subject: [LTP] [PATCH v3 3/4] lib: ignore SIGINT in _tst_kill_test
In-Reply-To: <CAEemH2fRLqipQWTxVsakYNGsmQT+2X8_xzgepCiAY1O8YWtKFA@mail.gmail.com>
References: <20210508055109.16914-4-liwang@redhat.com>
 <dfdd8e9a-90ca-642d-1c21-da169ca3878f@jv-coder.de>
 <CAEemH2et8_SXWJTsofdt7gc0NRV=91rPe0RtAMt1BX=SbAzhig@mail.gmail.com>
 <YJvkFTUWS2iuZ00H@pevik>
 <CAEemH2fRLqipQWTxVsakYNGsmQT+2X8_xzgepCiAY1O8YWtKFA@mail.gmail.com>
Message-ID: <a4154e09-8ae3-beb3-13d5-c92126177ed5@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

On 5/13/2021 7:08 AM, Li Wang wrote:
>> FYI I tried to use both SIGINT and SIGTERM, but there was some problem.
>> But I guess it was my error. Please *add* SIGTERM (keep SIGINT).
> Yes, we'd better keep SIGINT for ctrl^c action and use SIGTERM
> additionally for process terminating.
>
> Does this below (rough solution in my mind) work for you?
>
> diff --git a/lib/newlib_tests/shell/timeout03.sh
> b/lib/newlib_tests/shell/timeout03.sh
> index cd548d9a2..f39f5712a 100755
> --- a/lib/newlib_tests/shell/timeout03.sh
> +++ b/lib/newlib_tests/shell/timeout03.sh
> @@ -30,6 +30,7 @@ TST_TIMEOUT=1
>
>   do_test()
>   {
> +       trap "echo 'Sorry, timeout03 is still alive'" TERM
>          tst_res TINFO "testing killing test after TST_TIMEOUT"
>
>          sleep 2
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 28c2052d6..d7c9791e9 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -21,7 +21,7 @@ export TST_LIB_LOADED=1
>   . tst_security.sh
>
>   # default trap function
> -trap "tst_brk TBROK 'test interrupted or timed out'" INT
> +trap "tst_brk TBROK 'test interrupted'" INT
This would require something like
trap "tst_brk TBROK 'test terminated'" TERM
or
trap "_tst_do_exit" TERM

Otherwise the test is terminated very roughly, without executing 
cleanup, which is probably not a good idea.

But that introduces the next problem: A short deadlock between 
_tst_kill_test and _tst_cleanup_timer,
because _tst_cleanup_timer waits for the termination of the timeout 
process and vice versa.
Another problem is, that a SIGTERM originating from some other location 
could look like a timeout.

I am currently thinking about the following solution, to mitigate most 
problems:
The timeout process sends SIGUSR1 (or maybe SIGALRM?) only to the main 
test process and blocks TERM.
The main process can print, that it ran into a timeout, send a sigterm 
to its processs group (while ignoring TERM itself).
Then it can unset $_tst_setup_timer_pid safely, because it knows it was 
triggered by the timeout process and execute _tst_do_exit.

If the timeout process does not see the termination of the main process, 
it can still send SIGKILL to the whole process group.

J?rg


