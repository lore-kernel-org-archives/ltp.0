Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QwY7E-0000fY-3L
	for ltp-list@lists.sourceforge.net; Thu, 25 Aug 2011 11:28:56 +0000
Date: Thu, 25 Aug 2011 13:34:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110825113406.GA13635@saboteur.suse.cz>
References: <260174ADA4D63F4AA543B9C81F2DE71214D443@POCITMSEXMB02.LntUniverse.com>
	<20110825094054.GA11006@saboteur.suse.cz>
	<260174ADA4D63F4AA543B9C81F2DE71214D45D@POCITMSEXMB02.LntUniverse.com>
	<CAMhs6YzTYjHbKB2f6+j7pg04COn6mnMOaoHtzphjukxT-EqLBg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMhs6YzTYjHbKB2f6+j7pg04COn6mnMOaoHtzphjukxT-EqLBg@mail.gmail.com>
Subject: Re: [LTP] Porting of LTP on Android on Beagleboard
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
To: Maxin B John <maxin.john@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, "Manoj@suse.de" <Manoj@suse.de>, Kumar <Manoj_Kr@hcl.com>, "Anupam Srivastava - ERS, HCL Tech" <Anupam_Srivastava@hcl.com>

Hi!
> as bionic isn't as smart or big as glibc). I would also recommend you
> to port "Busybox" for Android or download it from the Android market
> itself.  The "ash" shell available in Busybox should be enough for you
> to get started with the scripts in LTP.

If anything doesn't work with ash, just send a patch. There may be some
bashishm lefovers that needs to be fixed. Ideally all the scripts should
work with POSIX compilant shell.

> There are some patches already available for porting LTP to Android :
> http://comments.gmane.org/gmane.linux.ltp/14497
> However,  these patches may not be acceptable to the mainstream LTP as
> it breaks some existing tests in the "common/normal" platforms. I
> think we can go ahead with the way we support UCLINUX in LTP ..
> ie: #ifdef UCLINUX
> So, if we care to re-write those patches with #ifdef ANDROID (or
> #ifndef ANDROID based on our logic) without breaking other tests, I
> think we can officially welcome Android related patches to LTP.
> 
> Cyril, Garrett, please let us know your thoughts on this.

As noted by garret previously, do not remove references for config.h.

Either use the configure script to create config.h or create config.h by
hand (as written in INSTALL).

Ideally most of the differencies should be detected with configure script
(Writing rules for generating it is hard but we may help you).

Do not write "removed XXX to do YYY" into comments to C sources. We have
git to track the change descriptions. Ideally each logical set of
changes should be in one patch. Please learn how to use git to create
patches with reasonable description. You have a bigger chance to get the
changes commited by small well described and reasonable bits.

Do not send patches mixed with DOS CR+LF

Most of the changes that patch are just lines commented out, that is
hardly applicable, this needs to be addresed in some reasonable manner.

Generally I'm not saying no. This would just need some more work done.

And for the UCLINUX part, I'm not really happy that we have #ifdef
UCLINUX spread around the codebase, but I could live with reasonable
bits that needs to be there. The best I could think about is to create
android-compat.h header to store all the android specific stuff. Which
would be included in test.h if ANDROID is defined.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
