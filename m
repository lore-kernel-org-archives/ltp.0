From: Li Wang <liwang@redhat.com>
Date: Fri, 20 Apr 2018 11:56:54 +0800
Subject: [LTP] LTP Release preparations
In-Reply-To: <20180419141749.GA13045@rei>
References: <20180412113532.GA5963@rei> <20180419141749.GA13045@rei>
Message-ID: <CAEemH2dxxvwC8fHwJuxACEjDZxfxLBjx8VFhC=dJDMcV4=vbmA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Thu, Apr 19, 2018 at 10:17 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > It's about the time we should slowly prepare for the next release, as
> > usuall let's start with a list of patches that should go in before we
> > enter the stabilization phase.
> >
> > As for me I would like to get the two speedup patchsets in, one of them
> > only waits for ack from Jan, the second one would probably benefit from
> > some more review. I will try to merge everything that is good to go and
> > just waiting for a review ASAP.
> >
> > Anything else that should really go in?
>
> Ping.
>
> I suppose that we should get in the fix for the read_all testcase along
> with the exponential back off.
>

​I'm hesitating if we should abandon the old patch[1] and re-rewrite a new
one
(which base on the new TST_RETRY_FUNC macro) to fix the problem.

​[1]​ http://lists.linux.it/pipermail/ltp/2018-April/007704.html

-----------------
something new like:

--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -265,23 +265,14 @@ static void spawn_workers(void)
 static void stop_workers(void)
 {
        const char stop_code[1] = { '\0' };
-       int i, stop_attempts;
+       int i;

        if (!workers)
                return;

        for (i = 0; i < worker_count; i++) {
-               stop_attempts = 0xffff;
-               if (workers[i].q) {
-               if (workers[i].q) {
-                       while (!queue_push(workers[i].q, stop_code)) {
-                               if (--stop_attempts < 0) {
-                                       tst_brk(TBROK,
-                                               "Worker %d is stalled",
-                                               workers[i].pid);
-                                       break;
-                               }
-                       }
-               }
+               if (workers[i].q)
+                       TST_RETRY_FUNC(queue_push(workers[i].q, stop_code),
1);
        }

        for (i = 0; i < worker_count; i++) {
@@ -292,33 +283,15 @@ static void stop_workers(void)
        }
 }

-static void sched_work(const char *path)
-{
-       static int cur;
-       int push_attempts = 0, pushed;
-
-       while (1) {
-               pushed = queue_push(workers[cur].q, path);
-
-               if (++cur >= worker_count)
-                       cur = 0;
-
-               if (pushed)
-                       break;
-
-               if (++push_attempts > worker_count) {
-                       usleep(100);
-                       push_attempts = 0;
-               }
-       }
-}
-
 static void rep_sched_work(const char *path, int rep)
 {
-       int i;
+       int i, j;

-       for (i = 0; i < rep; i++)
-               sched_work(path);
+       for (i = j = 0; i < rep; i++, j++) {
+               if (j >= 15)
+                       j = 0;
+               TST_RETRY_FUNC(queue_push(workers[j].q, path), 1);
+       }
 }



-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180420/1ae8918e/attachment-0001.html>
