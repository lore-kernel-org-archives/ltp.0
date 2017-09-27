From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 27 Sep 2017 09:55:13 -0400 (EDT)
Subject: [LTP] [PATCH] utimensat_tests.sh: returns EPERM on 4.4.27 and
	above
In-Reply-To: <20170925144624.GB31931@rei>
References: <1504697434-22974-1-git-send-email-naresh.kamboju@linaro.org>
 <1059184676.9072017.1504698860809.JavaMail.zimbra@redhat.com>
 <CAO_48GG9k_MxhktOWptCkv1Y8xFfFN31w2ntcnkZL5LdhM7qxg@mail.gmail.com>
 <20170925144624.GB31931@rei>
Message-ID: <1297668995.23147365.1506520513918.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > I'd think so too - perhaps a better check is to check for (if 4.4.X,
> > then if > .27) OR (greater than 4.8.0)?
> 
> The safest bet would be allowing both for kernels between 4.4 and 4.8.

But also less strict. Why not just add check for 3rd digit?
We already do that in other tests.

diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
index 48154d6e65b2..6d7fc5030aff 100755
--- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
+++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
@@ -32,13 +32,16 @@ fi
 
 # Starting with 4.8.0 operations on immutable files return EPERM instead of
 # EACCES.
-if tst_kvcmp -lt "4.8.0"; then
+# This patch has also been merged to stable 4.4 with
+# b3b4283 ("vfs: move permission checking into notify_change() for utimes(NULL)")
+if tst_kvcmp -ge "4.4.27" -a -lt "4.5.0"; then
+       imaccess=EPERM
+else if tst_kvcmp -lt "4.8.0"; then
        imaccess=EACCES
 else
        imaccess=EPERM
 fi

Regards,
Jan
