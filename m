From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 May 2021 13:05:36 +0200
Subject: [LTP] [PATCH 2/4] syscalls/modify_ldt: Replace TINFO with TPASS
 or TFAIL
In-Reply-To: <YJPImeHT9rVsVtON@pevik>
References: <20210429125255.31510-1-zhaogongyi@huawei.com>
 <YJPImeHT9rVsVtON@pevik>
Message-ID: <YJPNgGwlZBLMaJOd@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> FYI: since merging this patch (f5e8e6b11) test fails on this. Is it expected?
> I haven't looked closer whether it's a test bug or real issue.

What is the test failure output? The only part that was change that
could introduce difference in the output is as far as I can tell this:

                /*
                 * Create a new LDT segment.
                 */
                if (create_segment(seg, sizeof(seg)) == -1) {
-                       tst_brkm(TINFO, cleanup, "Creation of segment failed");
+                       tst_brkm(TBROK, cleanup, "Creation of segment failed");
                }


Which would mean that the test was broken before the change but just
haven't produced any errors.

-- 
Cyril Hrubis
chrubis@suse.cz
