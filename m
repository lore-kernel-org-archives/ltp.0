From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 14 Sep 2021 18:37:24 +0530
Subject: [LTP] [PATCH 1/2] runtest/smoketest: Remove intermittent failed
 test case route4-change-dst
In-Reply-To: <YUCah4R0SBDKZvPQ@pevik>
References: <20210914122425.85129-1-naresh.kamboju@linaro.org>
 <YUCah4R0SBDKZvPQ@pevik>
Message-ID: <CA+G9fYvY4V=FwDq_uJiRrgPm97cCm9T6Lm-qcr+B1kRhi5BxMg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 14 Sept 2021 at 18:20, Petr Vorel <pvorel@suse.cz> wrote:
>
> > The test case route4-change-dst fails intermittently creating
> > the problem for smoketest results verdict. route4-change-dst
> > is a stress test should not be a part of smoketest. because of
> > these issues removing route4-change-dst from the smoketest.
>
> > Suggested-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> > Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>
> Did 75184c30a ("lib/tst_net.sh: disable ipv6_dad work on test interfaces")
> fixed your problem? I'd actually like to route4-change-dst in smoketest to
> have it as a detection DAD issue is working.

I will add this patch and test in loop.

- Naresh
