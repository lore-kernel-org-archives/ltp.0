From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 17 Mar 2021 12:34:34 +0100
Subject: [LTP] 
 =?utf-8?b?5Zue5aSNOiAgW1BBVENIIHYyXSBjbGVhbnVwOiBVbmlmeSB0?=
 =?utf-8?q?he_annotation_style_and_remove_Redundant_code?=
In-Reply-To: <OS0PR01MB6371A1E607BDFBC2421E6788836A9@OS0PR01MB6371.jpnprd01.prod.outlook.com>
References: <20210317100154.20389-1-zhaogongyi@huawei.com>
 <YFHghQWbAmjmKDx3@pevik>
 <OS0PR01MB6371A1E607BDFBC2421E6788836A9@OS0PR01MB6371.jpnprd01.prod.outlook.com>
Message-ID: <YFHpSspnD52A8N0P@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> > Hi Gongyi,

> > > Change 'DESCRIPTION' to 'Description' and change 'ALGORITHM' to 
> > > 'Algorithm', and remove Redundant tst_reap_children since 
> > > tst_reap_children has been called in the test skeleton.

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Hi Petr,

> If we want to unify the format of 'Description' and 'Algorithm' in test, it seems redundant to do the conversion in testinfo.pl, right?

> Can we use either of them(not both of them) because it is unnecessary to do the same thing twice.

I'd keep both: this is for cleanup of old approach, conversion in testinfo.pl in
case there is inconsistency in the future.

But not a strong opinion about it, it's not that important.

Kind regards,
Petr
