From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 19 Aug 2020 10:30:03 +0530
Subject: [LTP] [PATCH] syscalls/clone302: drop CLONE_CHILD_SETTID and
 CLONE_PARENT_SETTID
In-Reply-To: <8eefb21d278f0846024a16281c5e19b0e3936979.1596797812.git.jstancek@redhat.com>
References: <8eefb21d278f0846024a16281c5e19b0e3936979.1596797812.git.jstancek@redhat.com>
Message-ID: <20200819050003.bvamzdr4avawzrce@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07-08-20, 12:58, Jan Stancek wrote:
> Per https://lore.kernel.org/linux-m68k/20200627122332.ki2otaiw3v7wndbl@wittgenstein/T/#u
> EFAULT isn't propagated back to userspace so these will always appear
> to succeed. Also issue is that multiple flags are tested together
> and some arguments persisted between calls, because they were set
> only when argument != NULL.
> 
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/clone3/clone302.c | 42 +++++++++++----------
>  1 file changed, 23 insertions(+), 19 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
