From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 14 Sep 2021 17:45:30 +0530
Subject: [LTP] LTP: smoketest: route4-change-dst fails intermittently
In-Reply-To: <YUA4tLquwA3XRKfW@pevik>
References: <CA+G9fYtJYK4C4q7v2VBgyHe1EdOeZ=auEytoKJr0gYThj8gS5w@mail.gmail.com>
 <YUA4tLquwA3XRKfW@pevik>
Message-ID: <CA+G9fYtLzhDG+kz-4yigaV_Pxu2UvSa-azXNtzrbr5qv-MZZjw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 14 Sept 2021 at 11:22, Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Naresh, Alexey,
>
> > LTP smoketest  "route4-change-dst" fails intermittently on various
> > devices and qemu.
> > We do not want any intermittent failures on LTP smoketest.
> > Shall i send a patch to delete this test case from runtest/smoketest ?
>
> > - Naresh
>
> After Alexey merges DAD related fix [1] we can keep route test right?

No.
We will delete " route4-change-dst".

> Do we want to add ping02.sh -6 or replace route with test with ping02.sh?
Yes. I replace it with
ping02.sh -6

- Naresh

>
> Kind regards,
> Petr
>
> [1] https://patchwork.ozlabs.org/project/ltp/patch/20210913123935.10761-2-aleksei.kodanev@bell-sw.com/
