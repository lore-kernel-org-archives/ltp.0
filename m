From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 24 Mar 2021 21:31:09 +0100
Subject: [LTP] [PATCH] syscalls/setns: Replace libc function with
 safe_macros
In-Reply-To: <20210323135730.24806-1-zhaogongyi@huawei.com>
References: <20210323135730.24806-1-zhaogongyi@huawei.com>
Message-ID: <YFuhjavZQ6bZGGKc@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Gongyi,

thanks for your patchset. While it looks correct, some of changes break both tests:

./setns01 -i 5
tst_test.c:1289: TINFO: Timeout per run is 0h 05m 00s
setns01.c:153: TCONF: no ns types/proc entries

./setns02 -i 5
tst_test.c:1289: TINFO: Timeout per run is 0h 05m 00s
setns02.c:160: TCONF: your kernel has CONFIG_IPC_NS, CONFIG_UTS_NS or CONFIG_PROC disabled
setns02.c:175: TWARN: shmctl(0, 0, (nil)) failed: EINVAL (22)

Kind regards,
Petr
