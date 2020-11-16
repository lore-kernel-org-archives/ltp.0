From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 16 Nov 2020 20:42:12 +0100
Subject: [LTP] [PATCH 0/3] Convert network stress tests to tst_net.sh
In-Reply-To: <20201116124611.16919-1-lkml@jv-coder.de>
References: <20201116124611.16919-1-lkml@jv-coder.de>
Message-ID: <20201116194212.GB181383@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> Hi,

> this patch series converts (all?) remeianing tests in network/stress to
> use tst_net.sh
Please see my comments in first patch, they apply to second one and mostly to
third one as well (it should use route-lib.sh).

Ad all: I've never reposted fixed version for route{4,6}-rmmod [1] (needs a cleanup)
I'll do it soon.

Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2017-July/005079.html
