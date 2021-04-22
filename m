From: Xiao Yang <ice_yangxiao@163.com>
Date: Thu, 22 Apr 2021 16:57:23 +0800
Subject: [LTP] runltp-ng and possible ltp-pan deprecation
In-Reply-To: <YIE0INnCJOMGYQQR@pevik>
References: <YH7Z8nOX90qjsMpa@yuki> <YIE0INnCJOMGYQQR@pevik>
Message-ID: <fd47c5ca-57f8-c075-bb1d-9fa2c6caae53@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 4/22/21 4:30 PM, Petr Vorel wrote:
> Hi Cyril,
>
> Thank you for bringing the discussion to upstream runltp-ng.
>
> I'd prefer to add the project to ltp git, in runltp-ng/ in root directory.

+1

I also prefer to add it into ltp directly.

Best Regards,

Xiao Yang

> And add either a symlink runltp-ng/runltp-ng to the root directory or have a
> shell script which runs it:
> perl -I$(readlink -f $0)/runltp-ng $(readlink -f $0)/runltp-ng/runltp-ng $@
>
> Kind regards,
> Petr
>
>

