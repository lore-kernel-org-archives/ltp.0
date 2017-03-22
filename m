From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Mar 2017 16:40:15 +0100
Subject: [LTP] Running LTP results in read-only filesystem
In-Reply-To: <1488998475.22552.12.camel@caviumnetworks.com>
References: <1488912047.22552.6.camel@caviumnetworks.com>
 <20170308111930.GA28037@rei.lan>
 <1488998475.22552.12.camel@caviumnetworks.com>
Message-ID: <20170322154013.GB4960@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I am using an ext4 filesystem on a hard disk drive. ??dmesg is empty, it
> may have gotten deleted during the reboot and/or the fsck that was done
> during the reboot to get the system to come back up.

The dmesg output is not reboot persistent, the log is normally logged to
/var/log/messages via the syslog daemon, but once the FS gets read-only
the daemon can't write the logs so they end up lost on reboot...

-- 
Cyril Hrubis
chrubis@suse.cz
