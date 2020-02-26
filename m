From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 26 Feb 2020 09:19:13 +0800
Subject: [LTP] [PATCH] syscalls/kill11: convert to new library
In-Reply-To: <20200225125449.GD5077@rei.lan>
References: <1582271720-27370-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200225125449.GD5077@rei.lan>
Message-ID: <f51300ea-50a3-b584-8f2d-f10091a5b8f4@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

> Hi!
> Pushed with a minor change, thanks.
> 
>> +	if (tc->sig != SIGKILL) {
>> +		if (sigset(tc->sig, SIG_DFL) == SIG_ERR)
>> +			tst_brk(TBROK | TERRNO, "sigset(%d) failed", tc->sig);
>>   	}
> 
> There is no need to restore the default signal handlers if we haven't
> changed them, so I've removed this part as well.
Thanks for the removing.

Best Regards
Yang Xu
> 


