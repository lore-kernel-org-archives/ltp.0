From: Petr Vorel <petr.vorel@gmail.com>
Date: Wed, 5 Dec 2018 21:28:51 +0100
Subject: [LTP] [PATCH] cgroup_regression_test.sh: fixed test_5
In-Reply-To: <19f406bd-3fa4-2922-cb27-ea520caec886@arm.com>
References: <20181121134021.52225-1-cristian.marussi@arm.com>
 <20181205181640.GA11567@x230>
 <19f406bd-3fa4-2922-cb27-ea520caec886@arm.com>
Message-ID: <20181205202850.GC16603@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cristian,

> > + as with many tests, this tests needs rewrite into new API and cleanup.

> I'd fix this test_5 at it is, and then port the whole test to the new API with a
> new patch if it is fine for you. (also I have to look fully into the new API at
> first , I'm brand new of LTP...)
Great. Feel free to ask for help, if you need it (mailing list or irc).

Some docs
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell
+ have look in existing code, which uses tst_test.sh.

Kind regards,
Petr
