From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Nov 2017 12:14:48 +0800
Subject: [LTP] [PATCH] fs_fill: switch the SAFE MACROs back to ordinary
	syscall
In-Reply-To: <20171120131952.GA22113@rei.lan>
References: <20171110111519.27872-1-liwang@redhat.com>
 <1515676468.42550872.1511176722601.JavaMail.zimbra@redhat.com>
 <20171120131952.GA22113@rei.lan>
Message-ID: <CAEemH2ei8WXrpWLN5J_+tb4cZiZGeE1ovd43TnbUtb=seEdf3Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Nov 20, 2017 at 9:19 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> >   safe_macros.c:225: BROK: tst_fill_fs.c:43:
>> >   open(mntpoint/thread48/file0,65,0700) failed: ENOSPC
>> >   safe_macros.c:169: BROK: fs_fill.c:49: mkdir(mntpoint/thread21,0700)
>> >   failed: ENOSPC
>> >
>> > Signed-off-by: Li Wang <liwang@redhat.com>
>>
>> Pushed.
>
> I do not like that the worker exits prematurely here if the mkdir fails,
> that's why I suggested to mkdir() all the directories before we attempt
> to run the the worker threads.

My bad. Seems I did not fully get your point before.

>
> But I can always change that in a follow up patch...

How about this following change:

--- a/testcases/kernel/fs/fs_fill/fs_fill.c
+++ b/testcases/kernel/fs/fs_fill/fs_fill.c
@@ -41,21 +41,11 @@ struct worker {

 static void *worker(void *p)
 {
-       int ret;
        struct worker *w = p;
        DIR *d;
        struct dirent *ent;
        char file[PATH_MAX];

-       ret = mkdir(w->dir, 0700);
-       if (ret == -1) {
-               if (errno != ENOSPC)
-                       tst_brk(TBROK | TERRNO, "mkdir()");
-
-               tst_res(TINFO | TERRNO, "mkdir()");
-               return NULL;
-       }
-
        while (run) {
                tst_fill_fs(w->dir, 0);

@@ -92,6 +82,10 @@ static void testrun(void)
        for (i = 0; i < nthreads; i++) {
                snprintf(workers[i].dir, sizeof(workers[i].dir),
                         MNTPOINT "/thread%i", i + 1);
+               SAFE_MKDIR(workers[i].dir, 0700);
+       }
+
+       for (i = 0; i < nthreads; i++) {
                SAFE_PTHREAD_CREATE(&threads[i], NULL, worker, &workers[i]);
        }


>
> --
> Cyril Hrubis
> chrubis@suse.cz



-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-fs_fill-create-all-the-directories-befere-run-worker.patch
Type: text/x-patch
Size: 1409 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20171121/d78e751e/attachment.bin>
