From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 3 Jul 2017 10:14:31 +0800
Subject: [LTP] [PATCH] commands: fix unmatched installation path of
	datafiles
In-Reply-To: <20170630114037.GB18305@rei.lan>
References: <1498794020-9569-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170630114037.GB18305@rei.lan>
Message-ID: <5959A887.5060405@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2017/06/30 19:40, Cyril Hrubis wrote:
> Hi!
>> Both file01 and unzip01 fail due to unmatched installation
>> path of datafiles.  It has been broken by:
>>
>> commit f9a91c164ac52a4c91ff6aa9c156f110d04158d6
>> Author: Li Wang<liwang@redhat.com>
>> Date:   Wed May 24 15:18:31 2017 +0800
>>
>> 	tst_tests.sh: set the shell TST_ID automatically
>>
>> We need to change installation path of datafiles to fix it.
> Good catch, but I would be happier if we simply renamed the testcases to
> keep the test filenames constistent. Can you please post that patch
> instead?
Hi Cyril

Thanks for your comment.   I will send v2 patch as you suggested.

Thanks,
Xiao Yang



