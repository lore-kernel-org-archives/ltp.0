Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZEZN0-0005Fv-S3
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 08:45:50 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZEZMz-0004NI-4i
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 08:45:50 +0000
Date: Mon, 13 Jul 2015 04:45:29 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1979102079.16210434.1436777129564.JavaMail.zimbra@redhat.com>
In-Reply-To: <55A3610F.5000703@cn.fujitsu.com>
References: <1436426857-7322-1-git-send-email-mawentao@inspur.com>
	<55A3610F.5000703@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] acls: Solve a problem from acl_test01
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>, Wentao Ma <mawentao@inspur.com>, wunan@inspur.com
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Wentao Ma" <mawentao@inspur.com>, ltp-list@lists.sourceforge.net
> Cc: wunan@inspur.com
> Sent: Monday, 13 July, 2015 8:56:15 AM
> Subject: Re: [LTP] [PATCH] acls: Solve a problem from acl_test01
> 
> On 07/09/2015 03:27 PM, Wentao Ma wrote:
> > The failed infornamtion is as follow:
> > useradd: cannot set SELinux context for
> > home directory /tmp/tacl/mount-ext3/acltest1
> 
> It seems that the error is caused by SELinux, please disable
> your SELinux or set it to permissive and test again.

I thought this was fixed already:
  https://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg20602.html
  https://github.com/linux-test-project/ltp/commit/20cc1d9ef4b23f73acd68f23988ea73e1185c996

Does your LTP contain the commit above?

Regards,
Jan

> 
> Thanks,
> Wanlong Gao
> 
> > 
> > this is caused by comand "rm -rf $TEST_USER1_HOMEDIR".
> > But this directory is needed by next step.
> > So create this driectory again.
> > 
> > Signed-off-by: Wentao Ma <mawentao@inspur.com>
> > ---
> >  testcases/kernel/fs/acls/acl_test01 | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/testcases/kernel/fs/acls/acl_test01
> > b/testcases/kernel/fs/acls/acl_test01
> > index 328ff74..d079abd 100755
> > --- a/testcases/kernel/fs/acls/acl_test01
> > +++ b/testcases/kernel/fs/acls/acl_test01
> > @@ -87,6 +87,7 @@ do_setup(){
> >  	rm -rf $TEST_USER1_HOMEDIR
> >  	userdel $TEST_USER1 > /dev/null 2>&1
> >  	sleep 1
> > +        mkdir -p $TEST_USER1_HOMEDIR
> >  	useradd -d $TEST_USER1_HOMEDIR -m -g $TEST_USER1_GROUP $TEST_USER1 -s
> >  	/bin/sh
> >  
> >  	if [ $? -ne 0 ]; then
> > 
> 
> 
> ------------------------------------------------------------------------------
> Don't Limit Your Business. Reach for the Cloud.
> GigeNET's Cloud Solutions provide you with the tools and support that
> you need to offload your IT needs and focus on growing your business.
> Configured For All Businesses. Start Your Cloud Today.
> https://www.gigenetcloud.com/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
