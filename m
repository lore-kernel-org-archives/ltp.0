From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Jan 2020 11:58:35 +0100
Subject: [LTP] [PATCH v2] tst_dev_bytes_written: parsing /proc/diskstats
 instead of sys file
In-Reply-To: <20200115104627.GB24851@dell5510>
References: <1578299418-4961-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200108131231.GA23619@rei.lan>
 <bee8d39f-723f-491d-8676-a1c303f0a5bb@cn.fujitsu.com>
 <CAFA6WYMk-bT7xKG7nov8mzd=b4T1gzghxrFz9x_OegU8mtSNVA@mail.gmail.com>
 <20200110123012.GA14140@rei.lan> <20200115104627.GB24851@dell5510>
Message-ID: <20200115105834.GA14046@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If we merge Cyril's, I'd be for adding the hint about LTP_DEV (maybe as a
> separate commit).

Maybe it would be a bit better to print short TINFO message in the case
of failure instead of adding comments into the source code...

-- 
Cyril Hrubis
chrubis@suse.cz
