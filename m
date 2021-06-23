From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Jun 2021 15:34:12 +0200
Subject: [LTP] [PATCH] controllers/cpuset_hotplug: skip unsupported
 Microsoft Hyper-V
In-Reply-To: <c015b22b-5775-7301-a8b8-13cdd7000fb6@canonical.com>
References: <20210622145938.106477-1-krzysztof.kozlowski@canonical.com>
 <YNL9/k1iRralo/fj@pevik>
 <a7dd74e2-858f-19e4-d2bf-21cb77a3705e@canonical.com>
 <c015b22b-5775-7301-a8b8-13cdd7000fb6@canonical.com>
Message-ID: <YNM4VFC0pgygzNJz@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Krzysztof,

> On 23/06/2021 11:35, Krzysztof Kozlowski wrote:
> > On 23/06/2021 11:25, Petr Vorel wrote:
> >> Hi Krzysztof,

> >>> Microsoft Hyper-V with Linux guests does not support CPU hotplug, even
> >>> if enabled in kernel configuration.  Quoting Ubuntu bug report from
> >>> June 2018: "While Hyper-V may present all potential CPUs via ACPI MADT,
> >>> CPU add/remove is not supported.". [1]

> >> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> >> LGTM. How many of tests will need tst_virt_hyperv? Although we don't touch
> >> legacy API, I'd make an exception and add it to both test.sh and tst_test.sh
> >> (ideally with an API extension, i.e. test could use SKIP_VIRT="hyperv", but that
> >> can wait till tests are converted).

> > Around CPU hotplug that would be the last one I did not spot so far
> > other failures but I also do not track all failures in nice way. Rather
> > fixing them ad-hoc...

> I just checked more and there are additional failures on Azure/HyperV
> with more nodes: cpuset_load_balance, cpuset_memory_pressure,
> cpuset_memory_spread and cpuset_sched_domains. These did not appear on
> smaller instances (e.g. 4 CPUs).

Good to know. Does it mean we should check number of processors?

But even there were just these two and no additional change to
tst_virt_hyperv(), we'd prefer to have them in test.sh and tst_test.sh.
Could you please send v2, where you implement that?

Kind regards,
Petr

> Best regards,
> Krzysztof
