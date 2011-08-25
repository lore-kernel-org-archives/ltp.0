Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <takahash@us.ibm.com>) id 1QwdjM-0004ce-AF
	for ltp-list@lists.sourceforge.net; Thu, 25 Aug 2011 17:28:40 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QwdjL-0008Ul-Mj
	for ltp-list@lists.sourceforge.net; Thu, 25 Aug 2011 17:28:40 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7PH5K3v000997
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Aug 2011 13:05:20 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7PHSYKb214148
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Aug 2011 13:28:34 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7PDSLIE032001
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Aug 2011 10:28:21 -0300
Received: from taco.beaverton.ibm.com ([9.47.29.114])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p7PDSKOh031987
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Aug 2011 10:28:21 -0300
Date: Thu, 25 Aug 2011 10:26:27 -0700
From: James Takahashi <takahash@us.ibm.com>
Message-ID: <20110825172626.GA6398@us.ibm.com>
References: <mailman.342816.1314268291.22889.ltp-list@lists.sourceforge.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <mailman.342816.1314268291.22889.ltp-list@lists.sourceforge.net>
Subject: Re: [LTP] [PATCH 4/7 ver2 w/attachment] Changes to pounder's build
	scripts (Cyril Hrubis)
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
To: ltp-list@lists.sourceforge.net

On Thu, 25 Aug 2011 12:14:03, Cyril Hrubis <chrubis@suse.cz> wrote:
> To: Lucy Liang <lgliang@linux.vnet.ibm.com>

Hi Cyril,

Lucy was a summer intern here at IBM, but her internship has ended.  I'll
try to resolve any open issues with her pounder patch submission.  Please
direct any future comments to me.

> > diff --git a/tools/pounder21/build_scripts/ltp b/tools/pounder21/build_scripts/ltp
> > index 68dcdbe..70defe4 100755
> > --- a/tools/pounder21/build_scripts/ltp
> > +++ b/tools/pounder21/build_scripts/ltp
> > @@ -55,23 +55,24 @@ fi
> >  
> >  # NAK the setregid EPERM -> EINVAL patch, because it's
> >  # broken on 2.6!  May be fixed some time after 20050804 release.
> > -if [ ! -e "testcases/kernel/syscalls/setregid/setregid02.c.pounder" ]; then
> > -	echo "Patching some holes in ltp..."
> > -	cp -pRdu testcases/kernel/syscalls/setregid/setregid02.c testcases/kernel/syscalls/setregid/setregid02.c.pounder
> > -	patch -p1 < $POUNDER_SRCDIR/ltp-setregid-fix.patch
> > -	RESULT=$?
> > -	if [ $RESULT -ne 0 ]; then
> > -		echo Patching failed.
> > -		exit 1
> > -	fi
> > -fi
> > +#if [ ! -e "testcases/kernel/syscalls/setregid/setregid02.c.pounder" ]; then
> > +#	echo "Patching some holes in ltp..."
> > +#	cp -pRdu testcases/kernel/syscalls/setregid/setregid02.c testcases/kernel/syscalls/setregid/setregid02.c.pounder
> > +#	patch -p1 < $POUNDER_SRCDIR/ltp-setregid-fix.patch
> > +#	RESULT=$?
> > +#	if [ $RESULT -ne 0 ]; then
> > +#		echo Patching failed.
> > +#		exit 1
> > +#	fi
> > +#fi
> 
> Patching LTP before build from this build script is not really long term
> solution. We should get these patches applied to LTP (as it should have
> been done long time ago) and drop this logic entrirely.

I agree that this smells like a workaround, not a long term solution.

I'll investigate whether the setregid02 patch is still needed or not,
then I'll resubmit this patch.

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
