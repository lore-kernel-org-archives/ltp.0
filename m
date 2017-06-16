From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 16 Jun 2017 09:56:18 -0400 (EDT)
Subject: [LTP] [PATCH v2] syscalls: Add timer measurement library
In-Reply-To: <20170614124239.21109-1-chrubis@suse.cz>
References: <20170614124239.21109-1-chrubis@suse.cz>
Message-ID: <88192643.36961651.1497621378847.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- Original Message -----
> This commit adds a timer measurement library, mostly based on changes
> done to the pselect01.c test and changes all tests that measure timer
> precision to use it.
> 
> The timer testcases that measure timeouts now just define sampling function
> and
> optional setup and cleanup. The rest of the functionality is implemented in
> the
> lib/tst_timer_test.c library. This change not only removes fair amount of
> duplicated code but also allows us to tune thresholds and define testcases in
> a
> single place for all testcases.
> 
> The timer measurement library also supports for passing sleep time and
> number of iterations as a command-line parameters, can print nifty
> frequency plot into the terminal, as well as save test measurements into
> a text file.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
> 
> The changes from the v1:
> 
> * Fixed the outliners calculation not to overflow the sample array
> 
> * Moved the sample function to tst_test structure
>   - now the testcases define tst_test structure
>   - the tst_test structure is then passed to
>     the timer test setup function and is modified there
>   - this seems to be the easiest solution I could come
>     up with
> 
> * The timer test library now sets timeout in a case that
>   that we request single test, the timeout is set to 110%
>   of the requested runtime which fixes timeouts if the requested
>   time multiplied by iterations yields more than default
>   timeout value

Hi,

as approach it looks OK to me. Couple notes below:

- error: ‘PR_GET_TIMERSLACK’ undeclared (first use in this function)
Old ditros don't have this define.

- clock_getres/clock_gettime requires -rt for glibc < 2.17
On RHEL5/6 I had to modify these Makefiles:
#       modified:   include/mk/testcases.mk
#       modified:   lib/newlib_tests/Makefile
#       modified:   lib/tests/Makefile
#       modified:   testcases/kernel/containers/netns/Makefile
#       modified:   testcases/kernel/containers/share/Makefile

- threshold might be too low for some systems
The data I sent in:
  http://lists.linux.it/pipermail/ltp/2017-June/004705.html
was from a quite beefy system, and it sometimes went over
250us threshold.

Should we increase threshold? The formula is based on comment
for select(), but we are applying this to other syscalls as well.
We used to do 1%, now it's more strict with just 0.1%.

Should we use RT priority?
Should we set CPU affinity to only single CPU?

It fails easily on my laptop (i7-6820HQ CPU @ 2.70GHz) atm.:

tst_timer_test.c:269: INFO: pselect() sleeping for 25000us 50 iterations, threshold 301.29us
tst_timer_test.c:312: INFO: min 25063us, max 25586us, median 25293us, trunc mean 25303.85us (discarded 2)
tst_timer_test.c:315: FAIL: pselect() slept for too long

 Time: us | Frequency
--------------------------------------------------------------------------------
    25063 | *******************-
    25091 | ************************-
    25119 | *****************************
    25147 |
    25175 | *********+
    25203 | **************+
    25231 | ****+
    25259 | **************+
    25287 | *********+
    25315 | *********+
    25343 | ****+
    25371 | *********+
    25399 |
    25427 |
    25455 | ****+
    25483 | ********************************************************************
    25511 | **************+
    25539 |
    25567 | ****+
--------------------------------------------------------------------------------
     28us | 1 sample = 4.85714 '*', 9.71429 '+', 19.42857 '-', non-zero '.'

Regards,
Jan
