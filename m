From: Pengfei Xu <pengfei.xu@intel.com>
Date: Fri, 20 Dec 2019 13:58:47 +0800
Subject: [LTP] [PATCH v4 1/4] lib/tst_kconfig.c: Add any kconfig to
 match the expected value function
In-Reply-To: <17da9c80-0225-7344-b8a7-0e86ee783bad@cn.fujitsu.com>
References: <20191219131855.28799-1-pengfei.xu@intel.com>
 <17da9c80-0225-7344-b8a7-0e86ee783bad@cn.fujitsu.com>
Message-ID: <20191220055847.ixctyiof6zzfe7bb@xpf-desktop>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,
  Thanks for your advice!
  I will send the new patch to solve the warning.

  Thanks!
  BR.

On 2019-12-20 at 13:12:17 +0800, Yang Xu wrote:
> Hi Pengfei
> 
> This patch set looks good to me, only a samll comment.
> Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> 
> on 2019/12/19 21:18, Pengfei Xu wrote:
> > Example: CONFIG_X86_INTEL_UMIP=y for umip kconfig before and v5.4
> >             mainline kernel.
> >           CONFIG_X86_UMIP=y for umip kconfig after v5.5 mainline kernel.
> > Format: CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y
> > 
> > Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> > ---
> >   lib/tst_kconfig.c | 36 +++++++++++++++++++++++-------------
> >   1 file changed, 23 insertions(+), 13 deletions(-)
> > 
> > diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> > index 4b51413e5..74c46ebec 100644
> > --- a/lib/tst_kconfig.c
> > +++ b/lib/tst_kconfig.c
> > @@ -167,7 +167,8 @@ void tst_kconfig_read(const char *const *kconfigs,
> >   	struct match matches[cnt];
> > +							break;
> > +					}
> >   				}
> > -
> > -				if (j == cnt)
> It will report ?j? may be used uninitialized in this function when compile.
> But I think it can be modified by maintainer when it is merged.
> > -					goto exit;
> > +				kconfig_token = strtok_r(NULL, "|=", &p_left);
> > +				/* avoid to use after "=" string */
> > +				if (strlen(p_left) == 0)
> > +					break;
> >   			}
> > +			if (j == cnt)
> > +				goto exit;
> >   		}
> > -
> >   	}
> >   exit:
> > 
> 
> 
