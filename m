Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Qs5mb-00079i-EL
	for ltp-list@lists.sourceforge.net; Sat, 13 Aug 2011 04:25:13 +0000
Received: from mail-qy0-f182.google.com ([209.85.216.182])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Qs5ma-0002up-SF
	for ltp-list@lists.sourceforge.net; Sat, 13 Aug 2011 04:25:13 +0000
Received: by qyk9 with SMTP id 9so2459733qyk.13
	for <ltp-list@lists.sourceforge.net>;
	Fri, 12 Aug 2011 21:25:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGH67wSUQOd0h5Q1yZ0owyuGPWnGSY_ECB-cWC6PVx8ux4uisw@mail.gmail.com>
References: <0F68B52D2432864190BC72F760407FE9118354BDE5@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
	<CAGH67wSUQOd0h5Q1yZ0owyuGPWnGSY_ECB-cWC6PVx8ux4uisw@mail.gmail.com>
Date: Fri, 12 Aug 2011 21:25:07 -0700
Message-ID: <CAGH67wS5MokGCCOrH+9X9oDjU4-veCbZWXZwcOr_3mmuLsKtkw@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Porting of LTP on Android - Patch
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
To: "Anupam Srivastava - ERS, HCL Tech" <Anupam_Srivastava@hcl.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Manoj Kumar <Manoj_Kr@hcl.com>

On Fri, Aug 12, 2011 at 8:59 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Mon, Aug 8, 2011 at 6:13 AM, Anupam Srivastava - ERS, HCL Tech
> <Anupam_Srivastava@hcl.com> wrote:
>> Hi,
>>
>>
>>
>> This is in continuation of my last mail sent to you regarding the porting of
>> LTP on Android 2.2 Froyo dated Aug 04, 2010.
>>
>> We have ported LTP open source (Version: ltp-full-20110228) on Android 2.2
>> Froyo. It will validate the reliability, robustness, and stability of
>> Android. We want to submit the same to open source community.
>
> ...
>
> 1. This really should use git, not a patch against a release version.
> 2. You should use unified diffs.

Some other things:
1. These diffs contain references to files not in the git repo.
2. There are debug statements that were added should be removed.
3. Some diagnostic output should be restored.
4. There's some unnecessary commentary that's been added.
5. It doesn't make sense why you didn't follow the build directions
and decided to instead remove all references to config.h .
Thanks,
-Garrett

------------------------------------------------------------------------------
FREE DOWNLOAD - uberSVN with Social Coding for Subversion.
Subversion made easy with a complete admin console. Easy 
to use, easy to manage, easy to install, easy to extend. 
Get a Free download of the new open ALM Subversion platform now.
http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
