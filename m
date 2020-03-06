From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 6 Mar 2020 14:25:47 +0100
Subject: [LTP] [PATCH V5 05/10] syscalls/fsconfig: New tests
In-Reply-To: <20200228160149.GA5312@dell5510>
References: <cover.1582779464.git.viresh.kumar@linaro.org>
 <01949a4ba3d2c125a9be8422ec27c8436a53f6a8.1582779464.git.viresh.kumar@linaro.org>
 <20200228160149.GA5312@dell5510>
Message-ID: <20200306132547.GA17606@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

> I get TCONF for all fsconfig01 results, while I'm using 5.5.5-1-default:

> tst_test.c:1290: INFO: Testing on ext2
> tst_mkfs.c:89: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.45.5 (07-Jan-2020)
> tst_test.c:1227: INFO: Timeout per run is 0h 05m 00s
> fsconfig01.c:43: CONF: fsconfig(): FSCONFIG_SET_PATH not supported
> fsconfig01.c:53: CONF: fsconfig(): FSCONFIG_SET_PATH_EMPTY not supported
> fsconfig01.c:63: CONF: fsconfig(): FSCONFIG_SET_FD not supported
> fsconfig01.c:92: PASS: fsconfig() passed
> tst_test.c:1290: INFO: Testing on ext3
> tst_mkfs.c:89: INFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
> mke2fs 1.45.5 (07-Jan-2020)
> tst_test.c:1227: INFO: Timeout per run is 0h 05m 00s
> fsconfig01.c:43: CONF: fsconfig(): FSCONFIG_SET_PATH not supported
> fsconfig01.c:53: CONF: fsconfig(): FSCONFIG_SET_PATH_EMPTY not supported
> fsconfig01.c:63: CONF: fsconfig(): FSCONFIG_SET_FD not supported
> fsconfig01.c:92: PASS: fsconfig() passed
> tst_test.c:1290: INFO: Testing on ext4
> tst_mkfs.c:89: INFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
> mke2fs 1.45.5 (07-Jan-2020)
> tst_test.c:1227: INFO: Timeout per run is 0h 05m 00s
> fsconfig01.c:43: CONF: fsconfig(): FSCONFIG_SET_PATH not supported
> fsconfig01.c:53: CONF: fsconfig(): FSCONFIG_SET_PATH_EMPTY not supported
> fsconfig01.c:63: CONF: fsconfig(): FSCONFIG_SET_FD not supported
> fsconfig01.c:92: PASS: fsconfig() passed
> tst_test.c:1290: INFO: Testing on xfs
> tst_mkfs.c:89: INFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> tst_test.c:1227: INFO: Timeout per run is 0h 05m 00s
> fsconfig01.c:92: PASS: fsconfig() passed
> tst_test.c:1290: INFO: Testing on btrfs
> tst_mkfs.c:89: INFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
> tst_test.c:1227: INFO: Timeout per run is 0h 05m 00s
> fsconfig01.c:43: CONF: fsconfig(): FSCONFIG_SET_PATH not supported
> fsconfig01.c:53: CONF: fsconfig(): FSCONFIG_SET_PATH_EMPTY not supported
> fsconfig01.c:63: CONF: fsconfig(): FSCONFIG_SET_FD not supported
> fsconfig01.c:92: PASS: fsconfig() passed
> tst_test.c:1290: INFO: Testing on vfat
> tst_mkfs.c:89: INFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> tst_test.c:1227: INFO: Timeout per run is 0h 05m 00s
> fsconfig01.c:43: CONF: fsconfig(): FSCONFIG_SET_PATH not supported
> fsconfig01.c:53: CONF: fsconfig(): FSCONFIG_SET_PATH_EMPTY not supported
> fsconfig01.c:63: CONF: fsconfig(): FSCONFIG_SET_FD not supported
> fsconfig01.c:92: PASS: fsconfig() passed

> Not yet merged man page [1] (I reposted David Howells commit) there is
> explanation for EOPNOTSUPP: The command given by cmd was not valid.

> First, I suspected "sync" option is wrong. But looking at kernel sources it's
> really not implemented:
I'm sorry, I was wrong. I overlooked It's supported, but just by xfs
(which is surprising).

Kind regards,
Petr
