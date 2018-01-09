From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 9 Jan 2018 13:47:37 -0500 (EST)
Subject: [LTP] LTP release
In-Reply-To: <20180109181745.GA11221@rei.lan>
References: <20171220113323.GD6688@rei> <20180109181745.GA11221@rei.lan>
Message-ID: <1073451511.4987996.1515523657228.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> This is just a reminder that we should start working on the January
> stable release.
> 
> I see that we included the meltdown test which I guess was one of the
> important enough patches to be included.
> 
> Anything else that should be taken in before we freeze the git?
> 
> I've did some preliminary testing (compiling and runnign LTP on a few
> selected distros) and haven't found any big issues so far, so it looks
> like this may as well be smoothest release ever (fingers crossed).

I ran a test couple days ago with snapshot from 20180103 on RHEL6.2/6.9
and RHEL7.5(beta) across i386/x86_64/ppc64(le)/s390x. I'm planning
to try also some recent upstream kernel, but as you said so far
it looks good.

Regards,
Jan
