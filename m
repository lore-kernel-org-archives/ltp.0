From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Nov 2017 18:03:33 +0800
Subject: [LTP] [PATCH v3 15/16] fs/fs_fill: Add a test to fill a FS in a
 few threads
In-Reply-To: <20171011144130.29728-15-chrubis@suse.cz>
References: <20171011144130.29728-1-chrubis@suse.cz>
 <20171011144130.29728-15-chrubis@suse.cz>
Message-ID: <CAEemH2f8Dya2XUvZZ2t9XMbbVFo_tM5B=LuzjZqyB8ZCA6qvVA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

This case always broken in SAFE_* operations, seems the reason is no
space left on the device,
so I wonder if is it necessary to create so many thread "CPUs + 2" to
run the test?

What about just creating half of CPU number thread (nthreads =
tst_ncpus_conf()/2 + 1) there?

$ git diff
diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c
b/testcases/kernel/fs/fs_fill/fs_fill.c
index a50a22f..13207c4 100644
--- a/testcases/kernel/fs/fs_fill/fs_fill.c
+++ b/testcases/kernel/fs/fs_fill/fs_fill.c
@@ -106,7 +106,7 @@ static void testrun(void)

 static void setup(void)
 {
-       nthreads = tst_ncpus_conf() + 2;
+       nthreads = tst_ncpus_conf()/2 + 1;

        tst_res(TINFO, "Running %i writer threads", nthreads);
 }


Broken message:
==============
fs_fill.c:104: PASS: Got 73 ENOSPC runtime 1000ms
tst_mkfs.c:83: INFO: Formatting /dev/loop1 with xfs opts='' extra opts=''
tst_test.c:970: INFO: Timeout per run is 0h 05m 00s
fs_fill.c:111: INFO: Running 66 writer threads
safe_macros.c:225: BROK: tst_fill_fs.c:43:
open(mntpoint/thread48/file0,65,0700) failed: ENOSPC



-- 
Li Wang
liwang@redhat.com
