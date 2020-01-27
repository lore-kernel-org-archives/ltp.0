From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 27 Jan 2020 14:15:24 +0530
Subject: [LTP] [PATCH V4 2/2] syscalls/pidfd_open
In-Reply-To: <169e5dfcac201330511347e38a25f373fc698c92.1580114160.git.viresh.kumar@linaro.org>
References: <007f89609cfe05cc4f7f0f310f05fc4bb0be829d.1580114160.git.viresh.kumar@linaro.org>
 <169e5dfcac201330511347e38a25f373fc698c92.1580114160.git.viresh.kumar@linaro.org>
Message-ID: <20200127084524.xrrxivkw76zcmlsy@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 27-01-20, 14:07, Viresh Kumar wrote:
> Add tests to check working of pidfd_open() syscall.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3->V4:
> - Dropped duplicate headers
> - Dropped local variable "fd" and used TST_RET directly.
> - Handle failure tests with global variable
> - Remove else part after creating child process
> - Improved print messages

Cyril,

I did send this email with

--in-reply-to="8dc3dff0390db58b2f472501c30595647a913e34.1579858930.git.viresh.kumar@linaro.org"

so it appear in earlier thread. But git didn't work the way I expected
and so it shows this as a new thread now.

I created two patches (so this patch's header already had -in-reply-to
set to the 1st patch), and sent only the second with with explicit
--in-reply-to field, which in my expectations should have overridden
the setting that were their in patch's header but it didn't :(

Sorry about that. I am not re-sending it for now to avoid unnecessary
traffic.

-- 
viresh
