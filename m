From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri, 3 Sep 2021 11:17:25 +0300
Subject: [LTP] LTP: smoketest: route4-change-dst fails intermittently
In-Reply-To: <CA+G9fYtJYK4C4q7v2VBgyHe1EdOeZ=auEytoKJr0gYThj8gS5w@mail.gmail.com>
References: <CA+G9fYtJYK4C4q7v2VBgyHe1EdOeZ=auEytoKJr0gYThj8gS5w@mail.gmail.com>
Message-ID: <cab131c0-877e-4781-6d0e-07a6e528b329@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03.09.2021 09:33, Naresh Kamboju wrote:
> LTP smoketest  "route4-change-dst" fails intermittently on various
> devices and qemu.
> We do not want any intermittent failures on LTP smoketest.
> Shall i send a patch to delete this test case from runtest/smoketest ?
> 

route4-change-dst is a stress test, perhaps replacing it with more
simple like ping01.sh or ping02.sh that still triggers LTP/tst_net
library check?

BTW, such tests may overlap with existed network setup on a test
machine, by default they are using 10.0.0.0/24. Changing defaults
is done via IPV4_LHOST and IPV4_RHOST environment variables.
