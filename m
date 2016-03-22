From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 22 Mar 2016 12:11:18 +0300
Subject: [LTP] [PATCH] syscalls: close open files in cleanup
In-Reply-To: <20160321130439.GA1022@rei>
References: <1458309428-16300-1-git-send-email-alexey.kodanev@oracle.com>
 <20160321130439.GA1022@rei>
Message-ID: <56F10C36.40805@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 03/21/2016 04:04 PM, Cyril Hrubis wrote:
> Hi!
>> NFS creates special .nfs* files when test file was removed and
>> left open. In that case, tst_rmdir() fails to remove test dirs.
>>
>> Close left open files in cleanup and replace some of safe_open()
>> calls with safe_file_printf() ones for test files which fd won't
>> be used in a test.
> I would be closing the file descriptors only if they were initialized
> with value > 0, since otherwise there would be misleading failing close
> in the strace in case that some setup step prior to the SAFE_OPEN()
> failed.

Added checks and applied.

Thanks,
Alexey

> Otherwise it looks good.
>

