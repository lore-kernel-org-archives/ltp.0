From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Mar 2020 15:01:23 +0100
Subject: [LTP] [PATCH v2] Add new test cases to syscalls/readv01
In-Reply-To: <20200316103831.10224-1-mdoucha@suse.cz>
References: <20200316103831.10224-1-mdoucha@suse.cz>
Message-ID: <20200316140123.GA26750@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Split the original test scenario into two test cases and add:
> - read into buffers bigger than input file
> - read into multiple buffers
> - read into non-NULL buffer with size = 0 (test for kernel commit 19f18459)
> 
> Also use guarded buffers in all IO vectors. Fixes #382
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> Changes since v1:
> - Code style fixes
> - Use tst_get_bad_addr() in the zero-size lockup test case
> 
> Re: Timeout.
> The last test case may cause infinite loop in some kernels. The entire test
> program should finish in less than a second so waiting 15 minutes to detect
> the possible lockup is a waste of time. 15 seconds is long enough to avoid
> false positives.

I've added the linux-git tag to the testcase and pushed, thanks.

> Re: Guarded buffers/invalid pointers.
> Fixed. Patching the buffer library won't help me here because I'm working
> with IO vectors anyway. Negative size in IO vector definition array currently
> represents end of vector so negative sizes could only be used for single
> buffers. Or the whole IO vector definition semantics in struct tst_test
> would have to be redesigned.

Well, we can as well define -1 to be TST_BUF_END and -2 to be
TST_BUF_BAD and change the code to use these.

-- 
Cyril Hrubis
chrubis@suse.cz
