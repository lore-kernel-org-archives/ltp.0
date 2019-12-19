From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu, 19 Dec 2019 18:03:37 +0800
Subject: [LTP] [PATCH 1/2] lib/tst_kconfig.c: add or select kconfig
 function
In-Reply-To: <c97da094-a320-e4b4-dee9-423a3e306ecf@cn.fujitsu.com>
References: <20191218122504.9985-1-pengfei.xu@intel.com>
 <c97da094-a320-e4b4-dee9-423a3e306ecf@cn.fujitsu.com>
Message-ID: <20191219100337.vv6p3gi5dddqdhjm@xpf-desktop>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,
  Thanks for your comments!
  I made one wrong loop, which caused this issue.
  I will make another patch for any KCONFIG_AA or KCONFIG_AB is matached with
  y feature. : )

  Thanks!
  BR.

On 2019-12-19 at 12:02:34 +0800, Yang Xu wrote:
> Hi Pengfei
> 
> on 2019/12/18 20:25, Pengfei Xu wrote:
> > -	fp = open_kconfig();
> > -	if (!fp)
> > -		tst_brk(TBROK, "Cannot parse kernel .config");
> > +		while (fgets(buf, sizeof(buf), fp)) {
> > -	while (fgets(buf, sizeof(buf), fp)) {
> > -		for (i = 0; i < cnt; i++) {
> > -			if (match(&matches[i], kconfigs[i], &results[i], buf)) {
> > -				for (j = 0; j < cnt; j++) {
> > -					if (matches[j].match)
> > -						break;
> > -				}
> > +			memset(kconfig_multi, 0, sizeof(kconfig_multi));
> > +			/* strtok_r will split kconfigs[i] to multi string, so copy it */
> > +			memcpy(kconfig_multi, kconfigs[i], strlen(kconfigs[i]));
> > +
> > +			kconfig_token = strtok_r(kconfig_multi, "|=", &p_left)
> Here has a problem, if we use CONFIG_X86_INTEL_UMIP, it will report "miss
> this config" because it uses "=" or "|" to delim string.
> And I think you should use lib/newlib_tests/test_kconfig.c to test your
> introduced feature.
> 
> Also, it has another two problems even we use "|" or "=" in kconfigs
> 
> 1.If  use "CONFIG_X86_INTEL_UMIP=y|CONFIG_X86_UMIP=y" ,it will report y is
> invalid because we use "="or "|" to delim string.
> 2. If  use "CONFIG_X86_INTEL_UMIP|X86_INTEL_UMIP=y", it will doesn't check
> second config whether invalid if the first is ok.
> 
> Kind Regards
> Yang Xu
> > +			while (kconfig_token != NULL) {
> > +				if (strncmp("CONFIG_", kconfig_token, 7))
> > +					tst_brk(TBROK, "Invalid config string '%s'", kconfig_token);
> > +				matches[i].len = strlen(kconfig_token);
> > +				if (match(&matches[i], kconfig_token, &results[i], buf)) {
> > +					for (j = 0; j < cnt; j++) {
> > +						if (matches[j].match)
> > +							break;
> > +					}
> >   				if (j == cnt)
> >   					goto exit;
> > +				}
> > +				kconfig_token = strtok_r(NULL, "|=", &p_left);
> > +				/* avoid to use after "=" string */
> > +				if (strlen(p_left) == 0)
> > +					break;
> >   			}
> >   		}
> > -
> >   	}
> >   exit:
> > 
> 
> 
