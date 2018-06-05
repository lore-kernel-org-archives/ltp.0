From: Zhang, Yixin <yixin.zhang@intel.com>
Date: Tue, 5 Jun 2018 09:24:58 +0800
Subject: [LTP] [PATCH ltp] m4/ltp-kernel_devel.m4: get LINUX_VERSION
 from LINUX_DIR during configure
In-Reply-To: <20180604112402.GA3362@rei>
References: <20180604063306.24325-1-yixin.zhang@intel.com>
 <20180604112402.GA3362@rei>
Message-ID: <20180605012458.lszcgbpxi2yxdt44@yixin-desktop>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

I've double check the code and re-test multiple times today and you are right,
the "LINUX_VERSION" variable has nothing to do with building kernel module.
There was something wrong with my environment yesterday I think.
Please ignore this patch, thanks.

Yixin

On 2018-06-04 at 13:24:02 +0200, Cyril Hrubis wrote:
> Hi!
> > If LINUX_DIR is given, get LINUX_VERSION for kernel source code instead
> > of `uname -r`. So when we need to build .ko with a kernel differernt
> > than the one on current host PC, we only need to provide
> > "--with-linux-dir", and LINUX_VERSION will be generated automatically.
> 
> Looking at the m4 file for kernel-devel it seems we only use the
> LINUX_VERSION in order to construct the LINUX_DIR path and the rest of
> the code, i.e. include/mk/module.mk uses the LINUX_VERSION_MAJOR and
> LINUX_VERSION_MINOR generated based on the LINUX_DIR.
> 
> What is the LINUX_VERSION variable needed for? It does not seem to be
> used anywhere outside the m4 kernel devel file.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
