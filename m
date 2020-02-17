From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 17 Feb 2020 13:38:38 +0530
Subject: [LTP] [PATCH 1/7] lapi/fsmount: Add definitions for fsmount
 related syscalls
In-Reply-To: <CAEemH2eju4-Gv8P_H8teuo3qDYbFmfKL6EZbWQfw6xLHqWa5Xg@mail.gmail.com>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
 <98f8a5780f679b90f53fdded8b1b8821d7eb1ce9.1581680021.git.viresh.kumar@linaro.org>
 <CAEemH2eju4-Gv8P_H8teuo3qDYbFmfKL6EZbWQfw6xLHqWa5Xg@mail.gmail.com>
Message-ID: <20200217080838.btmgydxdgv4tu66c@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 16-02-20, 17:09, Li Wang wrote:
> Hi Viresh,
> 
> Thank you for creating new tests for LTP.
> 
> Unfortunately, this 1/7 patch has overlap with zlang@'s patch[1]. It
> probably can not be merged if the patch[1] applies first. But the remaining
> part is valuable to LTP, you can drop some of this and rebase your code to
> make use of the header file again.

Thanks for pointing that out Li. I will rebase over zlang's patch once it gets
merged.

-- 
viresh
