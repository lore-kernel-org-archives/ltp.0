From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 8 Sep 2017 14:20:35 +0200
Subject: [LTP] [PATCH v4] input/input06: Fix auto-repeat key test
In-Reply-To: <20170905225547.119211-1-sspatil@google.com>
References: <20170905225547.119211-1-sspatil@google.com>
Message-ID: <20170908122035.GA4351@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with this diff, thanks.

diff --git a/testcases/kernel/input/input06.c b/testcases/kernel/input/input06.c
index a15d11225..4c5f1a867 100644
--- a/testcases/kernel/input/input06.c
+++ b/testcases/kernel/input/input06.c
@@ -126,6 +126,9 @@ static void read_events(void)
        if (rd < 0)
                tst_brkm(TBROK | TERRNO, cleanup, "read() failed");
 
+       if (rd == 0)
+               tst_brkm(TBROK, cleanup, "Failed to read events");
+
        if (rd % sizeof(struct input_event) != 0) {
                tst_brkm(TBROK, cleanup, "read size %i not multiple of %zu",
                         rd, sizeof(struct input_event));


So that we do not return bogus event in next_event() in a case that the read()
has returned 0, which should not happen under normal conditions, but let's
handle that as well in a case that something went wrong...

-- 
Cyril Hrubis
chrubis@suse.cz
