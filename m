From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 18 Jan 2016 17:49:13 +0300
Subject: [LTP] [PATCH] kernel/input: increase the number of retries in
	open_device
Message-ID: <1453128553-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In some environments the current limit (2) is not enough, and only
3rd or 4th access will succeed. Therefore, let's increase it slightly.
The new limit (10) is the same value we have in open_uinput().

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---

Without this patch inputXX test cases fail with:

[root@skholman-m7 input]# ./input01 
input01     0  TINFO  :  Trying to load uinput kernel module
input01     0  TINFO  :  Uinput dev not found, retrying...
input01     0  TINFO  :  Uinput dev not found, retrying...
input01     0  TINFO  :  Uinput dev not found, retrying...
input01     0  TINFO  :  Found uinput dev at /dev/uinput
input01     0  TINFO  :  Device not found, retrying...
input01     0  TINFO  :  Device not found, retrying...
input01     1  TPASS  :  Data received from eventX
input01     0  TINFO  :  Unloading uinput kernel module

in our environment (an in-house, relatively old kernel).

Can we have this patch before the release?

Thanks!

 testcases/kernel/input/input_helper.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/input/input_helper.c b/testcases/kernel/input/input_helper.c
index 71c5dec..08fa81c 100644
--- a/testcases/kernel/input/input_helper.c
+++ b/testcases/kernel/input/input_helper.c
@@ -72,7 +72,7 @@ static int try_open_device(void)
 int open_device(void)
 {
 	int fd;
-	int retries = 2;
+	int retries = 10;
 
 	while (retries--) {
 		fd = try_open_device();
-- 
1.7.1

