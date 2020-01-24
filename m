From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 24 Jan 2020 13:18:05 +0530
Subject: [LTP] [PATCH 1/2] Add Syscall numbers for io_pgetevents
In-Reply-To: <f9e9bc067d1153199440512d6ece01f7a001b660.1579755655.git.viresh.kumar@linaro.org>
References: <f9e9bc067d1153199440512d6ece01f7a001b660.1579755655.git.viresh.kumar@linaro.org>
Message-ID: <20200124074805.b2gk4jcu3jrvrczd@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril,

On 23-01-20, 10:31, Viresh Kumar wrote:
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/lapi/syscalls/aarch64.in   | 1 +
>  include/lapi/syscalls/arm.in       | 1 +
>  include/lapi/syscalls/hppa.in      | 1 +
>  include/lapi/syscalls/i386.in      | 1 +
>  include/lapi/syscalls/ia64.in      | 1 +
>  include/lapi/syscalls/powerpc.in   | 1 +
>  include/lapi/syscalls/powerpc64.in | 1 +
>  include/lapi/syscalls/s390.in      | 1 +
>  include/lapi/syscalls/s390x.in     | 1 +
>  include/lapi/syscalls/sparc.in     | 1 +
>  include/lapi/syscalls/sparc64.in   | 1 +
>  include/lapi/syscalls/x86_64.in    | 1 +
>  12 files changed, 12 insertions(+)

Is it fine to send patches like this separately from the patches which
actually add the tests? Will you merge them alone as well?

Asking as I would be required to resend these patches (which just add
syscall number) along with the real tests, while they may never get
modified. I can then send such patches for future syscalls I am
working on.

-- 
viresh
