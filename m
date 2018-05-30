From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 May 2018 11:31:11 +0200
Subject: [LTP] [PATCH] commands: Remove all test cases
In-Reply-To: <20180529171319.365ca9c0@dell-desktop.home>
References: <20180426132418.19495-1-schlad@suse.de>
 <20180426132418.19495-2-schlad@suse.de>
 <b72b277b-e8e0-d69c-b918-bd48341c2a1d@oracle.com>
 <20180426172713.GB14157@x230> <20180427113553.GA14075@rei>
 <20180516101251.trwf4pxvqbqkqmp5@dell5510>
 <20180529171319.365ca9c0@dell-desktop.home>
Message-ID: <20180530093111.GA4031@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > BTW Myl??ne, Thomas, do you know people running these test on embedded? That might justify
> > some of the tests (not sure if it's possible to run busybox tests without compilation -
> > for machines which have their sources cross compiled).
> 
> We currently have one customer that run these tests on an embedded
> platform but in fact, we run the default scenario_group (that is why,
> we run "commands" runtest). I guess that if the community think these
> tests are not useful anymore, there is no problem on our side.
> Our customer is using it to "show" that LTP is successfully runnable on
> their platform, that it is.
> 
> I am pretty new to LTP but I had the feeling that these "commands"
> tests rely maybe too much on applications and not on Linux kernel
> features. Many of them are returning TCONF in our case because we do
> not have the correct configuration (busybox options, etc).

As discussed in the orignal thread that proposed removing these
testcases, some of the tests are related to kernel, some not so much.

For example the file or cron tests does not correspond to any kernel
functionality at all, while the df or du testcases, for instance, are
testing kernel filesystem implementation. So the plain is to examine
these tests case by case.

-- 
Cyril Hrubis
chrubis@suse.cz
