From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Aug 2019 13:58:45 +0200
Subject: [LTP] [PATCH v3 LTP] Skip the test if "htop" is used.
In-Reply-To: <5D6502C9.9040805@cn.fujitsu.com>
References: <20190814091545.147098-1-siliangx.yu@intel.com>
 <20190827094154.GA32175@dell5510> <5D6502C9.9040805@cn.fujitsu.com>
Message-ID: <20190829115845.GA2763@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Is the silly rename going to be changed by Clear Linux in future?
According to [2], they does not going to change it.

> If yes, we may keep cpuhotplug06.sh to detect the issue.
> If no, we may update cpuhotplug06.sh to use top2 if top is provided by htop.

I suggest to use proposed solution with extra tip:

if top -v | grep -q htop; then
	tst_brkm TCONF "htop is used instead of top, skip the test (workaround: alias top='/path/to/real/top')"
fi

And leave user to solve it:
alias top='top2'

Kind regards,
Petr
