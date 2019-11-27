From: Li Wang <liwan@redhat.com>
Date: Wed, 27 Nov 2019 20:10:24 +0800
Subject: [LTP] 
	=?utf-8?b?4p2MIEZBSUw6IFJlOiBbUkhFTDguMiBCWiAxNzczNzc0XSB4?=
	=?utf-8?q?86/quirks=3A_Disable_HPET_on_Intel_Coffe_Lake_platforms?=
In-Reply-To: <b46363e7-b60e-8316-07b9-be6032b0ae01@redhat.com>
References: <cki.0.PFTG7HN9XB@redhat.com>
 <20191126133713.25674-1-prarit@redhat.com>
 <b46363e7-b60e-8316-07b9-be6032b0ae01@redhat.com>
Message-ID: <CAEemH2fU6dgunAuvoEjygKq=EMD2PfRW9rLEyENdtwEVwNbPyQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Rachel Sibley <rasibley@redhat.com> wrote:

> ...
> >>
> >>      Pipeline:
> https://xci32.lab.eng.rdu2.redhat.com/cki-project/cki-pipeline/pipelines/308034
> >>
> >> One or more kernel tests failed:
> >>
> >>      s390x:
> >>       ? LTP lite
> >
> > This MUST be a failure due to some other reason.  This patch only affects
> > HPET timers on Intel x86_64 Coffee Lake platforms.
>
> I'm seeing it fail on other patches as well, MM-QE can you take a look ?
> Is this a known issue ?
>
> Thanks,
> Rachel
>
> <<<test_start>>>
> tag=mtest01w stime=1574715697
> cmdline="mtest01 -p80 -w"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
> mtest01.c:134: INFO: Filling up 80% of free ram which is 5868864 kbytes
> mtest01.c:149: INFO: ... child 38289 starting
> mtest01.c:149: INFO: ... child 38288 starting
> mtest01.c:208: WARN: the remaininig time is not enough for testing
> mtest01.c:218: FAIL: kbytes allocated (and written to) less than
> expected 5868864
> Test timeouted, sending SIGKILL!
>

The root cause is that children's memory allocating is still ongoing, but
the remaining time is in an emergency, so parent break from the while loop
and try to stop children, obviously, it doesn't have enough time to wait
for the process status change to 'T'.

        TST_PROCESS_STATE_WAIT(pid_list[i], 'T');
        kill(pid_list[i], SIGCONT);

My proposal patch to fix this problem as:

--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -216,11 +216,17 @@ static void mem_test(void)
        if (children_done < pid_cntr) {
                tst_res(TFAIL, "kbytes allocated %sless than expected %llu",
                                write_msg, alloc_maxbytes / 1024);
-       } else {
-               tst_res(TPASS, "%llu kbytes allocated %s",
-                               alloc_maxbytes / 1024, write_msg);
+
+               for (i = 0; i < pid_cntr; i++) {
+                       kill(pid_list[i], SIGKILL);
+               }
+
+               return;
        }

+       tst_res(TPASS, "%llu kbytes allocated %s",
+                       alloc_maxbytes / 1024, write_msg);
+
        for (i = 0; i < pid_cntr; i++) {
                TST_PROCESS_STATE_WAIT(pid_list[i], 'T');
                kill(pid_list[i], SIGCONT);



> tst_test.c:1158: INFO: If you are running on slow machine, try exporting
> LTP_TIMEOUT_MUL > 1
> tst_test.c:1159: BROK: Test killed! (timeout?)
>
> Summary:
> passed   0
> failed   1
> skipped  0
> warnings 1
> <<<execution_status>>>
> initiation_status="ok"
> duration=314 termination_type=exited termination_id=7 corefile=no
> cutime=1 cstime=3
> <<<test_end>>>
>
> >
> > P.
> >
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191127/3d41d9a1/attachment.htm>
