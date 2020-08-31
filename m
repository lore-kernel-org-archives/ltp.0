From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 31 Aug 2020 16:44:55 +0530
Subject: [LTP] [PATCH V9 1/2] syscalls/semtimedop: Add support for
 semtimedop and its time64 version
In-Reply-To: <b0d7642a89808c93e059beda06d8519361784686.1597839878.git.viresh.kumar@linaro.org>
References: <20200807132700.GB9851@yuki.lan>
 <b0d7642a89808c93e059beda06d8519361784686.1597839878.git.viresh.kumar@linaro.org>
Message-ID: <20200831111455.mdqzddghovvv2mvq@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 19-08-20, 17:57, Viresh Kumar wrote:
> This adds support for semtimedop() and its time64 variant to the
> existing semop() syscall tests.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V9:
> - Removed vDSO from comment
> - Add additional failure tests for EGAIN errors
> - Moved timeout configuration change to setup()
> - Test added for NULL timeout

Ping.

-- 
viresh
