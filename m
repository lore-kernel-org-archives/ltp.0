From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 18 Jun 2021 20:04:47 +0200
Subject: [LTP] [PATCH 3/3 v2] getrusage: Cleanup and bugfix for
 getrusage03
In-Reply-To: <021a65c83ac448e882077e7dabe1667b@huawei.com>
References: <20210617105556.130869-1-xieziyao@huawei.com>
 <20210617105556.130869-4-xieziyao@huawei.com>
 <YMyPhiiKwuwEdj7N@yuki>
 <021a65c83ac448e882077e7dabe1667b@huawei.com>
Message-ID: <YMzgP1kOP/LgfKEU@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed, thanks.

I had to add another fix for the -i parameter.

When the test was executed in a loop it was failing on subsequent
iterations because it expects that the initiali maxrss is 100MB.

So in order to fix that I had to change the run() function, now each
test runs in its own process and starts with a child that consumes
100MB.

Diff:

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index f72f908dc..ef2f62a18 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -161,12 +161,16 @@ void (*testfunc_list[])(void) = {

 static void run(unsigned int i)
 {
-       testfunc_list[i]();
-}
+       if (!SAFE_FORK()) {
+               if (!SAFE_FORK()) {
+                       consume_mb(100);
+                       exit(0);
+               }

-static void setup(void)
-{
-       consume_mb(100);
+               SAFE_WAIT(NULL);
+
+               testfunc_list[i]();
+       }
 }

 static struct tst_test test = {
@@ -177,7 +181,6 @@ static struct tst_test test = {
        .tags = (const struct tst_tag[]) {
                {"linux-git", "1f10206cf8e9"},
        },
-       .setup = setup,
        .test = run,
        .tcnt = ARRAY_SIZE(testfunc_list),
 };

-- 
Cyril Hrubis
chrubis@suse.cz
