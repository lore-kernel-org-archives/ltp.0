Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1YyHRe-0002tX-Ji
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2015 10:23:18 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YyHRd-0004Mw-IA
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2015 10:23:18 +0000
Message-ID: <55683E08.6050901@redhat.com>
Date: Fri, 29 May 2015 12:23:04 +0200
From: Jiri Jaburek <jjaburek@redhat.com>
MIME-Version: 1.0
References: <1432760421-14844-1-git-send-email-sunyuan3@huawei.com>
	<206480471.6823339.1432816433513.JavaMail.zimbra@redhat.com>
In-Reply-To: <206480471.6823339.1432816433513.JavaMail.zimbra@redhat.com>
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
To: Yuan Sun <sunyuan3@huawei.com>
Cc: ltp-list@lists.sourceforge.net, pleasuresun@sina.com

On 05/28/15 14:33, Jan Stancek wrote:
> ----- Original Message -----
>> From: "Yuan Sun" <sunyuan3@huawei.com>
>> To: jstancek@redhat.com
>> Cc: ltp-list@lists.sourceforge.net, pleasuresun@sina.com, sunyuan3@huawei.com
>> Sent: Wednesday, 27 May, 2015 11:00:21 PM
>> Subject: [PATCH V2] containers: new testcase userns02
>>
>> The user ID and group ID, which are inside a container, can
>> be modified by its parent process.
>>
>> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
> 
> Hi,
> 
> couple comments inline, but overall it looks good to me.
> Unless someone points out other issues, I can fix these before commit.
> 

As a FYI to the author - there's a "libclone" library in containers/
that can take care of the forking/cloning/unsharing, specifically the
do_clone_tests function could be used (uses ltp_clone_quick).
Given the simplicity of the function, though, I wouldn't see it as
a major issue.


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
