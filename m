From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 6 Apr 2016 18:07:06 +0300
Subject: [LTP] [PATCH] syscalls/fcntl: add new test for open file
 description locks
In-Reply-To: <1458033988-15881-1-git-send-email-alexey.kodanev@oracle.com>
References: <1458033988-15881-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <5705261A.10803@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 03/15/2016 12:26 PM, Alexey Kodanev wrote:
> OFD lock is available since Linux 3.15 and new F_OFD_* macros
> added to lapi/fcntl.h
>
> Test is based on [1] article and checks that OFD locks can
> syncronise access to a file between multiple threads.
>
> [1] https://lwn.net/Articles/586904

Any comments?

Thanks,
Alexey

