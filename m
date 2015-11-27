From: Li Jin <King.lijin@huawei.com>
Date: Fri, 27 Nov 2015 14:44:08 +0800
Subject: [LTP] Fix wrong pattern used by fnmatch in test case proc01.c
Message-ID: <1448606649-141790-1-git-send-email-King.lijin@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi

Hi,

When I run test case proc01 with 4.1 linux kernel, found that fnmatch use a
wrong pattern to match the known issue under /proc/sys/net/ipv6/conf/ such as
/proc/sys/net/ipv6/conf/all/stable_secret, and have the following error:

[root@localhost tmp]# ./proc01 
proc01      0  TINFO  :  /proc/sys/fs/binfmt_misc/register: is write-only.
proc01      1  TFAIL  :  proc01.c:392: read failed: /proc/sys/net/ipv6/conf/all/stable_secret: errno=EIO(5): Input/output error
proc01      2  TFAIL  :  proc01.c:392: read failed: /proc/sys/net/ipv6/conf/bond0/stable_secret: errno=EIO(5): Input/output error
proc01      3  TFAIL  :  proc01.c:392: read failed: /proc/sys/net/ipv6/conf/default/stable_secret: errno=EIO(5): Input/output error
proc01      4  TFAIL  :  proc01.c:392: read failed: /proc/sys/net/ipv6/conf/eth0/stable_secret: errno=EIO(5): Input/output error

Test passed with the following change

/proc/sys/net/ipv6/conf/*/stable_secret --> /proc/sys/net/ipv6/conf/[a-z]*/stable_secret

[root@localhost ~]# ./proc01 
proc01      0  TINFO  :  /proc/sys/fs/binfmt_misc/register: is write-only.
proc01      0  TINFO  :  /proc/sys/net/ipv6/conf/all/stable_secret: known issue: errno=EIO(5): Input/output error
proc01      0  TINFO  :  /proc/sys/net/ipv6/conf/bond0/stable_secret: known issue: errno=EIO(5): Input/output error
proc01      0  TINFO  :  /proc/sys/net/ipv6/conf/default/stable_secret: known issue: errno=EIO(5): Input/output error
proc01      0  TINFO  :  /proc/sys/net/ipv6/conf/eth0/stable_secret: known issue: errno=EIO(5): Input/output error
