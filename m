From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 10 Apr 2020 11:02:24 +0800
Subject: [LTP] Add new test for pipe2 with/without O_NONBLOCK mode
In-Reply-To: <20200409211255.1357-1-laniel_francis@privacyrequired.com>
References: <67fdc846a8cd8616c9eb13cf89463b9d637e6849>
 <20200409211255.1357-1-laniel_francis@privacyrequired.com>
Message-ID: <7c9e27de-aaff-98ea-4e00-2c242f7a0cc3@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Laniel


> Hi.
> 
> 
> I added a new test file (pipe2_03.c) to test pipe2 system call with and without
> O_NONBLOCK enabled.
> This test uses the macro SAFE_PIPE2 that I added, this macro is just the
> equivalent of SAFE_PIPE for pipe2.
> 
> I do not know if it is correct to do that but at the end of the test function we
> need to set the pipe in the same state as it was at the end of setup function:
> 1. Set the O_NONBLOCK flag to the pipe.
> 2. Read the pipe to empty it.
As my previous mail said, fill up the pipe in setup, so we don't need to 
read the pipe. we only need to set the non_block flag when using -i 
parameter.

I modify your patch and merged into my ltp own fork.
see 
https://github.com/xuyang0410/ltp/commits/Laniel_francis_pipe2_03_v3.fixes

ps: I will convert pipe2_01/02.c into new libray and use SAFE_PIPE2 macro.

Best Regards
Yang Xu
> 3. We do not set its size to default because we do not care of it.
> If we do not do that, there will be problem when this test is run multiple time
> (this problem was found when running ./pipe2_03 -i 10).
> 
> The diff --stat output is the following:
>   include/old/safe_macros.h                  |   3 +++
>   include/tst_safe_macros.h                  |   6 ++++++
>   lib/safe_macros.c                          |  15 ++++++++++++++
>   runtest/syscalls                           |   1 +
>   testcases/kernel/syscalls/pipe2/.gitignore |   1 +
>   testcases/kernel/syscalls/pipe2/pipe2_03.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 161 insertions(+)
> 
> 
> Best regards.
> 
> 
> 


