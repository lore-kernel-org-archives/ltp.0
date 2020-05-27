From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 27 May 2020 08:26:48 +0200
Subject: [LTP] [PATCH v5 4/4] umip_basic_test.c: improve kconfig
 verification to avoid umip wrong abort case
In-Reply-To: <33757536896DC84D9B3811B9D9F1A5D13D8BFA2B@SHSMSX101.ccr.corp.intel.com>
References: <20191220092529.3239-1-pengfei.xu@intel.com>
 <20191220092529.3239-4-pengfei.xu@intel.com>
 <20200525212401.GA30581@dell5510>
 <20200526023233.GA14105@xpf-desktop.sh.intel.com>
 <20200526092346.GB10775@dell5510> <20200526092703.GC10775@dell5510>
 <20200526100700.GA24819@xpf-desktop.sh.intel.com>
 <20200526101133.GA3114075@x230>
 <20200526103708.GA26057@xpf-desktop.sh.intel.com>
 <33757536896DC84D9B3811B9D9F1A5D13D8BFA2B@SHSMSX101.ccr.corp.intel.com>
Message-ID: <20200527062648.GA11836@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Pengfei,

>   Seems LINUX_VERSION_CODE way it not suitable when test platform is not compiled platform.
Well, you're expected to have installed kernel headers for target platform, when
you cross compile. That's what embedded distros like buildroot or yocto do.
We already use constructs like this in the code.

>   Need to use " if ((tst_kvercmp(5, 5, 0)) >= 0)" way.
As you noticed in previous mail, this will not work, as it's code outside of the
function, so you cannot call any function.

Kind regards,
Petr
