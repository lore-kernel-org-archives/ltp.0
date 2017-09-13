From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Sep 2017 15:42:42 +0200
Subject: [LTP] [PATCH v5 3/3] Test for CVE-2016-10044 mark AIO pseudo-fs
 noexec
In-Reply-To: <20170911115054.19982-3-rpalethorpe@suse.com>
References: <20170911115054.19982-1-rpalethorpe@suse.com>
 <20170911115054.19982-3-rpalethorpe@suse.com>
Message-ID: <20170913134241.GA29584@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed whole patchset, thanks.

And this test was pushed with a diff:

diff --git a/testcases/cve/cve-2016-10044.c b/testcases/cve/cve-2016-10044.c
index 4861647a0..7928d2765 100644
--- a/testcases/cve/cve-2016-10044.c
+++ b/testcases/cve/cve-2016-10044.c
@@ -62,6 +62,9 @@ found_mapping:
                tst_res(TFAIL, "AIO mapping is executable: %s!", perms);
        else
                tst_res(TPASS, "AIO mapping is not executable: %s", perms);
+
+       SAFE_FCLOSE(f);
+       f = NULL;
 }

That closes the file in a case that someone will run the test with -i, which
does not make much sense but I've added that for the sake of completness.

-- 
Cyril Hrubis
chrubis@suse.cz
