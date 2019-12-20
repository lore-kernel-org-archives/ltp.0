From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 20 Dec 2019 13:37:21 +0800
Subject: [LTP] [PATCH v4 4/4] lib: add any kconfig to match the expected
 value function document
In-Reply-To: <20191219131855.28799-4-pengfei.xu@intel.com>
References: <20191219131855.28799-1-pengfei.xu@intel.com>
 <20191219131855.28799-4-pengfei.xu@intel.com>
Message-ID: <9ac02979-d8ec-4a11-7705-bb484dd79a20@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi Pengfei

on 2019/12/19 21:18, Pengfei Xu wrote:
> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>   doc/test-writing-guidelines.txt | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index 79d857fea..e64ff8716 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1590,7 +1590,9 @@ aborted with 'TCONF' if any of the required options were not set.
Before your patch, I know we can use the following two formats kconfigs
CONFIG_A
CONFIG_A=y/m/v
after your patch set, we can use the following three formats kconfigs
CONFIG_A
CONFIG_A=y/m/v
CONFIG_A|CONFIGB=y/m/v
As the usual extend logic,  we think  CONFIGA|CONFIGB is also ok. But in 
fact, we use "|" or "=" to delim string. So  we can't parse 
CONFIGA|CONFIGB correctly. So, if we can tell user or developer about 
this in here, it will be better.

ps: we can add configA| config B test in your third patch.

Kind Regards
Yang Xu
>   #include "tst_test.h"
>   
>   static const char *kconfigs[] = {
> -	"CONFIG_X86_INTEL_UMIP",
> +	"CONFIG_EXT4_FS=y",
> +	"CONFIG_MMU",
> +	"CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y",
>   	NULL
>   };
>   
> 


