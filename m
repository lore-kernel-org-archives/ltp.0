From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 21 Jun 2019 10:01:29 +0800
Subject: [LTP] [PATCH v2] security: add missing
 PR_CAPBSET_READ/PR_CAPBSET_DROP check
In-Reply-To: <20190620114952.GA31382@dell5510>
References: <20190515143746.GA7507@dell5510>
 <1557989579-3661-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190620114952.GA31382@dell5510>
Message-ID: <5D0C3A79.7090504@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> Hi Yang,
>
>> PR_CAPBSET_READ/PR_CAPNSET_DROP was added since linux2.6.25,
>> current ltp detected them in ltp-prctl.m4, but three places
>> missed this check. So add it, fix possible compiler error
>> on some old dirtros without PR_CAPBSET_READ/PR_CAPNSET_DROP flag.
> Thanks for your patch, merged.
>
> BTW these cap files would deserve converting into new API.
Hi Petr

Ok. I will take this as the next plan.

> Kind regards,
> Petr
>
>
>



