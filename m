Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1YVAT9-0000kI-2E
	for ltp-list@lists.sourceforge.net; Tue, 10 Mar 2015 03:04:31 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YVAT7-0002EC-EI
	for ltp-list@lists.sourceforge.net; Tue, 10 Mar 2015 03:04:31 +0000
Message-ID: <1425956655.30355.4.camel@dhcp-13-206.nay.redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 10 Mar 2015 11:04:15 +0800
In-Reply-To: <1425954166.26995.19.camel@G08JYZSD130126.localdomain>
References: <1425894193-17523-1-git-send-email-liwang@redhat.com>
	<1425954166.26995.19.camel@G08JYZSD130126.localdomain>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] fs/acls: fix some permission issue in the testcase
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

hi,

On Tue, 2015-03-10 at 10:22 +0800, Zeng Linggang wrote:
> On Mon, 2015-03-09 at 17:43 +0800, Li Wang wrote:
> > hi,
> > 
> > The acl_test01 failed with a series of permission issue when runing on RHEL:
> > 	useradd: cannot set SELinux context for home directory
> > 	/mnt/testarea/ltp-KIK01kZbbL/tacl/mount-ext3/acltest1
> > 	Could not add test user acltest1.
> > 	/dev/loop1 on /mnt/testarea/ltp-KIK01kZbbL/tacl/mount-ext3
> > 	type ext3 (rw,relatime,seclabel,data=ordered)
> > 	...
> > 
> > A proposal fixed patch and test results as below:
> > 
> > 	TESTING ACLS FOR USER root
> > 	Trying extended acls for files
> > 	Extended acls for files (PASSED)
> > 	Trying extended acls for file links
> > 	Extended acls for links (PASSED)
> > 
> > 	TESTING ACLS FOR 2ND USER acltest1
> > 	Trying extended acls for files
> > 	Extended acls for files (PASSED)
> > 	Trying extended acls for file links
> > 	Extended acls for links (PASSED)
> > 	...
> > 
> > Thanks.
> > 
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > ---
> >  testcases/kernel/fs/acls/acl_test01 | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> > 
> > diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
> > index af65213..5aa5823 100755
> > --- a/testcases/kernel/fs/acls/acl_test01
> > +++ b/testcases/kernel/fs/acls/acl_test01
> > @@ -52,15 +52,30 @@ FILE_ACL="$TMP/tacl/mount-ext3/test_file"
> >  FILE_ACL_LINK="$TMP/tacl/mount-ext3/test_file_link"
> >  TCbin=`pwd`
> >  
> > +SESTATUS=`/usr/sbin/sestatus |grep "SELinux status"|awk '{print $3}'`
> > +if [ "$SESTATUS" = "enabled" ]; then
> > +	export SELINUX=`getenforce`
> > +else
> > +	export SELINUX="disabled"
> > +
> > +fi
> > +
> >  #-----------------------------------------------------------------------
> >  # FUNCTION:  do_setup
> >  #-----------------------------------------------------------------------
> >  
> >  do_setup(){
> >  
> > +	tst_require_root
> > +
> >  	rm -f $FILE_ACL
> >  	rm -f $FILE_ACL_LINK
> >  
> > +	if [ "$SELINUX" = "Enforcing" ]; then
> > +		echo "set the SElinux to Permissive."
> > +		setenforce 0
> > +	fi
> > +
> >  	if [ "x$TEST_USER1_HOMEDIR" = "x" ]; then
> >  		echo "Could not find user $TEST_USER1's home directory."
> >  		exit 1
> > @@ -91,6 +106,11 @@ do_cleanup() {
> >  	mount | grep "$TMP/tacl/mount-ext3" && umount -d $TMP/tacl/mount-ext3
> >  	[ "x$LOOP_DEV" != x ] && losetup -d $LOOP_DEV
> >  	rm -rf $TMP/tacl
> > +
> > +	if [ "$SELNUX" = "Enforcing" ]; then
> 
> At the begin, SELINUX is Enforcing.
> Then you set SELINUX to Permissive.
> Here $SELINUX(`getenforce`) is also Permissive, not Enforcing.
> Now you could not set it to Enforcing.
> 
> How about:
> 1.
> SELINUX=$(getenforce)
Yeah, we needn't to consider the Disabled and Permissive situation.
thanks for reviewing, I will post a V2.

Li Wang
> 
> 2.
> # We could not consider whether the SElinux is Disabled or Permissive.
> # We only set it to Permissive when it is Enforcing.
> if [ "${SELINUX} = "Enforcing" ]; then
> 	echo "set the SElinux to Permissive."
> 	setenforce 0
> fi
> 
> ...
> 
> 3.
> # We set it back to Enforcing.
> if [ "${SELINUX} = "Enforcing" ]; then
> 	setenforce 1
> fi
> 
> ...
> 
> Thanks,
> Zeng
> 
> > +		echo "set the SElinux to Enforcing."
> > +		setenforce 1
> > +	fi
> >  }
> >  
> >  #-----------------------------------------------------------------------
> > @@ -177,7 +197,7 @@ then
> >  	setfacl -m u:$TEST_USER1:r $FILE_ACL
> >  
> >  	echo "Trying extended acls for files"
> > -	${TCbin}/acl_file_test $FILE_ACL
> > +	$TMP/tacl/mount-ext3/acl_file_test $FILE_ACL
> >  	if [ $? -ne 0 ]
> >  	then
> >  		EXIT_CODE=1
> > @@ -187,7 +207,7 @@ then
> >  	fi
> >  
> >  	echo "Trying extended acls for file links"
> > -	${TCbin}/acl_link_test $FILE_ACL_LINK
> > +	$TMP/tacl/mount-ext3/acl_link_test $FILE_ACL_LINK
> >  	if [ $? -ne 0 ]
> >  	then
> >  		EXIT_CODE=1
> > @@ -227,6 +247,7 @@ else
> >  		echo "Extended acls for links (PASSED)"
> >  	fi
> >  
> > +	cp ${TCbin}/acl_link_test ${TCbin}/acl_file_test $TMP/tacl/mount-ext3/
> >  	chown $TEST_USER1 $FILE_ACL
> >  	chown $TEST_USER1 $FILE_ACL_LINK
> >  
> 
> 


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
