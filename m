From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 28 Apr 2021 15:56:02 +0200
Subject: [LTP] [PATCH] syscalls/setfsgid02: Bugfix for running as root
In-Reply-To: <20210428124939.23546-1-zhaogongyi@huawei.com>
References: <20210428124939.23546-1-zhaogongyi@huawei.com>
Message-ID: <YIlpcvO2UdSBxdXI@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When we run the test as root id, and with the option "-i 2",
> test will fail.

Looking at the test there is much more to fix.

- the description does not match what the test is doing
- the pass/fail condition and TFAIL message does not make any sense

And its the same for the rest of the setfsgid tests.

Looking at the manual pages for this oddball syscall we should check if:

- unpriviledged process cannot change the value i.e. value that is
  different from return from ret=setfsgid(-1) is passed as
  setfsgid(ret+1) followed by setfsgid(-1) and all of these returns the
  same value and the value also matches process effective group ID

- priviledged process can change the value i.e. the same as
  unpriviledged but we expect the last setfsgid(-1) return
  the new value. We either have to reset the setfsgid() at the end of
  the test or run it in a fork()-ed process so that we start with a
  clean plate for each iteration

-- 
Cyril Hrubis
chrubis@suse.cz
