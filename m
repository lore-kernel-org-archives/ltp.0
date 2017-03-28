From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 28 Mar 2017 18:37:30 +0800
Subject: [LTP] [PATCH] commands/keyctl01: Add new regression test
In-Reply-To: <20170328083411.GB1045@rei>
References: <1489576439-15122-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20170327134232.GA21272@rei.lan> <58DA06C2.6050703@cn.fujitsu.com>
 <20170328083411.GB1045@rei>
Message-ID: <58DA3CEA.5080109@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 03/28/2017 04:34 PM, Cyril Hrubis wrote:
> Hi!
>> Yes, it is necessary, without the sleep, this test fails to
>> reproduce the bug on RHEL7.2GA(buggy kernel), since I found
>> that it actually takes some time to free the key.
>>
>>
>> With 100ms sleep, the whole test takes about 2s.
> 
> Two seconds is not that bad but can we make it faster? Does the test
> still reproduce the issue when we decrease the sleep a bit?
> 

Sleep 50ms still ensure the reproducible in my system,
and it takes no more than 1 second to test, but 30ms
cannot ensure the reproducible.


Best Regards,
Guangwen Feng


