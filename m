From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 23 Mar 2020 14:42:01 +0530
Subject: [LTP] Query: Supporting time64 syscalls
Message-ID: <CAKohpokaPiyGFkAXgG2oy_f5UGMCtsVUUAf4vA3Npa2ixAbNig@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi guys,

I was looking to start working on the time64 syscalls
(like clock_gettime64, timerfd_settime64, etc) and
was looking for your suggestions on how to proceed on
the same.

AFAIU, the only difference is that the argument is 64 bit now
instead of 32 bit and so I don't think I should be adding new
tests but reusing the existing ones for both 32 bit and 64 bit
variants.

Thanks.

--
viresh
