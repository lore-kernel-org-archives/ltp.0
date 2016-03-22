From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 22 Mar 2016 12:40:18 +0300
Subject: [LTP] [PATCH] lib/tst_rmdir.c: close TESTDIR files before
	rmobj()
In-Reply-To: <20160321122733.GC32294@rei.lan>
References: <1458228954-28372-1-git-send-email-alexey.kodanev@oracle.com>
 <20160317161546.GB31815@rei.lan> <56EBEE70.90902@oracle.com>
 <20160321122733.GC32294@rei.lan>
Message-ID: <56F11302.80502@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03/21/2016 03:27 PM, Cyril Hrubis wrote:
> Hi!
>>>> NFS creates special .nfs* files when test file was removed and
>>>> left open. In that case, tst_rmdir() fails to remove test dirs:
>>> This is the reason why we state in test writing guidelines that all open
>>> file descriptors should be closed in the cleanup() function.
>> Most tests are not doing it and just call tst_rmdir() in cleanup.
>> When a testfails in the middle, e.g. with tst_brkm(TFAIL,...),
>> it will getworthlessTWARN along with TFAIL.
>>
>> Some tests closes fds in cleanup, and it means that they set global vars
>> to keep track of open files. I think, itcomplicates a little bit writing
>> and reading such tests.So that is why I think it's better to have such
>> cleanup operations insidethe library.
> I'm not saying this is a bad idea. I'm not 100% sure if there are any
> side effects. Maybe we can add a close_fds flag to the test structure in
> the new test library and enable it only when it's needed.

OK, may be it's a good idea. So, should I wait till the merge or
send youa new patch for your repo first?

Thanks,
Alexey


