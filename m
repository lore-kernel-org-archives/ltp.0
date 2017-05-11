From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 11 May 2017 13:50:47 +0300
Subject: [LTP] [PATCH] runtest/net.nfs: fix version typo
In-Reply-To: <20170505135011.GD16729@rei.suse.de>
References: <1489575310-3488-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <ede2fc8b-4486-ce87-4742-92ad4ea00d28@oracle.com>
 <20170505135011.GD16729@rei.suse.de>
Message-ID: <8c4dc7a0-d8d5-7e38-6f53-f0c6f9731e6a@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 05/05/2017 04:50 PM, Cyril Hrubis wrote:
> Hi!
>>>  nfs3_02 nfs02 -v 3 -t udp
>>> -nfs4_02 nfs02 -v 3 -t tcp
>>> +nfs4_02 nfs02 -v 4 -t tcp
>> I wonder if we should add back test-cases with NFSv3 over TCP,
>> something like this:
>> nfs3t_02  nfs01 -v 3 -t tcp
>> ...
> Sounds reasonable, feel free to commit this before the release.

Also added a few more test-cases with NFSv3 over TCP, patch applied.

Best regards,
Alexey

