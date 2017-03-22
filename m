From: Steve Ellcey <sellcey@caviumnetworks.com>
Date: Wed, 22 Mar 2017 08:49:30 -0700
Subject: [LTP] Running LTP results in read-only filesystem
In-Reply-To: <20170322154013.GB4960@rei.lan>
References: <1488912047.22552.6.camel@caviumnetworks.com>
 <20170308111930.GA28037@rei.lan>
 <1488998475.22552.12.camel@caviumnetworks.com>
 <20170322154013.GB4960@rei.lan>
Message-ID: <1490197770.19074.24.camel@caviumnetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, 2017-03-22 at 16:40 +0100, Cyril Hrubis wrote:
> Hi!
> > 
> > I am using an ext4 filesystem on a hard disk drive. ??dmesg is empty, it
> > may have gotten deleted during the reboot and/or the fsck that was done
> > during the reboot to get the system to come back up.
> The dmesg output is not reboot persistent, the log is normally logged to
> /var/log/messages via the syslog daemon, but once the FS gets read-only
> the daemon can't write the logs so they end up lost on reboot...

I may have been too fast to blame LTP for my system crashes.  I had
another crash when not running LTP and where the filesystem became
read-only and now I think the machine has a hardware issue.  LTP may
have caused the problem to appear more frequently by stressing the
system but I don't think the underlying bug of the filesystem becoming
read-only was due to LTP.

Steve Ellcey
