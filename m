From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 30 Oct 2019 19:02:00 -0400 (EDT)
Subject: [LTP] LTP: accept02: BROK: accept02.c:52: setsockopt(6, 0, 42,
 0xffff9c56df78, 136) failed: ENODEV (19)
In-Reply-To: <CA+G9fYv+-dz11fSjMNt8SHaAhRpu1F=8MF7ieS4ZASAwDzH7Eg@mail.gmail.com>
References: <CA+G9fYv+-dz11fSjMNt8SHaAhRpu1F=8MF7ieS4ZASAwDzH7Eg@mail.gmail.com>
Message-ID: <1277217234.9839643.1572476520526.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> LTP syscall accept02 test failed intermittently on hikey arm64 device,
> qemu_x86_64 and qemu_i386.
> 
> Do you see this intermittent failure at your end ?

I'm not. What does the network look like on these systems?
Is there a default route? Is 224.0.0.0 reachable?

Can you check with?

# ip route 
# ip route get 224.0.0.0

> 
> hikey arm64 output log,
> 
> tst_test.c:1118: INFO: Timeout per run is 0h 15m 00s
> tst_buffers.c:55: INFO: Test is using guarded buffers
> accept02.c:127: INFO: Starting listener on port: 35903
> safe_net.c:186: BROK: accept02.c:52: setsockopt(6, 0, 42,
> 0xffff9c56df78, 136) failed: ENODEV (19)
> 
> qemu_x86_64 output log,
> 
> tst_test.c:1118: INFO: Timeout per run is 0h 15m 00s
> tst_buffers.c:55: INFO: Test is using guarded buffers
> accept02.c:127: INFO: Starting listener on port: 47245
> safe_net.c:186: BROK: accept02.c:52: setsockopt(6, 0, 42,
> 0x7f5397ca3f78, 136) failed: ENODEV (19)
> 
> Test results comparison,
> https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-tests/accept02
> 
> Full test log,
> https://lkft.validation.linaro.org/scheduler/job/976363
> https://lkft.validation.linaro.org/scheduler/job/977681
> 
> Best regards
> Naresh Kamboju
> 

