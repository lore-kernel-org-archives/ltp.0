From: Steve Ellcey <sellcey@caviumnetworks.com>
Date: Wed, 01 Mar 2017 09:26:21 -0800
Subject: [LTP] [PATCH] Remove unneeded time() declaration.
In-Reply-To: <20170301124620.GA32207@rei.lan>
References: <1488317719-29809-1-git-send-email-sellcey@caviumnetworks.com>
 <20170301124620.GA32207@rei.lan>
Message-ID: <1488389181.2866.256.camel@caviumnetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, 2017-03-01 at 13:46 +0100, Cyril Hrubis wrote:
> Hi!
> > 
> > The 'extern long time()' declaration conflicts with time.h which
> > declares time() to be of type time_t which may or may not be long.
> > This declaration causes a build failure on x86_64 if the file is
> > compiled with the -mx32 flag.  The time() function does not appear
> > to be used anywhere in fcntl14 so I am not sure why the declaration
> > is there anyway.
> This is obviously correct, but the patch misses the Signed-of-by:
> line.
> 
> Also usually the first line of the patch describes what testcase it
> fixes so it should have been something like:
> 
> syscalls/fcntl14: Remove unneeded time() declaration.
> 
> Can you please resend with fixed commit description?

I updated the comments and resent the patch using format-patch and
send-email.  I am not sure if that is the right way to do it but I
don't see any way to use format-patch/send-email to resend the patch as
a response to your email so I sent it as a new email/thread.  The
inability (as far as I know) to update the patch and send it as a
response to an existing email thread is one of the reasons I am not a
huge fan of those tools but if that is how you want it done, I will do
it that way.

Steve Ellcey
