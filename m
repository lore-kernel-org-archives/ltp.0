From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 13 Oct 2016 16:44:43 +0300
Subject: [LTP] [PATCH] network/busy_poll: TCONF if driver doesn't
 support busy-poll feature
In-Reply-To: <20161010151059.GD1684@rei>
References: <1475761739-14380-1-git-send-email-alexey.kodanev@oracle.com>
 <20161010151059.GD1684@rei>
Message-ID: <57FF8FCB.8070107@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 10/10/2016 06:11 PM, Cyril Hrubis wrote:
> Hi!
>> +ethtool --show-features $(tst_iface) | grep -q 'busy-poll.*on' || \
>> +	tst_brkm TCONF "busy poll not supported by driver"
>> +
> Maybe it would be better to move all the TCONF checks into a common
> bussy_poll_lib.sh and source it in the scripts.
>
> And also we should check for ethtool command with the tst_check_cmds.

Added new shell lib with checks and applied.

Thanks,
Alexey
