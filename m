From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Sep 2021 07:52:52 +0200
Subject: [LTP] LTP: smoketest: route4-change-dst fails intermittently
In-Reply-To: <CA+G9fYtJYK4C4q7v2VBgyHe1EdOeZ=auEytoKJr0gYThj8gS5w@mail.gmail.com>
References: <CA+G9fYtJYK4C4q7v2VBgyHe1EdOeZ=auEytoKJr0gYThj8gS5w@mail.gmail.com>
Message-ID: <YUA4tLquwA3XRKfW@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Naresh, Alexey,

> LTP smoketest  "route4-change-dst" fails intermittently on various
> devices and qemu.
> We do not want any intermittent failures on LTP smoketest.
> Shall i send a patch to delete this test case from runtest/smoketest ?

> - Naresh

After Alexey merges DAD related fix [1] we can keep route test right?
Do we want to add ping02.sh -6 or replace route with test with ping02.sh?

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210913123935.10761-2-aleksei.kodanev@bell-sw.com/
