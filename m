From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Aug 2019 13:27:38 +0200
Subject: [LTP] [PATCH v3 LTP] Skip the test if "htop" is used.
In-Reply-To: <5D6502C9.9040805@cn.fujitsu.com>
References: <20190814091545.147098-1-siliangx.yu@intel.com>
 <20190827094154.GA32175@dell5510> <5D6502C9.9040805@cn.fujitsu.com>
Message-ID: <20190827112738.GA25476@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> On 2019/08/27 17:41, Petr Vorel wrote:
> > > From: "Yu,Siliang"<siliangx.yu@intel.com>
> > > In clear linux os, "htop" is used instead "top", which doesn't support '-b'. Skip the test on clear linux.
> > There is a bug report in Clear Linux OS [1]:
> > original top program is named top2, maybe it'd make sense to test for it as well.

> Is the silly rename going to be changed by Clear Linux in future?

> If yes, we may keep cpuhotplug06.sh to detect the issue.
> If no, we may update cpuhotplug06.sh to use top2 if top is provided by htop.
+1. Let's wait for the reply on Github issue [1].

> Best Regards,
> Xiao Yang

Kind regards,
Petr

> > [1] https://github.com/clearlinux/distribution/issues/277#issuecomment-442340322
