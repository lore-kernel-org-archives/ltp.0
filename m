From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 23 Feb 2016 17:50:19 +0800
Subject: [LTP] [PATCH] input: add kernel version check
In-Reply-To: <20160222111826.GA5704@rei.lan>
References: <1455874725-31499-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20160222111826.GA5704@rei.lan>
Message-ID: <56CC2B5B.2050404@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to 2016/02/22 19:18, Cyril Hrubis  wrote:
> Hi!
>> In this test case, the functionality of input has been improved by
>> following patch:
>> 'commit 4369c64c79a2 ("Input: Send events one packet at a time")'.
>> So it's not appropriate for testing on kernels that are lower than
>> 3.7.0 anymore.
> Are you sure that you have pointed out right commit? The commit
> description does not seem relevant.
>
> Also can you please describe why the testcases fail before 3.7.0 and
> how? Does kernel send empty sync events?
>
Hi !
I'm so sorry to reply this email late.
kernel will send empty sync evnets when there are no new events, because 
sync(boolean type)
is set ture when there are no new events. if mouse isn't moving, i think 
that nothing is received
in /dev/input/eventX. this patch imporved this function. that's right?


