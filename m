From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Aug 2016 13:34:12 +0200
Subject: [LTP] [PATCH v2 1/2] runltp: extend the default loop device
 size to 150MB
In-Reply-To: <1469683046-6271-1-git-send-email-liwang@redhat.com>
References: <1469683046-6271-1-git-send-email-liwang@redhat.com>
Message-ID: <20160815113412.GA20680@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Increase TST_DEVICE size to make btrfs-progs happy.

I've increased it in the C library in lib/tst_device.c as well and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
