From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 11 May 2020 16:53:54 +0530
Subject: [LTP] [PATCH V2 15/17] syscalls/semtimedop: Add support for
 semtimedop and its time64 version
In-Reply-To: <CAK8P3a3VrcpdmGZB_VOLk17uDMxAfYyfM57yUUUSuqEdKvROOQ@mail.gmail.com>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
 <8a675726b6e553e740016390c774bce19efc5a12.1588911607.git.viresh.kumar@linaro.org>
 <CAK8P3a1x+uK_WgVn9O8LVcLoZH=oJ_jQcePwcwzqpyhewApX9w@mail.gmail.com>
 <20200511064929.pa4lydt2vfryl7ve@vireshk-i7>
 <CAK8P3a2y+8kv0Wa4iiU+vGeNTudmx3aJJQ87zfi9WyfWKJ7WYg@mail.gmail.com>
 <20200511073315.gws5lhw6tsaaijpi@vireshk-i7>
 <CAK8P3a3VrcpdmGZB_VOLk17uDMxAfYyfM57yUUUSuqEdKvROOQ@mail.gmail.com>
Message-ID: <20200511112354.3u5r6vmu74knpst6@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11-05-20, 09:58, Arnd Bergmann wrote:
> We should still check that five variants of it (sys_semop,
> sys_semtimedop, sys_semtimedop64, ipc(SEMTIMEDOP) and ipc(SEMOP))
> correctly implement the semop semantics

How do you suggest I add tests for ipc() types? Should they be always
tested? Or they should be tested only if the normal sys_* variant
isn't implemented by the kernel/arch ?

-- 
viresh
