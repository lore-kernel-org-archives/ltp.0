From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Aug 2016 16:34:53 +0200
Subject: [LTP] [PATCH] fcntl.2: F_OFD_XXX needs flock64
In-Reply-To: <20160816115506.GA25201@rei.lan>
References: <20160816115506.GA25201@rei.lan>
Message-ID: <20160816143453.GA26323@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If we pass struct flock to the F_OFD_XXX fcntl() it will fail with
> EINVAL with a 32bit binary. That is because glibc uses fcntl64() by
> default but the struct flock uses 32bit off_t for 32bit binaries (unless
> _FILE_OFFSET_BITS=64) and kernel always expect flock64 for F_OFD_XXX in
> fcntl64(). Hence kernel will read some garbage that is a few bytes after
> the 32bit flock structure in this case which will likely end up with the
> syscall returning EINVAL.

Here is also a commit that fixes the corresponding LTP testcase:

https://github.com/linux-test-project/ltp/commit/ae09800dfed8630f67796501bef3a88bb4fd3daa

Before this the fcntl34 test was failing on 32bit platform or with
CFLAGS=-m32 LDFLAGS=-m32 passed to configure.



Before:

testcases/kernel/syscalls/fcntl $./fcntl34
tst_test.c:756: INFO: Timeout per run is 0h 05m 00s
fcntl34.c:104: INFO: write to a file inside threads with OFD locks
fcntl34.c:48: INFO: spawning '12' threads
fcntl34.c:79: BROK: fcntl() failed: EINVAL

Summary:
passed   0
failed   0
skipped  0
warnings 0


After:

testcases/kernel/syscalls/fcntl $./fcntl34
tst_test.c:756: INFO: Timeout per run is 0h 05m 00s
fcntl34.c:104: INFO: write to a file inside threads with OFD locks
fcntl34.c:48: INFO: spawning '12' threads
fcntl34.c:57: INFO: waiting for '12' threads
fcntl34.c:113: INFO: verifying file's data
fcntl34.c:141: PASS: OFD locks synchronized access between threads

Summary:
passed   1
failed   0
skipped  0
warnings 0


-- 
Cyril Hrubis
chrubis@suse.cz
