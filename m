Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1QAl0c-0000Sa-0f
	for ltp-list@lists.sourceforge.net; Fri, 15 Apr 2011 15:32:34 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QAl0b-0003Tu-8E
	for ltp-list@lists.sourceforge.net; Fri, 15 Apr 2011 15:32:33 +0000
Message-ID: <4DA864FB.6050807@redhat.com>
Date: Fri, 15 Apr 2011 23:32:11 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <06e447138f8f007517bb5c09cd96ffd4804a95d5.1302319401.git.czhang@redhat.com>	<f4ad73abd0251782d607e88f90a4a1a26001d9ea.1302440251.git.czhang@redhat.com>	<31e14b5b388ec4591dd62f86fa2b35b5ae4f408f.1302440251.git.czhang@redhat.com>
	<BANLkTi=zFezAWMpeQYE+JFRth8zCuByXhA@mail.gmail.com>
	<4DA3FCFC.9060109@redhat.com>
In-Reply-To: <4DA3FCFC.9060109@redhat.com>
Subject: Re: [LTP] [PATCH v3] [mm] mbind01: not working on some systems
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 04/12/2011 03:19 PM, Caspar Zhang wrote:
> On 04/12/2011 02:46 PM, Garrett Cooper wrote:
>> On Sun, Apr 10, 2011 at 6:00 AM, Caspar Zhang <czhang@redhat.com> wrote:
>>>
>>> when executing mem/mbind01 testcase under some systems, it returns
>>> ENOSYS error, indicating that mbind syscall is not implemented on this
>>> system. This behavior is allowed and should not return error.
>>>
>>> Signed-off-by: Caspar Zhang <czhang@redhat.com>
>>
>> Committed.
>> Thanks!
>> -Garrett
> 
> Thanks Garrett! However I still suggest merge the other patch, else
> there will be two "mbind01" tests: /kernel/syscalls/mbind/mbind01 and
> /kernel/mem/mbind/mbind01, after make install, there will be only one
> mbind01 in /opt/ltp/testcases/bin/..

ping Garrett, opinions?

Thanks,
Caspar

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
