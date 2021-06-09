From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 9 Jun 2021 15:33:41 +0200
Subject: [LTP] [PATCH] hotplug/cpu_hotplug: skip unsupported Microsoft
 Hyper-V
In-Reply-To: <20210609080313.15359-1-krzysztof.kozlowski@canonical.com>
References: <20210609080313.15359-1-krzysztof.kozlowski@canonical.com>
Message-ID: <YMDDNYojVH/NZbB8@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Krzysztof,

> Microsoft Hyper-V with Linux guests does not support CPU hotplug, even
> if enabled in kernel configuration.  Quoting Ubuntu bug report from
> June 2018: "While Hyper-V may present all potential CPUs via ACPI MADT,
> CPU add/remove is not supported.". [1]

> Detect the Hyper-V with systemd and if it succeeds, skip the test.
> This of course does not support all possible cases, e.g. running tests
> under Hyper-V without systemd will still fail, but it's a easy way to
> avoid test failure in common configuration.
Good catch, thanks!

> Ideally the newly introduced tst_virt_hyperv should be added to
> testcases/lib but first the CPU hotplug tests would have to be converted
> to newlib.
+1, thanks for TODO.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> [1] https://bugs.launchpad.net/ubuntu/+source/linux-azure/+bug/1776293

Kind regards,
Petr
