From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 1 Jul 2021 01:28:59 +0000
Subject: [LTP] [PATCH v2 2/2] syscalls/ipc: Make use of TST_EXP_FAIL or
 TST_EXP_FAIL2 macro
In-Reply-To: <YNx/ZvzdI9AifBHK@yuki>
References: <YNHCQ8qWSBdHIAra@yuki>
 <1624963486-6614-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1624963486-6614-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YNx/ZvzdI9AifBHK@yuki>
Message-ID: <60DD1A72.6020300@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril
> Hi!
>> +	TST_EXP_FAIL(msgget(*tc->key, tc->flags), tc->exp_err, "msgget(%i, %i)",
>> +		*tc->key, tc->flags);
>>   }
>
> I've changed this one to TST_EXP_FAIL2() since msgget() returns
> non-negative integer on success and pushed the patchset, thanks.
Oh, yes! I pasted from v1. Sorry for not changing this.

Best Regards
Yang Xu
>
