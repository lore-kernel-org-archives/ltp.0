From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 Sep 2021 15:14:54 +0200
Subject: [LTP] LTP: smoketest: route4-change-dst fails intermittently
In-Reply-To: <cab131c0-877e-4781-6d0e-07a6e528b329@bell-sw.com>
References: <CA+G9fYtJYK4C4q7v2VBgyHe1EdOeZ=auEytoKJr0gYThj8gS5w@mail.gmail.com>
 <cab131c0-877e-4781-6d0e-07a6e528b329@bell-sw.com>
Message-ID: <YT9OziyltlUo+Vnb@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On 03.09.2021 09:33, Naresh Kamboju wrote:
> > LTP smoketest  "route4-change-dst" fails intermittently on various
> > devices and qemu.
> > We do not want any intermittent failures on LTP smoketest.
> > Shall i send a patch to delete this test case from runtest/smoketest ?


> route4-change-dst is a stress test, perhaps replacing it with more
> simple like ping01.sh or ping02.sh that still triggers LTP/tst_net
> library check?
I overlooked your suggestion. OK, I'll merge replacing route4-change-dst with
ping02.sh -6.

> BTW, such tests may overlap with existed network setup on a test
> machine, by default they are using 10.0.0.0/24. Changing defaults
> is done via IPV4_LHOST and IPV4_RHOST environment variables.
I wonder if using IPV4_NET16_UNUSED and IPV6_NET32_UNUSED would help. Unless we
create a detection of whether they're actually unused (not sure even how to
implement nmap like search which would be fast enough) there still can be a
collision. But at least the addresses ranges in *UNUSED are less common.

Kind regards,
Petr
