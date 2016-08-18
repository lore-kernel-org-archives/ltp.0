From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 18 Aug 2016 12:54:47 +0300
Subject: [LTP] [PATCH 3/8] syscalls/waitpid: implement waitpid_ret_test()
In-Reply-To: <20160815152739.GG20680@rei.lan>
References: <1470818466-28109-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160815152739.GG20680@rei.lan>
Message-ID: <57B585E7.9020000@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 08/15/2016 06:27 PM, Cyril Hrubis wrote:
> Hi!
>> Several test cases call waitpid() and then verify the returned
>> value and errno set. Moved this code into a function.
> 
> One thing I do not like about this that this will report the file and
> line from the waitpid_common.h in the test output rather than the
> respective line where the check has failed.
> 
> We could decleare these as a macros that call the function with __FILE__
> and __LINE__ and call the tst_res_() with these instead. But I'm not
> sure that this is worth the added complexity...
> 

So you mean something like the attached function. Right?

With this code a failure will be presented as:

[stas@kholmanskikh waitpid]$ ./waitpid07
tst_test.c:756: INFO: Timeout per run is 0h 05m 00s
waitpid07.c:51: FAIL: waitpid() returned 0, expected 666

whereas with the original code:

[stas@kholmanskikh waitpid]$ ./waitpid07
tst_test.c:756: INFO: Timeout per run is 0h 05m 00s
waitpid_common.h:97: FAIL: waitpid() returned 0, expected 666

I.e. in the former case a user will be given the function which failed
and will need to go to its code to find the corresponding tst_res(TFAIL)
call, whereas with the original code he/she will be given the
tst_res(TFAIL) call, but will need to manually find a corresponding
function call in the test case sources. Yes, the former case is more
user friendly, but, to be honest, I don't think it's worth the added
complexity.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: waitpid_ret_test.c
Type: text/x-csrc
Size: 752 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160818/02c61051/attachment.c>
