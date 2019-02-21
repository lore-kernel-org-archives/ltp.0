From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Thu, 21 Feb 2019 17:19:51 -0300
Subject: [LTP] [PATCH 2/2] syscalls/clock_adjtime: create clock_adjtime
 syscall tests
In-Reply-To: <20190221200547.7277-2-rafael.tinoco@linaro.org>
References: <20190221200547.7277-1-rafael.tinoco@linaro.org>
 <20190221200547.7277-2-rafael.tinoco@linaro.org>
Message-ID: <DFA608DE-FDCA-424E-86B7-77B8AB31B0E1@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On 21 Feb 2019, at 17:05, Rafael David Tinoco <rafael.tinoco@linaro.org> wrote:
> 
> Fixes: 270
> 
> clock_adjtime{01,02} are created using the new API, based on existing
> adjtimex(2) tests. clock_adjtime() syscall might have as execution
> path:
> 
>  1) a regular POSIX clock (only REALTIME clock implements adjtime())
>  	- will behave exactly like adjtimex() system call.
>  	- only one being tested here.
> 
>  2) a dynamic POSIX clock (which ops are implemented by PTP clocks)
>  	- will trigger the PTP clock driver function "adjtime()"
>  	- different implementations from one PTP clock to another
>  	- might return EOPNOTSUPP (like ptp_kvm_caps, for example)
>  	- no observed execution entry point for clock_adjtime()
> 
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>

Sorry, forgot to checkpatch before sending. Doing it now and submitting patchset as v2.

Thank you!

-Rafael

