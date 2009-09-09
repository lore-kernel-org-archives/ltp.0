Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MlFl1-0004kG-D8
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 05:30:15 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MlFku-0005ED-6j
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 05:30:15 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n895LKNd014780
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 01:21:20 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n895TvqJ231628
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 01:29:57 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n895QpKP016635
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Sep 2009 01:26:51 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AA5085D.2060201@bull.net>
References: <4AA5085D.2060201@bull.net>
Date: Wed, 09 Sep 2009 10:59:45 +0530
Message-Id: <1252474187.5006.2.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] acl_test01 TestCase
Reply-To: subrata@linux.vnet.ibm.com
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
To: Jacky Malcles <Jacky.Malcles@bull.net>
Cc: ltp-list@lists.sourceforge.net, jyoung5@us.ibm.com

Hi Jacky,

On Mon, 2009-09-07 at 15:19 +0200, Jacky Malcles wrote:
> Subrata,
> 
> runltp can not run acl_test01 by default, we need a mounted partition 
>  with ACL options.
> 
>  To have acl_test01 started by runltp (or manually) without any acl
> aware partition,
> 
>  if you agree I suggest the following patch: a kind of new setup and
>   
>  at the same time the activation of a non root user.
> 
>  regards,
> 
>  Jacky
> 
> -- 
>  Jacky Malcles               B1-403   Email : Jacky.Malcles@bull.net
>  Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
>  Tel : 04.76.29.73.14
> 
> 
> 
> 
> 
> 
> 
> 
> plain text
> document
> attachment
> (envoi)


> 

Please Sign-off this patch, and, also create this patch from LTPROOT
directory.

Regards--
Subrata

> --- acl_test01.ori      2009-09-01 16:12:53.000000000 +0200
> +++ acl_test01  2009-09-01 16:12:39.000000000 +0200
> @@ -24,17 +24,91 @@
>  #
>  #  HISTORY:
>  #    03/03 Jerone Young  (jyoung5@us.ibm.com)
> +#    09/08 Jacky Malcles changing the setup to have this TC started
> by runltp 
>  #*********************************************************************
> -export PATH=$PATH:/usr/sbin/
> +#
> +################################################################
> +# 
> +# Make sure that uid=root is running this script. 
> +# Make sure that loop device is built into the kernel  
> +# Make sure that ACL(Access Control List) and Extended Attribute are
> +#     built into the kernel
> +#
> +#
> +################################################################
> 
>  TEST_USER1="acltest1"
>  TEST_USER1_GROUP="users"
>  TEST_USER1_PASSWD="ltp_test_pass1"
> -#ensure the test partition is ACL aware
> -TEST_USER1_HOMEDIR="/tmp/$TEST_USER1"
> +TEST_USER1_HOMEDIR="tacl/mount-ext3/$TEST_USER1"
> +
> +FILE_ACL="tacl/mount-ext3/test_file"
> +FILE_ACL_LINK="tacl/mount-ext3/test_file_link"
> +TCbin=`pwd`
> +
> +iam=`whoami`
> +if [ "z$iam" = "z$TEST_USER1" ]
> +then
> +       echo ""
> +else
> +if [ $UID != 0 ]
> +then
> +        echo "FAILED: Must have root access to execute this script"
> +        exit 1
> +fi
> +
> +if [ ! -e tacl ]
> +then
> +        mkdir -m 777 tacl
> +else
> +        echo "FAILED: Directory tacl are exist"
> +        exit 1
> +fi
> +
> +#       The  following  commands  can  be  used as an example of
> using the loop
> +#       device.
> +
> +dd if=/dev/zero of=tacl/blkext3 bs=1k count=10240
> +chmod 777 tacl/blkext3
> +#
> +losetup /dev/loop0 tacl/blkext3 2>&1 > /dev/null
> +if [ $? != 0 ]
> +then
> +        echo ""
> +        echo "FAILED:  [ losetup ] Must have loop device support by
> kernel"
> +        echo -e "\t to execute this script"
> +        exit 1
> +fi
> +
> +mount | grep ext2
> +if [ $? != 0 ] 
> +then
> +        mkfs -t ext3 /dev/loop0 #> /dev/null 2>&1
> +        mkdir  -m 777 tacl/mount-ext3
> +        mount -t ext3 -o defaults,acl,user_xattr /dev/loop0
> tacl/mount-ext3
> +        if [ $? != 0 ]
> +        then
> +                echo ""
> +                echo "FAILED: [ mount ] Make sure that ACL (Access
> Control List)"
> +                echo -e "\t and Extended Attribute are built into the
> kernel"
> +                echo -e "\t Can not mount ext3 file system with acl
> and user_xattr options"
> +                exit 1
> +        fi
> +else
> +        mkfs -t ext2 /dev/loop0
> +        mkdir  -m 777 tacl/mount-ext3
> +        mount -t ext2 -o defaults,acl,user_xattr /dev/loop0
> tacl/mount-ext3
> +        if [ $? != 0 ]
> +        then
> +                echo ""
> +                echo "FAILED: [ mount ] Make sure that ACL (Access
> Control List)"
> +                echo -e "\t and Extended Attribute are built into the
> kernel"
> +                echo -e "\t Can not mount ext2 file system with acl
> and user_xattr options"
> +                exit 1
> +        fi
> +fi
> +fi
> 
> -FILE_ACL="/tmp/test_file"
> -FILE_ACL_LINK="/tmp/test_file_link"
> 
>  #-----------------------------------------------------------------------
>  # FUNCTION:  do_setup
> @@ -55,7 +129,7 @@ do_setup(){
>         rm -rf $TEST_USER1_HOMEDIR 
>         userdel $TEST_USER1 > /dev/null 2>&1
>         sleep 1
> -       useradd -d $TEST_USER1_HOMEDIR -m -g $TEST_USER1_GROUP
> $TEST_USER1 -s /bin/sh
> +       useradd -d `pwd`/$TEST_USER1_HOMEDIR -m -g $TEST_USER1_GROUP
> $TEST_USER1 -s /bin/sh
> 
>         if [ $? != 0 ]
>         then {
> @@ -81,6 +155,9 @@ do_cleanup() {
>         userdel $TEST_USER1
>         rm -f $FILE_ACL > /dev/null 2>&1
>         rm -f $FILE_ACL_LINK > /dev/null 2>&1
> +       umount -d tacl/mount-ext3
> +       rm -rf tacl
> +
>  }
> 
>  #-----------------------------------------------------------------------
> @@ -91,6 +168,7 @@ iam=`whoami`
>  EXIT_CODE=0
>  if [ "z$iam" = "z$TEST_USER1" ]
>  then
> +       echo ""
>         echo "TESTING ACLS FOR 2ND USER $iam"
> 
>         #setup files for extended attributes
> @@ -118,6 +196,7 @@ then
>          fi
>  else
>         do_setup
> +       echo ""
>         echo "TESTING ACLS FOR USER $iam"
> 
>         touch $FILE_ACL
> @@ -150,11 +229,8 @@ else
>         chown $TEST_USER1 $FILE_ACL
>         chown $TEST_USER1 $FILE_ACL_LINK
> 
> -       if [ -z ${TCbin} ]
> -       then
> -               export TCbin=$PWD
> -       fi
> -       
> +       su $TEST_USER1 -c "$0"
> +       echo ""
>         do_cleanup
>  fi     
> 
> 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
