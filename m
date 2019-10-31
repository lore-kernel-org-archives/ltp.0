From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 31 Oct 2019 15:01:55 +0530
Subject: [LTP] LTP: accept02: BROK: accept02.c:52: setsockopt(6, 0, 42,
 0xffff9c56df78, 136) failed: ENODEV (19)
In-Reply-To: <1277217234.9839643.1572476520526.JavaMail.zimbra@redhat.com>
References: <CA+G9fYv+-dz11fSjMNt8SHaAhRpu1F=8MF7ieS4ZASAwDzH7Eg@mail.gmail.com>
 <1277217234.9839643.1572476520526.JavaMail.zimbra@redhat.com>
Message-ID: <CA+G9fYvOrBPW-8pEDayhNaT1J6g1c4z-_zO3V+G1K5xAMb-T3w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

On Thu, 31 Oct 2019 at 04:32, Jan Stancek <jstancek@redhat.com> wrote:
>
>
>
> ----- Original Message -----
> > LTP syscall accept02 test failed intermittently on hikey arm64 device,
> > qemu_x86_64 and qemu_i386.
> >
> > Do you see this intermittent failure at your end ?
>
> I'm not. What does the network look like on these systems?
> Is there a default route? Is 224.0.0.0 reachable?
>
> Can you check with?
>
> # ip route
> # ip route get 224.0.0.0

on qemu_x86_64,

+ ip route
+ ip route get 224.0.0.0
RTNETLINK answers: Network is unreachable


on hickey device,
+ ip route
default via 10.66.16.1 dev eth0 proto dhcp metric 100
10.66.16.0/23 dev eth0 proto kernel scope link src 10.66.16.28 metric 100
+ ip route get 224.0.0.0
multicast 224.0.0.0 dev eth0 src 10.66.16.28 uid 0
cache <mc>

Link,
https://lkft.validation.linaro.org/scheduler/job/987925#L609

- Naresh
