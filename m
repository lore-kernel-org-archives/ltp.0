From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Jun 2021 11:25:18 +0200
Subject: [LTP] [PATCH] controllers/cpuset_hotplug: skip unsupported
 Microsoft Hyper-V
In-Reply-To: <20210622145938.106477-1-krzysztof.kozlowski@canonical.com>
References: <20210622145938.106477-1-krzysztof.kozlowski@canonical.com>
Message-ID: <YNL9/k1iRralo/fj@pevik>
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM. How many of tests will need tst_virt_hyperv? Although we don't touch
legacy API, I'd make an exception and add it to both test.sh and tst_test.sh
(ideally with an API extension, i.e. test could use SKIP_VIRT="hyperv", but that
can wait till tests are converted).

Kind regards,
Petr
