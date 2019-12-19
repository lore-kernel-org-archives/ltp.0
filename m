From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu, 19 Dec 2019 21:18:07 +0800
Subject: [LTP] [PATCH 1/2] lib/tst_kconfig.c: add or select kconfig
 function
In-Reply-To: <cfa113f3-56b8-f93f-b3ed-50e9bd9f849a@cn.fujitsu.com>
References: <20191218122504.9985-1-pengfei.xu@intel.com>
 <c97da094-a320-e4b4-dee9-423a3e306ecf@cn.fujitsu.com>
 <b19e2cd0-964f-2fe3-860f-039d63088d52@cn.fujitsu.com>
 <20191219100602.mpyelysyizonfrit@xpf-desktop>
 <cfa113f3-56b8-f93f-b3ed-50e9bd9f849a@cn.fujitsu.com>
Message-ID: <20191219131807.cxwfm2mib6wqhwaj@xpf-desktop>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

On 2019-12-19 at 19:03:16 +0800, Yang Xu wrote:
> Hi Pengfei
> > Hi Xu,
> >    Thanks for your advice!
> >    My concern is that:
> >    If some one need any CONFIG_A, CONFIG_B, CONFIG_C ... set to y.
> >    We need rewrite again.
> >    Also, thanks for advice, I will used newlib_tests to double check.:)
> > 
> I see. Also, you should add example to lib/newlib_tests/test_kconfig.c so we
> can know the kconfig feature is ok when maintainer merges your patch.
> Usually, if we modify or add lib feature, we will document it in
> doc/test-writing-guidelines.txt. So if you do it , it will be better.
> as below:
> diff --git a/lib/newlib_tests/test_kconfig.c
> b/lib/newlib_tests/test_kconfig.c
> index d9c662fc5..9515b60e2 100644
> --- a/lib/newlib_tests/test_kconfig.c
> +++ b/lib/newlib_tests/test_kconfig.c
> @@ -14,6 +14,7 @@ static const char *kconfigs[] = {
>         "CONFIG_MMU",
>         "CONFIG_EXT4_FS=m",
>         "CONFIG_PGTABLE_LEVELS=4",
> +       "CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y",
>         NULL
>  };
  Thanks for your advice! I will add them.

  Thanks!
  BR.
> 
> Kind Regards
> Yang Xu
> >    Thanks!
> >    BR.
> 
> 
