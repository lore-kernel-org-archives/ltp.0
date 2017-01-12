From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Jan 2017 15:45:34 +0100
Subject: [LTP] [PATCH 1/4] lib: Add tst_kernel_bits()
In-Reply-To: <1457322111.1910057.1484232035660.JavaMail.zimbra@redhat.com>
References: <1484227419-16955-1-git-send-email-chrubis@suse.cz>
 <1457322111.1910057.1484232035660.JavaMail.zimbra@redhat.com>
Message-ID: <20170112144533.GD1208@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This function returns 32 or 64 depending on if we are running on 32bit
> > or 64bit kernel. This is detected from uname.machine string which seems
> > to be good enough heuristic and even if that fails we can always add a
> > special cases to the tst_kernel_bits() function.
> 
> ACK, though I keep thinking if there isn't something in /proc
> or /sys we could query and guess kernel bits from that.

Unfortunately parsing the machine from uname was the only way I could
came up with.

-- 
Cyril Hrubis
chrubis@suse.cz
