From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 4 May 2017 15:07:28 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] commands/which01.sh: Fix test for debian.
In-Reply-To: <20170503145016.27519-1-chrubis@suse.cz>
References: <20170503145016.27519-1-chrubis@suse.cz>
Message-ID: <94622407.7415649.1493924848056.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The which binary on Debian comes from debianutils package and not from
> the which package (like it is on the most of the distros). It does not
> support most of the options, which is fine, since the test produces
> TCONF for these but also returns relative path instead of absolute one.
> 
> So this patch adds alternate version for the expected path and the test
> passes if at least one of them matches.
> 
> Fixes #151.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

No objections - I think we used same approach in file test.
I'd add also that note about POSIX not defining it to commit message.

Regards,
Jan
