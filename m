From: Eddie Horng <eddiehorng.tw@gmail.com>
Date: Fri, 10 Aug 2018 17:32:55 +0800
Subject: [LTP] [PATCH v2] syscalls/execveat01: new test to verify
 execveat unlinked fd
In-Reply-To: <20180809090406.GA29365@rei>
References: <1533111474.1176.4.camel@mtkswgap22> <20180809090406.GA29365@rei>
Message-ID: <CALLuPvqBStiMEvY1rxSKYnF0L01ww2dB-gjGN93CXgeTm+f7ow@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

2018-08-09 17:04 GMT+08:00 Cyril Hrubis <chrubis@suse.cz>:
> Hi!
> Pushed with minor changes, thanks.
>
> * Added check for execveat() support to the test setup and dropped the
>   minimal kernel version from test structure
>
> * Renamed the test to execveat03 so that we can add execveat01 and
>   execveat02 that would test the cases without overlay being involved
>
> * Removed SAFE_WAITPID() from the verify_execveat() since the child
>   has to be waited for in the test library so that errors are propagated
>   correctly
>
> * Moved the execveat.h to the include/lapi/ directory
>
> * Added syscalls/runtest entry so that the test is executed during the
>   tesrun
>

Hi Cyril, Li,
Thanks your modifications and all the suggestions, reviews on this testcase.

Eddie
