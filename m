From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jul 2016 11:25:08 +0200
Subject: [LTP] [PATCH 2/2] mkfs01: extend the loop device size to 256M
In-Reply-To: <20160727092210.GB10645@rei.lan>
References: <1469598247-23993-1-git-send-email-liwang@redhat.com>
 <1469598247-23993-2-git-send-email-liwang@redhat.com>
 <20160727092210.GB10645@rei.lan>
Message-ID: <20160727092508.GC10645@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> As far as I can tell 150MB should suffice as well, at least for me the
> btrfs-progs v4.3.1+ requests at least 136MB. Or did they increase the
               ^
	       Should have been v4.5.1+

The v4.3.1+ increased the minimal size to 100MB.

-- 
Cyril Hrubis
chrubis@suse.cz
