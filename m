From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 15 Sep 2018 15:39:27 +0530
Subject: [LTP] LTP master: arm64 : fsetxattr02.c:214:
 open(mntpoint/fsetxattr02blk, 0, 00) failed: ENXIO
Message-ID: <CA+G9fYtAuGixa5x6kgmBOa7bDkhkz6rQMY5AdBgXLjp8uZKHzg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP master testing on Hikey (arm64) device reported new test case
fsetxattr02 and fgetxattr02 failed with error ENXIO (No such device or
address)

We have very limited failure information on the console.
Is this test case in any special TMP DIR ?

# cd /opt/ltp
# mkdir -m 777 -p /ltp-tmp # on the top level ltp-tmp created which is ext4 fs.
# ./runltp -f syscalls -d /ltp-tmp

Test output log,
safe_macros.c:225: BROK: fsetxattr02.c:214:
open(mntpoint/fsetxattr02blk,0,00) failed: ENXIO
safe_macros.c:225: BROK: fgetxattr02.c:244: open(fgetxattr02blk,0,00)
failed: ENXIO

Yangx fixed  error "EACCES" this error is ENXIO (No such device or address)

Full log link,
https://lkft.validation.linaro.org/scheduler/job/420924#L3182

FYI,
LTP Version: 20180515-270-ge7bab6188

Best regards
Naresh Kamboju
