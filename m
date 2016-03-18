From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 18 Mar 2016 15:02:56 +0300
Subject: [LTP] [PATCH] lib/tst_rmdir.c: close TESTDIR files before
	rmobj()
In-Reply-To: <20160317161546.GB31815@rei.lan>
References: <1458228954-28372-1-git-send-email-alexey.kodanev@oracle.com>
 <20160317161546.GB31815@rei.lan>
Message-ID: <56EBEE70.90902@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 03/17/2016 07:15 PM, Cyril Hrubis wrote:
> Hi!
>> NFS creates special .nfs* files when test file was removed and
>> left open. In that case, tst_rmdir() fails to remove test dirs:
> This is the reason why we state in test writing guidelines that all open
> file descriptors should be closed in the cleanup() function.

Most tests are not doing it and just call tst_rmdir() in cleanup.
When a testfails in the middle, e.g. with tst_brkm(TFAIL,...),
it will getworthlessTWARN along with TFAIL.

Some tests closes fds in cleanup, and it means that they set global vars
to keep track of open files. I think, itcomplicates a little bit writing
and reading such tests.So that is why I think it's better to have such
cleanup operations insidethe library.

Thanks,
Alexey

> I'm not sure that it's a good idea to close them in the library this
> way.

