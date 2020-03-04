From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 4 Mar 2020 13:15:02 +0530
Subject: [LTP] Query: Adding support for clone3()
In-Reply-To: <20200228114801.GA8324@rei>
References: <CAKohponuu3zpsQCv0v1_Yqb_tmqy5yyUejMoS1_M_UFf5FU2Mw@mail.gmail.com>
 <20200228085859.GA31181@rei>
 <20200228102432.3kdhl4aqkla4akss@vireshk-i7>
 <20200228114801.GA8324@rei>
Message-ID: <20200304074502.i5zpf5q4gxcz2vz5@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 28-02-20, 12:48, Cyril Hrubis wrote:
> That depends I guess mostly on the clone() flags, right? Unless we pass
> CLONE_VM the child lives in a separate copy of the memory space and we
> do not have to do anything about the stack.
> 
> So for the most clone3() tests we can just need the struct clone_args
> and the syscall number and we can treat it mostly like more complex
> version of fork(), i.e. pass NULL and 0 for the stack and stack_size
> parameters.
> 
> So I would start by adding the kernel version of the clone3() syscall,
> the structure, and the V0 structure size into the lapi header and use
> that for a basic testcases.

Okay, so you are suggesting here to create a separate
testcases/kernel/syscalls/clone3 directory for the tests ? That makes
sense as a user may want to test both clone and clone3 on a platform
for a given kernel version.

-- 
viresh
