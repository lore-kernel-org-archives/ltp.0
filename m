From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 17 Mar 2021 14:02:15 +0100
Subject: [LTP] ??????: [PATCH v2] cleanup: Unify the annotation style
 and remove Redundant code
In-Reply-To: <32fcff9e-54d4-a4ed-0d4c-3b703921d035@163.com>
References: <20210317100154.20389-1-zhaogongyi@huawei.com>
 <YFHghQWbAmjmKDx3@pevik>
 <OS0PR01MB6371A1E607BDFBC2421E6788836A9@OS0PR01MB6371.jpnprd01.prod.outlook.com>
 <YFHpSspnD52A8N0P@pevik> <YFHxcgN/3TG2Y9Mx@yuki.lan>
 <YFHyg8m3CmU8as2C@pevik>
 <32fcff9e-54d4-a4ed-0d4c-3b703921d035@163.com>
Message-ID: <YFH910rpcVjzDuEI@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On 3/17/21 8:13 PM, Petr Vorel wrote:
> > Hi,

> > > Hi!
> > > > I'd keep both: this is for cleanup of old approach, conversion in testinfo.pl in
> > > > case there is inconsistency in the future.
> > > If we agree on a certain format I would vote for docparse to fail the
> > > build if the format is wrong, that will force us to maintain the
> > > metadata correctly.
> +1
> > Make sense. But being the one who often fixes docparse failures I'm not sure if
> > I want to implement extra work for myself :).

> > (It'd help to implement https://github.com/linux-test-project/ltp/issues/599,
> > but I don't have any server to run it).

> This issue is about docparse, I think we can merge the patch itself
> directly.
Agree, rebased and merged with updated commit message.

Not sure when I update testinfo.pl to Cyril's suggestion,
anyone feel free to implement it.

Kind regards,
Petr

> Best Regards,

> Xiao Yang
