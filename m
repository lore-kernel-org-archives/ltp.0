From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Jun 2021 11:32:31 +0200
Subject: [LTP] [PATCH] controllers/cpuset_hotplug: skip unsupported
 Microsoft Hyper-V
In-Reply-To: <20210622145938.106477-1-krzysztof.kozlowski@canonical.com>
References: <20210622145938.106477-1-krzysztof.kozlowski@canonical.com>
Message-ID: <YNL/r6KzNdw6biZp@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Krzysztof,

> Detect the Hyper-V with systemd and if it succeeds, skip the test.
> This of course does not support all possible cases, e.g. running tests
> under Hyper-V without systemd will still fail, but it's a easy way to
> avoid test failure in common configuration.

Yes, we use systemd-detect-virt also in lib/tst_virt.c. We could steal code from
systemd (src/basic/virt.c), but as nobody has complained, this will have to wait
for somebody who is not using systemd.

Kind regards,
Petr
