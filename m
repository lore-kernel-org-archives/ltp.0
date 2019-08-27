From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Aug 2019 11:41:55 +0200
Subject: [LTP] [PATCH v3 LTP] Skip the test if "htop" is used.
In-Reply-To: <20190814091545.147098-1-siliangx.yu@intel.com>
References: <20190814091545.147098-1-siliangx.yu@intel.com>
Message-ID: <20190827094154.GA32175@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> From: "Yu,Siliang" <siliangx.yu@intel.com>

> In clear linux os, "htop" is used instead "top", which doesn't support '-b'. Skip the test on clear linux.
There is a bug report in Clear Linux OS [1]:
original top program is named top2, maybe it'd make sense to test for it as well.

> Signed-off-by: Yu,Siliang <siliangx.yu@intel.com>
Acked-by: Petr Vorel <pvorel@suse.cz>

>  .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh     | 4 ++++
...

> +if top -v | grep -q htop; then
> +	tst_brkm TCONF "htop is used instead of top, Skip the test..."
	tst_brkm TCONF "htop is used instead of top, skip the test"
...

Kind regards,
Petr

[1] https://github.com/clearlinux/distribution/issues/277#issuecomment-442340322
