From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Aug 2016 12:42:45 +0200
Subject: [LTP] [PATCH 3/8] syscalls/waitpid: implement waitpid_ret_test()
In-Reply-To: <57B585E7.9020000@oracle.com>
References: <1470818466-28109-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160815152739.GG20680@rei.lan> <57B585E7.9020000@oracle.com>
Message-ID: <20160818104245.GA24254@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> So you mean something like the attached function. Right?

Yes.

> With this code a failure will be presented as:
> 
> [stas@kholmanskikh waitpid]$ ./waitpid07
> tst_test.c:756: INFO: Timeout per run is 0h 05m 00s
> waitpid07.c:51: FAIL: waitpid() returned 0, expected 666
> 
> whereas with the original code:
> 
> [stas@kholmanskikh waitpid]$ ./waitpid07
> tst_test.c:756: INFO: Timeout per run is 0h 05m 00s
> waitpid_common.h:97: FAIL: waitpid() returned 0, expected 666
> 
> I.e. in the former case a user will be given the function which failed
> and will need to go to its code to find the corresponding tst_res(TFAIL)
> call, whereas with the original code he/she will be given the
> tst_res(TFAIL) call, but will need to manually find a corresponding
> function call in the test case sources. Yes, the former case is more
> user friendly, but, to be honest, I don't think it's worth the added
> complexity.

The whole motivation for printing the file and line in the
tst_res()/tst_brk() was to make it easier to analyse failures from test
logs. I.e. somebody posts test failure logs on the ML and you can see
what failed and where just by looking at the logs.

Sure you can add a few more test prints, recompile and run the test and
see what went wrong. But once you have to ask somebody at the other end
to do that and run it on a specific hardware or wait for other tests to
finish on a shared machine just to rerun the test, things get more
complicated.

So I would really want to keep the file and line tied closely to the
place in the source where the failure occured.

Here it could be done either by:

* Passing the file and line as in the snippet you send in this email
  - here we pay a price by making the code more complex

* Implementing the whole check as a macro
  - ugly but does the job

* Keeping the checks in the source code
  - we repeat the same pattern of code over and over there

None of these is really good solution to the problem unfortunately.



There may be a better solution, and I'm thinking of that one for quite
some time. We may be as well able to generate the tests from templates
which is something I would like to explore in the long term. But that
approach has another set of problems on it's own.

-- 
Cyril Hrubis
chrubis@suse.cz
