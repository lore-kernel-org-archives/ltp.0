Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <prvs=5218317ac8=G.Rajender@lnties.com>)
	id 1QwU4m-0002b2-Jm
	for ltp-list@lists.sourceforge.net; Thu, 25 Aug 2011 07:10:08 +0000
Received: from mailout2.ltindia.com ([125.18.18.171])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QwU4j-0007VM-BN
	for ltp-list@lists.sourceforge.net; Thu, 25 Aug 2011 07:10:08 +0000
From: G Rajender <G.Rajender@lnties.com>
Date: Thu, 25 Aug 2011 07:09:53 +0000
Message-ID: <260174ADA4D63F4AA543B9C81F2DE71214D443@POCITMSEXMB02.LntUniverse.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP]  Porting of LTP on Android on Beagleboard
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
To: Garrett Cooper <yanegomi@gmail.com>, "Anupam Srivastava - ERS, HCL Tech" <Anupam_Srivastava@hcl.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Kumar <Manoj_Kr@hcl.com>, Manoj@suse.de

Hi,

I want port LTP on android.  I am using android ginger bread. I have generated boot loaders, kernel images for beagleboard.

Can you please suggest me the procedure of how to execute LTP with android images on beagleboard.

Thanks in advance.

Thanks and regards,

Rajender.G

________________________________________
From: Garrett Cooper [yanegomi@gmail.com]
Sent: Saturday, August 13, 2011 9:55 AM
To: Anupam Srivastava - ERS, HCL Tech
Cc: ltp-list@lists.sourceforge.net; Manoj Kumar
Subject: Re: [LTP] Porting of LTP on Android - Patch

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


Larsen & Toubro Limited

www.larsentoubro.com

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
