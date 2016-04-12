From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 12 Apr 2016 13:01:25 +0300
Subject: [LTP] [PATCH v2 2/2] syscalls/fcntl: add new test for open file
 description locks
In-Reply-To: <1460016651-24181-2-git-send-email-alexey.kodanev@oracle.com>
References: <1460016651-24181-1-git-send-email-alexey.kodanev@oracle.com>
 <1460016651-24181-2-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <570CC775.5030403@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 04/07/2016 11:10 AM, Alexey Kodanev wrote:
> OFD lock is available since Linux 3.15 and new F_OFD_* macros
> added to lapi/fcntl.h
>
> Test is based on [1] article and checks that OFD locks can
> syncronise access to a file between multiple threads.
>
> [1] https://lwn.net/Articles/586904

Patch-set applied.

Best regards,
Alexey

