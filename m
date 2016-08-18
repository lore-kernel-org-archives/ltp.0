From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 18 Aug 2016 11:33:01 +0300
Subject: [LTP] [PATCH 2/8] waitpid10: use the new API
In-Reply-To: <57B57102.1010305@oracle.com>
References: <1470818466-28109-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160815143602.GF20680@rei.lan> <57B57102.1010305@oracle.com>
Message-ID: <57B572BD.9040508@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 08/18/2016 11:25 AM, Stanislav Kholmanskikh wrote:
> 
> 
> On 08/15/2016 05:36 PM, Cyril Hrubis wrote:
>> Hi!
>>> +static void do_child_1(void)
>>>  {
>>
>> Why do we run the test in the do_child_1() here?
>>
>> As far as I remember the whole point was to start some of the child
>> processes in different process group and we don't do that in this test,
>> so we may as well put this function as the test function into the struct
>> tst_test.
> 
> waitpid_test() just forks a child - do_child_1() which then does the
> actual testing. This scheme is needed in other test cases, since they
> operate with process groups.
> 
> Yes, here it's redundant, since this do_child_1() doesn't touch process
> groups. I decided to use this scheme here just for similarity with other
> test cases. In my opinion, it brings no harm or improvements.

I can add this to the commit message.


> 
> 
>>
>>
>> Otherwise this looks good.
>>
> 
