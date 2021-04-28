From: Li Wang <liwang@redhat.com>
Date: Wed, 28 Apr 2021 19:05:47 +0800
Subject: [LTP] [PATCH] syscalls/reboot: Update to new API
In-Reply-To: <CAEemH2d8PK2uz9QpYefmhoaLm=g9NwsViUGMB=pJ4f0PKtSAvw@mail.gmail.com>
References: <20210426031043.16212-1-zhaogongyi@huawei.com>
 <CAEemH2d8PK2uz9QpYefmhoaLm=g9NwsViUGMB=pJ4f0PKtSAvw@mail.gmail.com>
Message-ID: <CAEemH2cai9qNXiqq=MDi4KOo=2ZjiBxD2SssCT=vVp7F+qgDQA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Nice work on API converting and cleanup, pushed!

BTW, I made some modifications in a separate patch[1], because
I forget to submit them in the last code-reviewing.

https://github.com/linux-test-project/ltp/commit/b71b1a494be4126917221bb3b78594ec25c71ea0

--- a/testcases/kernel/syscalls/reboot/reboot02.c
+++ b/testcases/kernel/syscalls/reboot/reboot02.c
@@ -31,7 +31,7 @@
 char nobody_uid[] = "nobody";
 struct passwd *ltpuser;

-static struct test_case_t {
+static struct tcase {
        int flag;
        int exp_errno;
        const char *option_message;
@@ -40,19 +40,19 @@ static struct test_case_t {
        {LINUX_REBOOT_CMD_CAD_ON, EPERM, "LINUX_REBOOT_CMD_CAD_ON"},
 };

-static void run(int n)
+static void run(unsigned int n)
 {
-       struct test_case_t *tcase = &tcases[n];
+       struct tcase *tc = &tcases[n];

        if (n == 0)
-               TST_EXP_FAIL(reboot(tcase->flag),
-                       tcase->exp_errno, "%s", tcase->option_message);
+               TST_EXP_FAIL(reboot(tc->flag),
+                       tc->exp_errno, "%s", tc->option_message);
        else {
                ltpuser = SAFE_GETPWNAM(nobody_uid);
                SAFE_SETEUID(ltpuser->pw_uid);

-               TST_EXP_FAIL(reboot(tcase->flag),
-                       tcase->exp_errno, "%s", tcase->option_message);
+               TST_EXP_FAIL(reboot(tc->flag),
+                       tc->exp_errno, "%s", tc->option_message);

                SAFE_SETEUID(0);
        }


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210428/56d550e4/attachment-0001.htm>
