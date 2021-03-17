From: Xiao Yang <ice_yangxiao@163.com>
Date: Wed, 17 Mar 2021 20:09:50 +0800
Subject: [LTP] 
 =?utf-8?b?5Zue5aSNOiBbUEFUQ0ggdjJdIGNsZWFudXA6IFVuaWZ5IHRo?=
 =?utf-8?q?e_annotation_style_and_remove_Redundant_code?=
In-Reply-To: <YFHpSspnD52A8N0P@pevik>
References: <20210317100154.20389-1-zhaogongyi@huawei.com>
 <YFHghQWbAmjmKDx3@pevik>
 <OS0PR01MB6371A1E607BDFBC2421E6788836A9@OS0PR01MB6371.jpnprd01.prod.outlook.com>
 <YFHpSspnD52A8N0P@pevik>
Message-ID: <49c114a6-e662-473c-340d-12a3c76f7471@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 3/17/21 7:34 PM, Petr Vorel wrote:
> Hi all,
>
>>> Hi Gongyi,
>>>> Change 'DESCRIPTION' to 'Description' and change 'ALGORITHM' to
>>>> 'Algorithm', and remove Redundant tst_reap_children since
>>>> tst_reap_children has been called in the test skeleton.
>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> Hi Petr,
>> If we want to unify the format of 'Description' and 'Algorithm' in test, it seems redundant to do the conversion in testinfo.pl, right?
>> Can we use either of them(not both of them) because it is unnecessary to do the same thing twice.
> I'd keep both: this is for cleanup of old approach, conversion in testinfo.pl in
> case there is inconsistency in the future.
>
> But not a strong opinion about it, it's not that important.

Hi Petr,

Other than that, it looks good to me.

Acked-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Best Regards,

Xiao Yang

>
> Kind regards,
> Petr
>

