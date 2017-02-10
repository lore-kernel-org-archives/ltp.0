From: Li Wang <liwang@redhat.com>
Date: Fri, 10 Feb 2017 10:53:04 +0800
Subject: [LTP] madvise07.c:72: FAIL: Did not receive SIGBUS
Message-ID: <CAEemH2ddpwBet_2crzv+sOJ9P84fscFH1re4SCo1dD_PKGgsgA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I'm trying to run ltp on upstream kernel-4.10.0-rc7, and found that
madvise07 always failing with no SIGBUS received when mmap the PRIVATE
memory. I hope to know if there're some relevant stuff about this
issue.
Any discussion or document for that?


# uname -r
4.10.0-rc7

# ./madvise07
tst_test.c:794: INFO: Timeout per run is 0h 05m 00s
madvise07.c:57: INFO: madvise(0x7f25bdd7e000, 4096, MADV_HWPOISON)
madvise07.c:72: FAIL: Did not receive SIGBUS after accessing
MAP_PRIVATE memory marked with MADV_HWPOISON
madvise07.c:57: INFO: madvise(0x7f25bdd7e000, 4096, MADV_HWPOISON)
madvise07.c:90: PASS: madvise(..., MADV_HWPOISON) on MAP_SHARED memory


-- 
Regards,
Li Wang
Email: liwang@redhat.com
