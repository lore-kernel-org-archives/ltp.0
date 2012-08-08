Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Sz3Bp-0000E2-Dn
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 10:08:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Sz3Bn-0003rS-T9
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 10:08:33 +0000
Message-ID: <50223A4A.3000608@cn.fujitsu.com>
Date: Wed, 08 Aug 2012 18:07:06 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1343925295-1884-1-git-send-email-xu.simon@oracle.com>
	<502223B6.2070608@cn.fujitsu.com> <502228E3.9010802@oracle.com>
	<50223785.8040200@cn.fujitsu.com>
In-Reply-To: <50223785.8040200@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/1] fix container_ftp.pl
Reply-To: gaowanlong@cn.fujitsu.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 08/08/2012 05:55 PM, DAN LI wrote:
> On 08/08/2012 04:52 PM, Simon Xu wrote:
>> On 2012/8/8 16:30, DAN LI wrote:
>>> On 08/03/2012 12:34 AM, Simon Xu wrote:
>>>> container_ftp.pl has several problems:
>>>>
>>>> * ftp users can't cd to a temporary dir in /tmp
>>>> * ftp->cwd($dir) will always fail
>>>> * if we do 'chdir $dir', 'rmdir("$dir")' will fail
>>>> * 'ftp->put' should be 'ftp->get'
>>>>
>>>> Signed-off-by: Simon Xu <xu.simon@oracle.com>
>>>> ---
>>>>   testcases/kernel/containers/netns/container_ftp.pl | 15 ++++++++-------
>>>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/testcases/kernel/containers/netns/container_ftp.pl b/testcases/kernel/containers/netns/container_ftp.pl
>>>> index 89a35b5..98742f3 100644
>>>> --- a/testcases/kernel/containers/netns/container_ftp.pl
>>>> +++ b/testcases/kernel/containers/netns/container_ftp.pl
>>>> @@ -23,6 +23,7 @@
>>>>     use File::Temp 'tempdir';
>>>>   use Net::FTP;
>>>> +use File::Path;
>>>>     if ($#ARGV == -1) {
>>>>       print "usage: $0 host\n";
>>>> @@ -35,7 +36,7 @@ my $i = 0;
>>>>   my $kount = 51;
>>>>   my $file="junkfile";
>>>>   -my $tmpdir = defined($ENV{TMPDIR}) ? $ENV{TMPDIR} : "/tmp";
>>>> +my $tmpdir = "/var/ftp";
>>> hi, Simon
>>>
>>> I tested container_ftp.pl as follow:
>>> ********************************************************
>>> #./container_ftp.pl    knownhost_with_vsftpd
>>> ********************************************************
>>> and failed at "$ftp->cwd" either with this fix or without it.
>>>
>>> So,did i get the wrong way to test this script ,or,something wrong
>>> still exists.
>>
>> Could you print the value of $dir before "$ftp->cwd"?  And try ftp login as anonymous user, and see if you can cd to the value.
>>
> Thanks for your quick reply and sorry for my careless.
> I try operations as you suggested,and find the problem that dir created for test is not available
> for any user expect root.
> 
> So, now i test and confirm this fix works fine.

OK, pushed with your Reviewed-by and removed the tailing spaces. Thank you all.

Wanlong Gao

> 
> Thanks
> DAN LI
>> Thanks
>> Simon


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
