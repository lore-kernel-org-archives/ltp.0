Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1YTQ9K-000235-JS
	for ltp-list@lists.sourceforge.net; Thu, 05 Mar 2015 07:24:50 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YTQ9J-0001xt-2K
	for ltp-list@lists.sourceforge.net; Thu, 05 Mar 2015 07:24:50 +0000
Message-ID: <54F80480.5030702@cn.fujitsu.com>
Date: Thu, 5 Mar 2015 15:23:44 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1425531691-19211-1-git-send-email-liwang@redhat.com>	<1425535095.18011.24.camel@G08JYZSD130126.localdomain>
	<249535550.12516554.1425536777165.JavaMail.zimbra@redhat.com>
In-Reply-To: <249535550.12516554.1425536777165.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] commands/ade/ar01: the touched timestatp of
 file01.in should be newer than now
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 03/05/2015 02:26 PM, Li Wang wrote:
> Hi,
> ----- Original Message -----
>> Hi,
>>
>> On Thu, 2015-03-05 at 13:01 +0800, Li Wang wrote:
>>> Since the timestatp is older than now it cause this testcase
>>> failed like this:
>>> + touch -c -t 201503030303.55 file0.in
>>> + ar -ru /tmp/ar01-28953/lib.a file0.in file2.in
>>> ...
>>> FAIL - ar with -u flag failed
>>>
>>> >From the AR(1) Manual pager, ar -u:
>>> If you would like to insert only those of the files you list
>>> that are newer than existing members of the same names, use
>>> this modifier.
>>>
>>> Signed-off-by: Li Wang <liwang@redhat.com>
>>> ---
>>>  testcases/commands/ade/ar/ar01 | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/testcases/commands/ade/ar/ar01
>>> b/testcases/commands/ade/ar/ar01
>>> index 32fef11..c5181a3 100755
>>> --- a/testcases/commands/ade/ar/ar01
>>> +++ b/testcases/commands/ade/ar/ar01
>>> @@ -483,7 +483,7 @@ do
>>>  	File2time=`ar -tv $TCtmp/lib.a | grep file2.in`
>>>  
>>>  	#sleep 5
>>> -	touch -c -t 201503030303.55 file0.in
>>> +	touch -c -t 208503030303.55 file0.in
>>
>> How about
>> touch -c -t $(date --date='next day' +"%Y%m%d%H%M") file0.in
> Agree! 
> Absolutely it's better than the stable timestatp.

s/timestatp/timestamp/ in comment ?




------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
