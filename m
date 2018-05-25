From: Sebastian Chlad <schlad@suse.de>
Date: Fri, 25 May 2018 16:36:35 +0200
Subject: [LTP] [PATCH] commands: Remove all test cases
In-Reply-To: <20180516101251.trwf4pxvqbqkqmp5@dell5510>
References: <20180426132418.19495-1-schlad@suse.de>
 <20180426132418.19495-2-schlad@suse.de>
 <b72b277b-e8e0-d69c-b918-bd48341c2a1d@oracle.com>
 <20180426172713.GB14157@x230> <20180427113553.GA14075@rei>
 <20180516101251.trwf4pxvqbqkqmp5@dell5510>
Message-ID: <20180525163635.219c9949@linux-p5n0>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, 16 May 2018 12:12:51 +0200
Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
> 
> > > I guess most of user space tools not related to kernel (cp, cron,
> > > df, ln, tar, unzip, wc, which) are questionable.  
> 
> > It's really hard to draw a line here, but I would probably vote for
> > keeping tests that are working with files such as cp/df/ln as these
> > are basically just printing result from UNIX/POSIX syscalls.  
> 
> > We probably want to get rid of the unzip and wc test, since that is
> > not really kernel related.  
> 
> I recently pushed some patches sent by Mylène Josserand, just in case
> we don't get rid of these tests.
> 
> BTW Mylène, Thomas, do you know people running these test on
> embedded? That might justify some of the tests (not sure if it's
> possible to run busybox tests without compilation - for machines
> which have their sources cross compiled).

thx Petr for reminding me of this email thread.

I really like the idea from Jan, so in coming weeks I will really
follow that advice and 'll go one by one command. "For those that are
broken, propose them to be removed and CC people who touched it in last
~2-3 years"

> 
> 
> Kind regards,
> Petr

