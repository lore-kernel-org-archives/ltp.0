From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 27 Jul 2016 14:14:37 +0300
Subject: [LTP] [PATCH 2/2] network/xinetd: fix/cleanup test
In-Reply-To: <20160726142225.GG11679@rei.lan>
References: <1467033461-18797-1-git-send-email-alexey.kodanev@oracle.com>
 <1467033461-18797-2-git-send-email-alexey.kodanev@oracle.com>
 <20160726142225.GG11679@rei.lan>
Message-ID: <5798979D.6070705@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/26/2016 05:22 PM, Cyril Hrubis wrote:
> Hi!
>> +setup()
>> +{
>> +	[ -f "/usr/lib/systemd/system/telnet.socket" ] && \
>> +		tst_brkm TCONF "xinetd doesn't manage telnet"
> Hmm, there are still major distributions that were released in
> pre-systemd times and will be maintained a few more years.

This was added by this patch:

     54305b28 "network/xinetd: TCONF if telnet managed by systemd"

Thanks,
Alexey

