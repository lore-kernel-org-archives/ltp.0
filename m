From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 31 Oct 2019 05:45:10 -0400 (EDT)
Subject: [LTP] LTP: accept02: BROK: accept02.c:52: setsockopt(6, 0, 42,
 0xffff9c56df78, 136) failed: ENODEV (19)
In-Reply-To: <CA+G9fYvOrBPW-8pEDayhNaT1J6g1c4z-_zO3V+G1K5xAMb-T3w@mail.gmail.com>
References: <CA+G9fYv+-dz11fSjMNt8SHaAhRpu1F=8MF7ieS4ZASAwDzH7Eg@mail.gmail.com>
 <1277217234.9839643.1572476520526.JavaMail.zimbra@redhat.com>
 <CA+G9fYvOrBPW-8pEDayhNaT1J6g1c4z-_zO3V+G1K5xAMb-T3w@mail.gmail.com>
Message-ID: <2064120052.9903608.1572515110815.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi Jan,
> 
> On Thu, 31 Oct 2019 at 04:32, Jan Stancek <jstancek@redhat.com> wrote:
> >
> >
> >
> > ----- Original Message -----
> > > LTP syscall accept02 test failed intermittently on hikey arm64 device,
> > > qemu_x86_64 and qemu_i386.
> > >
> > > Do you see this intermittent failure at your end ?
> >
> > I'm not. What does the network look like on these systems?
> > Is there a default route? Is 224.0.0.0 reachable?
> >
> > Can you check with?
> >
> > # ip route
> > # ip route get 224.0.0.0
> 
> on qemu_x86_64,
> 
> + ip route
> + ip route get 224.0.0.0
> RTNETLINK answers: Network is unreachable

That looks like one plausible explanation. I get same failure when I drop default gw:

# uname -r
5.4.0-rc5

# ./accept02 
tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
tst_buffers.c:55: INFO: Test is using guarded buffers
accept02.c:127: INFO: Starting listener on port: 41919
accept02.c:71: PASS: Multicast group was not copied: EADDRNOTAVAIL (99)

# ip r del default via ...
# ./accept02 
tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
tst_buffers.c:55: INFO: Test is using guarded buffers
accept02.c:127: INFO: Starting listener on port: 36517
safe_net.c:186: BROK: accept02.c:52: setsockopt(3, 0, 42, 0x7f1d25aebf78, 136) failed: ENODEV (19)

Not sure why that would be intermittent though. Is it possible
that you sometimes start tests before network is up?

> 
> 
> on hickey device,
> + ip route
> default via 10.66.16.1 dev eth0 proto dhcp metric 100
> 10.66.16.0/23 dev eth0 proto kernel scope link src 10.66.16.28 metric 100
> + ip route get 224.0.0.0
> multicast 224.0.0.0 dev eth0 src 10.66.16.28 uid 0
> cache <mc>
> 
> Link,
> https://lkft.validation.linaro.org/scheduler/job/987925#L609
> 
> - Naresh
> 

