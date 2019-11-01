From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 1 Nov 2019 19:24:55 +0800
Subject: [LTP] [PATCH v2] syscalls/prctl02: add more error tests
In-Reply-To: <20191101084933.GA14639@dell5510>
References: <1572007183-13661-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1572512347-30116-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191101084933.GA14639@dell5510>
Message-ID: <fde85181-ce10-3a85-35aa-14bef2e61888@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


on 2019/11/01 16:49, Petr Vorel wrote:

> Hi Xu,
>
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>>   static struct tst_test test = {
>>   	.tcnt = ARRAY_SIZE(tcases),
>>   	.test = verify_prctl,
>> +	.caps = (struct tst_cap []) {
>> +		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
>> +		TST_CAP(TST_CAP_DROP, CAP_SETPCAP),
> This fails on some old distros (Debian stable [1], CentOS 6 [2]),
> but also on new (Fedora latest [3]):
>
> undeclared identifier 'CAP_SETPCAP'
>
> Could you please setup travis for your LTP fork and validate builds before
> posting to ML?

Hi Petr
Ok. I use travis before sending quotactl patches, but I forgot to use it for prctl02.

Sorry. I will test my patches in my ltp forklater.

ps: I add missing linux/capability.h to fix this build error and this is building in my ltp fork.

Thanks
Yang Xu

>
> BTW it'd be nice to have this feature in our patchwork [4], but not sure if this
> is available and configurable on our patchwork instance (we don't host it).
>
> Kind regards,
> Petr
>
> [1] https://travis-ci.org/pevik/ltp/jobs/605881703
> [2] https://travis-ci.org/pevik/ltp/jobs/605881705
> [3] https://travis-ci.org/pevik/ltp/jobs/605881704
> [4] https://github.com/linux-test-project/ltp/issues/599
>
>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191101/838008eb/attachment.htm>
