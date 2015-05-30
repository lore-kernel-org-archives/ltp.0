Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1Yyabj-00041m-8q
	for ltp-list@lists.sourceforge.net; Sat, 30 May 2015 06:50:59 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Yyabg-000297-7b
	for ltp-list@lists.sourceforge.net; Sat, 30 May 2015 06:50:59 +0000
Message-ID: <55695DBC.5020408@huawei.com>
Date: Sat, 30 May 2015 14:50:36 +0800
From: Yuan Sun <sunyuan3@huawei.com>
MIME-Version: 1.0
References: <1432760421-14844-1-git-send-email-sunyuan3@huawei.com>
	<206480471.6823339.1432816433513.JavaMail.zimbra@redhat.com>
	<55683E08.6050901@redhat.com>
In-Reply-To: <55683E08.6050901@redhat.com>
Subject: Re: [LTP] [PATCH V2] containers: new testcase userns02
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
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, pleasuresun@sina.com


On 2015/5/29 18:23, Jiri Jaburek wrote:
> On 05/28/15 14:33, Jan Stancek wrote:
>> ----- Original Message -----
>>> From: "Yuan Sun" <sunyuan3@huawei.com>
>>> To: jstancek@redhat.com
>>> Cc: ltp-list@lists.sourceforge.net, pleasuresun@sina.com, sunyuan3@huawei.com
>>> Sent: Wednesday, 27 May, 2015 11:00:21 PM
>>> Subject: [PATCH V2] containers: new testcase userns02
>>>
>>> The user ID and group ID, which are inside a container, can
>>> be modified by its parent process.
>>>
>>> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
>> Hi,
>>
>> couple comments inline, but overall it looks good to me.
>> Unless someone points out other issues, I can fix these before commit.
>>
> As a FYI to the author - there's a "libclone" library in containers/
> that can take care of the forking/cloning/unsharing, specifically the
> do_clone_tests function could be used (uses ltp_clone_quick).
> Given the simplicity of the function, though, I wouldn't see it as
> a major issue.
Hi Jan,
     Thanks for your comment. In general, I agree with you. But in this 
case I have different opinions.
  I tried replacing ltp_clone_quick with do_clone_tests.
#childpid = do_clone_tests(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, 
NULL, NULL, NULL);

   However, I found "do_clone_tests" function can't return the child 
pid. In this case,
the parent needs the child pid to modify /proc/$childpid/uid_map. Maybe 
ltp_clone_quick
is more appropriate than do_clone_tests in this case.
   Of course, if you have different opinion please feel free to let me know.
   Regards.
         Yuan






>
>
> .
>


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
