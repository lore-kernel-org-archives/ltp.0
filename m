From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 11 May 2020 11:14:02 +0530
Subject: [LTP] [PATCH V2 15/17] syscalls/semtimedop: Add support for
 semtimedop and its time64 version
In-Reply-To: <CAK8P3a0PCX_KzKLVD7ZT10xxpOXapUh8o5hhE5OOzyPjxf=GAw@mail.gmail.com>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
 <8a675726b6e553e740016390c774bce19efc5a12.1588911607.git.viresh.kumar@linaro.org>
 <CAK8P3a1x+uK_WgVn9O8LVcLoZH=oJ_jQcePwcwzqpyhewApX9w@mail.gmail.com>
 <20200508085657.ousiwqakcq7zegpo@vireshk-i7>
 <CAK8P3a0PCX_KzKLVD7ZT10xxpOXapUh8o5hhE5OOzyPjxf=GAw@mail.gmail.com>
Message-ID: <20200511054402.fhldrqkaasvv3n7r@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08-05-20, 11:24, Arnd Bergmann wrote:
> __NR_semtimedop can only be called with the 'old' timespec, which
> may have either 32 or 64 members depending on the architecture.
> On x32 it uses 64-bit members, and on riscv32 it does not exist at all.
> 
> I think you already have a correct __kernel_old_timespec definition,
> so what I'd expect to see here is code that passes __kernel_old_timespec
> into __NR_semtimedop whenever __NR_semtimedop is defined.

Ahh, so on ARM64 and x86_64, fields will be 8 bytes long even with the old
timespec. I missed that and so the confusion.

-- 
viresh
