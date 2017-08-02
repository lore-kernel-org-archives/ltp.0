From: Li Wang <liwang@redhat.com>
Date: Wed, 2 Aug 2017 12:00:55 +0800
Subject: [LTP] [PATCH v3 00/15] Convert LTP mem/testcase to new API
In-Reply-To: <20170801150432.GA3925@rei>
References: <20170718082312.3946-1-liwang@redhat.com>
 <20170801150432.GA3925@rei>
Message-ID: <CAEemH2frcfrffWTjfp=7REa+mVFODnFT-Zmq4OToqbmcs0a0RQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 1, 2017 at 11:04 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
> I've pushed this patches, after careful testing and with many changes,
> thanks.

Thank you for reviewing so patiently.

>
> Most of the changes were more or less cosmetic, such as removing -1
> handling after SAFE_FORK(), make use of more SAFE_MACROS() etc.
>
> But there were some problems as well. It introduced a compilation
> failure on 32bit for min_free_kbytes.c since it removed the total_mem
> variable that is used only on 32bit.
>
> The ksm06.c cleanup had to be changed, since in a case that
> merge_across_nodes is missing it attempted to run cleanup (previously
> there was NULL cleanup pointer for TCONF!) and failed the test. There is
> probably more unvanted cleanups possibly run for the ksm test, we should
> have a look at these later.

This worries of cleanup work in ksm06.c is very sensible.

Another situation come to mind is that, if the original value of
'run', 'sleep_millisecs' and 'merge_across_nodes' are all equal 0, but
something goes wrong during our test in function
test_ksm_merge_across_nodes(nr_pages), and these knobs obviously have
been changed to other number, then it attempt to run cleanup() to
recovery, but will be failed to restore the values to original,
because they are not satisfy the condition(should '> 0' but '== 0') in
comparing.

~~~~~~~~~~~~~
static int run = -1;
static int sleep_millisecs = -1;
static int merge_across_nodes = -1;
...

static void cleanup(void)
{
    if (merge_across_nodes > 0) {
        FILE_PRINTF(PATH_KSM "merge_across_nodes",
                "%d", merge_across_nodes);
    }

    if (sleep_millisecs > 0)
        FILE_PRINTF(PATH_KSM "sleep_millisecs", "%d", sleep_millisecs);

    if (run > 0)
        FILE_PRINTF(PATH_KSM "run", "%d", run);

    restore_max_page_sharing();
}
~~~~~~~~~~~~~

My simple patch for the problem is:

$ git diff
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index df7cd39..2f5221c 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -82,15 +82,15 @@ static void setup(void)

 static void cleanup(void)
 {
-       if (merge_across_nodes > 0) {
+       if (merge_across_nodes != -1) {
                FILE_PRINTF(PATH_KSM "merge_across_nodes",
                            "%d", merge_across_nodes);
        }

-       if (sleep_millisecs > 0)
+       if (sleep_millisecs != -1)
                FILE_PRINTF(PATH_KSM "sleep_millisecs", "%d", sleep_millisecs);

-       if (run > 0)
+       if (run != -1)
                FILE_PRINTF(PATH_KSM "run", "%d", run);

        restore_max_page_sharing();



FYI: The default values on my RHEL platform are:

# cat /sys/kernel/mm/ksm/run
0

# cat /sys/kernel/mm/ksm/sleep_millisecs
20

# cat /sys/kernel/mm/ksm/merge_across_nodes
1


>
> I've also reverted the change to the thp01 in the runtest file since I
> belive that the value was reduced only for testing and slipped to the
> patchset by accident.
>
> I've changed the patch that adds possibility to disable timeouts, mainly
> so that the API is consistent, which means that the tst_set_timeout()
> takes -1 as parameter as well + wrote documentation for the change.

great, looks better than previous patch.

>
> Also unsolved is a problem with TCONF tests. At the moment newlib test
> fails if we pass any parameters to it, since the option parsing runs
> with the tst_test structure without the option stucture. This fails, for
> instance, ksm test if they were compiled out since we pass parameters to
> them in the runtest file. I will have to think about this a bit more and
> figure out a good solution.

Yes, sounds a little tricky.


-- 
Li Wang
liwang@redhat.com
