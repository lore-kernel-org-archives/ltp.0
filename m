From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Sun, 4 Nov 2018 21:45:35 -0200
Subject: [LTP] [PATCH] syscalls/fremovexattr: Add fremovexattr() tests
In-Reply-To: <20181101220517.19785-1-rafael.tinoco@linaro.org>
References: <20181101220517.19785-1-rafael.tinoco@linaro.org>
Message-ID: <CABdQkv_WgpXPyeNzKRBhkgRg4vMPU7oRCgC1i=tv_TSEkg7buw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 1, 2018 at 7:05 PM, Rafael David Tinoco
<rafael.tinoco@linaro.org> wrote:
> Fixes: #276
>
> Following the same logic and tests used to test removexattr() syscall,
> this commit implements tests for fremovexattr(). It only differs from
> removexattr() on the given arguments: using a file descriptor instead of
> the filename.
>
> Kernel has different entry points for both, with slightly different
> execution paths, mainly related to dealing with the passed file
> descriptor.
>
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>

Sorry, Ignore this one please, sending out a v2 with a small fix PLUS
lremovexattr() test as well, both Fixing: #276. Thanks!
