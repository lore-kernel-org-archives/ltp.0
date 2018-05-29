From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Tue, 29 May 2018 17:13:19 +0200
Subject: [LTP] [PATCH] commands: Remove all test cases
In-Reply-To: <20180516101251.trwf4pxvqbqkqmp5@dell5510>
References: <20180426132418.19495-1-schlad@suse.de>
 <20180426132418.19495-2-schlad@suse.de>
 <b72b277b-e8e0-d69c-b918-bd48341c2a1d@oracle.com>
 <20180426172713.GB14157@x230> <20180427113553.GA14075@rei>
 <20180516101251.trwf4pxvqbqkqmp5@dell5510>
Message-ID: <20180529171319.365ca9c0@dell-desktop.home>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello,

On Wed, 16 May 2018 12:12:51 +0200
Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
> 
> > > I guess most of user space tools not related to kernel (cp, cron, df, ln, tar, unzip, wc,
> > > which) are questionable.  
> 
> > It's really hard to draw a line here, but I would probably vote for
> > keeping tests that are working with files such as cp/df/ln as these
> > are basically just printing result from UNIX/POSIX syscalls.  
> 
> > We probably want to get rid of the unzip and wc test, since that is not
> > really kernel related.  
> 
> I recently pushed some patches sent by Mylène Josserand, just in case we don't get rid of
> these tests.

Yes, thank you for that!

> 
> BTW Mylène, Thomas, do you know people running these test on embedded? That might justify
> some of the tests (not sure if it's possible to run busybox tests without compilation -
> for machines which have their sources cross compiled).

We currently have one customer that run these tests on an embedded
platform but in fact, we run the default scenario_group (that is why,
we run "commands" runtest). I guess that if the community think these
tests are not useful anymore, there is no problem on our side.
Our customer is using it to "show" that LTP is successfully runnable on
their platform, that it is.

I am pretty new to LTP but I had the feeling that these "commands"
tests rely maybe too much on applications and not on Linux kernel
features. Many of them are returning TCONF in our case because we do
not have the correct configuration (busybox options, etc).

Thank you in advance,

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
