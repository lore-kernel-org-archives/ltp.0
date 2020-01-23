From: Yang Xu <xuyang_jy_0410@163.com>
Date: Thu, 23 Jan 2020 20:44:41 +0800
Subject: [LTP] [PATCH v2] syscalls/add_key01: test the length of payload
In-Reply-To: <20200123111347.GE27845@rei>
References: <20200121151342.GD6337@rei>
 <1579670796-21233-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200123111347.GE27845@rei>
Message-ID: <0b715eaf-cb87-8604-a305-5443f4741c9f@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> Hi!
>> Seeing add_key manpages, the length of payload for "user"/"logon"
>> is 32767, this value is up tp 1M for "big_key". For "keyring" type
>> , this value is zero.
> 
> This version is nearly good, there are a few minor things I can fix up
> before applying.
> 
> However the test fails for me unless I run it as root. Looks like any
> key that is bigger than certain threshold fails with EDQUOT for me. Have
> you tried to run the test as an unpriviledged user?
Hi Cyril

I don't run this test under an unpriviledged user. Seeing keyrings 
manpages, it said "
/proc/sys/kernel/keys/maxbytes (since Linux 2.6.26)
This  is  the  maximum  number of bytes of data that a 	nonroot user can 
hold in the payloads of the keys owned by theuser.
The default value in this file is 20,000.

I perfer to add .needs_root in this flag and check this in a new case.
What do you think about it?

Best Regards
Yang Xu
> 

