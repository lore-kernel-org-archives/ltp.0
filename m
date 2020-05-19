From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 19 May 2020 15:12:01 +0530
Subject: [LTP] [PATCH V3 00/17] Syscalls: Add support for time64 variants
In-Reply-To: <CAK8P3a3_dGzoGPckBByySvLYGC3FyiCSwCdfzxG8xjJsY0oXrg@mail.gmail.com>
References: <cover.1589789487.git.viresh.kumar@linaro.org>
 <CAK8P3a3aP5S_w_FFv=UvJRSRTjcoNVy_W6ycm4OTct-7Q_5_xg@mail.gmail.com>
 <20200518091253.qmvqo7xub7hpeovm@vireshk-i7>
 <CAK8P3a3_dGzoGPckBByySvLYGC3FyiCSwCdfzxG8xjJsY0oXrg@mail.gmail.com>
Message-ID: <20200519094201.llskyyq2jbx7onai@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 18-05-20, 11:21, Arnd Bergmann wrote:
> For msgctl/semctl/shmctl, the existing syscalls were extended in a
> compatible way, using an extended 'high' field for each 32-bit
> seconds value. I later learned that on some architectures, the
> 'compat' version of that failed to zero-initialize those fields, so I
> guess all we need is a test that ensures this was fixed correctly,
> by initializing the '*_high' to something nonzero before calling
> the syscall, and checking that it gets zero-filled by the syscall.

Okay, I see the new structure (struct semid64_ds) getting added to the
kernel. But I am not sure how to call the 'compat' version, can you
please help ?

Do I just need to call like this ?

	struct semid64_ds buf_ds = {
                .sem_otime_high = 1,
                .sem_ctime_high = 1
        };
	union semun arg;

	arg.buf = &buf_ds;
	semctl(semid, 0, IPC_STAT, arg);

?
-- 
viresh
