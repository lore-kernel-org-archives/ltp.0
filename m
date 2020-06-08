From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 8 Jun 2020 23:29:24 +0530
Subject: [LTP] [PATCH] clock_gettime03: Fix issues with negative offset
In-Reply-To: <8b9a7e8ea27894090f1e31e178d7328f118163d0.1591270889.git.viresh.kumar@linaro.org>
References: <8b9a7e8ea27894090f1e31e178d7328f118163d0.1591270889.git.viresh.kumar@linaro.org>
Message-ID: <CA+G9fYuHsezzit3pzHiz-6ad4AfbgRsdbuqfUKvLif7_Jk5WkA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 4 Jun 2020 at 17:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The tests takes difference between two time readings and check it
> against the offset set by the test. When the offset is set to a positive
> value (eg 10000 ms), then the diff comes to a value >= 10000 ms (eg
> 10001 ms), and with divided by 1000, both sides evaluate to 10.
>
> But when the offset is set to -10000 ms, then the delta is >= -10000 ms
> (eg -9999) ms. And when divided by 1000, it comes to -9 != -10 and the
> test reports error. Over that we are comparing value in seconds, which
> is too large of a value. Change the test to compare delta in ms and fix
> the false failures.

Test ran for 100 iterations on x86 device and confirmed test getting pass.

>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Tested-by:  Naresh Kamboju <naresh.kamboju@linaro.org>

ref:
https://bugs.linaro.org/show_bug.cgi?id=5640
- Naresh
