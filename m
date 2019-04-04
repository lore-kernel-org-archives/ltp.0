From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 4 Apr 2019 09:29:33 +0800
Subject: [LTP] [PATCH 1/1] Remove break after return
In-Reply-To: <20190403120655.GA20621@dell5510>
References: <20190328105006.17337-1-pvorel@suse.cz>
 <5C9D8B2E.1090608@cn.fujitsu.com> <20190403120220.GB13658@rei>
 <20190403120655.GA20621@dell5510>
Message-ID: <5CA55DFD.4010701@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/04/03 20:06, Petr Vorel wrote:
>>> Can we also remove break after calling tst_brk()?
>> >  AFAIK that would generate warnings, since compiler cannot deduce on it's
>> >  own that the call will not return.
> Agree.
>
Hi,

Thanks for your explanation.

Other than the question, it looks good to me.
Reviewed-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Best Regards,
Xiao Yang



